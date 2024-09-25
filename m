Return-Path: <stable+bounces-77649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A0F985F7D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AFF1C25AB2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A922597B;
	Wed, 25 Sep 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIuWr6VB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A422596F;
	Wed, 25 Sep 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266581; cv=none; b=Xw+6Gfg+lCQMzP0t69DBrhvc6h4zBUVVLcqGbOzgdgx0HmDsU+A0dNuIujWB6lp9b4rxCKJpnDA403IrDWRFvnuVMt57FcoC9H6Fbz/6rvFzda/pv68QAjZxW8bAYzjZ2mL3ii2YNKsliEq9uRer2T/Wnr5DU26HjPdtuAzhZ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266581; c=relaxed/simple;
	bh=r7sIkaPAJe6TvaztpSHWy6z+QAm234TEqiXesD7tOAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRGFc9zP20aLCq4oUBC0tVF7StlmNIitGjP2n9f/w+nskw76q5IRWrYGcSNr8WoAqFwiGCBgJfYwUtLV9SAM8vOmrFiUwz2iZlDxulPkNHG7lCHTzBPoV3JvzVhJjyC3bAYpLkEmxW9HQ4N9/3XYmTcjCf9RqPlOoIYe3XXKbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIuWr6VB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A1CC4CEC3;
	Wed, 25 Sep 2024 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266581;
	bh=r7sIkaPAJe6TvaztpSHWy6z+QAm234TEqiXesD7tOAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIuWr6VBfDYGl4EdnHZ2vHXvA3UbpMcXUcQKSMRPH0olV6ZFZvOHqw+o23rvdmBXk
	 B7a6CYMSnvRjen/T8TCq/GcjNJinzTPBu3BstarOP4DIqUM2TsyFmbnyzElwtjQURN
	 pSTzB7q2wnji77cjYmgsvQC5Zr0nrRiV4zTeWcpUZ9S08gx6WKfmbGZkWdnxbhkZpO
	 GhBgzsihuYKhp9vJlwlJZp2UmRa1kPu6p5BJU7JGEwTQXrtFacclVR4jye2iWl/myW
	 sJ5sCa+AGZxM+xMQ4LZLJJWRptAMkFB9HNeXiXqbOCK8b/PZZpCyzs29JDVHAgPutH
	 2A+KxUyS+90jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng01@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunil.khatri@amd.com,
	Prike.Liang@amd.com,
	Tim.Huang@amd.com,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 102/139] drm/amdgpu: enable gfxoff quirk on HP 705G4
Date: Wed, 25 Sep 2024 08:08:42 -0400
Message-ID: <20240925121137.1307574-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng01@kylinos.cn>

[ Upstream commit 2c7795e245d993bcba2f716a8c93a5891ef910c9 ]

Enabling gfxoff quirk results in perfectly usable
graphical user interface on HP 705G4 DM with R5 2400G.

Without the quirk, X server is completely unusable as
every few seconds there is gpu reset due to ring gfx timeout.

Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index c28e7ff6ede26..00e693c47f3cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1174,6 +1174,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
 	/* https://bbs.openkylin.top/t/topic/171497 */
 	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
+	/* HP 705G4 DM with R5 2400G */
+	{ 0x1002, 0x15dd, 0x103c, 0x8464, 0xd6 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.43.0


