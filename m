Return-Path: <stable+bounces-205108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C7CF917B
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5CB230EECCB
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFD833985A;
	Tue,  6 Jan 2026 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b5z/c2Y5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F5339B2F
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712650; cv=none; b=tE9+TYYdWOJCJ4cBGCgnLCUJ+sqkhs4b2x3bt2xYvhs/f57n+/79ZRZsM5pR/ZCdk5p30Qy/r47gfN1PhR/UqGJr61lzVo/U3dqfC3hFpe+Sa9880qY3NlkJGCAGSHhFNIXxXS0sY9O88z3iyliZus9yQir+mTbaC0cmUX/3+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712650; c=relaxed/simple;
	bh=GUHXWmHyMLvaWlTPF1CR9NYTi/5V8ZpmHDrJJ+tYVAg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pta5oIQ/eBEE/7lop97Hlq0TVacLiRpdf+mCxgsyqjQXTJ/RuAaKS3eJI+0vspbgXsD8VUcoqlKTrxWnS6yUV2spHQz/efG/C50gFcNYaWizFUDzIHjq/MfLhb9GqbqclZtjoJCPbVa8mLYg9xiJbCVsVCigOEH96I+O+hxiWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b5z/c2Y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0344EC116C6;
	Tue,  6 Jan 2026 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767712649;
	bh=GUHXWmHyMLvaWlTPF1CR9NYTi/5V8ZpmHDrJJ+tYVAg=;
	h=Subject:To:Cc:From:Date:From;
	b=b5z/c2Y5aCoHQwpUHJxLwMNldf0U5yCzE3/YSR/rMn2fvWG5HFTIjgIF8H2VP0Au4
	 UtCCQYkrryNr9hWrB8XHQcIW8KetTcKnIV0sbuws+WRlwQ7VSQpG/KBGPUeaJ8Ubse
	 59kWsN0Vzx19TYhj/ps+13/oDJRCluFn8+fSuRW8=
Subject: FAILED: patch "[PATCH] drm/mediatek: ovl_adaptor: Fix probe device leaks" failed to apply to 6.6-stable tree
To: johan@kernel.org,angelogioacchino.delregno@collabora.com,chunkuang.hu@kernel.org,nancy.lin@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Jan 2026 16:17:26 +0100
Message-ID: <2026010626-drainable-stricken-476d@gregkh>
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
git cherry-pick -x e0f44f74ed6313e50b38eb39a2c7f210ae208db2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010626-drainable-stricken-476d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0f44f74ed6313e50b38eb39a2c7f210ae208db2 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 23 Sep 2025 17:23:40 +0200
Subject: [PATCH] drm/mediatek: ovl_adaptor: Fix probe device leaks

Make sure to drop the references taken to the component devices by
of_find_device_by_node() during probe on probe failure (e.g. probe
deferral) and on driver unbind.

Fixes: 453c3364632a ("drm/mediatek: Add ovl_adaptor support for MT8195")
Cc: stable@vger.kernel.org	# 6.4
Cc: Nancy.Lin <nancy.lin@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250923152340.18234-6-johan@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index fe97bb97e004..c0af3e3b51d5 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -527,6 +527,13 @@ bool mtk_ovl_adaptor_is_comp_present(struct device_node *node)
 	       type == OVL_ADAPTOR_TYPE_PADDING;
 }
 
+static void ovl_adaptor_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int ovl_adaptor_comp_init(struct device *dev, struct component_match **match)
 {
 	struct mtk_disp_ovl_adaptor *priv = dev_get_drvdata(dev);
@@ -560,6 +567,11 @@ static int ovl_adaptor_comp_init(struct device *dev, struct component_match **ma
 		if (!comp_pdev)
 			return -EPROBE_DEFER;
 
+		ret = devm_add_action_or_reset(dev, ovl_adaptor_put_device,
+					       &comp_pdev->dev);
+		if (ret)
+			return ret;
+
 		priv->ovl_adaptor_comp[id] = &comp_pdev->dev;
 
 		drm_of_component_match_add(dev, match, component_compare_of, node);


