Return-Path: <stable+bounces-90531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA669BE8C4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057A81C21112
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE31DF99A;
	Wed,  6 Nov 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aoz3sMdh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC71DE4EA;
	Wed,  6 Nov 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896048; cv=none; b=M5ci45zPidcocwwyQugAjnEUFxOpbN5XWytVHjvSMtNGcA0ESbYIiDMX+Dkd0QL+vKjCIehYcBJWspSJQ0+OX5rvaVF7Lv2i+uhbwC5e8kZQqyL87tC+Wp2LLrdhqoA1UVf2xlmvGFMCnN/2h+2TjvZDCYiVNbjROko4AqjHTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896048; c=relaxed/simple;
	bh=8nOoQJ7WV6a8GI9n9rLo6VRqoa1b2Z+LV5ohDrXYneU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8hquswTAx8u0KytUtUOva8IqnIlLrAshyyUB+8d4ckPRecQuscahOsdpfVcZSD33AVpyP/oc+71wAhk4qSa/6JCMDuj3Hhg8OcKvRVE1TOq7D47slfozfCiaIcB/0kjTSbcZMPbmhTpx7lNoWgdpwtY1GJZddI8U7tnXusi1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aoz3sMdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D18C4CED4;
	Wed,  6 Nov 2024 12:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896047;
	bh=8nOoQJ7WV6a8GI9n9rLo6VRqoa1b2Z+LV5ohDrXYneU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoz3sMdh4uufRVJ92CrVgAZBV3tSql9BcKGSQ8zNEZz5SDAQFvwfMowxW771c/3A5
	 40GEROTW6n3c3Gt+QWTO2hZIN5JmSUpaDLuGX0DkgajLtPZu2jSIsxhQkNy4h+TcA1
	 Y3/IPkZfIGi5DinGPOGqbBJFnH7Ysgyh4iO+g7Rs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 071/245] drm/mediatek: Fix color format MACROs in OVL
Date: Wed,  6 Nov 2024 13:02:04 +0100
Message-ID: <20241106120320.951919968@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hsin-Te Yuan <yuanhsinte@chromium.org>

[ Upstream commit 655c6c1b7afe6d29f386f415594ee643e5e3d755 ]

In commit 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in
OVL"), some new color formats are defined in the MACROs to make the
switch statement more concise. That commit was intended to be a no-op
cleanup. However, there are typos in these formats MACROs, which cause
the return value to be incorrect. Fix the typos to ensure the return
value remains unchanged.

Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20241016-color-v3-1-e0f5f44a72d8@chromium.org/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 4221206b994f1..064d03598ea2e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -61,8 +61,8 @@
 #define OVL_CON_CLRFMT_RGB	(1 << 12)
 #define OVL_CON_CLRFMT_ARGB8888	(2 << 12)
 #define OVL_CON_CLRFMT_RGBA8888	(3 << 12)
-#define OVL_CON_CLRFMT_ABGR8888	(OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP)
-#define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
+#define OVL_CON_CLRFMT_ABGR8888	(OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP)
+#define OVL_CON_CLRFMT_BGRA8888	(OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP)
 #define OVL_CON_CLRFMT_UYVY	(4 << 12)
 #define OVL_CON_CLRFMT_YUYV	(5 << 12)
 #define OVL_CON_CLRFMT_RGB565(ovl)	((ovl)->data->fmt_rgb565_is_0 ? \
-- 
2.43.0




