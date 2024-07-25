Return-Path: <stable+bounces-61382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE793C20E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FFF1C21541
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B6F1993A4;
	Thu, 25 Jul 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uDTZGL0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B821991DC
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910519; cv=none; b=VdPO+dLEE8N4IhkCf76VPYFeQZuRfsHLy+tGDsTVxyp3do20P1NKGUIgGi5vDpVXygOdH+e2CwUhJdJUFuc0a+0io7HiHE9Sr9GfO2GAOTbgcvDxU75AHkM+KX86OFDM3b540Z7P4R+4xuy7UD8KX0KHs+CKB/JJMEXFfqhOMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910519; c=relaxed/simple;
	bh=O1/5TZ4r319GSiuyybINOsR+FG0zuqV8OLhKc+3f3uE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i/gFw5hiJNswbeN61kL9x98FyHFxLpapW5RSXsf7H/tcXY+noDpnyRbDvtYKyqGuhrRc/X1QX1nXmUYmMe8ztDEbqDOAwUM3qaMtYMOEIkjHWuPBKSbV61tYDtVSgp16OPs/ub5EbSjCuE1zdtWTqLMcwVCC8TjY3l6kkI3kkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uDTZGL0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B1AC116B1;
	Thu, 25 Jul 2024 12:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721910519;
	bh=O1/5TZ4r319GSiuyybINOsR+FG0zuqV8OLhKc+3f3uE=;
	h=Subject:To:Cc:From:Date:From;
	b=uDTZGL0ZfVIAIvXdY9pXs6LLZHpy+w3DZUx0dFyT9tNjPmlhviOa1XWUH9WFsPY+0
	 bKrv6EiDU6IcxlDIntBNdVdXjqfywTO9GoNY5uf4Dl3aqefJhtHt6y5e/FhxPoyehI
	 pxfIA5lBRhrR+7wUTWCSupqZJNCkSdd3gtEkkm3Q=
Subject: FAILED: patch "[PATCH] s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()" failed to apply to 6.6-stable tree
To: gerald.schaefer@linux.ibm.com,agordeev@linux.ibm.com,gor@linux.ibm.com,yskelg@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:28:35 +0200
Message-ID: <2024072535-synergy-struggle-8ecc@gregkh>
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
git cherry-pick -x df39038cd89525d465c2c8827eb64116873f141a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072535-synergy-struggle-8ecc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

df39038cd895 ("s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()")
b20c8216c1e0 ("s390/mm,fault: move VM_FAULT_ERROR handling to do_exception()")
7c194d84a9ce ("s390/mm,fault: remove VM_FAULT_BADMAP and VM_FAULT_BADACCESS")
b61a0922b6dc ("s390/mm,fault: remove VM_FAULT_SIGNAL")
0f86ac4ba713 ("s390/mm,fault: remove VM_FAULT_BADCONTEXT")
0f1a14e0348e ("s390/mm,fault: simplify kfence fault handling")
64ea33fb09f8 ("s390/mm,fault: call do_fault_error() only from do_exception()")
5db06565cad6 ("s390/mm,fault: get rid of do_low_address()")
cca12b427d43 ("s390/mm,fault: remove VM_FAULT_PFAULT")
5be05c35e72f ("s390/mm,fault: improve readability by using teid union")
4416d2ed8166 ("s390/mm,fault: use static key for store indication")
9641613f48bb ("s390/mm,fault: use get_fault_address() everywhere")
5c845de331d9 ("s390/mm,fault: remove noinline attribute from all functions")
8dbc33dc8163 ("s390/mm,fault: have balanced braces, remove unnecessary blanks")
7c915a84e5e2 ("s390/mm,fault: reverse x-mas tree coding style")
3aad8c044297 ("s390/mm,fault: remove and improve comments, adjust whitespace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From df39038cd89525d465c2c8827eb64116873f141a Mon Sep 17 00:00:00 2001
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Date: Mon, 15 Jul 2024 20:04:16 +0200
Subject: [PATCH] s390/mm: Fix VM_FAULT_HWPOISON handling in do_exception()

There is no support for HWPOISON, MEMORY_FAILURE, or ARCH_HAS_COPY_MC on
s390. Therefore we do not expect to see VM_FAULT_HWPOISON in
do_exception().

However, since commit af19487f00f3 ("mm: make PTE_MARKER_SWAPIN_ERROR more
general"), it is possible to see VM_FAULT_HWPOISON in combination with
PTE_MARKER_POISONED, even on architectures that do not support HWPOISON
otherwise. In this case, we will end up on the BUG() in do_exception().

Fix this by treating VM_FAULT_HWPOISON the same as VM_FAULT_SIGBUS, similar
to x86 when MEMORY_FAILURE is not configured. Also print unexpected fault
flags, for easier debugging.

Note that VM_FAULT_HWPOISON_LARGE is not expected, because s390 cannot
support swap entries on other levels than PTE level.

Cc: stable@vger.kernel.org # 6.6+
Fixes: af19487f00f3 ("mm: make PTE_MARKER_SWAPIN_ERROR more general")
Reported-by: Yunseong Kim <yskelg@gmail.com>
Tested-by: Yunseong Kim <yskelg@gmail.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Message-ID: <20240715180416.3632453-1-gerald.schaefer@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 6b19a33c49c2..8e149ef5e89b 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -433,12 +433,13 @@ static void do_exception(struct pt_regs *regs, int access)
 			handle_fault_error_nolock(regs, 0);
 		else
 			do_sigsegv(regs, SEGV_MAPERR);
-	} else if (fault & VM_FAULT_SIGBUS) {
+	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON)) {
 		if (!user_mode(regs))
 			handle_fault_error_nolock(regs, 0);
 		else
 			do_sigbus(regs);
 	} else {
+		pr_emerg("Unexpected fault flags: %08x\n", fault);
 		BUG();
 	}
 }


