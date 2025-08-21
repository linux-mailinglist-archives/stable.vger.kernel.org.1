Return-Path: <stable+bounces-172114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6BDB2FADE
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06B61D005FE
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D543E338F26;
	Thu, 21 Aug 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sj1hIySJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DE73376AC
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783246; cv=none; b=eTpDhC/6JcrHLfn7PK9WclAW1C5BBeGAz8g/HfaNUEBCjY5EHJ8nE42kaoA7C+1Y3/cOuUpwnJzFr1RTvNC3ZOx8fCBYIi7U7nUFeBIo0FfJAT12UwEhTNYKU3Ab+jpRpGWUZs4irgmMhuGbKYG3CKIS8r37xRDOdMPsqH2LZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783246; c=relaxed/simple;
	bh=hwDUHQNz8gJxB5HCNN/LNtNVpHmVb3TXvAMAwv6OHf8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oEqgRXU2zf54KnLs0WNxjAPBe2gwPW177lsCBSao+Et1EyD8FcGcQ0xZBifYj6t+Dyk3H6kWhKSPETF3XHwBYLt+t0jfWs3iUiqG/cW/DKXOWLP13hKfC/LApajVxUD0sWT8PANwdT6i2/rX9X77a5NuqJF2dhpAeKBnIpv1aug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sj1hIySJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC92C4CEEB;
	Thu, 21 Aug 2025 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783246;
	bh=hwDUHQNz8gJxB5HCNN/LNtNVpHmVb3TXvAMAwv6OHf8=;
	h=Subject:To:Cc:From:Date:From;
	b=sj1hIySJEVtdgPYv/JYNDJRhZnBYGgMrIWIcQHgZYSZDxM3ME4CFgGhGJ2r2J22de
	 FnocTdTvORwk0uhQgsDOA0sSjyCkPXdgjJsDxKpXR6284mYnVKcN0aqhZAwr4bi2ZL
	 wFQHwk6NlO/c25Dna2dCttNPNNv747Vk01thDdlk=
Subject: FAILED: patch "[PATCH] parisc: Revise __get_user() to probe user read access" failed to apply to 5.15-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:33:55 +0200
Message-ID: <2025082155-mocker-overripe-4212@gregkh>
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
git cherry-pick -x 89f686a0fb6e473a876a9a60a13aec67a62b9a7e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082155-mocker-overripe-4212@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89f686a0fb6e473a876a9a60a13aec67a62b9a7e Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Fri, 25 Jul 2025 13:51:32 -0400
Subject: [PATCH] parisc: Revise __get_user() to probe user read access

Because of the way read access support is implemented, read access
interruptions are only triggered at privilege levels 2 and 3. The
kernel executes at privilege level 0, so __get_user() never triggers
a read access interruption (code 26). Thus, it is currently possible
for user code to access a read protected address via a system call.

Fix this by probing read access rights at privilege level 3 (PRIV_USER)
and setting __gu_err to -EFAULT (-14) if access isn't allowed.

Note the cmpiclr instruction does a 32-bit compare because COND macro
doesn't work inside asm.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index 88d0ae5769dd..6c531d2c847e 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -42,9 +42,24 @@
 	__gu_err;					\
 })
 
-#define __get_user(val, ptr)				\
-({							\
-	__get_user_internal(SR_USER, val, ptr);	\
+#define __probe_user_internal(sr, error, ptr)			\
+({								\
+	__asm__("\tproberi (%%sr%1,%2),%3,%0\n"			\
+		"\tcmpiclr,= 1,%0,%0\n"				\
+		"\tldi %4,%0\n"					\
+		: "=r"(error)					\
+		: "i"(sr), "r"(ptr), "i"(PRIV_USER),		\
+		  "i"(-EFAULT));				\
+})
+
+#define __get_user(val, ptr)					\
+({								\
+	register long __gu_err;					\
+								\
+	__gu_err = __get_user_internal(SR_USER, val, ptr);	\
+	if (likely(!__gu_err))					\
+		__probe_user_internal(SR_USER, __gu_err, ptr);	\
+	__gu_err;						\
 })
 
 #define __get_user_asm(sr, val, ldx, ptr)		\


