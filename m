Return-Path: <stable+bounces-163676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CBBB0D5F6
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 11:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033A916C041
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228952DCBF8;
	Tue, 22 Jul 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZfm9RJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C02DC35C;
	Tue, 22 Jul 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176469; cv=none; b=MhtxPg+vTRToT3U8AeolNV1L2dGUPDm0pKlJ04EEDKxDAd4ei6gc4iXa80FY//73IH6DTFt89BPU+DlFtbBHWQICkYNsGG91Gr+3BwlUnIkpdJurTqfjrNB4awZ179h19Vs6/8cev69wyIhKcuICBZa+WeRg6T9zEL9SARORbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176469; c=relaxed/simple;
	bh=VTOBb6nBpFUj+KE94TVU4rw/yZM3+SNTYOwcbQSppQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HEY8V0zqz6qmftobulQOvqMK8OcWASHSDcA9nX/ajgdLA3tjSCAquA0+x9PUOXlAxFhDVnWN3FCdwS63GUfHzkkDeQrWAHIgByE1G3aEDhhVe6fWYHlMRwHRmQT8UHxOs/t39JtDRCkWeqrnTa8TZARLiCqRTPxEM6/aFjBPdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZfm9RJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65517C4CEEB;
	Tue, 22 Jul 2025 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753176469;
	bh=VTOBb6nBpFUj+KE94TVU4rw/yZM3+SNTYOwcbQSppQk=;
	h=From:To:Cc:Subject:Date:From;
	b=fZfm9RJRju+Gpg+NyeURunZ6YiGhcnGfuCO8h42Yt4aULE8qFDRd8xlxe2mIo+EWs
	 4to72BKo0RmUSeM53nqddAMDXTqIZTJQ9c9yEF5Wm/hHhrBqz+L743AbsT00c+Nut9
	 bwIsZCVwM2krBfhDKFP2QrbPqTp5DMMeaQLxXTsdltvtrcP9i83X45RRDl+09qc9f0
	 LceOfe6B+gfLLR7qyY4ZB7870VzlI/9TIMcp/6m7a64XEFscAOKCAVKQAoVkFIYAjA
	 /H9RxmjBREAZxIysVW5rv89rZXoSfsyg2ggakyCJTQgYbcGJvsWrekNoSl6+7yBkr9
	 XSBHkJtyBfnMQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ue9He-0000000007G-3858;
	Tue, 22 Jul 2025 11:27:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	"Nancy.Lin" <nancy.lin@mediatek.com>
Subject: [PATCH] drm/mediatek: fix device leaks at bind
Date: Tue, 22 Jul 2025 11:27:22 +0200
Message-ID: <20250722092722.425-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the references to the sibling platform devices and
their child drm devices taken by of_find_device_by_node() and
device_find_child() when initialising the driver data during bind().

Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
Cc: stable@vger.kernel.org	# 6.4
Cc: Nancy.Lin <nancy.lin@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 7c0c12dde488..33b83576af7e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -395,10 +395,12 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 			continue;
 
 		drm_dev = device_find_child(&pdev->dev, NULL, mtk_drm_match);
+		put_device(&pdev->dev);
 		if (!drm_dev)
 			continue;
 
 		temp_drm_priv = dev_get_drvdata(drm_dev);
+		put_device(drm_dev);
 		if (!temp_drm_priv)
 			continue;
 
-- 
2.49.1


