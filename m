Return-Path: <stable+bounces-172585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD81B328AB
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86516821B0
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506A246BA4;
	Sat, 23 Aug 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs9mkBWK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A223D287
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953788; cv=none; b=Zz999LAx0qGDMUH41q6lbFrT+pIuMCl68fXK4OZgLkHlNpb8Zj2yGnifCWxT57m7fuzJyb8zoWNrQg26nBAX3NzR231iUVLbL8taDOe027BcU5P7nGmRv5J5BnBeC5upvstnW/8b+Rr07hvwuGUo50eqgMu/nctKusK3J9rg7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953788; c=relaxed/simple;
	bh=mDfi+vGDYy1phkvkQZOno74ILGCGwVxkGNZnwuUkHU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOwuN/OOixHN4MDUa6XjCT2Sonlxj+oL28kvyLm9m+QYLKyE7aih+3YWrdhKR6v0gtvX2VIYWtfYDfwBnQxbfvPdoZJ3MRK5YPE1oeLQtZA25QVom1SPjKgw6z1gtVT3gW6aU/HKvgdPDJ8vA4tCMfnZ2QZRj6rmmfmnVOtwBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs9mkBWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C81C4CEF4;
	Sat, 23 Aug 2025 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755953788;
	bh=mDfi+vGDYy1phkvkQZOno74ILGCGwVxkGNZnwuUkHU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gs9mkBWKFOyN9KzCDG41wQ/JJu3FN2K+dN/3pFnmLCzf91/uC720oGIeLbv15RHkX
	 48W82Hs3nt+UMcZZsVXpLA13NdWsKOhFT15NkdyWUomcFrDmJhL7XmKgfqax4oKQvF
	 sAL4cFTEw3Zxjb/mCOoko6UeaZJlfMGNRfnfJEg7GTx2VH7WL1+BMsyOfxP0+JcCcF
	 IyLveh/RhIqb29xYqSHHsfjulqqepOkGAWW5tAJ8txx8VutDcNSkBLR6LBAGvWYD4C
	 hrTAPaND8TyTmYxV2LK2coVAbPEtVyvgwEsy0isqD5JEBxsOzWnqah0dVwXujzK2S8
	 qCkD9Qj0zQ2dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y] drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS
Date: Sat, 23 Aug 2025 08:56:25 -0400
Message-ID: <20250823125625.2103160-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082148-refutable-outmatch-8a67@gregkh>
References: <2025082148-refutable-outmatch-8a67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit a40c5d727b8111b5db424a1e43e14a1dcce1e77f ]

Reading DPCD registers has side-effects in general. In particular
accessing registers outside of the link training register range
(0x102-0x106, 0x202-0x207, 0x200c-0x200f, 0x2216) is explicitly
forbidden by the DP v2.1 Standard, see

3.6.5.1 DPTX AUX Transaction Handling Mandates
3.6.7.4 128b/132b DP Link Layer LTTPR Link Training Mandates

Based on my tests, accessing the DPCD_REV register during the link
training of an UHBR TBT DP tunnel sink leads to link training failures.

Solve the above by using the DP_LANE0_1_STATUS (0x202) register for the
DPCD register access quirk.

Cc: <stable@vger.kernel.org>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250605082850.65136-2-imre.deak@intel.com
[ DP_TRAINING_PATTERN_SET => DP_LANE0_1_STATUS ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index ea78c6c8ca7a..dc622c78db9d 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -725,7 +725,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_probe(aux, DP_TRAINING_PATTERN_SET);
+		ret = drm_dp_dpcd_probe(aux, DP_LANE0_1_STATUS);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.50.1


