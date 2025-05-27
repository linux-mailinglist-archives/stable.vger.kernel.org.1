Return-Path: <stable+bounces-147494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77532AC57DE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0638E7B066A
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF4727FD56;
	Tue, 27 May 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pgOXueBD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADE27CB35;
	Tue, 27 May 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367512; cv=none; b=ZFLhR+8YMQYIxkPIB1ae9RvsFhNbjKK//I2l4Iv5aVtiNPnXHtP8yPgIG+PXtVAnqpxGuhSCSNBiwBhTv8zqBhjrY9m+IqQs1JJSv0vFvHECKwSsiFf368weUuCvMZG0ncWHGsm3iNqlbmCJ/pte6x/9tKgajjMAMDBIr0kr3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367512; c=relaxed/simple;
	bh=3XvYC5uUzpM4zNU1dUTfeSUGOt6vWen9X+mYqPcRY5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFAHNj2o20CvVl5MhVxGzKVml9pFz7RiS8u7vfwis8wiMzqvo4f/b7DTjY9EYzaI5I1UAmhmqhDA0NYbiIYMkMyAjY9zFB+6ihJhkecJo/68Y//XO34kcWMMl/jEfb3ruONOHA/5U7AwYot0r3HHGH5GJhpxFWaOpoQuXVu8eUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pgOXueBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F9C4CEE9;
	Tue, 27 May 2025 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367511;
	bh=3XvYC5uUzpM4zNU1dUTfeSUGOt6vWen9X+mYqPcRY5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgOXueBDw9JS/YgshLcYVi5ZUgA69p7QJ9EqSKwqVLGNT4v83FFIIqD3tvFP7lVn3
	 dGZHf7vJH2IuUaYI5i4WyiGyTKjCvS07zAnbDJYzZnf+Bf77I3SqbbQGdj25970Mlk
	 iipWyZSv6GkWNXw9C49tJbY99iYKoW8m8syxpkqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenjing Liu <wenjing.liu@amd.com>,
	Harry VanZyllDeJong <hvanzyll@amd.com>,
	Roman Li <roman.li@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 410/783] drm/amd/display: Add support for disconnected eDP streams
Date: Tue, 27 May 2025 18:23:27 +0200
Message-ID: <20250527162529.796741853@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[ Upstream commit 6571bef25fe48c642f7a69ccf7c3198b317c136a ]

[Why]
eDP may not be connected to the GPU on driver start causing
fail enumeration.

[How]
Move the virtual signal type check before the eDP connector
signal check.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 6d7131369f00b..28843e9882d39 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -945,6 +945,9 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		 * TODO: add MST specific link training routine
 		 */
 		decide_mst_link_settings(link, link_setting);
+	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
+		link_setting->lane_count = LANE_COUNT_FOUR;
+		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else if (link->connector_signal == SIGNAL_TYPE_EDP) {
 		/* enable edp link optimization for DSC eDP case */
 		if (stream->timing.flags.DSC) {
@@ -967,9 +970,6 @@ bool link_decide_link_settings(struct dc_stream_state *stream,
 		} else {
 			edp_decide_link_settings(link, link_setting, req_bw);
 		}
-	} else if (stream->signal == SIGNAL_TYPE_VIRTUAL) {
-		link_setting->lane_count = LANE_COUNT_FOUR;
-		link_setting->link_rate = LINK_RATE_HIGH3;
 	} else {
 		decide_dp_link_settings(link, link_setting, req_bw);
 	}
-- 
2.39.5




