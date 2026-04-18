Return-Path: <stable+bounces-238582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DHoEtZa42kcFwEAu9opvQ
	(envelope-from <stable+bounces-238582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 12:20:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF53420A31
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 12:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC4A302F988
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994BD330D54;
	Sat, 18 Apr 2026 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSiJZz0q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19B233D9E
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776507601; cv=none; b=k7PwJ6pZ48EfeX6E0lk5LBXYK2pA35HFknKkl2qv6Ksr5QGO0hYXY5HcaqU1a5sgsrjCCOlzZ7ECsncRS1XC0Qgcc4mXcHfdLvD8x7f06ee4TIf/gs3DyMTTGm8VpGGxoMJP3CaoGuRJSHlUIZWm9sYZUctTLN5LK0MqiEgbnYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776507601; c=relaxed/simple;
	bh=vZB01Uszi+NlvuVgjZIo5cDjSFQRqO8hbTz3Po6dwJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cM8C/tW+rn1LMH6yRpt9Z4L1GKcUg4RygRQT3KkYFn/9ud23dt22QkzUPZ2GzYVRDjn9NhNpOUsiHSA4sYoz7PhZJk447LfGUM7eyhBDcf0K6ivwn47iTpD69b4FiYmDHjkHkUITJWaXHFy154NrtOCDY1F+2xhA1Y7oFMug6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSiJZz0q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b467d03d57so1820745ad.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776507599; x=1777112399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xqAYAaB98xsAiWaW3K7BAxJ1Wdz7VTsIiYzGAY8PX4g=;
        b=JSiJZz0qBQIs+wx+1F5Aua6oA/lvVNodyLeuUWkCg4X2QEaZmt1mG1GRBeQvYItX9J
         8LXSp9vtmRT+7zDq9ALjR7HPqFFIpQr+p0rIYCWjOUtKgA26b3zmZp0UUr8muKXPtsZ6
         yKTXz3vK7b875FM6zWc1Rq6yR4L+r4Z4Sihud0P2VAqk+drWMolFGr6xJT7heISNQRtB
         BZCANn8ILdL3ZYB67hILmG53MzH3TqocpZ4XTtbeQQfkA8Mset+GMQzBJv9NlhU4xnnm
         V10ErJSKLtyXEyiKKvn1PoDFPr9fxT55rsdcuNdJSiEa+TO25h2b7JLKoMIRmyPqzXX2
         cx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776507599; x=1777112399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqAYAaB98xsAiWaW3K7BAxJ1Wdz7VTsIiYzGAY8PX4g=;
        b=lKUyccoVS8ZUzXj5/+o6fwUTW2yWrGmcq3VFjAxt+pQ5qRM+cg9qlj/CCjAtOijdhN
         bTiENONoYO09/LQ7c/F2wXGI640+ASXj3XupkOnfhAQa58rHIP/mH1TYpzLJHE0xiMBi
         lt1R2nhCt1Oc5enrGxmlU6DGkY+rDdCXBr3lgoTjp9oJgYHucbuw2O7z9DhGbgIqhQm4
         xwNs09u6q4rv8Ksi8QaNfNMviKL2W7rkUN2GSlx2U+qdKS7WGaPBGwtzh4zQ//OBZg/Y
         dp/ByBVOTr3C6J2EP65VDVjkemG3q1JmaoXSwCq52rBkBPMi76qugWEJE3181JP2cc0F
         r4vA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZO0SLLfSUvhLhyVN4m0LuHEquhGtGOvfCTrcFk4y/Vze2JYSOUxn6z19n/t2x8bVR8ctda+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrCLz34lJD5EwLSHqe3XxO+6bH8KCXujTY0DnfDsOPcsHS71+
	cSSxyiY2mt84Ilzbu/4AZoJTZWRxZDRanHExBZL2hv6spWiT1BbnETQK
X-Gm-Gg: AeBDieueoNASP4QNVaORnKcHvPS43XhpkHTXFVgped0v4ULFr+gtFH6JEG5QkxiZ/4G
	D4r3S4MKcBUWpD50dmA6r52B6twX8P4BfJdmkXA/2nyubCT2CiX6zKEODu632leH9bjLIaoII4W
	fuog/PcrrgTnMeuy6as+wa0gKItgdLrIY2/uz+SSuDtAIvPJKnrykT/zEPcgDFtEXaT+X+XU1Lz
	SrLW/44DHI+/lxd0aXWGrRK2Be/gFJ+QNB7hf2Jq3ZeEYp9ltRZYOm7Pl4IhpMcHgBOv8F8Vzd5
	jn+0lomnHe1rh+tSf1E3DCJVyqRfueIXI4kZx47JpAfaG0JWuitqgPiyyUGMWbzQN1OEmYI6Kgw
	sdKuomzLpWoX5zqsCU1UAZ9T2G8YF6LYim3RrhmpZ4FIe2n7KzuNoZnLDF0ayxx2HZA4rRlnFx1
	lb2LoA0eHIUKq7uRbLO9aR41wkdrflJeWhO3K0vvppgP0jaOvJ5cVKLHsbzhcSUA==
X-Received: by 2002:a17:903:907:b0:2b2:eb6b:72f2 with SMTP id d9443c01a7336-2b5f9fff1e5mr33840955ad.7.1776507599529;
        Sat, 18 Apr 2026 03:19:59 -0700 (PDT)
Received: from fedora.izzigo.tv (45.62.127.193.16clouds.com. [45.62.127.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff39csm46674525ad.4.2026.04.18.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 03:19:58 -0700 (PDT)
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
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY is down
Date: Sat, 18 Apr 2026 18:19:36 +0800
Message-ID: <20260418101936.7731-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[collabora.com,ideasonboard.com,kwiboo.se,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-238582-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmxpzlb@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AF53420A31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following panic was observed during system reboot:

Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
Call trace:
 ...
 regmap_update_bits_base+0x5c/0x90
 dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
 drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
 ...
 dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
 drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
 drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
 hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
 ...
 snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
 snd_pcm_release+0x60/0xe8 [snd_pcm]
 ...

The root cause is pipewire tries to close the HDMI audio device after
atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.

In this case, dw_hdmi_qp_audio_disable() will call
drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
accessing registers without checking tmds_char_rate.

Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().

Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

---
Changes in v2:
- Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
  the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
- Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index d649a1cf07f5..7760527484c8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 
-	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
-
-	if (hdmi->tmds_char_rate)
+	if (hdmi->tmds_char_rate) {
+		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 		dw_hdmi_qp_audio_disable_regs(hdmi);
+	}
 }
 
 static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
-- 
2.53.0


