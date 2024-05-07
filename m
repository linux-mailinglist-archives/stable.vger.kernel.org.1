Return-Path: <stable+bounces-43315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F718BF1A8
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E317282027
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE7135A40;
	Tue,  7 May 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/IQbY8l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9213541F;
	Tue,  7 May 2024 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123359; cv=none; b=iuYSnBjLezGMH8Uogi5OnAp1XxDD9T2A83rwnJm9U+ZsmWC/uMNoQTPN2W1uOsmmYSS9Smhtdyzs2cXynbAempK8mkIziMNTjRWv8ZMBRgs1JzUwVrPdBqtaVK2/s7EJbM1uSs8iS+j0dCFud3ndZMoqAMgxt9OjcQqRGnaCE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123359; c=relaxed/simple;
	bh=p44Y+LH/bsiflr+JnfeoUYJ7VALrebZAbNd75cLgEZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDKu441g7z7pyvYH/Gy4Ro+TZpnYXKmYPjGZ05rPg0ivaG/G6TjKXfMdOOU/WTu3koTdgXT46mPZRzk8Efvtj21Y/UsbpePzSoy+iMZhX9GjCOKLnfGPlDdVpEyxwsvttr3KJd0PlB1uzP9j3VG7psRlz+MV4a9mk99Y5uxvZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/IQbY8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD76C3277B;
	Tue,  7 May 2024 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123358;
	bh=p44Y+LH/bsiflr+JnfeoUYJ7VALrebZAbNd75cLgEZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/IQbY8lEUhKKIg224EDCKPwTTtdWte28PseVzEFSPMBTzBR/isgaH2z81THa0i2O
	 X/I/TSik6b0ae+kwPWidulFyrYINl1Jc+3FsdzeuHrSbJurQUK0NFetdiRJS4I3YAQ
	 NfC0aK96A6s6uPRGviXTxicqOu/zBZhg+BtZ8TAy2kv59isoFEABklYuPjlkLOjVRx
	 uDJ+FpjZ+iXfvEYXG38oxNLDKOtmiD2DoU6ZePkymOACvK3hbFCxcU/9NgsZ1W/yVG
	 pHh1QzhHw42UH9dImYzRAAXVXu3+X7Yddz/4M5Kir+6Jz9YnRzDDQp/zFyi77dz+G2
	 JkpngDO2DGjVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	hamza.mahfooz@amd.com,
	jun.lei@amd.com,
	moadhuri@amd.com,
	trix@redhat.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 36/52] drm/amd/display: Ensure that dmcub support flag is set for DCN20
Date: Tue,  7 May 2024 19:07:02 -0400
Message-ID: <20240507230800.392128-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[ Upstream commit be53bd4f00aa4c7db9f41116224c027b4cfce8e3 ]

In the DCN20 resource initialization, ensure that DMCUB support starts
configured as true.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index f9c5bc624be30..f81f6110913d3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2451,6 +2451,7 @@ static bool dcn20_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
+	dc->caps.dmcub_support = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
-- 
2.43.0


