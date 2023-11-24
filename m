Return-Path: <stable+bounces-1061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5FC7F7DD2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0B81C212DF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBE039FE9;
	Fri, 24 Nov 2023 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z1VgaU/Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CD39FD0;
	Fri, 24 Nov 2023 18:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2A6C433C8;
	Fri, 24 Nov 2023 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850462;
	bh=fEFXnsicwys+eKLUHQQWc9Qx+YoFqJC1GAuK8TFn9GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1VgaU/ZKimjHk7h05+9SI5qEZdNIqFVhlIIaE+MIr7ydWBqeoTu6pAO4/v22gU7q
	 954NTQep+twZs6ynlA+zkk0+jdgCvl/LLcwAExTykDDJau7uI8AqRrBrVEZeOsL0dV
	 e/C8AakVwcyHy/hW5poXl8kAtXebu2aGMb2QGUuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 051/491] drm/edid: Fixup h/vsync_end instead of h/vtotal
Date: Fri, 24 Nov 2023 17:44:47 +0000
Message-ID: <20231124172026.218284337@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit 2682768bde745b10ae126a322cdcaf532cf88851 ]

There are some weird EDIDs floating around that have the sync
pulse extending beyond the end of the blanking period.

On the currently problemtic machine (HP Omni 120) EDID reports
the following mode:
"1600x900": 60 108000 1600 1780 1860 1800 900 910 913 1000 0x40 0x5
which is then "corrected" to have htotal=1861 by the current drm_edid.c
code.

The fixup code was originally added in commit 7064fef56369 ("drm: work
around EDIDs with bad htotal/vtotal values"). Googling around we end up in
https://bugs.launchpad.net/ubuntu/hardy/+source/xserver-xorg-video-intel/+bug/297245
where we find an EDID for a Dell Studio 15, which reports:
(II) VESA(0): clock: 65.0 MHz   Image Size:  331 x 207 mm
(II) VESA(0): h_active: 1280  h_sync: 1328  h_sync_end 1360 h_blank_end 1337 h_border: 0
(II) VESA(0): v_active: 800  v_sync: 803  v_sync_end 809 v_blanking: 810 v_border: 0

Note that if we use the hblank size (as opposed of the hsync_end)
from the DTD to determine htotal we get exactly 60Hz refresh rate in
both cases, whereas using hsync_end to determine htotal we get a
slightly lower refresh rates. This makes me believe the using the
hblank size is what was intended even in those cases.

Also note that in case of the HP Onmi 120 the VBIOS boots with these:
  crtc timings: 108000 1600 1780 1860 1800 900 910 913 1000, type: 0x40 flags: 0x5
ie. it just blindly stuffs the bogus hsync_end and htotal from the DTD
into the transcoder timing registers, and the display works. I believe
the (at least more modern) hardware will automagically terminate the hsync
pulse when the timing generator reaches htotal, which again points that we
should use the hblank size to determine htotal. Unfortunatley the old bug
reports for the Dell machines are extremely lacking in useful details so
we have no idea what kind of timings the VBIOS programmed into the
hardware :(

Let's just flip this quirk around and reduce the length of the sync
pulse instead of extending the blanking period. This at least seems
to be the correct thing to do on more modern hardware. And if any
issues crop up on older hardware we need to debug them properly.

v2: Add debug message breadcrumbs (Jani)

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/8895
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920211934.14920-1-ville.syrjala@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 69d855123d3e3..f1ceb7d08519e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3499,11 +3499,19 @@ static struct drm_display_mode *drm_mode_detailed(struct drm_connector *connecto
 	mode->vsync_end = mode->vsync_start + vsync_pulse_width;
 	mode->vtotal = mode->vdisplay + vblank;
 
-	/* Some EDIDs have bogus h/vtotal values */
-	if (mode->hsync_end > mode->htotal)
-		mode->htotal = mode->hsync_end + 1;
-	if (mode->vsync_end > mode->vtotal)
-		mode->vtotal = mode->vsync_end + 1;
+	/* Some EDIDs have bogus h/vsync_end values */
+	if (mode->hsync_end > mode->htotal) {
+		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] reducing hsync_end %d->%d\n",
+			    connector->base.id, connector->name,
+			    mode->hsync_end, mode->htotal);
+		mode->hsync_end = mode->htotal;
+	}
+	if (mode->vsync_end > mode->vtotal) {
+		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] reducing vsync_end %d->%d\n",
+			    connector->base.id, connector->name,
+			    mode->vsync_end, mode->vtotal);
+		mode->vsync_end = mode->vtotal;
+	}
 
 	drm_mode_do_interlace_quirk(mode, pt);
 
-- 
2.42.0




