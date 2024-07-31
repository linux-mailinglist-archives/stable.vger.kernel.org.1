Return-Path: <stable+bounces-64872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E8943B54
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04393B25E58
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095016F0F9;
	Thu,  1 Aug 2024 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka1dhn+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4D143C62;
	Thu,  1 Aug 2024 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471236; cv=none; b=heim0ewfstvaFjU9LzJMBeHFa4Eg2qgJn8YxOArrlb4OVNwhca93fUZxJdUwaNDQzR8PY1dykQpssqS/d0FCuseKNibnb1Qml/BV7R/QI231gFggBrNIXKKErPKQhNT6F9WW+NQLvdlfSc3VskbaSkuMbF7AtczhJwfTr09+3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471236; c=relaxed/simple;
	bh=R9OVsiwIBGuWRjh/v9KWxRWmZi2hM8JdzCHLJI7sh4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyhBKVkdUIdHkjXr/dsA4AFhYhGTxikFWg9jevXlvUAGcuRGis+7Nhq3pnhRRqztjwIGty2h2LPJfJ6JVgu/63xXu1hK7NN0p9odqbb+7/HQKiJEh+cxUhzHIBbOBgkQyi5S+KfQyzU8sVsxvxErZyvGvMUGxOJX/I+S/zOYnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka1dhn+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D97C116B1;
	Thu,  1 Aug 2024 00:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471236;
	bh=R9OVsiwIBGuWRjh/v9KWxRWmZi2hM8JdzCHLJI7sh4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ka1dhn+6HGvXJD9TaAI7F6UQMEGADe3aRfSeEFSxFmT12TXIu5TAsf6pd4PL/c8gj
	 wwQAPOCgK6byPcyjbRDc/2za7/2Dc8Zv6dX7/OEVxHOo6kYeUin6hq0oX5sLu1emCa
	 IN+My7H+fEdsfJoVRDnAW8BDl4qTVQbDKpzjqR6PlhIGUKbf/E3mlz36Cd+xGWOmz3
	 2jinNGZRn239YRMnbD0VOVLxP+LgnT+VE1J+REBXrPz2d/manv/jv3Ddsco9nN5oD/
	 gF0+Pb8PDa0b/5SED8qyUqUGYGS5XeMYYux232LYoGpHeLWdL249rUTIyGSOR7qzoq
	 39kITJ3RJIkUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Jesse Zhang <Jesse.Zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	tao.zhou1@amd.com,
	Hawking.Zhang@amd.com,
	felix.kuehling@amd.com,
	lijo.lazar@amd.com,
	candice.li@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 047/121] drm/amdgpu: the warning dereferencing obj for nbio_v7_4
Date: Wed, 31 Jul 2024 19:59:45 -0400
Message-ID: <20240801000834.3930818-47-sashal@kernel.org>
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

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit d190b459b2a4304307c3468ed97477b808381011 ]

if ras_manager obj null, don't print NBIO err data

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 19986ff6a48d7..750ce281b97bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -387,7 +387,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		else
 			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
-- 
2.43.0


