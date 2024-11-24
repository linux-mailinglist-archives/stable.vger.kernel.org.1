Return-Path: <stable+bounces-94907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D09D7087
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E90816335B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B11AAE17;
	Sun, 24 Nov 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZtizp+j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615F1AA7A5;
	Sun, 24 Nov 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455203; cv=none; b=SjYyl8iBy6a1W3v1AfV+l3dxKTvi8oyjjCViOgBRb/HEig86HXn3NjTqH3NOikRJmM5S0sVLmokFTZFI0GECVHoVkKoHa/WeljeG/yXvRxl3Tm5GXiUz54Z8qCdUPfGliO12PGdFekC1MuL3RW5ZNjWJks2weR/yhyRsB3KntR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455203; c=relaxed/simple;
	bh=bzhSVrwZXLtsJ5pvz9QQuHBjTJBk6Lp7rOsaZcq/+Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPV3Yyg5m25h7hYeT2Fn8oYGa+THhQYFLCF4SSS9tUGUU+dBYmpVqnCPcGI2G66YCvCfda0TnVa7IesyWVIDpE/6pvQN/Xyzuc/ihG7ub0rU4YWBL5LAJm5blZC24gqhyqjVlwy2vsl4+nFhEp5uNwc3VjlLo3s4FlnrM2V4sZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZtizp+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C3BC4CECC;
	Sun, 24 Nov 2024 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455203;
	bh=bzhSVrwZXLtsJ5pvz9QQuHBjTJBk6Lp7rOsaZcq/+Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZtizp+jjCywYRqzXgAuXQ1i5xKdjy1INTzH3hx/XkPI0zzk+px96EYV0AaIHEL4D
	 P+tABDmwduy1V+MotXWeItaxYpVgSQcwX/s96ThsGAcEsvCn2dpQu8+LSi0lr7WPu/
	 axK15Ijb52m+mPC12FrwuZJp+qydE2yQgKVKIugt2PGjAtBYqJEHJmuHeViH7Fj8qh
	 Xugw72NsqYSkXlWC5GV2sQQGFprp6UKFL/6Te8el4T6eqSwe9lFyDfmdZZzwwLSpR8
	 7bLIP4JQGocpkLULLXyXGmzkrT0wNBtE3HPz6khVNc14pebTOu6OMdgeSif69Q7I6S
	 eKGN+B3wUAN2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 011/107] drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
Date: Sun, 24 Nov 2024 08:28:31 -0500
Message-ID: <20241124133301.3341829-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Joaquín Ignacio Aramendía <samsagax@gmail.com>

[ Upstream commit d7972d735ca80a40a571bf753c138263981a5698 ]

Add quirk orientation for AYA NEO Founder. The name appears with spaces in
DMI strings as other devices of the brand. The panel is the same as the
NEXT and 2021 models. Those could not be reused as the former has VENDOR
name as "AYANEO" without spaces and the latter has "AYADEVICE".

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/f71889a0b39f13f4b78481bd030377ca15035680.1726492131.git.tjakobi@math.uni-bielefeld.de
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 4864d8406db41..01a33d33c4aaf 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -202,6 +202,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* AYA NEO Founder */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYA NEO Founder"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.43.0


