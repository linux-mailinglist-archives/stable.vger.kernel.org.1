Return-Path: <stable+bounces-64980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16D943D32
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282491C21211
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ACE16DC1A;
	Thu,  1 Aug 2024 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRG5F/bT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C671C2D89;
	Thu,  1 Aug 2024 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471841; cv=none; b=A9RW4v/8aQvB7S3IUdT37fu5HO5D/wkbyl98/HXXUJnPpimgIx2lYWRAfqb51kkuKGJtjKDvGIjnXwIh7tCTWluHpR3LtbmR5AjqjrRW+O9KD+rXBicz5qoWNG2IEc/LiA2nYFRDlb3OnqX5quReQZjnqnEZkYeLLdJnzpN0V1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471841; c=relaxed/simple;
	bh=DeQXXmqT5sn1n6hTPD+quCCH7uKWhAW9iZdE2YjrIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3E2/bgCoc654xkj/TRnmhh4wxC31SySj5+JWQ/gzP54MwfExHRak2MYaPvIxms5zmABK3Ud50lanxj5onKkpOhwJaJDR9JP/EKzAwlKXMb3BBKbwOGMl8vHP+LF22RI1JEwI8A6n2VgVVNU1hE/gT/Xx2ozLpZkBGwUfrHGJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRG5F/bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531EBC116B1;
	Thu,  1 Aug 2024 00:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471840;
	bh=DeQXXmqT5sn1n6hTPD+quCCH7uKWhAW9iZdE2YjrIu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kRG5F/bT/gf3uL+pgeiQ+7SBpYRqVwE3S8wR6yzVw2lBIijFWRRzqxM6ARyFQRzZV
	 +MKyrpDSdF6TjVV00gB/meUFXD+YVWb+objJEMSrEkCKq3Q1PDjB9H4WIkTGggvC+j
	 sdVwsvE9YyVC6uu8DjmB4H4eP9tKuUdbkvEFRNXkRis9rg36A1u4tGcloZ9E0vG7q1
	 QSsS1KAEv4BHIq5AdY3oBxhOtTKTwcfeNJrCTLBMOn1W6TigvsslydmHRUlWqU/0K7
	 9L9FwisJ2Ee38d/DIqp79yXfNXRhG1chD7My1EhX8ufx4FN1aH0wqY3xLnxBXzVekK
	 PNS11zoVvy66A==
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
Subject: [PATCH AUTOSEL 6.6 34/83] drm/amdgpu: the warning dereferencing obj for nbio_v7_4
Date: Wed, 31 Jul 2024 20:17:49 -0400
Message-ID: <20240801002107.3934037-34-sashal@kernel.org>
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
index 685abf57ffddc..977b956bf930a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -384,7 +384,7 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
 		else
 			WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
 
-		if (!ras->disable_ras_err_cnt_harvest) {
+		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
 			/*
 			 * clear error status after ras_controller_intr
 			 * according to hw team and count ue number
-- 
2.43.0


