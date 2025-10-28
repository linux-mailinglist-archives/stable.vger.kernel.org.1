Return-Path: <stable+bounces-191537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B946CC1695C
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D14E8833
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2D2BE021;
	Tue, 28 Oct 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+rXjtlF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF92BE02A
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679079; cv=none; b=i5a9Hsyy8QwlQ6QDNdMihGCOiTljef8+u1mzu1l9uLhIWGaBDR4ugBcFRAIgHdM7pQQOxewtV0B9w85z6cYB93yo7R5Hcy3ZdYhRC4yea8WNEqYT9161YF57k+MtXNnQ4slaRKQr08itcBtY+MXegbFn9riWi9xUXKxAvl1PIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679079; c=relaxed/simple;
	bh=GAbTnvVAUiZ+2hkN7TO3fMB1++CbFNVWiB9EQeeOzms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ubuVaXMG9RhwNhiIUxDeI8UwrGOig4+pasGiXZcDbM0ZuiMXgd1VDKoSFbeshpGxf/6Vz8Rl1Bva1ecMuQtLG15ty3PcbwmRUygu0S6T6p0Lkdl1yin+g2xuplppChJwO3hGqfU/aCCPB/bHZW0EeFLHzrID/VtfZtBoLlbqNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+rXjtlF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b472842981fso185607066b.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761679076; x=1762283876; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sfEXkWaRnyYnPPJV+DDN9HE3C+zqOfqrpxrX7M4JGO0=;
        b=W+rXjtlFAl+w8myu6KCJPX2FgDc7nGEpsGgp4qV1JqePLXyhGtj67WWr7l8lDt5hq2
         yVtRYIjn0b76SPNr/LhnnO5csT+Q4gAOuiWXgYgZFwORI+MSK4/zNO3iNZag2SqSg2eD
         Np0pyvQhk1qcvIZx1yMBRNfTR93cMD3GvBxKaJm+bOWY6/5u2Pm/R1BiLAVtgjrETWU9
         UQJcBdsetYHj/T7g4rduFWzqWv6HyRMK+3t4uyifAylPCKkmTZ5u6JXl/DMKL9JS9mZx
         9jR22Qra4np3DJq5I7rc293SjmGn9Kp5r+VyuODpBNCraoh1hIBWWevvkqXUORLh13+o
         L1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679076; x=1762283876;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfEXkWaRnyYnPPJV+DDN9HE3C+zqOfqrpxrX7M4JGO0=;
        b=xD217pV5w2ZoEATZ/Qgd81YwUZE0pi6Nl2t4PAL0TVbs3AYxyUayQBGODuuxEb2rx1
         iIuB6jLtu4IJ543c4Bji/A3L1InaQb+XJzUzfIC5otuH0aTAJ9S2xmQ61WFtWz0RPmAa
         0EIZwz8WcTBaa6Q/ll+dYwb2bTkXRlzyy4DFV/UKsmx3wdPuyGX5FQyvPiWx2NAZWAXu
         N5Hc4KW046/N2hD84pPGKfbcsUM79Oi40oAV4Hg3vHkA9DvRoJsi+Sv8AodVBNQam8Oq
         UVxDD8FloQYASB9+K/xg9iggReby6AV1xAZTStqD65htdup9KrXfEEf1nSl1DRnUNRhz
         dLJw==
X-Gm-Message-State: AOJu0Ywg3CBTwvDSL9pGWGyEFAb6cq07mr3SPpFpus6iSnYuyTarkAH4
	FIf3UbMVNIYaKoVFN0UY/iOMtpulBW1ksqUO8af6WEuH/1hr1K6Y0XP5
X-Gm-Gg: ASbGnctUzTrJjDH1wR4tTMR0FmYZcxsXydplEbKWGlLXbbcpGhO97cwg2NrNzMg1to2
	D1MYpEk9zvappLdOWAg8ZZTE84JhsH1i88qXMbEtTZIWMfZP7+QMmrUjoYv4j2ZEmPDW1QKYIL2
	sRO62dCL4Zy+AABQQsI2lKN47qsVu7/4k4EPxrL3oUk65imCpOdl/aJo0stmBc3f14y5vPAw4ua
	gYhfRnl1uiQzTaKPv6x5nDfQf+dj1AbP4b7Xsm52iVVh8Fze3YQ1dI7CrhffCc0QdMLLlVVmGbu
	ThlW9jdYS0PBgEA8xHS9pP2hSO3M4bO1NtnOcAKKYBkcmxfcMrJ4DBiA/lU+TyaJAgG+OiaUwZK
	CW2k0PSNjjFAgUF0862N/5AcuHEdjkU9FMpGUcP3bVir7OTl7RyLvi0R9lNHCGptT/A2sbW2qee
	i0VYTkTCJ2wM9GFpAohY6yRnD5ZN/qjGJD2A==
X-Google-Smtp-Source: AGHT+IGXAnUpht3wBnYehTrb8AizUEeeYnMTMdxdiB/iQETed4bAUbTqSwca43xumiVWxyTjELUNUQ==
X-Received: by 2002:a17:907:c10:b0:b40:e687:c2c with SMTP id a640c23a62f3a-b703d4d6115mr11330266b.37.1761679075416;
        Tue, 28 Oct 2025 12:17:55 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1175737066b.39.2025.10.28.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:17:54 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 5DBD3BE2EE7; Tue, 28 Oct 2025 20:17:53 +0100 (CET)
Date: Tue, 28 Oct 2025 20:17:53 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: Missing backport of 3c591faadd8a ("Reapply "Revert drm/amd/display:
 Enable Freesync Video Mode by default"") in 6.1.y stable series?
Message-ID: <aQEW4d5rPTGgSFFR@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IQ2crxNQGoY4ga83"
Content-Disposition: inline


--IQ2crxNQGoY4ga83
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

We got in Debian a request to backport 3c591faadd8a ("Reapply "Revert
drm/amd/display: Enable Freesync Video Mode by default"") for the
kernel in Debian bookworm, based on 6.1.y stable series.

https://bugs.debian.org/1119232

While looking at he request, I noticed that the series of commits had
a bit of a convuluted history.  AFAICT the story began with:

de05abe6b9d0 ("drm/amd/display: Enable Freesync Video Mode by
default"), this landed in 5.18-rc1 (and backported to v6.1.5,
v6.0.19).

This was then reverted with 4243c84aa082 ("Revert "drm/amd/display:
Enable Freesync Video Mode by default""), which landed in v6.3-rc1
(and in turn was backported to v6.1.53). 

So far we are in sync.

The above was then reverted again, via 11b92df8a2f7 ("Revert "Revert
drm/amd/display: Enable Freesync Video Mode by default"") applied in
v6.5-rc1 and as well backported to v6.1.53 (so still in sync).

Now comes were we are diverging: 3c591faadd8a ("Reapply "Revert
drm/amd/display: Enable Freesync Video Mode by default"") got applied
later on, landing in v6.9-rc1 but *not* in 6.1.y anymore.

I suspect this one was not applied to 6.1.y because in meanwhile there
was a conflict to cherry-pick it cleanly due to context changes due to
3e094a287526 ("drm/amd/display: Use drm_connector in
create_stream_for_sink").

If this is correct, then the 6.1.y series can be brough in sync with
cherry-picking the commit and adjust the context around the change.
I'm attaching the proposed change.

Alex in particular, does that make sense?

Regards,
Salvatore

--IQ2crxNQGoY4ga83
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Reapply-Revert-drm-amd-display-Enable-Freesync-Video.patch"

From 8c227a5050c07450c4585832a9a35659b39c4bf1 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Tue, 27 Feb 2024 13:08:12 -0500
Subject: [PATCH] Reapply "Revert drm/amd/display: Enable Freesync Video Mode
 by default"

This reverts commit 11b92df8a2f7f4605ccc764ce6ae4a72760674df.

This conflicts with how compositors want to handle VRR.  Now
that compositors actually handle VRR, we probably don't need
freesync video.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2985
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Salvatore Bonaccorso: Adjust context due to missing 3e094a287526
("drm/amd/display: Use drm_connector in create_stream_for_sink") in
6.1.y stable series ]
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 39151212b8a7..f7fbc7932bb5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6044,7 +6044,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 		 */
 		DRM_DEBUG_DRIVER("No preferred mode found\n");
 	} else {
-		recalculate_timing = is_freesync_video_mode(&mode, aconnector);
+		recalculate_timing = amdgpu_freesync_vid_mode &&
+				 is_freesync_video_mode(&mode, aconnector);
 		if (recalculate_timing) {
 			freesync_mode = get_highest_refresh_rate_mode(aconnector, false);
 			drm_mode_copy(&saved_mode, &mode);
@@ -7147,7 +7148,7 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
 
-	if (!edid)
+	if (!(amdgpu_freesync_vid_mode && edid))
 		return;
 
 	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
@@ -9160,7 +9161,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		 * TODO: Refactor this function to allow this check to work
 		 * in all conditions.
 		 */
-		if (dm_new_crtc_state->stream &&
+		if (amdgpu_freesync_vid_mode &&
+		    dm_new_crtc_state->stream &&
 		    is_timing_unchanged_for_freesync(new_crtc_state, old_crtc_state))
 			goto skip_modeset;
 
@@ -9200,7 +9202,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		}
 
 		/* Now check if we should set freesync video mode */
-		if (dm_new_crtc_state->stream &&
+		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
 		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
 		    is_timing_unchanged_for_freesync(new_crtc_state,
@@ -9213,7 +9215,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 			set_freesync_fixed_config(dm_new_crtc_state);
 
 			goto skip_modeset;
-		} else if (aconnector &&
+		} else if (amdgpu_freesync_vid_mode && aconnector &&
 			   is_freesync_video_mode(&new_crtc_state->mode,
 						  aconnector)) {
 			struct drm_display_mode *high_mode;
-- 
2.51.0


--IQ2crxNQGoY4ga83--

