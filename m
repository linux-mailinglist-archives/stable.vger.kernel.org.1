Return-Path: <stable+bounces-130707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D2A80547
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85307AB075
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD8268FDD;
	Tue,  8 Apr 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAzZJS+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5741B87CF;
	Tue,  8 Apr 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114434; cv=none; b=ar4BhXlrdMenT8mdWEIAhLTDcT0+lO0+6531Q8H/b2utyPaIkIwJKSY2l75bmjM9VN/RE0set9lm/b+kgV1kL6JgRXl1HcLaNKFJHq5Ov4DE57b/+ju1Ph8vcFBoCxH+Y+S3tgsd2tnQhW+9G6xPa3twN5LGdXfp0zpYFDC6wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114434; c=relaxed/simple;
	bh=QmvdhLJJhsT7TKZW9nLn33fQNdG7SC3h9svkdaVmrXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9PTNembuR8Chzi/Ey62cOC0c9umNvkowQeGjNT5Ql6wjlCC8Woxm6CvgfY6YkZu4oYmHgi2iReO+62r1CpPNjnT2heN++Y9PUuEfs8s4LaJ7JbZt5zjVLVRKc7LmpY2+x+XV6aCRtvn9RH+MM7oxfjxn+DVSF+buuzpa0Yls1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAzZJS+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C2BC4CEE5;
	Tue,  8 Apr 2025 12:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114434;
	bh=QmvdhLJJhsT7TKZW9nLn33fQNdG7SC3h9svkdaVmrXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAzZJS+EWqiD6uCGs9NaXYD1MW+uMNVaEOdO/mnYEstffBOpunQ/xJtWMUMB4d8nx
	 dTwGR6hGtkVjstFkgySuyyjsM8UmSFQC0OG3qzXKxZbyCh/eCgFsDiO3YQ9zYEiyNj
	 ujeKViX03lxqB7NthTy3CWVPQ2FOIB2mrij4DXX4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 105/499] drm/mediatek: dp: drm_err => dev_err in HPD path to avoid NULL ptr
Date: Tue,  8 Apr 2025 12:45:17 +0200
Message-ID: <20250408104853.827503996@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 106a6de46cf4887d535018185ec528ce822d6d84 ]

The function mtk_dp_wait_hpd_asserted() may be called before the
`mtk_dp->drm_dev` pointer is assigned in mtk_dp_bridge_attach().
Specifically it can be called via this callpath:
 - mtk_edp_wait_hpd_asserted
 - [panel probe]
 - dp_aux_ep_probe

Using "drm" level prints anywhere in this callpath causes a NULL
pointer dereference. Change the error message directly in
mtk_dp_wait_hpd_asserted() to dev_err() to avoid this. Also change the
error messages in mtk_dp_parse_capabilities(), which is called by
mtk_dp_wait_hpd_asserted().

While touching these prints, also add the error code to them to make
future debugging easier.

Fixes: 7eacba9a083b ("drm/mediatek: dp: Add .wait_hpd_asserted() for AUX bus")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20250116094249.1.I29b0b621abb613ddc70ab4996426a3909e1aa75f@changeid/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 3b0993abfdc3d..8688665f6701d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1746,7 +1746,7 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 
 	ret = drm_dp_dpcd_readb(&mtk_dp->aux, DP_MSTM_CAP, &val);
 	if (ret < 1) {
-		drm_err(mtk_dp->drm_dev, "Read mstm cap failed\n");
+		dev_err(mtk_dp->dev, "Read mstm cap failed: %zd\n", ret);
 		return ret == 0 ? -EIO : ret;
 	}
 
@@ -1756,7 +1756,7 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 					DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0,
 					&val);
 		if (ret < 1) {
-			drm_err(mtk_dp->drm_dev, "Read irq vector failed\n");
+			dev_err(mtk_dp->dev, "Read irq vector failed: %zd\n", ret);
 			return ret == 0 ? -EIO : ret;
 		}
 
@@ -2039,7 +2039,7 @@ static int mtk_dp_wait_hpd_asserted(struct drm_dp_aux *mtk_aux, unsigned long wa
 
 	ret = mtk_dp_parse_capabilities(mtk_dp);
 	if (ret) {
-		drm_err(mtk_dp->drm_dev, "Can't parse capabilities\n");
+		dev_err(mtk_dp->dev, "Can't parse capabilities: %d\n", ret);
 		return ret;
 	}
 
-- 
2.39.5




