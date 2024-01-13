Return-Path: <stable+bounces-10759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E482CB80
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 11:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51E6283ECB
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968DA185A;
	Sat, 13 Jan 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e1t6Hez+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6728F7;
	Sat, 13 Jan 2024 10:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B12C433F1;
	Sat, 13 Jan 2024 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705140020;
	bh=HctQXMDlZgDfADNGo0797r2sdJ4x5LCcUdut553yTwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1t6Hez+gutEvrhYHww/MnaHK1MfLaktb6+GQBTvUPEDSuDoVXnie0AnIuCc1iz4x
	 M0NmK5a1HIb8vrQPppF1iwijH7gmNLD75vhYwAw6Zif7/R7FSkWHhGhMqV/IbJb3w0
	 jZgZuGYMfSOWnuJRpjwFIi6yfHlLJ4673mFIih40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jani Nikula <jani.nikula@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Lee Shawn C <shawn.c.lee@intel.com>,
	Khaled Almahallawy <khaled.almahallawy@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 09/59] drm/i915/dp: Fix passing the correct DPCD_REV for drm_dp_set_phy_test_pattern
Date: Sat, 13 Jan 2024 10:49:40 +0100
Message-ID: <20240113094209.589386260@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
References: <20240113094209.301672391@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Khaled Almahallawy <khaled.almahallawy@intel.com>

[ Upstream commit 2bd7a06a1208aaacb4e7a2a5436c23bce8d70801 ]

Using link_status to get DPCD_REV fails when disabling/defaulting
phy pattern. Use intel_dp->dpcd to access DPCD_REV correctly.

Fixes: 8cdf72711928 ("drm/i915/dp: Program vswing, pre-emphasis, test-pattern")
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Lee Shawn C <shawn.c.lee@intel.com>
Signed-off-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231213211542.3585105-3-khaled.almahallawy@intel.com
(cherry picked from commit 3ee302ec22d6e1d7d1e6d381b0d507ee80f2135c)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6cc1258578088..a0c04b9d9c739 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3275,7 +3275,7 @@ static void intel_dp_process_phy_request(struct intel_dp *intel_dp,
 			  intel_dp->train_set, crtc_state->lane_count);
 
 	drm_dp_set_phy_test_pattern(&intel_dp->aux, data,
-				    link_status[DP_DPCD_REV]);
+				    intel_dp->dpcd[DP_DPCD_REV]);
 }
 
 static u8 intel_dp_autotest_phy_pattern(struct intel_dp *intel_dp)
-- 
2.43.0




