Return-Path: <stable+bounces-139943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF272AAA2A4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508B44634BE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B22DFA5C;
	Mon,  5 May 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlfauqrQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1822DFA4B;
	Mon,  5 May 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483726; cv=none; b=PaVeDpUDTXBWvqhpaErvdGJpYSBFr/f3T34CUzZ9g39/0ok0bu8QYVxUc1qUek/wc7IF8aBfP4JwPI7kwqKcj41p7l2NU5Oa+a2ZW2EPYUJNNHRzwKv2H6EcqwN3jOUmB5EcRGDAdteYaFB3XeZH6V+M8+sBGDYJD7IhbgVuHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483726; c=relaxed/simple;
	bh=x54oFjb3Om5VeeJPerMe5HRpxna0aXEGyUWxPC0/k0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ViiIRIkE/jzuUmOQMYDeZY85aqTIq4QBbQp0wkIfD1cOXmSp8Oti8jNz3Ay/zn+RkyC3cAJausLBYX8Qxr0u7Do4ydxMZMSp3b0eWiTEagv3inBekS4Fr5iZ55nVvtePCWqyVSsyPDXfylJSUiU1iTbAGuai4U0YTHK/gjM/jW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlfauqrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EC7C4CEE4;
	Mon,  5 May 2025 22:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483726;
	bh=x54oFjb3Om5VeeJPerMe5HRpxna0aXEGyUWxPC0/k0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlfauqrQDWPyHP6D4eZSpET/aM3Zl2LrIBzhGFNysv2gQMqJtytppeSuTbbN9ppFB
	 JiXPFZRzDSfrPHf3WsTXmkVLEXzwhDm4QpyabYkcs2KLp9afdkG1KXmdmhuYS+nIYe
	 gL+lw60wHhB1KZ8jMb3dFjM0GHK8T4+szROU/pjL7RUiTQO3o73VUOwxFK2XxtM2S5
	 zbrDp/lGRb/OV3JI9BNpt3bpZpb618vKj5CnTPV36JFBooHnD7ho36iNge5r8QVIhe
	 HdvLxPOrK8N8Wk5F5fluCMWqIChRBVFHCb8KIrhfd0JbVCWpCNTDotGfHJ5LLZgcnV
	 LA+9bp8c4qcqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peichen Huang <PeiChen.Huang@amd.com>,
	Cruise Hung <cruise.hung@amd.com>,
	Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	wenjing.liu@amd.com,
	alex.hung@amd.com,
	Jerry.Zuo@amd.com,
	ivlipski@amd.com,
	michael.strauss@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 196/642] drm/amd/display: not abort link train when bw is low
Date: Mon,  5 May 2025 18:06:52 -0400
Message-Id: <20250505221419.2672473-196-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Peichen Huang <PeiChen.Huang@amd.com>

[ Upstream commit 8a21da2842bb22b2b80e5902d0438030d729bfd3 ]

[WHY]
DP tunneling should not abort link train even bandwidth become
too low after downgrade. Otherwise, it would fail compliance test.

[HOW}
Do link train with downgrade settings even bandwidth is not enough

Reviewed-by: Cruise Hung <cruise.hung@amd.com>
Reviewed-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 751c18e592ea5..7848ddb94456c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1782,13 +1782,10 @@ bool perform_link_training_with_retries(
 			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
 				(cur_link_settings.lane_count <= LANE_COUNT_ONE));
 
-			if (is_link_bw_low) {
+			if (is_link_bw_low)
 				DC_LOG_WARNING(
 					"%s: Link(%d) bandwidth too low after fallback req_bw(%d) > link_bw(%d)\n",
 					__func__, link->link_index, req_bw, link_bw);
-
-				return false;
-			}
 		}
 
 		msleep(delay_between_attempts);
-- 
2.39.5


