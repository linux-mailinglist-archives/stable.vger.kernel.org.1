Return-Path: <stable+bounces-155057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD248AE1754
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D699189DC8D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FD2280327;
	Fri, 20 Jun 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LZFVGGZl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F427FD6D
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411162; cv=none; b=KesimwXviJCgI+U/n6ZvokIxNp8aAOI0wgeNb6Y/X7LBqR1Zyr/5bVsxRuidfide7LgKIeHqJ/H2rEByvPeIh47q9Lw1oL9DHbOKV7JOFUEB805UjP08acDOurDqLrv9ZzHRaWsUZ9V9E4lyDW47/MuaUEDGN5FNbYQoN6auYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411162; c=relaxed/simple;
	bh=bG2nfuEex9dka0gpsHXZrWCeOgFV3+8vDVYXzZAWiJc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i0JmwLRQWDGYXRWYydLnTlt09l3xYShzwTB76mSR3mYj54vPVLFpoYJJDgc87jB/IvXKcPbJpvHJCnCkolZpZD63CPpHIOZ0/bM7uHehIoW5fj7312blOmXUL0r2RO7qxG3wk9IhhaPmHdOn2rnU94wnSWWAAKz/RPBbW1ZyAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LZFVGGZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D72AC4CEED;
	Fri, 20 Jun 2025 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750411162;
	bh=bG2nfuEex9dka0gpsHXZrWCeOgFV3+8vDVYXzZAWiJc=;
	h=Subject:To:Cc:From:Date:From;
	b=LZFVGGZlarWbH5vrZNRCD3t5lEty6S0gZLnRRkBlIj6K8syzZck3iyb4ymXaXziWb
	 OORyxcMbMyIKAPrSbeZX4+b+EAojsHiPfTnuAiKkp3HFNAMEpGOQak6WDD4e2XSWcS
	 qqTA8d1YkWXHi+LfBZ/WG8T6Rd92ULHe8hEVzRPI=
Subject: FAILED: patch "[PATCH] uio_hv_generic: Align ring size to system page" failed to apply to 5.15-stable tree
To: longli@microsoft.com,mhklinux@outlook.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:18:42 +0200
Message-ID: <2025062042-matter-tragedy-57ab@gregkh>
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
git cherry-pick -x 0315fef2aff9f251ddef8a4b53db9187429c3553
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062042-matter-tragedy-57ab@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0315fef2aff9f251ddef8a4b53db9187429c3553 Mon Sep 17 00:00:00 2001
From: Long Li <longli@microsoft.com>
Date: Mon, 5 May 2025 17:56:35 -0700
Subject: [PATCH] uio_hv_generic: Align ring size to system page

Following the ring header, the ring data should align to system page
boundary. Adjust the size if necessary.

Cc: stable@vger.kernel.org
Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus")
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1746492997-4599-4-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1746492997-4599-4-git-send-email-longli@linuxonhyperv.com>

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index cc3a350dbbd5..aac67a4413ce 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -243,6 +243,9 @@ hv_uio_probe(struct hv_device *dev,
 	if (!ring_size)
 		ring_size = SZ_2M;
 
+	/* Adjust ring size if necessary to have it page aligned */
+	ring_size = VMBUS_RING_SIZE(ring_size);
+
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;


