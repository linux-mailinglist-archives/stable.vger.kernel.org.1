Return-Path: <stable+bounces-5135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926D580B437
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A271C20A00
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929711184;
	Sat,  9 Dec 2023 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I4ZGimKT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBD187C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC36C433C7;
	Sat,  9 Dec 2023 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702125232;
	bh=QGYT6u8+2U8RzQXab8kyK/PnNFsJTfAve0r2uaZBu3c=;
	h=Subject:To:Cc:From:Date:From;
	b=I4ZGimKT/B/zGrz3xBqAmKLEWqq6mPpmlu3mQGQ1nsy/Zt/1nDkSZeudyizH2bAeD
	 tYo4WlyR/k16KCO1mFGoGH14T/pbYvGA4xhY4I/LPQMRwi1Wx6zDwTTI1voOAvWHCU
	 PbSBM1MvRBEIy65EH8hXUXZqnFM42cXsOqrSfieI=
Subject: FAILED: patch "[PATCH] parisc: Fix asm operand number out of range build error in" failed to apply to 6.6-stable tree
To: deller@gmx.de,lkft@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:33:49 +0100
Message-ID: <2023120949-antiquity-primer-60c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 487635756198cad563feb47539c6a37ea57f1dae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120949-antiquity-primer-60c1@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

487635756198 ("parisc: Fix asm operand number out of range build error in bug table")
43266838515d ("parisc: Reduce size of the bug_table on 64-bit kernel by half")
fe76a1349f23 ("parisc: Use natural CPU alignment for bug_table")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 487635756198cad563feb47539c6a37ea57f1dae Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Mon, 27 Nov 2023 10:39:26 +0100
Subject: [PATCH] parisc: Fix asm operand number out of range build error in
 bug table

Build is broken if CONFIG_DEBUG_BUGVERBOSE=n.
Fix it be using the correct asm operand number.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: fe76a1349f23 ("parisc: Use natural CPU alignment for bug_table")
Cc: stable@vger.kernel.org   # v6.0+

diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 1641ff9a8b83..833555f74ffa 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -71,7 +71,7 @@
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
 			     "\t.pushsection __bug_table,\"a\"\n"	\
-			     "\t.align %2\n"				\
+			     "\t.align 4\n"				\
 			     "2:\t" __BUG_REL(1b) "\n"			\
 			     "\t.short %0\n"				\
 			     "\t.blockz %1-4-2\n"			\


