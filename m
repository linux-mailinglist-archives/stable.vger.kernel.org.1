Return-Path: <stable+bounces-126339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03391A700A8
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AD63B361C
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF26269833;
	Tue, 25 Mar 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zzjV/vg9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04362586CD;
	Tue, 25 Mar 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906040; cv=none; b=uyyD/5l9IGVxfaYSU7Qlcc13Ov3EfQRA4FXFRlcWG7VYaePeN9eED0FeVrtcBf6HaOVbbiOGf3h9cEl1YO5woodK/yj0GEGDo2H7yBqonGTm8AlSuHPaYDiEQZmELHQvqiEMIP0S2zGhIBqvgqQP/QIWOFtrsIwPxjebyPQR4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906040; c=relaxed/simple;
	bh=Vn6NF3sTawKNfYdCTHXhv7NtusTFf2lIb4drePCi+OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxfoxrWp8B1WJW2cufmEhlexqpHD+K5u4k4b9JOprELX6PtwcC5EztFZ60L3T+r9cp+OqW+jfyNHq5lMu+mJp9k65o18tz2d2NjQ3lap2+ikK13ylQiXlpwWfJVwUOLUcpKAwWyHl/Ry1n7VIjABFwOhhl/Te7IA3G72Oj8xadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zzjV/vg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85924C4CEE4;
	Tue, 25 Mar 2025 12:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906040;
	bh=Vn6NF3sTawKNfYdCTHXhv7NtusTFf2lIb4drePCi+OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zzjV/vg9gJy/OR4aqZsaw5JftmH52tXXOHWFgTq9fO7yhLlS4KHlgPwUY1dN9L1zH
	 ZrnOwU5yQOo2GKzmkOpuiARZs6omy6CciR+xIMyKXGbihNEBlxp7QaQ3QMVKl+ixc1
	 5aWko+eDn2REKnQZwj1R7mP/4c/c5hbWqjVM+IpA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Rosca <david.rosca@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>
Subject: [PATCH 6.13 103/119] drm/amdgpu: Remove JPEG from vega and carrizo video caps
Date: Tue, 25 Mar 2025 08:22:41 -0400
Message-ID: <20250325122151.688234723@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
References: <20250325122149.058346343@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Rosca <david.rosca@amd.com>

commit 7fc0765208502e53297ce72c49ca43729f9d6ff3 upstream.

JPEG is only supported for VCN1+.

Signed-off-by: David Rosca <david.rosca@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0a6e7b06bdbead2e43d56a2274b7e0c9c86d536e)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c |    1 -
 drivers/gpu/drm/amd/amdgpu/vi.c    |    7 -------
 2 files changed, 8 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -108,7 +108,6 @@ static const struct amdgpu_video_codec_i
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 };
 
 static const struct amdgpu_video_codecs vega_video_codecs_decode =
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -239,13 +239,6 @@ static const struct amdgpu_video_codec_i
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
 };
 
 static const struct amdgpu_video_codecs cz_video_codecs_decode =



