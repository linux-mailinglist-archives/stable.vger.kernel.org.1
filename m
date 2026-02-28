Return-Path: <stable+bounces-220298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN0dHxkwo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B71C586D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF574308C564
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A738B08D;
	Sat, 28 Feb 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abzjlhUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3D38B082;
	Sat, 28 Feb 2026 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300201; cv=none; b=gRNsajZ4ilV+WsAM0imP09Wsi8ETjXLGB8IV+bbU82unyJwxxhjNmCCJNet2kI56Umzt2Z+yDnhdH2WWj5LLMq/eBYx0z2HYgZau3myGEQf73xxFD0SC0FS0Pnju3Orf+QXM/O9DSXNd5hnC0dYpU/sYXXU/wDdpTXQn1RN9LzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300201; c=relaxed/simple;
	bh=RLrpuXOskdUjrMLmYKSnbBOc1+AQtLbjAOsyVcpzuZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIX6NvcFQeaL7XserOU6nq5gV8ttaPx2Re11CSOP8hMGUPY96ifhp3Ee/0aPwQhYRjNooqKcKVu6r+xzzbYR6IdNHUrGu1bjJaZsgwWl4d0m24rFCIuuzTqV0ArBOtibTI3Eu9UYt0xPRhvRqz+zcyQ2vm1K5xyogr8JdRG0EZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abzjlhUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD88FC19423;
	Sat, 28 Feb 2026 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300201;
	bh=RLrpuXOskdUjrMLmYKSnbBOc1+AQtLbjAOsyVcpzuZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abzjlhUUy3qfkjDyJOAmu8jeu57MqzyWXivGJbxO8AoQ/+ph8Ngb7V2kWTBzaO1De
	 k27b8WGeWF9fkIROsDbkAMetqPgXbPNuHa0yXSZB1ehrTAIWB7ZEusAGXDMjUBejGP
	 SRy1e/6DCr5DwJu6Zz+hJCT4EEAPbp0DcJ2dy+sV+hpQFWwi7hdRgNJ0mIsBW52SgV
	 r9OQq7kiyPoE688V23AASOhGpZZuAYgAqrCeyf9E8hc+OX7hdCvdti2kGLSoy9+Ssv
	 0y6vM81BlcvWjE1yP1LPUOseI5OLLe460I3gDidR7cr7UGXmUa85M8DVxfZ84HYAem
	 wioLeqDNqr9jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Stewart <Matthew.Stewart2@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 220/844] drm/amd/display: Fix GFX12 family constant checks
Date: Sat, 28 Feb 2026 12:22:13 -0500
Message-ID: <20260228173244.1509663-221-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220298-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F7B71C586D
X-Rspamd-Action: no action

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[ Upstream commit bdad08670278829771626ea7b57c4db531e2544f ]

Using >=, <= for checking the family is not always correct.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 62622aa622066..209a6e5c713ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11853,7 +11853,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	 * check tiling flags when the FB doesn't have a modifier.
 	 */
 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
-		if (adev->family >= AMDGPU_FAMILY_GC_12_0_0) {
+		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
 		} else if (adev->family >= AMDGPU_FAMILY_AI) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index f0946e67aef97..7474f1bc1d0b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -278,7 +278,7 @@ static int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 	if (!dcc->enable)
 		return 0;
 
-	if (adev->family < AMDGPU_FAMILY_GC_12_0_0 &&
+	if (adev->family != AMDGPU_FAMILY_GC_12_0_0 &&
 	    format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
 		return -EINVAL;
 
@@ -901,7 +901,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			upper_32_bits(chroma_addr);
 	}
 
-	if (adev->family >= AMDGPU_FAMILY_GC_12_0_0) {
+	if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
 		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
 										 rotation, plane_size,
 										 tiling_info, dcc,
-- 
2.51.0


