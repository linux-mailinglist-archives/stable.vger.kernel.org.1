Return-Path: <stable+bounces-76640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA6997B863
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 09:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B47284BC1
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB516FF3B;
	Wed, 18 Sep 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiUelxl7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966B169AE6;
	Wed, 18 Sep 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726643882; cv=none; b=mwug8cL/HEopLfGr6l2yp+ezPCRSh2FBsZtIjoQI7XE1LJQLzHFncVTSMuL3zodr2XZjBcytfJcJZ4dRN6bD/7irESKdJbV7t6Tg2IbJYSC7M/rgZVy0Ku6jNPCwNQpvIiEb8+dSkj6ZygxeX+OoVUa0gfC9Z4UYpN4qJyDCpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726643882; c=relaxed/simple;
	bh=Y9jbd4JWFQB6z2sA5iWC4S4FUg6AOW2guJLi3l2dohY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC4SI+bYB2yhcXUtlMWXTPzyFxObXIiqEwdX1XaFaR6r5pnvwafP9JJurWTleVJwpYfEb/AyTML70A2NPLddx1kSqFzBOYBj0XxNgJyE5xZ1zo5E5lGkoVFPYrjNQRhIt2xLLSV9HUIjNS9TqWb53ITwsPBMu0UPOLnuGmXKvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiUelxl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4040C4CEC3;
	Wed, 18 Sep 2024 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726643882;
	bh=Y9jbd4JWFQB6z2sA5iWC4S4FUg6AOW2guJLi3l2dohY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiUelxl7xtEQ2ZWSMgLoBN5lh7gFpTd/whJLm9+KQWphDIDiHsBtPoFlPSjc0m9oi
	 3gYwcl34kVAMDQokyLDl3TH59bFq0k6vO4lo7fNB2QiAl5n9opSkkppaORbV9zRXpG
	 RvhC19xj4RblcFkkXyWn7qhCjWEiU8lboen5aoJuGH6jNqRihAi1ikH+8g+63qxmnn
	 cZJXdDCzUlX+2++Ce56lJlSFWjj4R9jtWupSoVRpOGBAsvh6uV5CwYM7crSYG0Er3E
	 RaDdO1F5wVi8traFKW3k5cOaBcCRq0YJtGnAiqB3oGyHATztZsP0Bl1Zf/YBRaT51R
	 /dqkUZi0MyX7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	evan.quan@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@linux.ie,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 3/3] drm/amd/pm: fix the pp_dpm_pcie issue on smu v14.0.2/3
Date: Wed, 18 Sep 2024 02:36:11 -0400
Message-ID: <20240918063614.238807-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918063614.238807-1-sashal@kernel.org>
References: <20240918063614.238807-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.10
Content-Transfer-Encoding: 8bit

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit 7a0982523cf3ff00f35b210fc3405c528a2ce7af ]

fix the pp_dpm_pcie issue on smu v14.0.2/3 as below:
0: 2.5GT/s, x4 250Mhz
1: 8.0GT/s, x4 616Mhz *
2: 8.0GT/s, x4 1143Mhz *
the middle level can be removed since it is always skipped on
smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit fedf6db3ea9dc5eda0b78cfbbb8f7a88b97e5b24)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 06b65159f7b4..33c7740dd50a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -672,6 +672,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
 					skutable->LclkFreq[link_level];
 		pcie_table->num_of_link_levels++;
+
+		if (link_level == 0)
+			link_level++;
 	}
 
 	return 0;
-- 
2.43.0


