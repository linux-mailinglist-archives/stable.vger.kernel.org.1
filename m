Return-Path: <stable+bounces-204374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A077ACEC3DF
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855D13015AAE
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1F285061;
	Wed, 31 Dec 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzDstO7O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3A51EFF9B
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198572; cv=none; b=N6qgdCzHEnb/qrNg5hydIjuqB8iFdf8BCY3IX/Leb5rVBJmk9WQu0dCbNl/oiPEqYo+pwmpugIHdNW+ynB2mTzIzOfxGQqi3iK7egDoFjf02LSfIZhGqNQcXZXCQGJNO/LDfLYfSePnhcCLETI42OwLLqzZa0qpDcFWwWwoDsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198572; c=relaxed/simple;
	bh=L/U3okdJKuAqcPV60azBq+Nosmv5WxsosOta8hsnYCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vh1/JR/1j72VkD4yAfHI+xvHLbqeG8zZMhfJMNZVH4+wuv674IxE8fTkY7U6mfW9LH9tlidYyppkHNJnEO3Iwn9gz8v27KgTnXROkpb61c3R+5Etal5YDwwFmNVlxdZnGPviJ5UUoodK/e/7673Jna+aEMsk9kZR2WOzPxEiTL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzDstO7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C114C113D0;
	Wed, 31 Dec 2025 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767198571;
	bh=L/U3okdJKuAqcPV60azBq+Nosmv5WxsosOta8hsnYCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzDstO7ONpxHUxt5AZCOJCyajboU/lXahKPOUnjy5anQlzSOSaenl8u05+T0PNZk6
	 d1P39okXWPXmVJW67rDPkZV23WJkBT8CsbWWeTZBluxcckwy6FsQtr8MFFY8UmCdCb
	 NkK1se7x4puFMvFQsEFJXKSDm0Lcbh+UUhXvlV0ftbfZU7fP+gT8uOMq91kfSh6I5c
	 n6IGLwtnMgf4zzUf6IGVELOl1v5pGHQiHeSXngibCG+TxG+GX4g7MqHiUQspeIcOrN
	 mKIzJYh4qSh1jgqqquUPy4sd0oGyPiFNYTbqT9+JhF22+DA3BvfKorZxR4JvUPuOjl
	 5WWugSUJyq/BA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Tiago=20Martins=20Ara=C3=BAjo?= <tiago.martins.araujo@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] drm/displayid: add quirk to ignore DisplayID checksum errors
Date: Wed, 31 Dec 2025 11:29:26 -0500
Message-ID: <20251231162926.3267905-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231162926.3267905-1-sashal@kernel.org>
References: <2025122954-stony-herring-2347@gregkh>
 <20251231162926.3267905-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 83cbb4d33dc22b0ca1a4e85c6e892c9b729e28d4 ]

Add a mechanism for DisplayID specific quirks, and add the first quirk
to ignore DisplayID section checksum errors.

It would be quite inconvenient to pass existing EDID quirks from
drm_edid.c for DisplayID parsing. Not all places doing DisplayID
iteration have the quirks readily available, and would have to pass it
in all places. Simply add a separate array of DisplayID specific EDID
quirks. We do end up checking it every time we iterate DisplayID blocks,
but hopefully the number of quirks remains small.

There are a few laptop models with DisplayID checksum failures, leading
to higher refresh rates only present in the DisplayID blocks being
ignored. Add a quirk for the panel in the machines.

Reported-by: Tiago Martins Araújo <tiago.martins.araujo@gmail.com>
Closes: https://lore.kernel.org/r/CACRbrPGvLP5LANXuFi6z0S7XMbAG4X5y2YOLBDxfOVtfGGqiKQ@mail.gmail.com
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14703
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Tiago Martins Araújo <tiago.martins.araujo@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/c04d81ae648c5f21b3f5b7953f924718051f2798.1761681968.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_displayid.c          | 41 +++++++++++++++++++++---
 drivers/gpu/drm/drm_displayid_internal.h |  2 ++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayid.c
index 20b453d2b854..58d0bb6d2676 100644
--- a/drivers/gpu/drm/drm_displayid.c
+++ b/drivers/gpu/drm/drm_displayid.c
@@ -9,6 +9,34 @@
 #include "drm_crtc_internal.h"
 #include "drm_displayid_internal.h"
 
+enum {
+	QUIRK_IGNORE_CHECKSUM,
+};
+
+struct displayid_quirk {
+	const struct drm_edid_ident ident;
+	u8 quirks;
+};
+
+static const struct displayid_quirk quirks[] = {
+	{
+		.ident = DRM_EDID_IDENT_INIT('C', 'S', 'O', 5142, "MNE007ZA1-5"),
+		.quirks = BIT(QUIRK_IGNORE_CHECKSUM),
+	},
+};
+
+static u8 get_quirks(const struct drm_edid *drm_edid)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(quirks); i++) {
+		if (drm_edid_match(drm_edid, &quirks[i].ident))
+			return quirks[i].quirks;
+	}
+
+	return 0;
+}
+
 static const struct displayid_header *
 displayid_get_header(const u8 *displayid, int length, int index)
 {
@@ -23,7 +51,7 @@ displayid_get_header(const u8 *displayid, int length, int index)
 }
 
 static const struct displayid_header *
-validate_displayid(const u8 *displayid, int length, int idx)
+validate_displayid(const u8 *displayid, int length, int idx, bool ignore_checksum)
 {
 	int i, dispid_length;
 	u8 csum = 0;
@@ -41,8 +69,11 @@ validate_displayid(const u8 *displayid, int length, int idx)
 	for (i = 0; i < dispid_length; i++)
 		csum += displayid[idx + i];
 	if (csum) {
-		DRM_NOTE("DisplayID checksum invalid, remainder is %d\n", csum);
-		return ERR_PTR(-EINVAL);
+		DRM_NOTE("DisplayID checksum invalid, remainder is %d%s\n", csum,
+			 ignore_checksum ? " (ignoring)" : "");
+
+		if (!ignore_checksum)
+			return ERR_PTR(-EINVAL);
 	}
 
 	return base;
@@ -52,6 +83,7 @@ static const u8 *find_next_displayid_extension(struct displayid_iter *iter)
 {
 	const struct displayid_header *base;
 	const u8 *displayid;
+	bool ignore_checksum = iter->quirks & BIT(QUIRK_IGNORE_CHECKSUM);
 
 	displayid = drm_edid_find_extension(iter->drm_edid, DISPLAYID_EXT, &iter->ext_index);
 	if (!displayid)
@@ -61,7 +93,7 @@ static const u8 *find_next_displayid_extension(struct displayid_iter *iter)
 	iter->length = EDID_LENGTH - 1;
 	iter->idx = 1;
 
-	base = validate_displayid(displayid, iter->length, iter->idx);
+	base = validate_displayid(displayid, iter->length, iter->idx, ignore_checksum);
 	if (IS_ERR(base))
 		return NULL;
 
@@ -76,6 +108,7 @@ void displayid_iter_edid_begin(const struct drm_edid *drm_edid,
 	memset(iter, 0, sizeof(*iter));
 
 	iter->drm_edid = drm_edid;
+	iter->quirks = get_quirks(drm_edid);
 }
 
 static const struct displayid_block *
diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index aee1b86a73c1..01ae9812340c 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -154,6 +154,8 @@ struct displayid_iter {
 
 	u8 version;
 	u8 primary_use;
+
+	u8 quirks;
 };
 
 void displayid_iter_edid_begin(const struct drm_edid *drm_edid,
-- 
2.51.0


