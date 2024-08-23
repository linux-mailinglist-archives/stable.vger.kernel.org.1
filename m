Return-Path: <stable+bounces-70017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F6195CF44
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C931C21519
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062BF19E830;
	Fri, 23 Aug 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGEhBXBe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FF19E81F;
	Fri, 23 Aug 2024 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421882; cv=none; b=VhfW3Nnka9JZzCWajo9h7mLDyx55dQMa4JFOXnZ+iQVfCcVl/d3kktAg5XuGcOtGuuZtBLrIDuBPtmM+gMiDTcyRwiWp1ADb8d48DqP4qGXvUt3tpRMl4lO8bO+ACDR3a5U4aTWeblNsYnsLyqmSmW7VwbiklBHkcJIEuoV1ELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421882; c=relaxed/simple;
	bh=gSSvy2dAew+hub5xIOIxQ3J5yTcYbohKu8RqJPZlqHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSlS4o8nG0hWdc8WJEUmKVb5lzM3jIdh+L2//FHwKviAzFf9YCEuaHI1xXPBWiuT1baR6Nk/lE9CpwiEYeVTDYTUiqeEOTktxO9fe8z1/WkWCnG3il/2T8vP8cmyuYveznx8SBrGZ51oKNw8xGFrkRZ49DMjuLIHPPHqIK7RpPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGEhBXBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7FCC4AF0F;
	Fri, 23 Aug 2024 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421882;
	bh=gSSvy2dAew+hub5xIOIxQ3J5yTcYbohKu8RqJPZlqHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGEhBXBed/n7OQwj4tWwgIFulJi2g1qR2rMKWSH4Flt/oHiwxqO7VVlWMhEJPeB3y
	 8yYnxQ1i9TnQ+snKS+ZerUrm+zWnVanwoOQKoPUjIKMslCR071aTbyfb+aPEChJuSx
	 Q9KJa++er9TK4PCjDgCQlGxguARIO09WCX5nnaoxDB/gLC+i5vGN6/KBvR41RGE4hd
	 D4EhgGuc43CJH4DtIhT40LoLTGru8XrmVNlsnV3mzAyqwK1vG/SC7cBFgKk6NECoum
	 UkwzXd/fJaZQhu23k89cR9IH7vB+icds31e53wdIJEWFfGp9phw7N5Ds3fFCEitkHw
	 snvDBnRXXCfbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 06/13] drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
Date: Fri, 23 Aug 2024 10:03:55 -0400
Message-ID: <20240823140425.1975208-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140425.1975208-1-sashal@kernel.org>
References: <20240823140425.1975208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.106
Content-Transfer-Encoding: 8bit

From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>

[ Upstream commit b86aa4140f6a8f01f35bfb05af60e01a55b48803 ]

Add quirk orientation for the Ayn Loki Zero.

This also has been tested/used by the JELOS team.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240728124731.168452-2-boukehaarsma23@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 5db52d6c5c35c..21f2f3abf90f0 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {	/* AYN Loki Zero */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Zero"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.43.0


