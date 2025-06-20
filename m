Return-Path: <stable+bounces-155058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B628AE1755
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972A8189EDB0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE19280333;
	Fri, 20 Jun 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBBuE3Nx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3627FD6D
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411165; cv=none; b=HuQOeww2zskC0DzyGcYEl9giCfS8ZglSzMIFvK9nGztuMwSwnFxgl6sltk2XJYU5i+qMI0kQNi3qpbqcl7D7iW5fYE+LLqJ4Q28nkq5YXbNJ+9Ue9jW6pW1bAi0cUq0B4ZOLE9Fn7IqoPnY1xxClG6fmUAlX7ytiDDY8jm8Gz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411165; c=relaxed/simple;
	bh=qOzPNZbcbJQYGl8yL3z0sFeFnwyB49B6acUdYOM1sRw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e/PaknhJ1nkfNnR8EiZCRXoJMrzCDM2b7BgHBVZw8Dpr/p+e9fGibS3i9OOHY1aaZCpwPdBa3X0Co6qCzjwwMIwBW5eMLzNKVEkMp5qvCytiudjc/fgb5tXAFtwNo+k3+grr6fYitU2eeQ/l/Md1bT5fSq19BKipSfG4Oea/qgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBBuE3Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E797C4CEE3;
	Fri, 20 Jun 2025 09:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750411165;
	bh=qOzPNZbcbJQYGl8yL3z0sFeFnwyB49B6acUdYOM1sRw=;
	h=Subject:To:Cc:From:Date:From;
	b=mBBuE3NxcnEQvitgi6zXhiEWSSXR++mej9peyPYsaWFffN0ZUyPHfKhxJxkRDWLbI
	 K6hnDAdZDqH1di/u7lLqO0hbuF/2dk9vXCBsOMv6xStsFgsbEORCetXq58vkcirEwT
	 FYZlRpkoBXzH4Yq33otD+71rKq0pdmo13MhiYUvA=
Subject: FAILED: patch "[PATCH] uio_hv_generic: Align ring size to system page" failed to apply to 5.6.1-stable tree
To: longli@microsoft.com,mhklinux@outlook.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:19:09 +0200
Message-ID: <2025062009-reward-founding-f804@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0315fef2aff9f251ddef8a4b53db9187429c3553
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062009-reward-founding-f804@gregkh' --subject-prefix 'PATCH 5.6.1.y' HEAD^..

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


