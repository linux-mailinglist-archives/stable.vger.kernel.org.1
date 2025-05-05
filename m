Return-Path: <stable+bounces-141209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82489AAB1A0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B5F3A8989
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64224401162;
	Tue,  6 May 2025 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGa5ivS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4012D1F48;
	Mon,  5 May 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485492; cv=none; b=iVKXfouCoc7LUbZ21a9UrlifUZ5JW9hDOyh74RSYwd+W2WEih4dr/sbIIgYVNrZD82gpPWjCsvHmhaLw4Zc2djhJI01/XYPwOwfWYUOnd2pdyz6eSnoHwkVRToeCs2/tqJMD5F9xnPGk7vUFy4UETaB6gJK8bn0PxinTZc5DZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485492; c=relaxed/simple;
	bh=rNpSLdeuMAuI1j6VCZmei6KaiZtnFNpKia4rWzF842M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NSHHVMCjEcFIRgcojyIwrwXF/indPOUz3p8iCtOFflmZyzJMSDHEggaV+TEdKD8CEBOagopgg8zLapLRPd/WO0wP5JpqZRdKMUl+S9Rnzd0W/fdSQgRNPlyNK6K6MQBJlBnL+iki9a26BzYf8c/u7xAyoBbbXhhTyDqOPA9uyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGa5ivS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12CBC4CEE4;
	Mon,  5 May 2025 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485492;
	bh=rNpSLdeuMAuI1j6VCZmei6KaiZtnFNpKia4rWzF842M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGa5ivS369oeyC4q+tMft5hTqJwbwiwkbqkc/j44dyXlNqNMjR94eFLVyIOUvidwa
	 oM2fFvoUn9xl/AcHGAG7jAmz0vpAqZ9BgCf0lIyMIgYvoc5RTgmoaW68KIug5WrXPk
	 6xivpBmFaj82vvYt1vgW/aOVwrhCT4CCH3sv73OPDreNoQ8bD5vIVHdiQtbil2PLHW
	 rIoXw6N0UZR8ojywka3q1WBWG9aGABKmoDejGx21fNGrzklGUJ7sp7QzCxvSW85Atk
	 3DqpH8O4vOU+mU22KqhFV/UbH+HNaA4XJEgr8Bay8wJB+VxqpKOwUxM7h7k4i6XJ90
	 hRbDrVv0BdD6A==
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
Subject: [PATCH AUTOSEL 6.12 344/486] drm/xe: Fix xe_tile_init_noalloc() error propagation
Date: Mon,  5 May 2025 18:37:00 -0400
Message-Id: <20250505223922.2682012-344-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index dda5268507d8e..349beddf9b383 100644
--- a/drivers/gpu/drm/xe/xe_tile.c
+++ b/drivers/gpu/drm/xe/xe_tile.c
@@ -173,9 +173,7 @@ int xe_tile_init_noalloc(struct xe_tile *tile)
 
 	xe_wa_apply_tile_workarounds(tile);
 
-	err = xe_tile_sysfs_init(tile);
-
-	return 0;
+	return xe_tile_sysfs_init(tile);
 }
 
 void xe_tile_migrate_wait(struct xe_tile *tile)
-- 
2.39.5


