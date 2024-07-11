Return-Path: <stable+bounces-59085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D951492E3A4
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C861B21C3E
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4F6156F46;
	Thu, 11 Jul 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="usdFNYhz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDBD76034
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690978; cv=none; b=HwHcMejIMgYg8xlSs0k4LY8fpePK8qYYqLnL6yG2nqS9NYL+0uXWUqFXwCcLv4JhewZ12wunyHzPS9XQ9y9QcvD1iIN0S+UX4IQJK5Sy7hM2f6GqNcLw/8wl7pD5Em4fRh3G2MsDzHeXH7TiuAomTNhEZNF2FkVOgas+yDt7y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690978; c=relaxed/simple;
	bh=LmTFbA9KTVKhpCD7WHzyojQcTatNS4C7pEB+Od1VL+s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LncgaGhNMwXzcg6or49bqyYzm42Ob6E+XUN+yN4CPxwB/qk+zCoIUm/a/uat5TfLrWPcSO6ojVGVu+zsvkFPy2uAeXjaXNwx4ZvRUKluem3s/dOyRGwRYKgGRQodqm9SBskrKgY+GgNJKRVv4nd3FzlFadETEgC+T2/7HASJo78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=usdFNYhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C04C116B1;
	Thu, 11 Jul 2024 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720690977;
	bh=LmTFbA9KTVKhpCD7WHzyojQcTatNS4C7pEB+Od1VL+s=;
	h=Subject:To:Cc:From:Date:From;
	b=usdFNYhzqBn11M0WABRnGU+nIikXKovoJ7zaBLfPlWCCmzsXYRdqiSHmF0a6EvDVS
	 lCK1H5WLIdzTWPrmYfmyN3bcNfgUOqKoJIJIs8ymacUHc/dpELB3+JUvZzQh/zu0M2
	 hVlzcRhJGkFe1F/gH3Ffwc/ycY07WV4QPjmhLoXY=
Subject: FAILED: patch "[PATCH] s390: Mark psw in __load_psw_mask() as __unitialized" failed to apply to 6.1-stable tree
To: svens@linux.ibm.com,agordeev@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 11 Jul 2024 11:42:52 +0200
Message-ID: <2024071152-smoked-reheat-1908@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7278a8fb8d032dfdc03d9b5d17e0bc451cdc1492
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071152-smoked-reheat-1908@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


