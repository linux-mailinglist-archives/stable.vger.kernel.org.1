Return-Path: <stable+bounces-59089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A920B92E3A8
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 496CAB21CD1
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E2815279E;
	Thu, 11 Jul 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kbD3upXa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFF1509AE
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690991; cv=none; b=ml8IeHOXmPmpbSh4V0Y06ulk9vm4erHyshKcOzElLcpysdwyGgpsXqRLQJYC/kG7F/8M5WqNb5RHd9puI8vJjs8BwEwqP/p+ELB64tl+Y8+wjUnDW6uj/AbGm16ohHYonlz039DlVA8V3bka7eFMiHJ3k782x5hCQQ68xSpWgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690991; c=relaxed/simple;
	bh=u8kpBsuSsF6xv0epROcpPxfE1vERt6tEwFMO4aaM7G0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y3URAsAPXUR0XNVptHhlv2dWQeDojWF/tHtjZXN9bNS/myMk7Fupf6yKm+tfG1tDrDNddwhsGgH3kw0ay8Bdop/UhNqjIzlyfeok8t4Ju2Oneo2zBdf0h0tZnun/dYGNCp/5zWn06lEyJhmaXJnVq73Ze7t3zqmE4WT5c6iQ41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kbD3upXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAB2C116B1;
	Thu, 11 Jul 2024 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720690991;
	bh=u8kpBsuSsF6xv0epROcpPxfE1vERt6tEwFMO4aaM7G0=;
	h=Subject:To:Cc:From:Date:From;
	b=kbD3upXaGHkIK17zRPDjFELRDbcFJlIr0+NVDb1VpHhywL5M96d9faXBUC9HhoaEr
	 z0njujmA+cx4tRKy7YoLvUUIXbdW5qmBdmxvdFDjKHF+jFSw51wsNoslZA4AChYp13
	 S9CtegfgQVwTpVkEXczMZtFS9l3YZvTsZ61vWY0o=
Subject: FAILED: patch "[PATCH] s390: Mark psw in __load_psw_mask() as __unitialized" failed to apply to 4.19-stable tree
To: svens@linux.ibm.com,agordeev@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 11 Jul 2024 11:42:55 +0200
Message-ID: <2024071155-mushiness-lumpiness-edc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 7278a8fb8d032dfdc03d9b5d17e0bc451cdc1492
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071155-mushiness-lumpiness-edc1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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
 


