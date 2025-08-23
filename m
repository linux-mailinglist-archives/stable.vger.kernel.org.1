Return-Path: <stable+bounces-172586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9FB328AC
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B255AA3C38
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A8E28682;
	Sat, 23 Aug 2025 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihIMxlFo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BB3FF1
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755954137; cv=none; b=KV/RBnV166+RWNTi6tp9IBZCDUhAhKWxo5cIrUTjfo5wPRvf7hIU3aUAIKVigSR8lVvkgYJX0HViy8/WBlh3DRiYIfm+ic3OIUhCgiTkVoEEXMrAyjrsZukmtji4mgHyJMneviKVYyP0jWVgN0wVavWygoyiwEDEOLtessneqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755954137; c=relaxed/simple;
	bh=iPKYhmNFge8+R8ugTJVwYBJxCGUlmOMsiIMfFfVgFto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIi31C2ywtTeiV87RUbOfiGS/rTBoHDXTY9IU2MA1FIPBceeDW3XPHJwkC5xPOUntKzWTqt3Rpa+YaA6BCUL7F806WWi35iwO6ot3TTD0UoXdXqXjEFDglra2q38tJcmaC/N4k96xjghIyzzwtjbTeGrz0Gh9fhLi8wsWQeYSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihIMxlFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8245DC4CEE7;
	Sat, 23 Aug 2025 13:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755954136;
	bh=iPKYhmNFge8+R8ugTJVwYBJxCGUlmOMsiIMfFfVgFto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihIMxlFomzMSv0JOpIx542hbmVaLFpBqgMmk/zuN+ETeatc/4hi7VjSSgWSbf5Biu
	 UZiRhNDXtz/hai1+VFAoqz2vvX/7z+Khbs16OnTpbU0biTTQg4Lb8EhlDQnreltSzf
	 za27PboKteXcef4raRZfC5IbloNwA1z42AJNMwfZIzDy4ElH4S1U3aTNKdo1TPSM+m
	 kMVrpY03qVg2JPol8vsaWZNwYlRVbYpvy9Z0Tf8qGmPlJcQDOmbjh+R9whgQL81/TF
	 WNgwwrpAZ15SK4i3wq5XPShu5gzhy5hs483SSsSAEi485vtrvF8eVcdkXqQHDFKELc
	 1nsQttpGcu61w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS
Date: Sat, 23 Aug 2025 09:02:13 -0400
Message-ID: <20250823130214.2108368-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082149-baggy-limpness-3f61@gregkh>
References: <2025082149-baggy-limpness-3f61@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 9fa13da513d2..bb61bbdcce5b 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -664,7 +664,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
+		ret = drm_dp_dpcd_probe(aux, DP_LANE0_1_STATUS);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.50.1


