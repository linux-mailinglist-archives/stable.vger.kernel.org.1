Return-Path: <stable+bounces-140184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76709AAA639
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5F27AFDE4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CAD29187A;
	Mon,  5 May 2025 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJB4Buvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC255291872;
	Mon,  5 May 2025 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484289; cv=none; b=lMes8BCnMoQ2VlaDqD1Ena4aD3K1/bpYDaAzThczCyv4DtJzMQHkzMCzlEREDedVShIO7TWanG2ml4g2WNqXPO5/auFWgygeNVKgEPFYbJ4q936xM9pZ6mSWA8jm0nf+tRdKmWr0y6CmWh9/0v88WMEt64K46HOkaV3/pIBCsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484289; c=relaxed/simple;
	bh=zpK1R8wze3U6ReEPtkYuk8uW5B/Opn6Y5h40oQ9O7To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QGPpeAkh2Cya9naWBf7DwbD5UIZQhb5qJFvRcxsBLvHgb7j9zsO6XqjDsDOx4iEj9ALAoxchy7XiYrjwU38AcYmzun1+ePCIt03XfJj8mE7hR4qJ8WcewdTwGhE7mUj2irqVQbavF4iN579BJQ4TmToB3aFYO8uwOu4MAzfHNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJB4Buvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C387C4CEEF;
	Mon,  5 May 2025 22:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484289;
	bh=zpK1R8wze3U6ReEPtkYuk8uW5B/Opn6Y5h40oQ9O7To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJB4BuvcvYrpgwRwqL3ROSopDaUcy+mqfE2q0qdT6uk4SvYVnjXiw3uxFGTKBrlWP
	 3tgZrdIVDC3tmbE7m0tx5ysq41YnegMxghRRqPp4OBGjZL6IRxao+VW3SkV+l7y42h
	 OfDU1xDB4wm0pEtfvxKWtsuq0pon/Sf2EuQxTLPTDtXtXkVvwmLWByUoeiMUr+uOtl
	 0jm9gwKt/xc4suenBMKAMm20NPSMlDk5GFMDRxtfiTbmcNNCznyibH1uPxah+DEQQ+
	 KtNA3QJIpa8HoyYCMSKFt/cp4iVteKl3zjNWWoZuPfrklrjoMrJCmPZw2XoVOdQQqi
	 J/pGXh+FEHBXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 437/642] drm/xe: Fix xe_tile_init_noalloc() error propagation
Date: Mon,  5 May 2025 18:10:53 -0400
Message-Id: <20250505221419.2672473-437-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit 0bcf41171c64234e79eb3552d00f0aad8a47e8d3 ]

Propagate the error to the caller so initialization properly stops if
sysfs creation fails.

Reviewed-by: Francois Dugast <francois.dugast@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213192909.996148-4-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_tile.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_tile.c b/drivers/gpu/drm/xe/xe_tile.c
index 07cf7cfe4abd5..37f170effcd67 100644
--- a/drivers/gpu/drm/xe/xe_tile.c
+++ b/drivers/gpu/drm/xe/xe_tile.c
@@ -176,9 +176,7 @@ int xe_tile_init_noalloc(struct xe_tile *tile)
 
 	xe_wa_apply_tile_workarounds(tile);
 
-	err = xe_tile_sysfs_init(tile);
-
-	return 0;
+	return xe_tile_sysfs_init(tile);
 }
 
 void xe_tile_migrate_wait(struct xe_tile *tile)
-- 
2.39.5


