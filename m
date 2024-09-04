Return-Path: <stable+bounces-72957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3659896AED0
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 04:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6065A1F24E42
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 02:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491F339AE3;
	Wed,  4 Sep 2024 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="qdblM6Kd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6822E859
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418527; cv=none; b=NKwKscxXO91zFE3OyM0hspULuYVSCCKqPL/0FNPbE8cqjE+uWsU8JPPJdgztspAp45DGCbfr0MIU//qEW2w8lj7a5uMDzM602tFgYbBwUyVtzalBqSEd1dPt83c8y8PAu7TsonW5p07uM73OJKZ3Oq7xoYPZ2arp8h0IFjVsFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418527; c=relaxed/simple;
	bh=r8Y0/kNm3avd1wrmgCAGa0UZlDSKDMmbvWP5i2mGqiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FIacz2wMUCBgaZHk453apB7aZ7V2F59DCzgKODH8BSCcnRxkaeQFQam0r4smns/Wt293+AeooNjT/8AsheycrBWkpsI44CZRhioWEGVbqfTZu470teQd2ZbpyzeBBt96TdCQpfOIpWCSncOo0ZYZhBJYyCPEs74fsxY+sSyHxOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=qdblM6Kd; arc=none smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0047961.ppops.net [127.0.0.1])
	by m0047961.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id 4842BSQt034281
	for <stable@vger.kernel.org>; Tue, 3 Sep 2024 22:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to; s=outbound; bh=vyl5jEoBHiNv
	ky0bbAZ9dQeCfGv4WVu+/0q2Qb5oE/Y=; b=qdblM6KdRThT9S1RVxXpF9g0qOXG
	NPzF9U/j01BeB6A8ybTBuSZCLLejfcT7ZDcurNq1nnptdmDJIJaMqsDelztNUp0F
	C62eQz5/yVLRjyyoElN7GiLVymfhW+o6k0+aGLbhjf69inIT6jHIly08m+A2NG7n
	X1sp74BwqT1lMoHXlqLg57V/p/NnMZkuxCLZw9NY07PzWf9rpChTC5+WsPLyb+xn
	HTv4UyiowGl5cljN+0iavEBCiQQ6EnyTlvVc7IkYSpsKbnGp3Xve44javgg/9UDc
	n5L1fmA9bfd91OI0rbJA0YZihfC7oX1mopN6l3+SBfa6z15LIbcTiXQPzA==
From: Paul Pu <hui.pu@gehealthcare.com>
To: hui.pu@gehealthcare.com
Cc: stable@vger.kernel.org
Subject: [PATCH] drm: imx: ipuv3-plane: fix HDMI cannot work for odd screen resolutions
Date: Wed,  4 Sep 2024 05:36:36 +0300
Message-Id: <20240904023636.55-1-hui.pu@gehealthcare.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FxJkfpL20BNr_I2lzUiHq46z77dAIGP0
X-Proofpoint-GUID: FxJkfpL20BNr_I2lzUiHq46z77dAIGP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=813 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040017

This changes the judgement of if needing to round up the width or not,
from using the `dp_flow` to the plane's type.

The `dp_flow` can be -22(-EINVAL) even the plane is a PRIMARY one.
See `client_reg[]` in `ipu-common.c`.

[    0.605141] [drm:ipu_plane_init] channel 28, dp flow -22, possible_crtcs=0x0

Per the commit message in commit: 71f9fd5bcf09, using the plane type for
judging if rounding up is needed is correct.

Fixes: 71f9fd5bcf09 ("drm/imx: ipuv3-plane: Fix overlay plane width")
Cc: stable@vger.kernel.org

Signed-off-by: Paul Pu <hui.pu@gehealthcare.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index 704c549750f9..cee83ac70ada 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -614,7 +614,7 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 		break;
 	}
 
-	if (ipu_plane->dp_flow == IPU_DP_FLOW_SYNC_BG)
+	if (ipu_plane->base.type == DRM_PLANE_TYPE_PRIMARY)
 		width = ipu_src_rect_width(new_state);
 	else
 		width = drm_rect_width(&new_state->src) >> 16;

base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
-- 
2.39.2


