Return-Path: <stable+bounces-175545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C018CB368D5
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66BA1C80AFD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C32BEC45;
	Tue, 26 Aug 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PyyGt+YI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B5286881;
	Tue, 26 Aug 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217327; cv=none; b=a9pA+maJ4ypq0CDfWFYI6Id2kMmUv1tDzC6SXZMwZGXvFrfmv0R8KEcuqr0Fuw/zJkKtP25ULivW8e5sRGQ/cpNT+6g5XplZuWzU84e5RANy/H4ZfVBg0EbEeIwaAXji74FRZJvxptvphD+6GamJhbnwrtuu/hBdN9w/t07+qwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217327; c=relaxed/simple;
	bh=nPW5P6y6rNCF0YEld+vBVLvLlT8Oft1TfoUf+wDC2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa08XU84Pekck7D9CDgO1vkVhf83x1kB7nWj3BkoZ4yAjPdgdz0dln6mMDnx3V/R+LnKALxiQCPzwj6RvEI7/2xRGRNKSJ8Zr1i5P+A/Gr8MNe4fazN3oTv+iLdBFtNcOsF0WB9QmUgbUGNTozAE6c41ezKu+CEpzPWMF/q/eHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PyyGt+YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB17C4CEF1;
	Tue, 26 Aug 2025 14:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217327;
	bh=nPW5P6y6rNCF0YEld+vBVLvLlT8Oft1TfoUf+wDC2ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PyyGt+YIWhhlPLM+uhadhMWfPTL1vYxiP5D+3b0yxeANsOZSWzVCMutvgVtI0Ha9E
	 tMT50PIA+cNnDnrwDA9jI0XBmWB2DM1WJx03TywLmfaec/4WCDG6QCfKj9pqKpWOvh
	 kUqDGYVMBtu8f13pQnRGnXncWMvSwv0oJYurQ+gI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Zhivich <mzhivich@akamai.com>
Subject: [PATCH 5.10 070/523] x86/bugs: Fix use of possibly uninit value in amd_check_tsa_microcode()
Date: Tue, 26 Aug 2025 13:04:40 +0200
Message-ID: <20250826110926.299094956@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Zhivich <mzhivich@akamai.com>

For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
field in zen_patch_rev union on the stack may be garbage.  If so, it will
prevent correct microcode check when consulting p.ucode_rev, resulting in
incorrect mitigation selection.

This is a stable-only fix.

Cc: <stable@vger.kernel.org>
Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
Fixes: 78192f511f40 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/amd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -599,6 +599,8 @@ static bool amd_check_tsa_microcode(void
 	p.model		= c->x86_model;
 	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
+	/* reserved bits are expected to be 0 in test below */
+	p.__reserved	= 0;
 
 	if (c->x86 == 0x19) {
 		switch (p.ucode_rev >> 8) {



