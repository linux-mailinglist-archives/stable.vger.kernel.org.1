Return-Path: <stable+bounces-51149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0370906E8B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23291C21B13
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6242A144D22;
	Thu, 13 Jun 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="avAXp8HE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2F82C76;
	Thu, 13 Jun 2024 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280453; cv=none; b=EsAcwsRQDuzhr2F3z3P6UdJssPkpNUe/dy2YTdZ/WSxdeyQxenmCdYqzfSDDPuQUbHG3gpObrJK4ME/s8AQRhmanzF0yNMjnjh2wCzHvuvYY+tJ7jbe7mywMCHq+AehYNA2uw0vTLDfw1inzatB0VPP/gKS84BQGD/CiFph7Cr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280453; c=relaxed/simple;
	bh=6h/tc7E6i0eAc5nbY9SbdaG9TV75+P88v3bU5K774jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENX1Mub8hHn1q+mV8U7htnCXIuOMvicypb5vAnmnCFu5qaILZVeBwFcBuKcMsjff3uTB76nUS0ycpXhTcbFGhychtdAQKmlZRKxqDBP51kKQ+c43jh+2ubjvblE/S2TyBt3B56/xm9P04WOBHygLZD0zy0Me85Bg60oKO8FNy08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=avAXp8HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF03C2BBFC;
	Thu, 13 Jun 2024 12:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280453;
	bh=6h/tc7E6i0eAc5nbY9SbdaG9TV75+P88v3bU5K774jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=avAXp8HELi9nCSwiaz+efb9wvWRtrGeQ9HJmK0+3ck0PgwIW4gIQt+oEIQj4y7LsF
	 d3WSRS5rAWCzDpHME4sK6VWcC8NpEw2yl8jUGh6bvQ76TU7ub/Y8Es1aV8gWjeeLB2
	 CiI0g1mxSJh6LGKsqyRpR1dB2qEIRBNYlUZ5iCPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Huang <Tim.Huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	lectrode <electrodexsnet@gmail.com>
Subject: [PATCH 6.6 058/137] drm/amd: Fix shutdown (again) on some SMU v13.0.4/11 platforms
Date: Thu, 13 Jun 2024 13:33:58 +0200
Message-ID: <20240613113225.554681924@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 267cace556e8a53d703119f7435ab556209e5b6a upstream.

commit cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown for
some SMU 13.0.4/13.0.11 users") attempted to fix shutdown issues
that were reported since commit 31729e8c21ec ("drm/amd/pm: fixes a
random hang in S4 for SMU v13.0.4/11") but caused issues for some
people.

Adjust the workaround flow to properly only apply in the S4 case:
-> For shutdown go through SMU_MSG_PrepareMp1ForUnload
-> For S4 go through SMU_MSG_GfxDeviceDriverReset and
   SMU_MSG_PrepareMp1ForUnload

Reported-and-tested-by: lectrode <electrodexsnet@gmail.com>
Closes: https://github.com/void-linux/void-packages/issues/50417
Cc: stable@vger.kernel.org
Fixes: cd94d1b182d2 ("dm/amd/pm: Fix problems with reboot/shutdown for some SMU 13.0.4/13.0.11 users")
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c |   20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -226,15 +226,17 @@ static int smu_v13_0_4_system_features_c
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && adev->in_s4) {
-		/* Adds a GFX reset as workaround just before sending the
-		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
-		 * an invalid state.
-		 */
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
-						      SMU_RESET_MODE_2, NULL);
-		if (ret)
-			return ret;
+	if (!en && !adev->in_s0ix) {
+		if (adev->in_s4) {
+			/* Adds a GFX reset as workaround just before sending the
+			 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
+			 * an invalid state.
+			 */
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+							      SMU_RESET_MODE_2, NULL);
+			if (ret)
+				return ret;
+		}
 
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
 	}



