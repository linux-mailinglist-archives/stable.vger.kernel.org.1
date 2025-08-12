Return-Path: <stable+bounces-167293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41956B22F78
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17BB566142
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91982FF14F;
	Tue, 12 Aug 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+eSjL3k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E1268C73;
	Tue, 12 Aug 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020326; cv=none; b=FlKTpCtWNHcTKf4a2Ztr6jK6CjAGrZKABpGXPT8OW3LhkBrlCKwXO5hL7jXpJmmGutgOZhGibbnhJW1ls1hfVQaKEybnSytCcErQ7l1oaQb+T5idODdTFBpQxs7jFmW0BPdxtWyy9/koGkOCSOqDl56w+s11cR7cJ2xmPl76SOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020326; c=relaxed/simple;
	bh=XoHGWCgWC7UIkVXxCOnsQH5O7BieycocfWOYazIX/RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPVnet6rGyZLHeplpQEulPnWBTSnw0xSUR/L3Z9yElc9lZji0z3bPlUwdzSSamtlw+xym9BGdCnj+zkZDiNFuHoNpxSfgVaenTkKXjzOc5Gz4MQQTbv1NOzAz9AFkAju2+5+HOpE0np8FYTCjCgP22FkeWsHgdZsxC63VoXJ3p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+eSjL3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0596CC4CEF0;
	Tue, 12 Aug 2025 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020326;
	bh=XoHGWCgWC7UIkVXxCOnsQH5O7BieycocfWOYazIX/RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+eSjL3k4MtaZuxTDeYeh6eoE8FleqmnH1ZaorrSHYwTrlu6sNWdeTwxbDSlfTf9N
	 p5oYH/KpADg/Gj4jhInNXuCYf0SsKYJcSTuZNBogUeqf583NonP0Pzw4wl9JSWeYDR
	 PW7KKDeBH0v+qVVKIPdFy4kcDsCzlA0RiG4OuFWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Zhivich <mzhivich@akamai.com>
Subject: [PATCH 6.1 047/253] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Tue, 12 Aug 2025 19:27:15 +0200
Message-ID: <20250812172950.738265660@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Zhivich <mzhivich@akamai.com>

For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
field in zen_patch_rev union on the stack may be garbage.  If so, it will
prevent correct microcode check when consulting p.ucode_rev, resulting in
incorrect mitigation selection.

This is a stable-only fix.

Cc: <stable@vger.kernel.org>
Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
Fixes: d12145e8454f ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Changes in v3:
- separate "fixes" tag for each stable

 arch/x86/kernel/cpu/amd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -563,6 +563,8 @@ static bool amd_check_tsa_microcode(void
 	p.model		= c->x86_model;
 	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved	= 0;
 
 	if (c->x86 == 0x19) {
 		switch (p.ucode_rev >> 8) {



