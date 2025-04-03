Return-Path: <stable+bounces-128129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D24A7AF7E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27BD3B0336
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA72638BD;
	Thu,  3 Apr 2025 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJUvT3kb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84082638AF;
	Thu,  3 Apr 2025 19:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743708039; cv=none; b=MRyP59cOEIWPr9hguWJBZu+iMhNM/msM798DB/jlqxnlqqjephv6/xyx10kD1Ul+RBS0Yx43/qIa1XgM/LXAtW8gLSdTJn9Ewrmf5PWYalhyMHkxyaCht29pPasF/PBWytlFwFrQRw3HLiKu41cAPm7Ivx8pkr51QbTJL01LcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743708039; c=relaxed/simple;
	bh=mrQfTVPQtZD86RqB0Xrk3f9mgqysvajVRgxyfqDzdnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FxaLCmWNWutUW2xa0QZZHFX33eZbn9HkLXdiZqZm50bdOyKjkf1GQ/Pw2QPKt2ybRBVoGEfChzTjnOJmM1BmCyZcRR2OMOmMuqT52khM5NU8G1wEkshpOiB3u7Rcf+90Qprniap2QNdQBDZDFIwZ1QtIL/Gs24F2o66vphsX5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJUvT3kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E8DC4CEE9;
	Thu,  3 Apr 2025 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743708039;
	bh=mrQfTVPQtZD86RqB0Xrk3f9mgqysvajVRgxyfqDzdnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJUvT3kbPV5DNd9/iw0gy2oVlLFpPbid71gBKVC/FGQjwT9OizElsuXJLD4S1X13d
	 1V/6JHYhE7IJ2CSL1mUrN4u0JP1eDwtZmeE83qdMppbFTwLPt74r23URlh5E61vxB/
	 sFiaXKQvd1BdiIRQYCkYJgWEzmu/H89ww13F//SBd2SCb9gPUCb2bS7o0mjGBQ+WF0
	 dzlRQ9l3wexC1+ruELg/770yZGbgho9R8tQY/yhhhvPKE+Mv1S3wQRxxKeLJj7M22g
	 2FbtzVuHWPPAKZz0P6TJfJCAoa6lFf9+aMvT283HZtooZ0LiDpVhTN8Ji3h7UqjAu0
	 i2VAT5v6Sjl6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Wyatt <fewtarius@steamfork.org>,
	John Edwards <uejji@uejji.net>,
	Paco Avelar <pacoavelar@hotmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 3/8] drm: panel-orientation-quirks: Add new quirk for GPD Win 2
Date: Thu,  3 Apr 2025 15:20:25 -0400
Message-Id: <20250403192031.2682315-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403192031.2682315-1-sashal@kernel.org>
References: <20250403192031.2682315-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

[ Upstream commit a860eb9c6ba6cdbf32e3e01a606556e5a90a2931 ]

Some GPD Win 2 units shipped with the correct DMI strings.

Add a DMI match to correctly rotate the panel on these units.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: Paco Avelar <pacoavelar@hotmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213222455.93533-5-uejji@uejji.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 6bb8d4502ca8e..6fc9d638ccd23 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -235,6 +235,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_win2,
+	}, {	/* GPD Win 2 (correct DMI strings) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "WIN2")
+		},
+		.driver_data = (void *)&lcd720x1280_rightside_up,
 	}, {	/* GPD Win 3 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
-- 
2.39.5


