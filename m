Return-Path: <stable+bounces-83528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6751199B391
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278F728200A
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096A1714C8;
	Sat, 12 Oct 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glycJtuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE13B19F12D;
	Sat, 12 Oct 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732408; cv=none; b=ptzcUqEuMGjVSPTHH+8tFHV1lUAgeXuCT3adWnoWAhZOriGGD/cTt7qwIvdZhKh2Tl1O4qvTEpec82gjJC0dSSyXxHVqSCNt7tGWvJAi7bcBnewUkU2fiUASs5uZYkohh3SCW6OLu841QpEoJ1cBjF7CnytPhcUZws3XbzGiKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732408; c=relaxed/simple;
	bh=atjmffrzZgLCNMCiFzOqBVE3wLBEiqWkaoBHeOfXNHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVx8RXArh57lLylZe7BEiIzplbNF9KtMc4n79+DYhf/WKKApHPGafGIRDoEtrmrj74MgX1c5afDDdl0wGfc+9XDLA2tX8cb5P4aN2CTxhrPqF53nMZxCNOTa1daMuL1JAr0gL75sU7+v+8sGPnrqPuoZwWKd6Pd19AoYuafv2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glycJtuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E13AC4CECE;
	Sat, 12 Oct 2024 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732408;
	bh=atjmffrzZgLCNMCiFzOqBVE3wLBEiqWkaoBHeOfXNHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glycJtuRKya+u46WceaOwk5jKyZaicIPmpEVLAzSYmBZvxIJeDSshzrqrAtBGyL8B
	 T9zKG/7KgeppoX9VI28D9Zy2D9SpAHSfZTniy0hncWsWjjE21TfQXCAdzvGe77/sTM
	 TdUudb/WhLOKmhLLmsyQhoWH0DSiBsBlE+s+SbC8MISKcUF/NoI9Nwk9U5HTKL230B
	 DG7z+8oJIRC01lw44uf1SaQW3APkn+BI6N52VEPX8NLC8oCVqCf51l/sKwaZR1l/D6
	 CibjOGol89HUXLX8eD/JM+E64e3hWmavPMtae0OhXtU3e9J8wxOhXeMYFWyr1AkRsc
	 YFL6Lpon794yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 14/16] drm/xe/mcr: Use Xe2_LPM steering tables for Xe2_HPM
Date: Sat, 12 Oct 2024 07:26:10 -0400
Message-ID: <20241012112619.1762860-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Gustavo Sousa <gustavo.sousa@intel.com>

[ Upstream commit 7929ffce0f8b9c76cb5c2a67d1966beaed20ab61 ]

According to Bspec, Xe2 steering tables must be used for Xe2_HPM, just
as it is with Xe2_LPM. Update our driver to reflect that.

Bspec: 71186
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
Reviewed-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240920211459.255181-2-gustavo.sousa@intel.com
(cherry picked from commit 21ae035ae5c33ef176f4062bd9d4aa973dde240b)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_mcr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mcr.c
index 6d948a4691264..d57a765a1a969 100644
--- a/drivers/gpu/drm/xe/xe_gt_mcr.c
+++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
@@ -407,7 +407,7 @@ void xe_gt_mcr_init(struct xe_gt *gt)
 	if (gt->info.type == XE_GT_TYPE_MEDIA) {
 		drm_WARN_ON(&xe->drm, MEDIA_VER(xe) < 13);
 
-		if (MEDIA_VER(xe) >= 20) {
+		if (MEDIA_VERx100(xe) >= 1301) {
 			gt->steering[OADDRM].ranges = xe2lpm_gpmxmt_steering_table;
 			gt->steering[INSTANCE0].ranges = xe2lpm_instance0_steering_table;
 		} else {
-- 
2.43.0


