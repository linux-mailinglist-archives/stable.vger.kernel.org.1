Return-Path: <stable+bounces-186080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C54BE382D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03031A61CE6
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FBE335BB5;
	Thu, 16 Oct 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pS7CJ/76"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ABA335BB1
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619252; cv=none; b=JbRzZAJmrWg96HEQa3G3KfhOCB1FvIgGBclGr7BTcNDX3odJsNwGSOGjunQ1rghffwQfUCVfFuT9BBEBV/ArdyMEcn2/GMWDdurewz+Nln/iJyiECudqqJlgbjoRryqDEG25rcgoWEIX6zvzrSIYa+D6EdJ9YzjKtymJnVhlBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619252; c=relaxed/simple;
	bh=dlhgVTWY4WQ7of2/9/pxv8Isq1S9vDpTVyUH3Mkcc98=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ty4DDfPr4qyha1tIou4sf8ulYoGAxKljKDO6ygm5Vsv4hddnLowWycgeKg+JtJKR17ZTsAQSYFTwLieTx4Qk4QmvZVg5zGXjPkbgIfuMiC/Xn3h9XY5GiLxUPY4mq+61X2Bjslvs5D8oqN4pLuV/DZ1c03w8PlujfPTWUSn7/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pS7CJ/76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5328DC4CEFE;
	Thu, 16 Oct 2025 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619249;
	bh=dlhgVTWY4WQ7of2/9/pxv8Isq1S9vDpTVyUH3Mkcc98=;
	h=Subject:To:Cc:From:Date:From;
	b=pS7CJ/76Y8vF6F9ljtakcZZFfmzh6RkA+nc/YCsW/Chdl2EuFJ1Necnz+zYnr0Y4E
	 xZg5TYVHcapoMlhuGl5vdX0iLZzJZWi1li5ToSDcUfyH0iM02T9p6bRzgtQA4Ky5Kb
	 XMG2xbVTQFurvaAjS5FdLbjoN3+ZgKfTwiHn5/FQ=
Subject: FAILED: patch "[PATCH] xtensa: simdisk: add input size check in proc_write_simdisk" failed to apply to 5.15-stable tree
To: linmq006@gmail.com,jcmvbkbc@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:54:06 +0200
Message-ID: <2025101606-wildfire-moody-50d8@gregkh>
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
git cherry-pick -x 5d5f08fd0cd970184376bee07d59f635c8403f63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101606-wildfire-moody-50d8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d5f08fd0cd970184376bee07d59f635c8403f63 Mon Sep 17 00:00:00 2001
From: Miaoqian Lin <linmq006@gmail.com>
Date: Fri, 29 Aug 2025 16:30:15 +0800
Subject: [PATCH] xtensa: simdisk: add input size check in proc_write_simdisk

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")

Fixes: b6c7e873daf7 ("xtensa: ISS: add host file-based simulated disk")
Fixes: 16e5c1fc3604 ("convert a bunch of open-coded instances of memdup_user_nul()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Message-Id: <20250829083015.1992751-1-linmq006@gmail.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 6ed009318d24..3cafc8feddee 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -231,10 +231,14 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 static ssize_t proc_write_simdisk(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
-	char *tmp = memdup_user_nul(buf, count);
+	char *tmp;
 	struct simdisk *dev = pde_data(file_inode(file));
 	int err;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
+	tmp = memdup_user_nul(buf, count);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 


