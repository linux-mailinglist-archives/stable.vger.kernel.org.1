Return-Path: <stable+bounces-186082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C675BE3833
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BAB1A611CA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF6433438B;
	Thu, 16 Oct 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dA3L4j06"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA35334380
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619261; cv=none; b=THjla3EtYUcxjL3cHmF4aZXLDkhnPsocH+iV2Vwp0zqlZHpY/xvNG1aocufuxV12hShLZ3b5wl0K78AGZHbwDFDEZdJoNWu/y6DcYBVzsHH/BRm7+SvOWDpFRj9NhKQ1shUG32eEzqF7Dv+wkwsBl/R3f47o7VIgSt+1IlW3B6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619261; c=relaxed/simple;
	bh=+FpDEN+2ptZKUa2iJhm8o9/pZUs16/w6MzUSWgGSvbQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=j7aff1NZbrpTj2LFKGuAlhOGGW7C1pA9OmUMTlqo0ybUr4KVhMO1VnSt+G0PPUGd38pC+bwBycif45DPQV4yFmNNBOLzNg3YY2suF+TvQcLeWITIRXJoxiJYxCEFCnH7tj7ZpA9PhGF+Vvoaa2qNWeDSZlQV7unpuJB2bbV1BVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dA3L4j06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE5C4CEF1;
	Thu, 16 Oct 2025 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619260;
	bh=+FpDEN+2ptZKUa2iJhm8o9/pZUs16/w6MzUSWgGSvbQ=;
	h=Subject:To:Cc:From:Date:From;
	b=dA3L4j06p78Tnl68vY29wxqe7Fxm0EULdeSptBJAng0W/e9HC/o0mBx3J+ZG5ia5P
	 D1g/4nkLO3pTqYVXURaw+Y6wXtuDoqbgIJOKnMKOFGlEOQBLIOeh0My4VkZvGj3DQb
	 zGpod3Ks1+AyVU4C7WmgtEK+0tro5sRnVlKuPLj8=
Subject: FAILED: patch "[PATCH] xtensa: simdisk: add input size check in proc_write_simdisk" failed to apply to 5.10-stable tree
To: linmq006@gmail.com,jcmvbkbc@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:54:07 +0200
Message-ID: <2025101607-sift-throttle-b1aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5d5f08fd0cd970184376bee07d59f635c8403f63
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101607-sift-throttle-b1aa@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


