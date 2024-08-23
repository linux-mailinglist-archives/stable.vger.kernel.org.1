Return-Path: <stable+bounces-69980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5495CEC6
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB0B1F26A61
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C83418F2C5;
	Fri, 23 Aug 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRt06c5j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE7A18EFF0;
	Fri, 23 Aug 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421723; cv=none; b=aGcM2kTJyUk+VqOfls5H0cji0eTdUDuHyvCFodQeqS1aa3zAFQVAjqGvGu6bfIM3fSvEoq6Qskzd98HTZKxWbB/Kw2JBbu0VUMNqTvbNMlGfKBkRNqkDa55inNkPMTkn8JrztXi8u2m6ral118nVRM7vJzILpjyXcNMJeT0GRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421723; c=relaxed/simple;
	bh=iZc7NsL68kpViOBiwGAUIx7yIDbE9vIsNWX8rgkVNMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T663fFB7pV/1HEaCeq+4O5F57O2yDZLVrfbNupaujUrtCSkV5XeF/xgq4FMIqV1SYQTrO9IL0o/qwt8CMbh1NiE4WRmpjyOfVAxYSOGE4a7hlejumBH7qMr2kFq1IGsWKbmVDZQdoe5Vjowwvx3GoO7G/tI2EcAfCa9HtKraLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRt06c5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A710FC4AF09;
	Fri, 23 Aug 2024 14:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421722;
	bh=iZc7NsL68kpViOBiwGAUIx7yIDbE9vIsNWX8rgkVNMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jRt06c5jmylviUKlna5JAVufLkWQMxCpyo0rCi5TlvvjOgaj/weRC7txDKaWqzx1+
	 rWCSnqTbCfxt+p3gbA+RGp68pceRIuWK0am3cIm9P/gUE+7DXRaQBUSSwcPrXRtU0v
	 +GMNCrR7fv6+bK4Qqne2xFD+pRpM4jGjBPdz0aXZHh8d4kfF2pBLk8AeKqOIaa1YON
	 UT79m3R96+3RGmrYN9CLAIuroZj8WpNFsK0M+yysMJVLMyQnQX0KHjTmd65pdYfRHy
	 /4OuH7YttF+ir3fKnvkNEogBsQeoDPsmP4K9yhJLLqM2wk3JHWebPTOBgnpOZDnA0k
	 1PZmCX8Gah4WA==
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
Subject: [PATCH AUTOSEL 6.10 13/24] drm: panel-orientation-quirks: Add quirk for Ayn Loki Max
Date: Fri, 23 Aug 2024 10:00:35 -0400
Message-ID: <20240823140121.1974012-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
Content-Transfer-Encoding: 8bit

From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>

[ Upstream commit 2c71c8459c8ca66bd8f597effaac892ee8448a9f ]

Add quirk orientation for Ayn Loki Max model.

This has been tested by JELOS team that uses their
own patched kernel for a while now and confirmed by
users in the ChimeraOS discord servers.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240728124731.168452-3-boukehaarsma23@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 96551fd156abb..820c6fbaff441 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {    /* AYN Loki Max */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Max"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYN Loki Zero */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
-- 
2.43.0


