Return-Path: <stable+bounces-184065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED2BCF34C
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E8F42655E
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B623E342;
	Sat, 11 Oct 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HVFFH7t4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE92264BA;
	Sat, 11 Oct 2025 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760176284; cv=none; b=ju33NXQKdLl4HqlfgsrtVc1t5Ywrm6c2u/2LvNcl9l6tPgUH+oLWgzgoJk7QJ2sWmnv2q2bs9NIQRojVBATmYke7das3JaXXMrUmC6AwXwVOtuXUT+GrfwtGX6hgWZRPjh5HY446pcS4uNNLuFwBvk1kV7B/Ba2PcazmqK1Meh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760176284; c=relaxed/simple;
	bh=c9Dv+k+WMCSOf8X6lgtRzh+GIEDTCEfsKKsqpy5DtgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LFZ1LpSYMQMj+WlCna053Lc0yREEtvToQY12ALvBJFf/TteoKOKVgnswZlU3QGKt/zB+MILPu4lfPzgwE0m8S6rwUdYTWtGAJJQQ2i2SLP+RIYNLRDKJfIhhIKgxsHHfOhFj/zf6YlD+1h28NCE710BkB9bF8wxsuxKfOmvA+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HVFFH7t4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D9C3C4CEF4;
	Sat, 11 Oct 2025 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1760176283; bh=c9Dv+k+WMCSOf8X6lgtRzh+GIEDTCEfsKKsqpy5DtgY=;
	h=From:Date:Subject:To:Cc:From;
	b=HVFFH7t4IbeOeYpE7oFhoTrTSTiq+JB44fZO3iNJxrgAwB0rcKL+vpsllW3JEJgPw
	 ijA87JB9sMAM3SpGOTzuPb192g6A7vqnJg37V3/oNXnIr0zBziMIJEF4wVyRGzZdJ5
	 yctVVcMVQZCvNb9GDeKqb8XmVQJsyEIa11aKmJeg=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738DFCCA476;
	Sat, 11 Oct 2025 09:51:23 +0000 (UTC)
From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Date: Sat, 11 Oct 2025 17:51:18 +0800
Subject: [PATCH] ALSA: usb-audio: apply quirk for Huawei Technologies Co.,
 Ltd. CM-Q3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-sound_quirk-v1-1-d693738108ee@linux.dev>
X-B4-Tracking: v=1; b=H4sIAJUo6mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3eL80ryU+MLSzKJsXbNEC2MjM2MjUxNTQyWgjoKi1LTMCrBp0bG
 1tQD01tW+XQAAAA==
X-Change-ID: 20251011-sound_quirk-6a8326325451
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, zhanjun@uniontech.com, niecheng1@uniontech.com, 
 anguoli@uniontech.com, zhaochengyi@uniontech.com, fengyuan@uniontech.com, 
 Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760176282; l=1832;
 i=cryolitia.pukngae@linux.dev; s=20250730; h=from:subject:message-id;
 bh=c9Dv+k+WMCSOf8X6lgtRzh+GIEDTCEfsKKsqpy5DtgY=;
 b=wbp7xEW18wbmtw1ngB9hiPnogk1zwwypB0R5ze/0nCz7RPFSzg38kofd2SAaZfo+CLgutOA/t
 +SKFP291munD1kixPWbiEcz6xwMIQ5abOt9OQ3Pq9q3D4bahtbTm5MD
X-Developer-Key: i=cryolitia.pukngae@linux.dev; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia.pukngae@linux.dev/20250730
 with auth_id=540

There're several different actual hardwares sold by Huawei, using the
same USB ID 12d1:3a07.

The first one we found, having a volume control named "Headset Playback
Volume", reports a min value -15360, and will mute iff setting it to
-15360. It can be simply fixed by quirk flag MIXER_PLAYBACK_MIN_MUTE,
which we have already submitted previously.[1]

The second one we found today, having a volume control named "PCM
Playback Volume", reports its min -11520 and res 256, and will mute
when less than -11008. Because of the already existing quirk flag, we
can just set its min to -11264, and the new minimum value will still
not be available to userspace, so that userspace's minimum will be the
correct -11008.

1. https://lore.kernel.org/all/20250903-sound-v1-3-d4ca777b8512@uniontech.com/

Tested-by: Guoli An <anguoli@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
---
 sound/usb/mixer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 34bcbfd8b54e66abc0229eefd354eb7bc4c01576..ae412e651faf905c9f7d600de8e19c51995cd3f9 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1189,6 +1189,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->min = -14208; /* Mute under it */
 		}
 		break;
+	case USB_ID(0x12d1, 0x3a07): /* Huawei Technologies Co., Ltd. CM-Q3 */
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				       "set volume quirk for Huawei Technologies Co., Ltd. CM-Q3\n");
+			cval->min = -11264; /* Mute under it */
+		}
+		break;
 	}
 }
 

---
base-commit: 7e9827afc78073096149cf3565ba668fe2ef4831
change-id: 20251011-sound_quirk-6a8326325451

Best regards,
-- 
Cryolitia PukNgae <cryolitia.pukngae@linux.dev>



