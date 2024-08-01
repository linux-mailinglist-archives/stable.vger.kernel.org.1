Return-Path: <stable+bounces-65014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE58943D8B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1E32879E7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE41CAAC9;
	Thu,  1 Aug 2024 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWzLyZmN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A01CAABB;
	Thu,  1 Aug 2024 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471941; cv=none; b=PdlPNeKRx0RQzL58hhnMpJ6eUCaSihVkNjQaGpv+LoKXFyTw0Nno3mJAqcvt/VDq7f2Mffas1hNA9DMrZGKhku6POhBv+xUvMJCsYTMN+9eLxF6XZXEgA4hVyZmXs9ot70onKDhGOp/qMbAbYgA2bvlU/IsTnX4Hf98T8me2ULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471941; c=relaxed/simple;
	bh=LMbDleCu2LDjEQVy6fy6hqERvgQ17LQ2hr295RGkXpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvIe4U44gSZ1gAutoPnlJBuSgCZgXCHck9CguvR8ti4lGyc5lHv9g+ujvWOvXEnlX+BXDohK8t4OAGaoQ7cQvm+rXik1ZDDsSHUcP9kiWDg4wmWd/LSfLJ7047y1f9hV3gfFuID0VuJ8y+QKyb7XvzHW0YVwQGYWEqteWqIcpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWzLyZmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE759C32786;
	Thu,  1 Aug 2024 00:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471940;
	bh=LMbDleCu2LDjEQVy6fy6hqERvgQ17LQ2hr295RGkXpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWzLyZmNGKxyQ+bsMsZttB/M2OHk8udDmpTcYziugge9zPWnccHmkQZQRnx8ZOQLt
	 M5rDPrWB6yhlbVQrJiHc/jgB7os3zgKxoqYjqtlAqW5wJ1fzzu16b5wYfriNxGacmS
	 Wo7VMZRNm7twsVPMSqVhv+G/Lo/gXHwNQ2X5YHuBVUe8X7MIl0qnhutxxWBxZh35MA
	 H7OILS1u0SnMlVwzfYNX0mBHfB0KVNKo6Lm1/LD+gnWYd4CP8dhsQYwD4u/JAZ8TJO
	 yz3EEtoeMUTTf9kdEbrOVN3BQHPQPfUCcWemEOtGhKAfh0UCwsmh4uKmPE5L2XLmlH
	 YhIPAaQNK352Q==
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
	marcelomspessoto@gmail.com,
	wenjing.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 68/83] drm/amd/display: Check HDCP returned status
Date: Wed, 31 Jul 2024 20:18:23 -0400
Message-ID: <20240801002107.3934037-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 1ddb4f5eac8e5..93c0455766ddb 100644
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


