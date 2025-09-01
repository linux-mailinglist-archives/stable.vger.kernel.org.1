Return-Path: <stable+bounces-176850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB389B3E37C
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA8E203B03
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92E212FB9;
	Mon,  1 Sep 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yGLL/UvE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384DB17A2E6
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730450; cv=none; b=EyVr6TGOapEvHp6M7THSlvVo3Es/zuIxxEDBvysM7jhiMkNjTHdhgHezwf7ZZoTcUe7iBwlBUHpW5y1CNa718FAVj10A+M6xot8bM9MfhTzDVnIrP0u6AJPi9l/dvH/W+qaxRRyCxPLKiNGK45rxgbitxemvNsbTCyj6TnIk/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730450; c=relaxed/simple;
	bh=K66wKWpKsYQeY2DCqrN61ftC181HWnftwu4PsDsFGhU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LJFFrZQqcROdL5fBykmRwZFHqkh7o8WZykhHJr+afhZ4hUVerrDF2dQWVdAjdgwLYI/a84doAy0ka7hcTxT/2odb8H8vTs3O5Sa3CsjsqhB1jnET8jZIoi30WOwd7VANTcXSmVhB+MJ4XoOFjWLz2NKsfSPMpzlhNFv771RfuLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGLL/UvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B0FC4CEF0;
	Mon,  1 Sep 2025 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756730449;
	bh=K66wKWpKsYQeY2DCqrN61ftC181HWnftwu4PsDsFGhU=;
	h=Subject:To:Cc:From:Date:From;
	b=yGLL/UvEwqYFLa+VvcYAfzUbqoW3q0sSnv7ybfAEv+EJ66kSmfqccDUDBTfM+bc+t
	 DmZ8iEksjEpGljmRAFFFBKXYbc4m6vsGcrhYZYEGkUr59e3wYwI/2UtYILcocCba+8
	 /nQER46by9ti5i+o3buPOqAYKLurPvpZZmiy9qD4=
Subject: FAILED: patch "[PATCH] drm/mediatek: Fix device/node reference count leaks in" failed to apply to 6.6-stable tree
To: make24@iscas.ac.cn,chunkuang.hu@kernel.org,ck.hu@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Sep 2025 14:40:46 +0200
Message-ID: <2025090146-playback-kinsman-373c@gregkh>
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
git cherry-pick -x 1f403699c40f0806a707a9a6eed3b8904224021a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025090146-playback-kinsman-373c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f403699c40f0806a707a9a6eed3b8904224021a Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Tue, 12 Aug 2025 15:19:32 +0800
Subject: [PATCH] drm/mediatek: Fix device/node reference count leaks in
 mtk_drm_get_all_drm_priv

Using device_find_child() and of_find_device_by_node() to locate
devices could cause an imbalance in the device's reference count.
device_find_child() and of_find_device_by_node() both call
get_device() to increment the reference count of the found device
before returning the pointer. In mtk_drm_get_all_drm_priv(), these
references are never released through put_device(), resulting in
permanent reference count increments. Additionally, the
for_each_child_of_node() iterator fails to release node references in
all code paths. This leaks device node references when loop
termination occurs before reaching MAX_CRTC. These reference count
leaks may prevent device/node resources from being properly released
during driver unbind operations.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Cc: stable@vger.kernel.org
Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250812071932.471730-1-make24@iscas.ac.cn/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index d5e6bab36414..f8a817689e16 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -387,19 +387,19 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 
 		of_id = of_match_node(mtk_drm_of_ids, node);
 		if (!of_id)
-			continue;
+			goto next_put_node;
 
 		pdev = of_find_device_by_node(node);
 		if (!pdev)
-			continue;
+			goto next_put_node;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
 		if (!drm_dev)
-			continue;
+			goto next_put_device_pdev_dev;
 
 		temp_drm_priv = dev_get_drvdata(drm_dev);
 		if (!temp_drm_priv)
-			continue;
+			goto next_put_device_drm_dev;
 
 		if (temp_drm_priv->data->main_len)
 			all_drm_priv[CRTC_MAIN] = temp_drm_priv;
@@ -411,10 +411,17 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-		if (cnt == MAX_CRTC) {
-			of_node_put(node);
+next_put_device_drm_dev:
+		put_device(drm_dev);
+
+next_put_device_pdev_dev:
+		put_device(&pdev->dev);
+
+next_put_node:
+		of_node_put(node);
+
+		if (cnt == MAX_CRTC)
 			break;
-		}
 	}
 
 	if (drm_priv->data->mmsys_dev_num == cnt) {


