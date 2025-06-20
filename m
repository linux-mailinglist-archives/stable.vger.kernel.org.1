Return-Path: <stable+bounces-155064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06933AE1771
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CEA1897A11
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284C281351;
	Fri, 20 Jun 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1XVmC5rz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0C27BF76
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411471; cv=none; b=IseSA0iC5OGUq/k+2ni5w2nOEnwx8gccy9ruUDqWMwogZUo3ipF4uJ3aJJ1z196P4gIM7Q51Sp45JW1Wf6bvxMpJFB0mjq+UROH/gMj5I70KnkJ/kvgVhEVGi+7XupzwvkVWoKwc9wb4akmOHHxgLtUnVjwA3u6NBhqMeJHfzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411471; c=relaxed/simple;
	bh=HjtJqiQ9+cVoka77VqUIFjwRYeLXiWLsOGg1+2OYhTE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=thzHkPLqyDcDeb+E0di/3HTs4ibizKVoYu6+u3Eu+rszXKA/3pIk2b/doyfsVQjj1eA88Qn/ExyxlOvsCseoV15C9vf/VZ/aHCeOEIUtr/gmR4y8G2S2T8oJEK+ME1HmXiNon7yd3k1wLrNIISIklOIelgB8zbphewl0HR3YMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1XVmC5rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE74AC4CEE3;
	Fri, 20 Jun 2025 09:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750411471;
	bh=HjtJqiQ9+cVoka77VqUIFjwRYeLXiWLsOGg1+2OYhTE=;
	h=Subject:To:Cc:From:Date:From;
	b=1XVmC5rz30fM01kRRC9FYjXFfiFFugS1l/ZHU6lwtGwM14OoEgRlvqs8zCg2eAF1x
	 MDq6mJWMfG6gRpxjr+AuyEeJp/ztNwCkvShF2moGhao0IhC6Z24Sicgd1+ko7OF0GG
	 vdVFiEmSru9GvDPKq+9C7QegPzyE3WbmrnkRkmOY=
Subject: FAILED: patch "[PATCH] uio_hv_generic: Align ring size to system page" failed to apply to 6.6-stable tree
To: longli@microsoft.com,mhklinux@outlook.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:24:28 +0200
Message-ID: <2025062028-ability-zigzagged-b1e7@gregkh>
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
git cherry-pick -x 0315fef2aff9f251ddef8a4b53db9187429c3553
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062028-ability-zigzagged-b1e7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


