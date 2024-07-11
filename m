Return-Path: <stable+bounces-59086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FDD92E3A5
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A96428372A
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FD41509B1;
	Thu, 11 Jul 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fy234ZRC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A476034
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690981; cv=none; b=ClGPO+nWzBSx9LHZHIw8C9fhIgjjSpWHUs4D0SRdlWGYU3hlgh9wEqgYceLdlT9viIVPhjccR7iu9clVpN0NYR89iXRp10x6/atgO82+vU1aVm3+hbpGjujwmFGwyJP69TtU3qwA72yyOf2UD4pqspvB/I5hiwFs1pDagQ8iir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690981; c=relaxed/simple;
	bh=a1D0JWZwerbZkgWq2Mw1NvxPwNIZ7tcC57cUaWaUjt8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tswpq78qf1vWBKBFR8Abcfr60KRxkgP0fJklLIByqQQN4PLfN55jEhxYOpKOALJPOZGoJgNJ1AIa1Boy2k8jy2D+MFXA1RhLo+TmI9xOy50oVkKVabLMdnaNJp15ej9W6mnyKza03+QH1NRVDterke3I39fM5CSoEMcIHvrxHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fy234ZRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB43C116B1;
	Thu, 11 Jul 2024 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720690981;
	bh=a1D0JWZwerbZkgWq2Mw1NvxPwNIZ7tcC57cUaWaUjt8=;
	h=Subject:To:Cc:From:Date:From;
	b=fy234ZRClOra4IFcr/1Pud4jabBYe9PmoxAQdFCr9KX93nlMTqL1yh1MG9cV757Ob
	 oua+dJ+0gtg9eBhd7w/J6GFzz2Zwnac3ctfNPHrJBoul+DCjlKG+OVzcEPi38r6zwj
	 V+hbqVhyyX8nIqOcfs4xaU/rdNE92ToDa1qUDlhM=
Subject: FAILED: patch "[PATCH] s390: Mark psw in __load_psw_mask() as __unitialized" failed to apply to 5.15-stable tree
To: svens@linux.ibm.com,agordeev@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 11 Jul 2024 11:42:53 +0200
Message-ID: <2024071153-tanned-cobalt-76a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7278a8fb8d032dfdc03d9b5d17e0bc451cdc1492
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071153-tanned-cobalt-76a1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7278a8fb8d03 ("s390: Mark psw in __load_psw_mask() as __unitialized")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7278a8fb8d032dfdc03d9b5d17e0bc451cdc1492 Mon Sep 17 00:00:00 2001
From: Sven Schnelle <svens@linux.ibm.com>
Date: Tue, 30 Apr 2024 16:30:01 +0200
Subject: [PATCH] s390: Mark psw in __load_psw_mask() as __unitialized

Without __unitialized, the following code is generated when
INIT_STACK_ALL_ZERO is enabled:

86: d7 0f f0 a0 f0 a0     xc      160(16,%r15), 160(%r15)
8c: e3 40 f0 a0 00 24     stg     %r4, 160(%r15)
92: c0 10 00 00 00 08     larl    %r1, 0xa2
98: e3 10 f0 a8 00 24     stg     %r1, 168(%r15)
9e: b2 b2 f0 a0           lpswe   160(%r15)

The xc is not adding any security because psw is fully initialized
with the following instructions. Add __unitialized to the psw
definitiation to avoid the superfluous clearing of psw.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 1e2fc6d6963c..07ad5a1df878 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -314,8 +314,8 @@ static inline void __load_psw(psw_t psw)
  */
 static __always_inline void __load_psw_mask(unsigned long mask)
 {
+	psw_t psw __uninitialized;
 	unsigned long addr;
-	psw_t psw;
 
 	psw.mask = mask;
 


