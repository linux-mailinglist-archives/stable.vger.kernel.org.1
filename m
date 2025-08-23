Return-Path: <stable+bounces-172588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7CAB328B2
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF43B1C260FD
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC91233704;
	Sat, 23 Aug 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blnCF6Bt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACCB15C158
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755954604; cv=none; b=a4hUKPy/RGbGYyepGCCkS6LR4SMk3bBjXgGgtJOLU5CjWGQm+7FcJe883V/giWBv5KQA0yMvBeTIsiJhrCpbv5ibE8fAHlhrik7asuT45cqKVXURbO1brc9hU8n/wtj7rySUduSWEs6sRoZ1gn+I7njJuZJJLMfeKl21OzwPBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755954604; c=relaxed/simple;
	bh=ZCsK1iKGS9Z9QvTL6s7OqsTAVcTbw7cF2oclJSKw+AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hC5dgf+Sz1nBlTpzTajofxcODMfstOBR0jJwjvH0pl0Zf541/aoMfmN110scy+9YfH33kniZtso2PxCnK2VE4Ou0KlDnExDWGpwCsbw03a2Rvx4FrB0Oxr82B9j71T0GA0jwPvdPa5BD3lyEcC10b0v4m4BAPxJ2qYnjvvmoUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blnCF6Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CFEC4CEE7;
	Sat, 23 Aug 2025 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755954604;
	bh=ZCsK1iKGS9Z9QvTL6s7OqsTAVcTbw7cF2oclJSKw+AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blnCF6Bt4wxPmYVtQmBWEz4TmROnpSRR6FCtcllIiTzjr7Ft3tooPrzgKsBSuDstj
	 dY4rGaac2lBIa+e59ZHU6n7ZTjPD0C+O1+8PUuHRNSuNWIV+CBVi3quO14OLNOFe9q
	 bj8iAbPuSRhy3aOUiJ4J6dNRwkCXp+9n/iOXMYLXD3fYdimJiKydAziVM1DAvTK53W
	 jY4ier0RJ8ji+FLYhBtHPLNgqJB0+WbdE3OflQiuXWqDzYK+gLe6NrDqyxEl29Xfn1
	 Yv3Aa/glHh9zTVYZMiFAuPolkuxqE5Wjmnvu431F2XeL3GESmKknd4kTXimWuPW1Sy
	 jaGYt9hoLe7sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS
Date: Sat, 23 Aug 2025 09:10:01 -0400
Message-ID: <20250823131001.2113226-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082149-disfigure-divinely-bc5c@gregkh>
References: <2025082149-disfigure-divinely-bc5c@gregkh>
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
index 851f0baf9460..772d8e662278 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -663,7 +663,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
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


