Return-Path: <stable+bounces-205594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF0CFA3B1
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 842F53046DA9
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9BD2D9782;
	Tue,  6 Jan 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lLx8kEUp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54121A92F;
	Tue,  6 Jan 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721209; cv=none; b=rOfYp3W3INicdJvA3gdmDh4i0MAA04fvhDbn4NYnV0iQ60r7BaRZDLGItd0KpmNJMhWOZgYuo0orrYzm6O/6oXwTiV7r7Cyds+TCyTeFpqQc8ruyJggJrDfJ4zZORFq6I79ahuUtJlfaON5eWlTV6VkOobNztKddk7bceBtvYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721209; c=relaxed/simple;
	bh=k4GDYZHlFhrsBGokNgB8nIalVvnSJlemnALNIfZZCtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzhTPVVyC697stpk9Az3P19TreY5SheQmJgKAic2VuW84kakqToMg2I+TWiVd40uEALPBJWPEo5XCMcQ6FIk9Fx0NrTSfD7xuVMxykyA9Y8YY1U3CnYyMIZLtq13EI7pW2ocgKp0Nus6FrNTfID8iv02r02QfYDcZyC2NwsiCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lLx8kEUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8086C116C6;
	Tue,  6 Jan 2026 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721209;
	bh=k4GDYZHlFhrsBGokNgB8nIalVvnSJlemnALNIfZZCtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLx8kEUp04uAL1P1Xyf3BrWhDhrDI+HCamVY+vDcxlOWv9T7wZTtisTRDT4bB5Kb8
	 Cnh4eRj9bZG3mJaz6duORklX6QMBvanR2+G5Gk/+46D4/3Nlh7V6TUPF3Zwj1WjJQC
	 SwC9nw9ASujEvIl6iqzN1SX9WmveAliZjLXcOftE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 6.12 469/567] drm/mediatek: Fix probe device leaks
Date: Tue,  6 Jan 2026 18:04:11 +0100
Message-ID: <20260106170508.700640376@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 2a2a04be8e869a19c9f950b89b1e05832a0f7ec7 upstream.

Make sure to drop the reference taken to each component device during
probe on probe failure (e.g. probe deferral) and on driver unbind.

Fixes: 6ea6f8276725 ("drm/mediatek: Use correct device pointer to get CMDQ client register")
Cc: stable@vger.kernel.org	# 5.12
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250923152340.18234-4-johan@kernel.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -621,6 +621,13 @@ int mtk_find_possible_crtcs(struct drm_d
 	return ret;
 }
 
+static void mtk_ddp_comp_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static void mtk_ddp_comp_clk_put(void *_clk)
 {
 	struct clk *clk = _clk;
@@ -656,6 +663,10 @@ int mtk_ddp_comp_init(struct device *dev
 	}
 	comp->dev = &comp_pdev->dev;
 
+	ret = devm_add_action_or_reset(dev, mtk_ddp_comp_put_device, comp->dev);
+	if (ret)
+		return ret;
+
 	if (type == MTK_DISP_AAL ||
 	    type == MTK_DISP_BLS ||
 	    type == MTK_DISP_CCORR ||



