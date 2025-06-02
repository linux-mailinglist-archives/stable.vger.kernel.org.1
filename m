Return-Path: <stable+bounces-148693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6695EACA5E1
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DE418881BB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFEB258CD3;
	Sun,  1 Jun 2025 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAlKaHZz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2374229883B;
	Sun,  1 Jun 2025 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821122; cv=none; b=rIauxwRFVzut3RGeYDb+gAQgPX5ToBmA3m9QzTSxgbSue5Owb3yp5EMnjAD2Wl4U5jKOFapnN/eVL3PgHMgkwodND8Zvspob8E6um5hDA9mJebo0MdJ60AE38TqMYlBQ/wSszEew9OTuLvkmOb0wtuXPgohMMXaLU7HsAY+bg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821122; c=relaxed/simple;
	bh=wya/bQiyVLnmLH0DMDaG6zL4eFgtyW9lqzmnPj48u74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhM40zncEMApeJznjbR0q8Atpz5/8I7TiVVmdFBab8lZFkg2GP7N2s4B6CugpvCRaovnU9KbmahGGzVX8mAackHCfMxWmkv44ilAfUbOsDO1TYtMII5WpXObaQTIye/ENq/Gu0KdB+MBph/nvkqndpCLSTr0L64U53/hfLyvy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAlKaHZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B4DC4CEF1;
	Sun,  1 Jun 2025 23:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821122;
	bh=wya/bQiyVLnmLH0DMDaG6zL4eFgtyW9lqzmnPj48u74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAlKaHZzReroWWxl9dHOQ1vInVltQvGUQucDm6jbZTkLfJB7wX4jw7y6sm1nDfguH
	 0ON1OK3u72FKRtBMzMn+RX+XmVH54ARe8+YomV+8hu1UsUGy5eRv28UXveDh4T5ZUx
	 MlnnRORdk4rtR/sjRPSD94IxU+XjK5SMcHztR6GsDxk3wLb95ix4mcidGRlfjNEgF/
	 oRk1S4RQbyDdfLQdy2eoa93V0RP/e5AnoUQDBfiDxHXpR3RRJWf0YqkvdHLRaS57LD
	 sH5b7VCMfW0d+0HIiV/nVxR9yFPzxe4PuTcCFp9eEohlF0gjVgdd462GGMgM/0Ircl
	 ohoL4CoRWuxog==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 22/66] drm: panel-orientation-quirks: Add ZOTAC Gaming Zone
Date: Sun,  1 Jun 2025 19:36:59 -0400
Message-Id: <20250601233744.3514795-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601233744.3514795-1-sashal@kernel.org>
References: <20250601233744.3514795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit 96c85e428ebaeacd2c640eba075479ab92072ccd ]

Add a panel orientation quirk for the ZOTAC Gaming Zone handheld gaming device.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250313211643.860786-2-vi@endrift.com
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees.
**Extensive Analysis:** **1. Pattern Matching with Historical Commits:**
The commit follows an identical pattern to all the similar commits
marked as "Backport Status: YES" in the reference examples: - GPD Win3
(YES): Added DMI quirk for handheld gaming device with specific
vendor/product matching - OrangePi Neo (YES): Added DMI quirk for gaming
handheld with same pattern - GPD Win Mini (YES): Added gaming device
quirk with identical structure - GPD Win Max (YES): Added gaming device
quirk following same format **2. Code Analysis:** The change is
extremely minimal and safe: ```c + }, { /bin /bin.usr-is-merged /boot
/dev /etc /home /init /lib /lib.usr-is-merged /lib64 /lost+found /media
/mnt /opt /proc /root /run /sbin /sbin.usr-is-merged /snap /srv /sys
/tmp /usr /var ZOTAC Gaming Zone model/ prompt/ src/ target/ + .matches
= { + DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ZOTAC"), +
DMI_EXACT_MATCH(DMI_BOARD_NAME, "G0A1W"), + }, + .driver_data = (void
*)&lcd1080x1920_leftside_up, ``` This adds exactly 6 lines to the
`orientation_data[]` array in
`drivers/gpu/drm/drm_panel_orientation_quirks.c:500`. The change: - Uses
existing, well-tested infrastructure (`lcd1080x1920_leftside_up` data
structure already defined at line 120-124) - Employs standard DMI
matching with `DMI_EXACT_MATCH()` for precise device identification -
References an existing orientation configuration, introducing zero new
logic - Is completely isolated and cannot affect other devices due to
highly specific DMI matching **3. Bug Fix Nature:** This addresses a
real user-affecting bug - incorrect screen orientation on ZOTAC Gaming
Zone handhelds. Without this quirk: - The display appears rotated
incorrectly - Users experience poor usability with graphics rotated 90
degrees - Gaming on the device is significantly impacted **4. Risk
Assessment:** - **Minimal regression risk**: The DMI matching is highly
specific (`DMI_SYS_VENDOR="ZOTAC"` AND `DMI_BOARD_NAME="G0A1W"`) - **No
architectural changes**: Uses existing quirk framework - **No new
features**: Pure bug fix for hardware support - **Contained scope**:
Only affects this specific ZOTAC device model **5. Stable Tree
Compliance:** ✅ **Important bug fix**: Fixes screen orientation for
users ✅ **Small and contained**: 6-line addition using existing
infrastructure ✅ **No side effects**: Cannot impact other devices due to
specific DMI matching ✅ **No architectural changes**: Pure data addition
to existing quirk table ✅ **Critical subsystem**: Display orientation
affects basic usability ✅ **Follows established pattern**: Identical to
other gaming handheld quirks that were backported **6. Historical
Precedent:** All similar gaming handheld orientation quirks in the
reference examples were marked "Backport Status: YES", establishing
clear precedent that these types of device-specific orientation fixes
are appropriate for stable backporting. **7. User Impact:** Gaming
handhelds are consumer devices where display orientation directly
impacts usability. Users of ZOTAC Gaming Zone devices currently
experience a rotated display, making the device difficult or impossible
to use properly until this fix is applied. The commit perfectly matches
the stable kernel criteria: it's a small, important bug fix with minimal
risk that improves hardware support for end users.

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 036b095c98882..c2a6b4495ae12 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -517,6 +517,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* ZOTAC Gaming Zone */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ZOTAC"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "G0A1W"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* One Mix 2S (generic strings, also match on bios date) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
-- 
2.39.5


