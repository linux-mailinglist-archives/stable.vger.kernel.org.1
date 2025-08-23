Return-Path: <stable+bounces-172601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC718B32906
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B0AA2540E
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D598C2566E2;
	Sat, 23 Aug 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmNF07G5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AC1F4174
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958474; cv=none; b=Shn3032aNhiZQXnhK3R3Ga3z7B2Wb66EUHV/iwRflecvYJ2leKPtx7sSz9eAHlwE0v+iUcHkiPpcms71DwPVtZoQGyTCDlRjVkbpDp0zc8O7fcBXj3QT+oKlHItRgsr9PyjOlWUx92PGhXoYJCaKSA6vItwE5gfHuC1o41Bmg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958474; c=relaxed/simple;
	bh=coqEgOntdSTLG8b+lRy2qe4IlR1htmA5xPh1q3dPWc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmeq01Vg+HrDc123sWMBxIMYlHZDhCQ++jsWFob7GT9l08usGLqT/6mZeXgqyD1tm5TdVJ9P/KaIytp6BwNZ5jEt09kaA7WJUQd/du4VUjsBtDtqOF2C9W1/sfKHBNq4QszBLXNx6IDUTPIpBn6t+UF5UITjTMi6sp4XZaWIgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmNF07G5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A842C4CEE7;
	Sat, 23 Aug 2025 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755958474;
	bh=coqEgOntdSTLG8b+lRy2qe4IlR1htmA5xPh1q3dPWc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmNF07G5gf8Nc51GiAnIFXOy0fIjt9BqY53hH5zI2ua6IekrrOz7Ib5DMyCc/nvzX
	 kKtuS8CTLPWDS/W0AZUue6lC54fmxaTi17LW2hWXIfNRVYdEsLsDLu04Pnb+hGgSz4
	 oP9I9TXNCphsg5+XVfc4z05JpzmiI+u23wLAHRqPZJmdZCiUp+R9ITWCqNP1amEJQd
	 31YUa9Lk0Qd/8I3z1l9yF9LcUrwOiK9BuWMI3D6+gvEdvNydlV0LWX2+CdS04TjsCD
	 88GMcd42auIvGZDwFlK4vfgd1VMTZ0z07uHBoSmr0O9hXYzDFpMSD9Lm2CzHSiZrta
	 WEeMzgzY6NOlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/dp: Change AUX DPCD probe address from DPCD_REV to LANE0_1_STATUS
Date: Sat, 23 Aug 2025 10:14:31 -0400
Message-ID: <20250823141432.2196555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082151-aftermost-fanatic-fb5f@gregkh>
References: <2025082151-aftermost-fanatic-fb5f@gregkh>
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
[ call to drm_dp_dpcd_access() instead of drm_dp_dpcd_probe() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 6ba16db77500..ba8ab1dc4912 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -299,7 +299,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV,
+		ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_LANE0_1_STATUS,
 					 buffer, 1);
 		if (ret != 1)
 			goto out;
-- 
2.50.1


