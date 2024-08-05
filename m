Return-Path: <stable+bounces-65442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E2A948133
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E237D1F20CA6
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16C16C6AB;
	Mon,  5 Aug 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNOs1K1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97A161327;
	Mon,  5 Aug 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880742; cv=none; b=UhzoFgC4KqpmG++96A1pGLD+QgIh+wWp2DpltQaoHuGTQc8/uge10ex6UarIn3UmLOYuxan3QS6+n5Fw+gJT3/XTU9UQMsZrZn+sznY1VsXnKfxSrwLp216p3/DS9YVc08LB1hKluWwJxgW1aU+dkSm0d6F/ReNPQU8SHhVqG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880742; c=relaxed/simple;
	bh=9ksv/G/aFOuCm5jYIeueKidNCRidn+d+FACT/CaLoco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuCkoo9DifHY4N0FWWDy4ge3R5xDZEej0sIeCGoQDgQ84yq7xyb6s/Iy4NNa/XU5SU647OpWjMdszpKOUn7URGyGlN5r/8xX7+zBfiR1QSwedhxLTUpZDR72TvosogSyX6AKnak5JK4dA0acQJkFtPBn+paAO7bGRteXXLZ1IAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNOs1K1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E25C32782;
	Mon,  5 Aug 2024 17:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880741;
	bh=9ksv/G/aFOuCm5jYIeueKidNCRidn+d+FACT/CaLoco=;
	h=From:To:Cc:Subject:Date:From;
	b=rNOs1K1BbV6Xo1TtGB0MIS179aQpy76Jzf1Q8RWeo6+/SBqny/UdmA4a2RmiqwjiA
	 coZsGJ5F/ppI5pe2YZqml14Ljr0hrQfJUtXKlOiARLOKLgUZ8L0xYa2wd5WI3nB5aa
	 Wh0N006mqT8c8iPCU+VFAfDoZYx/DtqZhsUWmCK8hwwHfs/2wzt1ilyTu0aca5vm97
	 1BYUZwt4IyrE0vnPZb57JFgFaQUfOaQfmE0FkXQaPRl/jXQ59PC1ujD9ZpBu+abuTQ
	 cimxw3sQtCfN4ix78aBRD8s6sGKN7ixJCocbUTnZM9O9gA8HIOU/gktLYptFpxJRW6
	 aOSA5MPIKHmcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Mueller <philm@manjaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 1/4] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
Date: Mon,  5 Aug 2024 13:58:49 -0400
Message-ID: <20240805175857.3256338-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Philip Mueller <philm@manjaro.org>

[ Upstream commit d60c429610a14560085d98fa6f4cdb43040ca8f0 ]

This adds a DMI orientation quirk for the OrangePi Neo Linux Gaming
Handheld.

Signed-off-by: Philip Mueller <philm@manjaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240715045818.1019979-1-philm@manjaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 43de9dfcba19a..f1091cb87de0c 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -318,6 +318,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OrangePi Neo */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO-01"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-- 
2.43.0


