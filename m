Return-Path: <stable+bounces-240442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GW/FZDV6WnxlAIAu9opvQ
	(envelope-from <stable+bounces-240442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:17:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B88F244E6B3
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5359302F719
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7E366550;
	Thu, 23 Apr 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAcNnt59"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034636607C
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932134; cv=none; b=GNYBD1O5TDsyaF5CoBP0KhzMjgq8s33AQlZWRVyV64wWtXdAqBZDiVdHywjIcJSCHxlxUbqBPHTyJf5p21U2veqXC4csr8M2lDcyNiNt2MYPJQkG/76D2JIa2crZRT7R3ES9klUF6AZKE1vWjFwo0TOUyChO99gQARiOdwVsCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932134; c=relaxed/simple;
	bh=vbXFXdDNH9CWDwD/M4tOAcTT2UeqIyCWutuohVIoFME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASgYeKy1wx6xiH9QMgRfkgkOfJkxYI0XiMkD9it4OIUWSBOVwuhYWvRQtPQr9FmEXCaubxdk5aHubns9u8uWmjzjQzQfVBZzDRB4AOsxG9EPphR+WIJWtIhHZR1Kj3b876EKsfDdlNCSeIChH1Hog9y7oO7xQHCGEQrC139Aeuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAcNnt59; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d99c906d5so1100823a91.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776932132; x=1777536932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAlmZfpdk3Iz3porN4R6dSq4Ld5esbkgYHoF3QfFzLg=;
        b=VAcNnt59HwiRRoySMcFRPBIVO1zl9umyVrhbeiJGR0H66vb41wQVUkvUFumxqV3Leo
         r6gj3CM8tlP0Tz4oOyXrgoeTl9TziqskOWIwigjO+9C1Xqe/cZrU3t8W8wWw+FzNsnQM
         SY91H36RUrpFjzhpL72gftrcnJrcfEIIGyFVJEkBePkHmdor+6iSpQG7YjfOAmZ7cHAV
         p/o5mgXwF7O7OgvjK0q+X63MdXLyVYrBnLQZr2D5lLa7dDWzay+4E/yVth5GQdWr1T/V
         UPbCi8iLdGI+KBfhHBe9aApOCnvrL1iPKQV8+4VyK3Y+qSEf+VMqZr18+bKOoYjeicU7
         Iaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932132; x=1777536932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAlmZfpdk3Iz3porN4R6dSq4Ld5esbkgYHoF3QfFzLg=;
        b=Kox3+x8QdmgGFAjrPt0iBoHn2kGGqsf9iUpf3gpPg2IR/5miSlQVXEIwoMUHYHDTVe
         M0JzUc42lLnMImNRmy3P91mboVGgVRQYetl4Py4LXMI579Xr2hLjM/gAnByq6YP8QyJE
         +SX4Hx+r/V+MWnvgy1Fvw6kMFs3LVClvILjvWs1SsAR5O1DbxVLlJTo9QCeizmubRl96
         znod6GOou8NjeciIunzpN2gUY3l3xhoMgxpx7i5Hi8laj0TOeRDtOu8eMvVMLMVbiMpb
         CZnZZDLDHfcGGAHkKpYf45WuyrXt9PN4z+8Uc2Tl62WtqFFPfgpZhef3ttBkHv+4PZ3K
         Uchg==
X-Forwarded-Encrypted: i=1; AFNElJ+ySJzvOXTeLhsHNOJ6gTux9O3/RzFG7vHkqoZdp6YVDiqAfiPhWG5o+RMm6s0qyd2qjVxJX0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUh8ylmz3vrMR+n1tAgrf10nmYR8nU9VWBWLHNtOKT4j7aUsvJ
	ETneTqa2bUBljhikJVkQxkVEzA6RzP3Ri5A6UdQ3rXUaR9i0XyNsuVfU
X-Gm-Gg: AeBDiesWp6wJ4qtJoINmZi+u1tal7ZhnGQVyU/0CzQD2T1QdJ9gQRp+pLXjUuNxbs5e
	FNsbyihzvU5en4MZ2AelV3cyTiETf3AQNTwPuM/EdSCXlZIw2hyN7XN+jiEtCcXrGB3T8JlTL8c
	UAI3GrLpeytlClfq+ONaUUqDZWhm5Zms6YYQOj0o4hvhG91WTJ9dXropEqcflhlWtyJU2pKFM06
	Jf9wTbsFr+U8E/uYCB++ahNCQonyNV0HmcTlGUyopy37HdpTs/8QNR5mJP84yLF9d4KH0ghIoKf
	jOU8khbT4x8nPCCHCE/r1uFsHeuWq3wwChp4kCcs/QDCdJ2uSXZn97iDExi2fKAsX205BWeHHoS
	PzRf3/D9TnJmmoYJlARl4zX1Sc2JRnV9DfJAwRRu9rtI8nTCWTSU1C54lk8NcwAa6hkUOdt13EZ
	Q5ELEYegsNWfDcFUHae8coEfjAUPQQ4XcoIALCrv5uNx5UgsR0ySPLIQ+MlsIphQ==
X-Received: by 2002:a17:90a:ec87:b0:362:bc7c:55cf with SMTP id 98e67ed59e1d1-362bc7c5d34mr5499791a91.8.1776932132310;
        Thu, 23 Apr 2026 01:15:32 -0700 (PDT)
Received: from fedora.izzigo.tv (45.62.127.193.16clouds.com. [45.62.127.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361418c3944sm24091557a91.8.2026.04.23.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:15:31 -0700 (PDT)
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
Subject: [PATCH v3] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY is down
Date: Thu, 23 Apr 2026 16:15:14 +0800
Message-ID: <20260423081514.15444-1-rmxpzlb@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[collabora.com,ideasonboard.com,kwiboo.se,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-240442-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: B88F244E6B3
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
2.53.0


