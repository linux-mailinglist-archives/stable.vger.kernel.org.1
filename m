Return-Path: <stable+bounces-241169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECi/MIwc7mkpqwAAu9opvQ
	(envelope-from <stable+bounces-241169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 16:09:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E14346A3F5
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9186D3007AC3
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B08364929;
	Sun, 26 Apr 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYY6jPZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92854364925;
	Sun, 26 Apr 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777212530; cv=none; b=Cpp8KMGFZia1urGfVwxxhNk3XKbs3DiVBOms6RiS8ioHb5peq5oM4BNwubR2TOjmOD+IQerK2x/iyxHsY4V0ccv66ANEa6WeZ0ip2HHCIeuf6C0dyoAmQ8b1113SAr5WL96jKPNV72dEs+W/NFXwFN3zfNU6EgQbsnwtt+FbqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777212530; c=relaxed/simple;
	bh=Aqi75IhndrV0ywUutOkCqgNS6SouxMp0XDzJxatZjrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l/1vukUg36u4TL5JvuSVmdTCQPF58pwLjIR+dom9Cs6ShNMBWgDgxTHhkltoTcBOZufShxHwdibf5Wr9TFzbVCnUJdV2+hGXY0mMrXYQoR4mFKv5IWgRdUUV5x5/LoYzFrUNbxJEqZRj4ZjkmmjBrzpWPO44XFlIZW+IkXbT7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYY6jPZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BE8AC2BCB3;
	Sun, 26 Apr 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777212530;
	bh=Aqi75IhndrV0ywUutOkCqgNS6SouxMp0XDzJxatZjrY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XYY6jPZ7QSASe7snmeFwrM6pHNhkv0AOZMZfyK1IZeF4b83hT23HfVmanvwmi4Z+a
	 /rNG8bx4Fyhy4osjwp9yPgblAhg0vDgFxLRMvmVUs3TjWe9PV0UsB0DgrwxLOfVDud
	 +EqQ8xJNbCENQtbG6/iIeOItrQ/sCTeUVsDIcxJOIqTmeV2Tl5hOwPd/zHSKobXw+i
	 cO4N5/BL6v4cbgUWVfDEu6NFHloHaw9lfdDHWMpN+rJOUvMIf/e9qBKNt8TQevNe3T
	 Zd2W1765QXV7FYqPLP3h9FE1a38LS+VnVT73d8CHzBvFG2pLLB5p2ecTbs8P+2jwSZ
	 XGBK60af56tSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD02FF885E;
	Sun, 26 Apr 2026 14:08:50 +0000 (UTC)
From: Shivam Kalra via B4 Relay <devnull+shivamkalra98.zohomail.in@kernel.org>
Date: Sun, 26 Apr 2026 19:38:41 +0530
Subject: [PATCH] ACPI: video: force native backlight on HP OMEN 16 (8A44)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260426-omen-16-backlight-fix-v1-1-62364f268ea6@zohomail.in>
X-B4-Tracking: v=1; b=H4sIAGgc7mkC/yXM0Q5DQBCF4VeRuTYJS1Gv0rjYWYPRdjW7iES8u
 y2X30nOv4NnJ+yhjnZwvIqXyQakcQRm0LZnlDYYVKKKJFcPnL5sMS2QtHl/pB9m7GTDMuuoIpN
 rRU8I35/jMF/dV3PbLzSymf8xOI4TdT+L03kAAAA=
X-Change-ID: 20260425-omen-16-backlight-fix-73fb8bc4a2b9
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Shivam Kalra <shivamkalra98@zohomail.in>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777212528; l=3008;
 i=shivamkalra98@zohomail.in; s=20260402; h=from:subject:message-id;
 bh=Ks75/0yCMSiPZ5NGPSiLdDntV/e7UFJBadOo45wysJA=;
 b=ImzlN1NF/yjSEwdic/vHSQlDyh2HDbuxm3ilC7wHeE26rJSBVCMfn4V3XByKns2e2Sekc/Yrj
 AA+AbNfO0kDAJPvHDEDPFsh+D+binV7lvoEReIkEwJGdwwIhdYKWZAB
X-Developer-Key: i=shivamkalra98@zohomail.in; a=ed25519;
 pk=U8kQSxcte8P8iZ6zB7phIj+Yl+i/5ntifBGuclgypx8=
X-Endpoint-Received: by B4 Relay for shivamkalra98@zohomail.in/20260402
 with auth_id=716
X-Original-From: Shivam Kalra <shivamkalra98@zohomail.in>
Reply-To: shivamkalra98@zohomail.in
X-Rspamd-Queue-Id: 6E14346A3F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241169-lists,stable=lfdr.de,shivamkalra98.zohomail.in];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[shivamkalra98@zohomail.in]

From: Shivam Kalra <shivamkalra98@zohomail.in>

The HP OMEN 16 Gaming Laptop (board name 8A44) has a mux-less hybrid
GPU configuration with AMD Rembrandt (Radeon 680M) and NVIDIA GA104
(RTX 3070 Ti). The internal eDP panel is wired to the AMD iGPU.

When Nouveau loads without GSP firmware, the ACPI video backlight
device (acpi_video0) gets registered alongside the native AMD
backlight (amdgpu_bl2). In this state, writes to amdgpu_bl2 update
the software brightness value but fail to change the physical panel
brightness.

Force native backlight to prevent acpi_video0 from registering.
Confirmed that booting with acpi_backlight=native resolves the issue.

Cc: stable@vger.kernel.org
Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
---
This patch adds a DMI quirk to force native backlight control on the
HP OMEN 16 Gaming Laptop (board name 8A44), which has a mux-less
hybrid GPU configuration with AMD Rembrandt (680M iGPU) and NVIDIA
GA104 (RTX 3070 Ti).
On this laptop the internal eDP panel is wired to the AMD iGPU. The
amdgpu driver registers amdgpu_bl2 as the native backlight device.
When the Nouveau driver is loaded without GSP firmware (as is the
case on v6.17 where GSP is not the default for Ampere GPUs), writes
to amdgpu_bl2 fail silently — the brightness sysfs value updates
but the physical panel brightness does not change.
Testing:
- Tested on HP OMEN 16 with AMD Ryzen 9 6900HX + NVIDIA RTX 3070 Ti.
- On v6.17, without this quirk, brightness control is broken.
- On v6.17, booting with acpi_backlight=native restores correct
  brightness control. This patch applies that workaround
  automatically via DMI match.
- On v6.18+, the issue does not reproduce because commit
  e0ed674acbac ("drm/nouveau: Remove DRM_NOUVEAU_GSP_DEFAULT
  config") made GSP firmware the default for Ampere, which avoids
  the ACPI conflict entirely.  
I have only tested this on v6.17 and v7.0. I am leaving it to the
stable/LTS maintainers to determine whether this quirk should be
backported, as I have not verified the stability of the GSP firmware
path on intermediate releases.

Thanks,
Shivam Kalra
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0a3c8232d15d..458efa4fe9d4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -916,6 +916,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* HP OMEN Gaming Laptop 16-n0xxx */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-n0xxx"),
+		},
+	},
 
 	/*
 	 * x86 android tablets which directly control the backlight through

---
base-commit: 27d128c1cff64c3b8012cc56dd5a1391bb4f1821
change-id: 20260425-omen-16-backlight-fix-73fb8bc4a2b9

Best regards,
--  
Shivam Kalra <shivamkalra98@zohomail.in>



