Return-Path: <stable+bounces-155044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC5AE173C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA363A5CD5
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA027FB14;
	Fri, 20 Jun 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fOiu4ROr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47023312D
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410715; cv=none; b=J9YG6EPP69mE+e//b29mm3Y/EyFZj03/kgutdtXkwNrtyL70e1BlWNE/Le/ToqeMzdTUCQpm9LBwo5XAudWaKaLUOixE7OenLjdoW8z2MQOpkMOaxbfjvAp8mHhXqXM4nI2GML5b2adnFfD7fDZgPgCqC+r+WkteCuMLbiAst/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410715; c=relaxed/simple;
	bh=OthBb49YKby0g+E1ww7a19RVF4It3TmPQiM4jl5gokE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SniCdmKJ/aMkvUmHV3DmWjX3xWsmKdEST85NVGHwTKPJTArVRiom4xv9/0asI9EVggWuFPhjXi/GzdwvbECz6xpSYviYKMv8ScWrbgE0gCHpRc583mKHfrw5uBQib8NZrXX/YjdbvD9IJM4J/SRSDjtDajxC8ywR9WxXL7K9EMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fOiu4ROr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D02C4CEED;
	Fri, 20 Jun 2025 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410715;
	bh=OthBb49YKby0g+E1ww7a19RVF4It3TmPQiM4jl5gokE=;
	h=Subject:To:Cc:From:Date:From;
	b=fOiu4ROrD73z6ZrI4gpKJAqmFO56JdpVtzoPiU/YxCzwyEFbjH21X4n4EB7SWCVGc
	 BcDs7W5o58kOVH1Tp0VNO5U6GKzu3ufiUleM4PWde6Eu7RnDpQ7jzJ1enGBM6HVlP/
	 6jS/9kp4/1ngxWr60Cs/q8xGCUUPBRZ0+jEB2pFw=
Subject: FAILED: patch "[PATCH] uio_hv_generic: Align ring size to system page" failed to apply to 5.4-stable tree
To: longli@microsoft.com,mhklinux@outlook.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:11:39 +0200
Message-ID: <2025062039-result-repair-ee9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 0315fef2aff9f251ddef8a4b53db9187429c3553
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062039-result-repair-ee9a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


