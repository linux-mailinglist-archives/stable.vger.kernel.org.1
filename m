Return-Path: <stable+bounces-64924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECFB943C94
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82CEB26777
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9975814D422;
	Thu,  1 Aug 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIPh/VdV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F1441F;
	Thu,  1 Aug 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471451; cv=none; b=ezeVeTYhSmJ/y/8d3s+XTx4Flx90p7L/WrY69gt4xe8ifOjwgTs4r0OjPyq2zVOlI7g3JJQe6+3ICfrZdgJKM00m+HIDqI/K7/ECJP7A9+AJpt1SosrXa4sOfPbCh+YXELxzLngI0/ZG5E0YdGgm0BXmzFPPrvKv/a26o21XfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471451; c=relaxed/simple;
	bh=l755Jq9bxcVcurMsrHOJdoqYBGnGShDlnnL22h02viA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpPPMHAWjYqZ/Yp1vubFv/Hzkb7plsOHMvVaeXENt3TAETrRUijql6ihQmVWeYVQFbBeaQiPLgT6iDF+bEO1vaQeP5Uu93ar1IuqWArxUVyPOikppkylWJ8Y+iLhUlLLF8a6ACgvEQkQE9SrCAZBAv2IJtMzzHrJ89OrpCg/B0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIPh/VdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EAEC32786;
	Thu,  1 Aug 2024 00:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471451;
	bh=l755Jq9bxcVcurMsrHOJdoqYBGnGShDlnnL22h02viA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIPh/VdVn+x1eHgPFNX+M10sAL9uLv1nqKPLEQcesQLyuMkNXrRF6Lw5MTbDZY+mN
	 FRe7umWSeC0NsuBIUtQiwXObwopM5jMSCZVxQrbmqfPog4vsYKtIZO8fl7qU5tKB0z
	 kW4FJBwrPVsfSApyU6idMMt5WPtJBQ//OE7VwaUThhWmEKtwHHKj6o9ZB63CTdLuYz
	 nKgL5/5A0Hsl7hFZPMb3xKxNvcYEZ8Oys69o5SM+TgHfny6BS2LvS33ygUESWFiYns
	 svzRLbY/nZs9PzINqMP6gsQXEJK2QsoiHfK29hflJ1gNY5QBZRXqIgpZquTj6vCqEZ
	 OQKVqLiGiOn+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	marcelomspessoto@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 099/121] drm/amd/display: Check HDCP returned status
Date: Wed, 31 Jul 2024 20:00:37 -0400
Message-ID: <20240801000834.3930818-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 5d93060d430b359e16e7c555c8f151ead1ac614b ]

[WHAT & HOW]
Check mod_hdcp_execute_and_set() return values in authenticated_dp.

This fixes 3 CHECKED_RETURN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/modules/hdcp/hdcp1_execution.c    | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 182e7532dda8a..d77836cef5635 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -433,17 +433,20 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 	}
 
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
+		if (!mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
 				&input->bstatus_read, &status,
-				hdcp, "bstatus_read");
+				hdcp, "bstatus_read"))
+			goto out;
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(check_link_integrity_dp,
+		if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
 				&input->link_integrity_check, &status,
-				hdcp, "link_integrity_check");
+				hdcp, "link_integrity_check"))
+			goto out;
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
+		if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
 				&input->reauth_request_check, &status,
-				hdcp, "reauth_request_check");
+				hdcp, "reauth_request_check"))
+			goto out;
 out:
 	return status;
 }
-- 
2.43.0


