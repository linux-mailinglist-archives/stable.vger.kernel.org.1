Return-Path: <stable+bounces-245437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD5SBUcCA2pczgEAu9opvQ
	(envelope-from <stable+bounces-245437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:34:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C993D51EAB4
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1470E30237DD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3474238399E;
	Tue, 12 May 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZKiwpw3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068738398A
	for <stable@vger.kernel.org>; Tue, 12 May 2026 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581942; cv=none; b=Qlz71hItOLy2yloOu04OggdFpWkrX77par3sjLjaCEpCeYuuuTGFXrVUOFDARj97Mmr8UliYlv91GM+obivfHQmWAFUZhtej0Li6Tkei+Ddx5U1tMqntgNXON/RhTzMa+Nl2quwdhMChmImZrn9G/6FA4GBbkEKJ7BMzAVLCmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581942; c=relaxed/simple;
	bh=tvp7L1oZJYHVNwIsz78SgXYaRd+6+wYWtLy29bKHyAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQNqlX9PJTW+Ha3CUoRrqrfKnbki/G5PAHHC1pW3XQvVsGYknAqBeJoBc2MhOxFTX3Ac1HuxdkkF5KhC+RRqKRzf9nU5ZAxzstIrW041V300okh/6QLC0bmcYQiCxieCSxdnSHMfo+RXA94SYTB1a/UCRjOKoPN9xOlJFyXPlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZKiwpw3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-835378dc7cdso478452b3a.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581940; x=1779186740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhehjUWhhndTO+aLTrKXJGjjblaTc3IzZAO9VvBbULE=;
        b=dZKiwpw3r4leLnSC1x206+V5c7JXBoxEn5ABGWOOh482bGr/cjtjOXuiqNhz3Ehrha
         512Bbpzk3eEUUHu8bMbB2xdB24J/XP63/+nmu8rVCS8eOmEI4d81tBQ6SFh+1cWBmrKl
         iR/hHgF8EL2TPRKWwknvh9gh709aCW5/efs6JY7rgYMgM4bWbPHUkFAFNcuX11CubkqN
         IRo9hYLa+IwzrIo7pUpGUUGl+32wHgL8uS1xYZzDQGrghXqEdCcoJIq/6yiIQdecyJaB
         ASDK1wcDeWqFC2TTkFDK9L5hFsIdP7FnbrhhOlM0CfTgFcLUXPm7B21Ua2A5p0X7JFV1
         vKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581940; x=1779186740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhehjUWhhndTO+aLTrKXJGjjblaTc3IzZAO9VvBbULE=;
        b=sixww2yyUHwtr4P9VicdSeio+X5Jk346yeTG0+TNVUqk7U1D8fadgGwddGfNqtZuD4
         qQQN5HzbUBuZTMrR9NtMuansdAShEN0f/HviwUL8bPN98d+Xy2TnWxXN4dogfbAuzrJQ
         kJLs1lF9YaRvKIvtOgnUfKcNsQyZAmci3PbPyrO43FyKE+ATm+RWAGPmpKfQQnpTnn9U
         ZHww5Ry4qtudp3EhugoRGq1AZY91x6oTi4KMH4xgjanwUYiOhwrBPAIGX0Cgiu0BBKiQ
         vpRpPOWr0Tz7SwmJIeQ+nFDsrXXrsHX0xJu79kF+Ii9lZ3JttKbyR/JaqOqNhwq++P4d
         h2kQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BCrhxC4sqmfkPfi3zQ+cvma1H8Uezvd9x+J/pKv4u3iBKZwBxCC5b1Lw44wzc3algyvhF/bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcszeLBbJPGMvmLihTc0iddwO7/E9feamav6PVf8wCdS6Tz/ZV
	72PWh3H5HMpIIstgUeUrGjb/CDYnPpKmOfn8vw6+IThVk6jeNvraNMdS
X-Gm-Gg: Acq92OH0szBP8xWl2rwJf/R34iv2D68bKy8Mzs44txwwjgitrCPNO57KcWc2s9bqXN/
	E1TUNKetobrZ013UCJpPWDmlbFmOVsGvO4Daq1GQR7CrGnqSBzY/QYFIXe8BQIVJ6rMMXXt9/vC
	ocdgD71uyrPjyCva4vpss4A8kST5Mk04NkfDEvIAkXC6Apa6TIUjpp6LpV6rHsXZE7/d7DZ0zzs
	G0wp8/KtYdBCEN/61qcXJYMXSlQVYa6sCBOl2cg69J7nbokMGp/Po5AMHM3lzNmQuwDAv3jh6Yo
	QZg1457I7KaBqIWC6TqAv64L3sLJkmDhqbWD+XGD/j+JMNqDJyVHNSavem8VcZeGewBMN699vsp
	4I6jmF9kOBFrEqggwvf/MWFxYneMCZKolQ/vCwmmanlDWupsR+D4DqxcHvTmbMgWRSdUxNsHrsb
	QERwjHpr0nyb1hVE9XHh3YW2zkgIIutWPZOBOxrXadnwg5pPaG6l8=
X-Received: by 2002:a05:6a00:4088:b0:835:36f2:7332 with SMTP id d2e1a72fcca58-83a5aaf7775mr15856894b3a.2.1778581939943;
        Tue, 12 May 2026 03:32:19 -0700 (PDT)
Received: from fedora.izzigo.tv (45.62.127.193.16clouds.com. [45.62.127.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8462sm23025473b3a.38.2026.05.12.03.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:32:19 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: detlev.casanova@collabora.com,
	cristian.ciocaltea@collabora.com,
	daniels@collabora.com,
	dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY is down
Date: Tue, 12 May 2026 18:31:53 +0800
Message-ID: <20260512103153.8861-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C993D51EAB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[collabora.com,oss.qualcomm.com,sntech.de,ideasonboard.com,kwiboo.se,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-245437-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmxpzlb@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.977];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The following panic was observed during system reboot:

Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
Call trace:
 ...
 regmap_update_bits_base+0x70/0xa8
 dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
 drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
 ...
 dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
 drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
 drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
 hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
 ...
 snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
 snd_pcm_release+0x4c/0xc0 [snd_pcm]
 ...

The root cause is pipewire tries to close the HDMI audio device after
atomic_disable(), which sets tmds_char_rate to 0 and disables the PHY.

In this case, dw_hdmi_qp_audio_disable() will call
dw_hdmi_qp_bridge_clear_audio_infoframe(), accessing register without
checking tmds_char_rate.

Add a tmds_char_rate guard in dw_hdmi_qp_bridge_clear_audio_infoframe().
Decouple write_audio_infoframe from clear_audio_infoframe to avoid the
redundant check in the write path.
Add PKTSCHED_AMD_TX_EN to the clear mask to keep the enable/disable
balance.

Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

---
Changes in v2:
- Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
  the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
- Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/

Changes in v3:
- Add a tmds_char_rate guard in clear_audio_infoframe path.
- Decouple write_audio_infoframe from clear_audio_infoframe.
- Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
- Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/

Changes in v4:
- Update panic stack on 7.0.5
- Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index d649a1cf07f5..1c18f8650fcd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -886,11 +886,11 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_mod(hdmi, 0,
-		       PKTSCHED_ACR_TX_EN |
-		       PKTSCHED_AUDS_TX_EN |
-		       PKTSCHED_AUDI_TX_EN,
-		       PKTSCHED_PKT_EN);
+	if (hdmi->tmds_char_rate)
+		dw_hdmi_qp_mod(hdmi, 0,
+			       PKTSCHED_ACR_TX_EN | PKTSCHED_AMD_TX_EN |
+			       PKTSCHED_AUDS_TX_EN | PKTSCHED_AUDI_TX_EN,
+			       PKTSCHED_PKT_EN);
 
 	return 0;
 }
@@ -989,7 +989,10 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
+	dw_hdmi_qp_mod(hdmi, 0,
+		       PKTSCHED_ACR_TX_EN | PKTSCHED_AMD_TX_EN |
+		       PKTSCHED_AUDS_TX_EN | PKTSCHED_AUDI_TX_EN,
+		       PKTSCHED_PKT_EN);
 
 	/*
 	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
-- 
2.54.0


