Return-Path: <stable+bounces-99003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C09E6D33
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09C0F2834EA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7D1DA61E;
	Fri,  6 Dec 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BoFR0VBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1C46426
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484096; cv=none; b=FtGh0f9AQn6QZS43mUVBqR5k/ulLHLb/y2zvcovDABtrOob0knD1aJYp9IMWG92jbec8z+BW6p+AZZBdLz+OwqU5GQn1apHs9LAsFZjuhCJInlC3EpcPewrkVuc81W/2laERdYRvuQ0Y4FD3SYlflTN41H0OCuG3ohP3lNRskkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484096; c=relaxed/simple;
	bh=p2Fy1kjDcuVFpt6q4KvFnSUPett9FOdyZgYrT008SKg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SgwYarIhLKFWukZO3DYrYq4hPQdRa7KYL1Pq9/zZJh2sYnd0YrB7BXFmxgFa/cGnAa1XAwM3aXUaZ4iqomC+5SDTadTD7NSAESnq26X3Aj0IkfN7K/2X5l5oaD3Cwrb94RB9Gm7wSDketkAUUkQfYeroifiJfnMV9w5QgbkTliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BoFR0VBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE051C4CED1;
	Fri,  6 Dec 2024 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733484096;
	bh=p2Fy1kjDcuVFpt6q4KvFnSUPett9FOdyZgYrT008SKg=;
	h=Subject:To:Cc:From:Date:From;
	b=BoFR0VBDfDkodPCuKX2eFpEIVERxidmU4p9YhF3VLTkn5v6l88ATtkDsSPpuUoWSr
	 KnRn6BXpxuHfQVn4gztMpqvk+SK/T5rUVk/jV7vw9SEFxV7E85WeXl48wJfY7+cAkv
	 uH8R/OVRFw4DL9GkYA1212vFQ6Slk5pHVJwrOCAY=
Subject: FAILED: patch "[PATCH] media: platform: exynos4-is: Fix an OF node reference leak in" failed to apply to 5.10-stable tree
To: joe@pf.is.s.u-tokyo.ac.jp,hverkuil@xs4all.nl,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 12:21:24 +0100
Message-ID: <2024120624-skype-wisdom-07d3@gregkh>
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
git cherry-pick -x 8964eb23408243ae0016d1f8473c76f64ff25d20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120624-skype-wisdom-07d3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8964eb23408243ae0016d1f8473c76f64ff25d20 Mon Sep 17 00:00:00 2001
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Date: Mon, 4 Nov 2024 19:01:19 +0900
Subject: [PATCH] media: platform: exynos4-is: Fix an OF node reference leak in
 fimc_md_is_isp_available

In fimc_md_is_isp_available(), of_get_child_by_name() is called to check
if FIMC-IS is available. Current code does not decrement the refcount of
the returned device node, which causes an OF node reference leak. Fix it
by calling of_node_put() at the end of the variable scope.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Fixes: e781bbe3fecf ("[media] exynos4-is: Add fimc-is subdevs registration")
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[hverkuil: added CC to stable]

diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.h b/drivers/media/platform/samsung/exynos4-is/media-dev.h
index 786264cf79dc..a50e58ab7ef7 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.h
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.h
@@ -178,8 +178,9 @@ int fimc_md_set_camclk(struct v4l2_subdev *sd, bool on);
 #ifdef CONFIG_OF
 static inline bool fimc_md_is_isp_available(struct device_node *node)
 {
-	node = of_get_child_by_name(node, FIMC_IS_OF_NODE_NAME);
-	return node ? of_device_is_available(node) : false;
+	struct device_node *child __free(device_node) =
+		of_get_child_by_name(node, FIMC_IS_OF_NODE_NAME);
+	return child ? of_device_is_available(child) : false;
 }
 #else
 #define fimc_md_is_isp_available(node) (false)


