Return-Path: <stable+bounces-65659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8494AB56
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660971F25B6E
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A801013A869;
	Wed,  7 Aug 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgNqvzgj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342F84A4E;
	Wed,  7 Aug 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043062; cv=none; b=WLMlWL/0lgt8X/6+ORU52SiacWxGorM5jG2/CCJBHrPZnv2SdgPBtFwAd2dcdUL8v46/BKotVs1yFAWyLbsmH6p35UbTpgxgmFHvaHCCv1gj9fOJkeYfhD4WAll4yt81x/avEuvWSlfGAhcfIvQ4PCFTeQ2qwzwwGR6rNhXFIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043062; c=relaxed/simple;
	bh=JUharwETHCVC8tWLHRPhSeOKRFYOmEWbZowle9xPmkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw81C2GcwdJrLHaMSsrRv5OlhnjEWX6ETo6GOfRozsN67xzLI+sA98siaN+hEJMvy/NHlU5P4NXxXivavlBUyQJ1yn1TPf8JLYHqgLmEfraC5DMqtf67MZPtEBllcbjM544AP4Ey7rEHNe5QuuSiaUzGMXX6AUKUHGWIwYiHb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PgNqvzgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BAFC4AF0D;
	Wed,  7 Aug 2024 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043062;
	bh=JUharwETHCVC8tWLHRPhSeOKRFYOmEWbZowle9xPmkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgNqvzgjXoVfs+dC8ZElq7HejYug4gS9AHxMveiXVe0K9XuC7wIBzaevIPykukp6J
	 lAoBPWEX+8WF3MLbDwJ/JMGhFbcKacYXgMT6o7hufjoEaIImaeu8ObxyXg5pF6KlIu
	 kTL2qY9XUq27gikmbbs88jIDqfg9Sk7WyS/pCYCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aristeu Rozanski <aris@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 6.10 077/123] s390/fpu: Re-add exception handling in load_fpu_state()
Date: Wed,  7 Aug 2024 16:59:56 +0200
Message-ID: <20240807150023.290844648@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit 4734406c39238cbeafe66f0060084caa3247ff53 upstream.

With the recent rewrite of the fpu code exception handling for the
lfpc instruction within load_fpu_state() was erroneously removed.

Add it again to prevent that loading invalid floating point register
values cause an unhandled specification exception.

Fixes: 8c09871a950a ("s390/fpu: limit save and restore to used registers")
Cc: stable@vger.kernel.org
Reported-by: Aristeu Rozanski <aris@redhat.com>
Tested-by: Aristeu Rozanski <aris@redhat.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/fpu.c b/arch/s390/kernel/fpu.c
index fa90bbdc5ef9..6f2e87920288 100644
--- a/arch/s390/kernel/fpu.c
+++ b/arch/s390/kernel/fpu.c
@@ -113,7 +113,7 @@ void load_fpu_state(struct fpu *state, int flags)
 	int mask;
 
 	if (flags & KERNEL_FPC)
-		fpu_lfpc(&state->fpc);
+		fpu_lfpc_safe(&state->fpc);
 	if (!cpu_has_vx()) {
 		if (flags & KERNEL_VXR_V0V7)
 			load_fp_regs_vx(state->vxrs);
-- 
2.46.0




