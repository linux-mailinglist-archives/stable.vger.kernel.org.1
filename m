Return-Path: <stable+bounces-128047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F8A7AEA5
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85C417BB58
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763521E098;
	Thu,  3 Apr 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLpjqMPW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6621E08A;
	Thu,  3 Apr 2025 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707849; cv=none; b=noI5i7OqEBlB6cWveAWt54LTaq1d4LvWw0EqQWdJ1qM2PeBmFj9J4r2+Pz+RGUuxilNMcIoR5ykY1OnxVJEN9/tnpFRYMEHyDwT7DOiWMXggoiEooJ2udPvDM6H3J+WlUWmcZZNl+couJZndzU7SKIUz/r5iW8Ied+VNs9hYYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707849; c=relaxed/simple;
	bh=9vLA05UqALd9HAN6zu0mr5Jdmu90GO+dK/JXjUDyrN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W747Tx8gSvnL7ieQg2/n5gqIm6DK1N5OyoyFQSersX+zWbMCdrVGS/dX246XoyXzpJ4D4AQ1skE0Hz/Uur3xT5CZqw3x4qs1KGfCrtbnigVUlCRKxQz0T2gNdKHcE43JH8SVOSXFsw6r4RHc880yQESNOrJ1kg2+BWTRD3KBLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLpjqMPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA34C4CEE3;
	Thu,  3 Apr 2025 19:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707848;
	bh=9vLA05UqALd9HAN6zu0mr5Jdmu90GO+dK/JXjUDyrN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLpjqMPWphQLixw3Hu9zfiTKbODHx3mEUKMmYPCHipFnDaJ+1gErk5x1c8CQB3VG3
	 AVsf0pfcQ5EOL6gPRm1p0dGM648O41QMNWO03ua7a7kKi2MtLnxLSk6k9H0zDd/b9M
	 hJj0RPvVNYro8YxME8b9fk3mYTi1gTR9Gu0kPySHH5BEBfoCLE1nVXWzM3Y5wYBr7s
	 cFpg7LxCdZBs6VfGwFwiyR4ppM2N9fnL3fr6JJXOFrPN9IibMcsYgtJe8LpP5HGrj3
	 A1/jW6Q0MqkuTHcVq4r1mEjSHNfClq85qUmyaFIs2IbdiaMcfK8JxB6dwX6HxDo+a5
	 Ehn6a8cGnRdtQ==
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
Subject: [PATCH AUTOSEL 6.12 09/33] drm: panel-orientation-quirks: Add new quirk for GPD Win 2
Date: Thu,  3 Apr 2025 15:16:32 -0400
Message-Id: <20250403191656.2680995-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index b57078cfdd80f..384a8dcf454fb 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -339,6 +339,12 @@ static const struct dmi_system_id orientation_data[] = {
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


