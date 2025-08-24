Return-Path: <stable+bounces-172670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0FEB32CB8
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 02:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DB3207F3E
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF018C31;
	Sun, 24 Aug 2025 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+542iPt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3593211F
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755995539; cv=none; b=PVJTgh2L8AGod5pZWsZWPQ4U63Sfx5Lx6w74jioJRcJXAdXegf9hGRvGtgXG3D2Stug23WpNhinDW9gIanytN/8DacxQYnXh3JEqPqznufWvSG2JkHER1UjN34zpgx3TaIWo3VZp9nCwgMGAHeaK2WguTyREMUdEYlGDIbf427k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755995539; c=relaxed/simple;
	bh=XWG2nmbMmZ7E6FKI7+R4IelLfmICqlZwV5okOV3BBns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/jaqEHMhqOV+4mVcW3fJfSsAhIr1yVW4s93YYVIFMg/tztRJq/JLSAASJW/K1Kk95QifEil5wmOYvr1YBaK8fx5M1K+mWZJfjEyphZebXorTHboL0QswVBVq4+7eLH5L5Rx+so/kxP/Mu18TZwV25cydvFDhlL4bR+pA/7qGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+542iPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7742FC4CEE7;
	Sun, 24 Aug 2025 00:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755995539;
	bh=XWG2nmbMmZ7E6FKI7+R4IelLfmICqlZwV5okOV3BBns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+542iPtnND1QHNGOTcWO4X5rGzYyfECESFKvlesjqnN5NA9jdQv4KGOqHOZxKCMw
	 I+wrx+j04WWYNCQ+a3tnxUsGKHdNLDMutXGCrTb71PDhRQ9wUPsEwVbRIns16Kjrd1
	 C/3OsOzODILTNRuIMTgi6qS+IEMfa/OaVhgt7dExqRH0jRkAnooo46YiOGtN4IWwpC
	 RVPTl+8Z+ctYU4iYW8qKPSH14+72LPXHwk4vCk5+/DTVFZODg7QBwBoCirgWOJUMIu
	 cmX/vg6J2/xK6iROsT47xnW9yR+osbBw5KdbNK749z9e3UL00sYcyJGovl3mblsNEB
	 QrdlYjqqYiX6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	Charlton Lin <charlton.lin@intel.com>,
	Khaled Almahallawy <khaled.almahallawy@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/icl+/tc: Convert AUX powered WARN to a debug message
Date: Sat, 23 Aug 2025 20:32:15 -0400
Message-ID: <20250824003215.2541102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082347-unstuck-spiral-493c@gregkh>
References: <2025082347-unstuck-spiral-493c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit d7fa5754e83cd36c4327eb2d806064e598a72ff6 ]

The BIOS can leave the AUX power well enabled on an output, even if this
isn't required (on platforms where the AUX power is only needed for an
AUX access). This was observed at least on PTL. To avoid the WARN which
would be triggered by this during the HW readout, convert the WARN to a
debug message.

Cc: stable@vger.kernel.org # v6.8+
Reported-by: Charlton Lin <charlton.lin@intel.com>
Tested-by: Khaled Almahallawy <khaled.almahallawy@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://lore.kernel.org/r/20250811080152.906216-6-imre.deak@intel.com
(cherry picked from commit 6cb52cba474b2bec1a3018d3dbf75292059a29a1)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
[ display->drm API => i915->drm ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_tc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 6f2ee7dbc43b..10bf7baf8726 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -1416,7 +1416,8 @@ static void intel_tc_port_reset_mode(struct intel_tc_port *tc,
 
 		aux_domain = intel_aux_power_domain(dig_port);
 		aux_powered = intel_display_power_is_enabled(i915, aux_domain);
-		drm_WARN_ON(&i915->drm, aux_powered);
+		drm_dbg_kms(&i915->drm, "Port %s: AUX powered %d\n",
+			    tc->port_name, aux_powered);
 	}
 
 	tc_phy_disconnect(tc);
-- 
2.50.1


