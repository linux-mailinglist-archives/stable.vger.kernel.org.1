Return-Path: <stable+bounces-72971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46CE96B382
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9205028460E
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9C15532A;
	Wed,  4 Sep 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="pe6zJngd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265E13AD20
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436310; cv=none; b=e6IPHT1ck+hXgxqssHWC52Nmr6OpoZPbCXlS67x+vCEHpSpPRqhUpbtMGmcFNURY9atebGfdEChC4/jTaa4qfIUGx7bAugtDVZ30880Xbej4AJhzn43JoJdv/vAhW85KIo46hVB/efVK61g5tRFfDv9/Z4RP6W1gC0cPRrlK58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436310; c=relaxed/simple;
	bh=r0a5AYrIFTg6126FS0HDRo81dWEf9zYSuTdKXXqeSbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPLN1NQzAEwFA8oJQ7vv99MLDHuT5hcZhSedPTJuDd+aX1bdOYriOX75kQ9EERGp8+JJNsavyzc5BvICXvbWVx3ge0DKmxQ5bdORpWU5Arpe5/7+VbnQFMCZerzSEI7khHuuenfeaVTGpz/aA+VJTpR9gj6AnKxGLWkBH7NSgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=pe6zJngd; arc=none smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0047961.ppops.net [127.0.0.1])
	by m0047961.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id 4847dblS028783
	for <stable@vger.kernel.org>; Wed, 4 Sep 2024 03:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	outbound; bh=YgLq/2dBPG+eknMq5HrdJ7VBavF7x7z1tmaFPepaKYE=; b=pe6
	zJngdxLZ5lCftcfhr8Hgi1FqFAgUGhFMT79PceWdsZ8cLqW1+YNm08sHiyHHvHER
	zwgKRVeFpiuM2hiqBZSJ6XXWL4RzW2DTN+418+jYyAGXRtDOkwGw9qrCmWstrr/N
	i9JtjqKnCRY0YyDWIIMpJP8fVLCyQDCT/UejcYFyE83Zew9vFvthGTgQT51e26Cg
	kKx/cVvXOHOBmhneUra3gIeJG7ca31K/kTOVUrcnsshR0JyB/iRci77B/uiyYcop
	qXPWuYyh9kb8LuVtgxN0sw0g6SiM11E7WTM4xoaCg8E8VN+WccAgwLXQ8q7pVZYb
	coz0j9ySFiaLgrr6bwQ==
From: Paul Pu <hui.pu@gehealthcare.com>
To: hui.pu@gehealthcare.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2] drm/imx/ipuv3: ipuv3-plane: Round up plane width for IPUV3_CHANNEL_MEM_DC_SYNC
Date: Wed,  4 Sep 2024 10:51:27 +0300
Message-Id: <20240904075127.15-1-hui.pu@gehealthcare.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240904024315.120-1-hui.pu@gehealthcare.com>
References: <20240904024315.120-1-hui.pu@gehealthcare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CxIa9TRgrxIkptVFjASFFQb4ts_IRaYt
X-Proofpoint-GUID: CxIa9TRgrxIkptVFjASFFQb4ts_IRaYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=959 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040059

This changes the judgement of if needing to round up the width or not,
from using the `dp_flow` to the plane's type.

The `dp_flow` can be -22(-EINVAL) even if the plane is a PRIMARY one.
See `client_reg[]` in `ipu-common.c`.

[    0.605141] [drm:ipu_plane_init] channel 28, dp flow -22, possible_crtcs=0x0

Per the commit message in commit: 4333472f8d7b, using the plane type for
judging if rounding up is needed is correct.

This fixes HDMI cannot work for odd screen resolutions, e.g. 1366x768.

Fixes: 4333472f8d7b ("drm/imx: ipuv3-plane: Fix overlay plane width")
Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Paul Pu <hui.pu@gehealthcare.com>
---
v1 -> v2: Fixed addressed review comments
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index 704c549750f9..3ef8ad7ab2a1 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -614,7 +614,7 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 		break;
 	}
 
-	if (ipu_plane->dp_flow == IPU_DP_FLOW_SYNC_BG)
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY)
 		width = ipu_src_rect_width(new_state);
 	else
 		width = drm_rect_width(&new_state->src) >> 16;

base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
-- 
2.39.2


