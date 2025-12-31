Return-Path: <stable+bounces-204371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C33EBCEC38B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B662B3007282
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A58D281358;
	Wed, 31 Dec 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYx/QU3E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE042798F3
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767197940; cv=none; b=knzvWh4/zXz1TsV+3BdgQXRZ9XLcz01g1EOx8nDSUZmsU35GR1gGHLOesYoGDOB1sIgU4/DCjoq+/Z+/fwzk6sk/qSSZOg1T0nuC2WO3vBiIKONpiuOD/wMFMwnG6jKEw63f366BFgpqMqftvucK+0qYKc0HNrRZO3drUSaT2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767197940; c=relaxed/simple;
	bh=QC9fIIhDzzl/HXTF/lYLq+ckESOKQIwP9WOMS/EDoV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkV2hTQx05gc4aBHaI1D0dOyFp007kInn12OpUn+vpMZgu6EjGtGBe+Yd53EsCvcu+U2CzqitLmU/akShw7NtRN8wzZjXT8KlrGyg+yu04u53ifibBExEh4dhH9LIWXqUPfvHxe12jjJMfFrQLGMmrOd8ScitUONXWd41DE5JM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYx/QU3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D1C113D0;
	Wed, 31 Dec 2025 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767197940;
	bh=QC9fIIhDzzl/HXTF/lYLq+ckESOKQIwP9WOMS/EDoV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYx/QU3EAynCM7JV94gCMRDEosiLPsIgIlFie+5GG0HWHmfWtrdQL5shHg2dEkPqi
	 EhH0rakCL43qrhk+VmzErJAFm4lZjPLLpa3k64Z91c8Hq02UHZHAyfwsRp1TFX10p6
	 2v5D8ShR5BoW/eImSC1x661/gjevI0QQAZYegwET1zfSdMzIEGFprR47fcOnLFe0Dc
	 zCWAY3wGiAX/py7vDUqrg7jGwR6CWTYTtw8/mYYNFjPri+CKiZM4dTXp0lQrR2P9CW
	 U14wFyNPjvFIM+SE92S54UKiVvtfnqcu90wTuKIX3ICpScVbbGIiJ1a27nQRQgJItg
	 KNcyQFSuxXNbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Tiago=20Martins=20Ara=C3=BAjo?= <tiago.martins.araujo@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] drm/displayid: add quirk to ignore DisplayID checksum errors
Date: Wed, 31 Dec 2025 11:18:56 -0500
Message-ID: <20251231161856.3237284-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231161856.3237284-1-sashal@kernel.org>
References: <2025122944-trimester-congrats-2c82@gregkh>
 <20251231161856.3237284-1-sashal@kernel.org>
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
index 957dd0619f5c..5b1b32f73516 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -167,6 +167,8 @@ struct displayid_iter {
 
 	u8 version;
 	u8 primary_use;
+
+	u8 quirks;
 };
 
 void displayid_iter_edid_begin(const struct drm_edid *drm_edid,
-- 
2.51.0


