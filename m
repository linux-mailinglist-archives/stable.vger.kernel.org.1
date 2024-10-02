Return-Path: <stable+bounces-79248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EDE98D74A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C6BB22525
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DCA1D0156;
	Wed,  2 Oct 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XSxIzaR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837629CE7;
	Wed,  2 Oct 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876884; cv=none; b=Y1Az/9S76vRt0uT0esCXcyyF2PMP5DJf40F6520YJvrbDVzy6RKfXCS57rslxARgyl2y5bXPszgA9FsCHtxzxI7fOiUEf78PZnLld7RKb3tWME6Y512CpuzGT8yOOf5yqaGRw7n6BiZ8Luyz659P77F9YPUW8jlUE+umw9iAKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876884; c=relaxed/simple;
	bh=/mxsa7174w2HCVmddt1yVJXMGxUEU9jicc7mv54xWWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0tPHoUai6rc00xUb54SAJhe7hqBkUwg3GtkWCXwcFoAJwMfUkaeZBqLDxhu5+4TA9kUR1C/xCtzivVxMabOxpODKC6tGcl3dc6uoDtGq6NXCO2bOqnTLmUxyV24rWEd1A+Erh0n34CsiAKiCDwkx0V0wkfY0Vwu4Ji8jyjraew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XSxIzaR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E026C4CEC2;
	Wed,  2 Oct 2024 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876883;
	bh=/mxsa7174w2HCVmddt1yVJXMGxUEU9jicc7mv54xWWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSxIzaR/2jk38h/ZGwLYx7mUcyQfLLqcrecXOMxP6FDPYNhzyaJg5RjEiT1B+8Bpv
	 iuVA/mQwMolDpoZDeDVp5qyvLdfq4IYbLB0uEHkUmkfhJj4yW9IpGaWodLqDf+y1N2
	 1yzKMw6slh8LA4iAz+Ki0tqO89c5z8tLb83GmzUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sun peng Li <sunpeng.li@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.11 561/695] drm/amd/display: Update IPS default mode for DCN35/DCN351
Date: Wed,  2 Oct 2024 14:59:19 +0200
Message-ID: <20241002125844.896413581@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Li <Roman.Li@amd.com>

commit 199888aa25b3a3315360224bda9134a9b58c9306 upstream.

[WHY]
RCG state of IPX in idle is more stable for DCN351 and some variants of
DCN35 than IPS2.

[HOW]
Rework dm_get_default_ips_mode() to specify default per ASIC and update
DCN35/DCN351 defaults accordingly.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   50 ++++++++++++++--------
 1 file changed, 33 insertions(+), 17 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1756,25 +1756,41 @@ static struct dml2_soc_bb *dm_dmub_get_v
 static enum dmub_ips_disable_type dm_get_default_ips_mode(
 	struct amdgpu_device *adev)
 {
-	/*
-	 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
-	 * cause a hard hang. A fix exists for newer PMFW.
-	 *
-	 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
-	 * IPS state in all cases, except for s0ix and all displays off (DPMS),
-	 * where IPS2 is allowed.
-	 *
-	 * When checking pmfw version, use the major and minor only.
-	 */
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(3, 5, 0) &&
-	    (adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
-		return DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+	enum dmub_ips_disable_type ret = DMUB_IPS_ENABLE;
 
-	if (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(3, 5, 0))
-		return DMUB_IPS_ENABLE;
+	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+	case IP_VERSION(3, 5, 0):
+		/*
+		 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
+		 * cause a hard hang. A fix exists for newer PMFW.
+		 *
+		 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
+		 * IPS state in all cases, except for s0ix and all displays off (DPMS),
+		 * where IPS2 is allowed.
+		 *
+		 * When checking pmfw version, use the major and minor only.
+		 */
+		if ((adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
+			ret = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+		else if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(11, 5, 0))
+			/*
+			 * Other ASICs with DCN35 that have residency issues with
+			 * IPS2 in idle.
+			 * We want them to use IPS2 only in display off cases.
+			 */
+			ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+		break;
+	case IP_VERSION(3, 5, 1):
+		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
+		break;
+	default:
+		/* ASICs older than DCN35 do not have IPSs */
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) < IP_VERSION(3, 5, 0))
+			ret = DMUB_IPS_DISABLE_ALL;
+		break;
+	}
 
-	/* ASICs older than DCN35 do not have IPSs */
-	return DMUB_IPS_DISABLE_ALL;
+	return ret;
 }
 
 static int amdgpu_dm_init(struct amdgpu_device *adev)



