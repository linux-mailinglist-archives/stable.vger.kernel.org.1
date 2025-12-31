Return-Path: <stable+bounces-204369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CABCEC385
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 17:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A066D3011763
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575428031D;
	Wed, 31 Dec 2025 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBhSJzmL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421A2798F3
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767197939; cv=none; b=CtxExgK0JksBFw80Va8ELB7hxi4GWKsZ11og31NisVttB4lbrei2XkYxpIoIh7HGeqfY3/qrGVWW3wBZzZCGUlkrbCUEk7yRs/UO7dK5IM0wWHvtpzwR2KKWVsCN3ItREXyNyT6VTkXsk1F7Rwweez9s/KFqfo3/HmnFCUjAgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767197939; c=relaxed/simple;
	bh=kUadBEXnLZdgoDOd8kgTz8e4gYPPYsKejtUeQ36+Qm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6dIVXOubk+962TvZDIXV4F2rLAWUrzGTZMBvPdjA+ViT/WNj+qlbq9XnWcsCaM8Hm9BgJ6AbMyrDt00aHZy9XeaMetbU0PrgCCGcNTvF9kM/5WTsOTOZIWwWffsciDnJHOCtlqSBWL37jAzE65vGU9ZxBLq/e/qxibH6WQdJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBhSJzmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3947DC113D0;
	Wed, 31 Dec 2025 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767197938;
	bh=kUadBEXnLZdgoDOd8kgTz8e4gYPPYsKejtUeQ36+Qm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mBhSJzmLBu5uUIGAd3/PRVbp3AfdoDqN5jT6JqBRKSmaK9hLJmpXK4B9X6D+7bHla
	 ong8wWG1kGpVZ3z66BSuRm+oVpIskU/Q+fdxkk1fqyclrmqJFuwmJHbc7aMOd78B2r
	 Rq9h8wSKxtfd9Ua4Iex9vMqgDMnyNBmlUx3CxtZETT4+NC37zEA9cntM3qsypJrvt3
	 5c0//doFZgIeVvK2wcRf7O6gs2JY55EDriaFBRNWV+bZG21VJj/4J70xmZGNl6vYng
	 KxKs5Z3D78YKUqBoOE+dzlqILsK3zfsaXzwhhYpbserC9fp0mgS/YtYKLQS6eaIhbv
	 kz0pvesWU/GUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Tiago=20Martins=20Ara=C3=BAjo?= <tiago.martins.araujo@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] drm/displayid: pass iter to drm_find_displayid_extension()
Date: Wed, 31 Dec 2025 11:18:54 -0500
Message-ID: <20251231161856.3237284-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122944-trimester-congrats-2c82@gregkh>
References: <2025122944-trimester-congrats-2c82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 520f37c30992fd0c212a34fbe99c062b7a3dc52e ]

It's more convenient to pass iter than a handful of its members to
drm_find_displayid_extension(), especially as we're about to add another
member.

Rename the function find_next_displayid_extension() while at it, to be
more descriptive.

Cc: Tiago Martins Araújo <tiago.martins.araujo@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Tiago Martins Araújo <tiago.martins.araujo@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/3837ae7f095e77a082ac2422ce2fac96c4f9373d.1761681968.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Stable-dep-of: 83cbb4d33dc2 ("drm/displayid: add quirk to ignore DisplayID checksum errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_displayid.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_displayid.c b/drivers/gpu/drm/drm_displayid.c
index b4fd43783c50..20b453d2b854 100644
--- a/drivers/gpu/drm/drm_displayid.c
+++ b/drivers/gpu/drm/drm_displayid.c
@@ -48,26 +48,24 @@ validate_displayid(const u8 *displayid, int length, int idx)
 	return base;
 }
 
-static const u8 *drm_find_displayid_extension(const struct drm_edid *drm_edid,
-					      int *length, int *idx,
-					      int *ext_index)
+static const u8 *find_next_displayid_extension(struct displayid_iter *iter)
 {
 	const struct displayid_header *base;
 	const u8 *displayid;
 
-	displayid = drm_edid_find_extension(drm_edid, DISPLAYID_EXT, ext_index);
+	displayid = drm_edid_find_extension(iter->drm_edid, DISPLAYID_EXT, &iter->ext_index);
 	if (!displayid)
 		return NULL;
 
 	/* EDID extensions block checksum isn't for us */
-	*length = EDID_LENGTH - 1;
-	*idx = 1;
+	iter->length = EDID_LENGTH - 1;
+	iter->idx = 1;
 
-	base = validate_displayid(displayid, *length, *idx);
+	base = validate_displayid(displayid, iter->length, iter->idx);
 	if (IS_ERR(base))
 		return NULL;
 
-	*length = *idx + sizeof(*base) + base->bytes;
+	iter->length = iter->idx + sizeof(*base) + base->bytes;
 
 	return displayid;
 }
@@ -126,10 +124,7 @@ __displayid_iter_next(struct displayid_iter *iter)
 		/* The first section we encounter is the base section */
 		bool base_section = !iter->section;
 
-		iter->section = drm_find_displayid_extension(iter->drm_edid,
-							     &iter->length,
-							     &iter->idx,
-							     &iter->ext_index);
+		iter->section = find_next_displayid_extension(iter);
 		if (!iter->section) {
 			iter->drm_edid = NULL;
 			return NULL;
-- 
2.51.0


