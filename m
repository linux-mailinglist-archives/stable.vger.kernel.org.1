Return-Path: <stable+bounces-65450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4C94814F
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CE91C21FD4
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 18:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B517CA0B;
	Mon,  5 Aug 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+G60gbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EDC17C9E9;
	Mon,  5 Aug 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880773; cv=none; b=n8lvUcZNv3hdBY8g5rWaxqepEc9tCoUvTf2F19/S/cNyvPEAJzEIyzrS+IO5Zvo5i6jZr79T9QMOdVZOPyIPc5ZIQ+0OcgjQfRFPxhKOg17tePwL/m/W2nTgTXVSyqvlqzdTd7ToMYL06UX4UVb2M8XRjIf5gBGNoNrI9Xnl+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880773; c=relaxed/simple;
	bh=9ksv/G/aFOuCm5jYIeueKidNCRidn+d+FACT/CaLoco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvGhzTSTOJq4mI4Nr0scp83eXzUl0EvO1P6ZOJKbv8e5c4XOsRYybP3vqaHJj8GlXCLIInovBiK7rPZdvxtj7an1xw24AuU4USOnHA6gjafQG4q9ufKUqy9Eg1+jU4SOB798z2x8GHE8VYFJD0w6A+WOvPC/MjaLJI508M+ZcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+G60gbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D69C32782;
	Mon,  5 Aug 2024 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880771;
	bh=9ksv/G/aFOuCm5jYIeueKidNCRidn+d+FACT/CaLoco=;
	h=From:To:Cc:Subject:Date:From;
	b=u+G60gbWEVmC2LZ8+Umm1g6SJqKvB3SFkPdnFAXypTZ7zqqgllzHRBr70OkkRK51S
	 bX6DuUWoB2LtQltvCNIRu+V/bxs9dD1PueBzOetqqlorllU5+j9AHQkXsppsX+xRhm
	 N0Y6RuQE2ilzvl729AYjBydvkE6usyZJk4igcLWnk5vHTTt3SCZjRWiQgVOA2PC7JY
	 z4xSzYBo174iZu5W6EsGoV+ZmI0oM9BT+THCPBzrD73m9iotWGD6Rsr7OpEb4dYO+x
	 ad72qTMCzLPX0N8JtIRDVm2L0pyABZgQFqUFL1qlU28MTubNkIeKRWycaC4rZaoNpK
	 0w6Y/334qqIQA==
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
Subject: [PATCH AUTOSEL 5.4 1/2] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
Date: Mon,  5 Aug 2024 13:59:26 -0400
Message-ID: <20240805175928.3257720-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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


