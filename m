Return-Path: <stable+bounces-96034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A629E068B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F93BB460C0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EDF1FE457;
	Mon,  2 Dec 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="iP2692B7"
X-Original-To: stable@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37213AA35;
	Mon,  2 Dec 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145456; cv=none; b=O+AfJAyEl66i7d4AaAjE2B4EA0K6VuTWyo6+rzymaDZJDkuKv3tLTpqK9afi0tFMnzwOZcYTMESeOxCxDK0tfylWv1bd1FpiAcDf/psg1keQ+OblgEZ0iyfvWckwjlvpqIbCfEtuhiUv0BJTO9FyXaKnXG1fDGb/Y55iYCu2jm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145456; c=relaxed/simple;
	bh=OLJpSX3LNj136Ba0KdFNNezKUJSqfSOM2lpI+TIC/FU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=geXQ2ERecR1Sux7K/isMAJHbzQjPKsjJgdsbz3tcTUenSJjxOPQgVNzJ4Yz6l/EyiW7NH3drcguoDw82ojtNchn8Qu74CN3LmAlkfZYQlQF7SzMedRzureV6mNYijFkYcDlykeQpRtERcOjluT70ybmpm7ZUKFTfw9IEDZ4WwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=iP2692B7; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 2F90241F5F;
	Mon,  2 Dec 2024 13:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1733145447;
	bh=OLJpSX3LNj136Ba0KdFNNezKUJSqfSOM2lpI+TIC/FU=;
	h=From:Date:Subject:To:Cc;
	b=iP2692B7NwQbgSq+Id0GvlWW2ejP9DL62dburowzPz/pTRjFeRnmb7W54ufkRJciu
	 154HyNgxUKfidUwlylK7NlsEWb+zJvjoM/JR3ERCXjRMdnef8Sc1DrIOPHRUSg/u02
	 JA4d83v4VVSLaBCi5/jASTmd7OwBE/23WdsCWizxvU+88msk5Nc+oA9iFAfmFwwLNN
	 P6yBGxSPpgLc/8nhaOMnUAh31cn5zjZkeNwq5TmNCXNTzs1shUbAvnr4/gaxwHI/dP
	 JJGCNHlF3H1GW/U8C34HKy/RPuyjdIy9NVJPZNlgwgsvfYchRKfo3Ux8siBCaCqD4i
	 fimp1RVp4jInA==
From: Asahi Lina <lina@asahilina.net>
Date: Mon, 02 Dec 2024 22:17:15 +0900
Subject: [PATCH] ALSA: usb-audio: Add extra PID for RME Digiface USB
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-rme-digiface-usb-id-v1-1-50f730d7a46e@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAFqzTWcC/x2MQQqAIBBFrxKzbiArQ7pKtDAdaxZZKEUg3b2hz
 YPH4/8CmRJThrEqkOjmzEcUUXUFbrNxJWQvDm3T9kqAaSf0vHKwjvDKi3T0odEuGGUG3YEsz0S
 Bn/91mt/3A3llORxlAAAA
X-Change-ID: 20241202-rme-digiface-usb-id-df05cf818653
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Heiko Engemann <heikoengemann@gmail.com>, 
 Cyan Nyan <cyan.vtb@gmail.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733145447; l=11996;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=OLJpSX3LNj136Ba0KdFNNezKUJSqfSOM2lpI+TIC/FU=;
 b=IdNg5bli6ojMRL2JqkteKYnIe5jtU1uXf0bBYSbhBiAlQhQxud/BGoJZQwoJCHTvUG81ef6Vo
 Wbwg1tnmvaeBWjS3A9oHgKoZ7PJTHNAV1xSAFmfKPVx5TkOEJVatDOd
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=

It seems there is an alternate version of the hardware with a different
PID. User testing reveals this still works with the same interface as far
as the kernel is concerned, so just add the extra PID. Thanks to Heiko
Engemann for testing with this version.

Due to the way quirks-table.h is structured, that means we have to turn
the entire quirk struct into a macro to avoid duplicating it...

Cc: stable@vger.kernel.org
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 sound/usb/mixer_quirks.c |   1 +
 sound/usb/quirks-table.h | 341 ++++++++++++++++++++++++-----------------------
 sound/usb/quirks.c       |   2 +
 3 files changed, 176 insertions(+), 168 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 6456e87e2f397478aa1d767bc27f15d7b09acb86..a95ebcf4e46e76b19ec439c4ec02f18e650f96a3 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4059,6 +4059,7 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_bbfpro_controls_create(mixer);
 		break;
 	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+	case USB_ID(0x2a39, 0x3fa0): /* RME Digiface USB (alternate) */
 		err = snd_rme_digiface_controls_create(mixer);
 		break;
 	case USB_ID(0x2b73, 0x0017): /* Pioneer DJ DJM-250MK2 */
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 199d0603cf8e592930199097a9fa009a7b5308d8..3f8beacca27a1787987ee7eba08456eb3598231c 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3616,176 +3616,181 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
-{
-	/* Only claim interface 0 */
-	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
-		       USB_DEVICE_ID_MATCH_PRODUCT |
-		       USB_DEVICE_ID_MATCH_INT_CLASS |
-		       USB_DEVICE_ID_MATCH_INT_NUMBER,
-	.idVendor = 0x2a39,
-	.idProduct = 0x3f8c,
-	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
-	.bInterfaceNumber = 0,
-	QUIRK_DRIVER_INFO {
-		QUIRK_DATA_COMPOSITE {
+#define QUIRK_RME_DIGIFACE(pid) \
+{ \
+	/* Only claim interface 0 */ \
+	.match_flags = USB_DEVICE_ID_MATCH_VENDOR | \
+		       USB_DEVICE_ID_MATCH_PRODUCT | \
+		       USB_DEVICE_ID_MATCH_INT_CLASS | \
+		       USB_DEVICE_ID_MATCH_INT_NUMBER, \
+	.idVendor = 0x2a39, \
+	.idProduct = pid, \
+	.bInterfaceClass = USB_CLASS_VENDOR_SPEC, \
+	.bInterfaceNumber = 0, \
+	QUIRK_DRIVER_INFO { \
+		QUIRK_DATA_COMPOSITE { \
 			/*
 			 * Three modes depending on sample rate band,
 			 * with different channel counts for in/out
-			 */
-			{ QUIRK_DATA_STANDARD_MIXER(0) },
-			{
-				QUIRK_DATA_AUDIOFORMAT(0) {
-					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-					.channels = 34, // outputs
-					.fmt_bits = 24,
-					.iface = 0,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.endpoint = 0x02,
-					.ep_idx = 1,
-					.ep_attr = USB_ENDPOINT_XFER_ISOC |
-						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_32000 |
-						SNDRV_PCM_RATE_44100 |
-						SNDRV_PCM_RATE_48000,
-					.rate_min = 32000,
-					.rate_max = 48000,
-					.nr_rates = 3,
-					.rate_table = (unsigned int[]) {
-						32000, 44100, 48000,
-					},
-					.sync_ep = 0x81,
-					.sync_iface = 0,
-					.sync_altsetting = 1,
-					.sync_ep_idx = 0,
-					.implicit_fb = 1,
-				},
-			},
-			{
-				QUIRK_DATA_AUDIOFORMAT(0) {
-					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-					.channels = 18, // outputs
-					.fmt_bits = 24,
-					.iface = 0,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.endpoint = 0x02,
-					.ep_idx = 1,
-					.ep_attr = USB_ENDPOINT_XFER_ISOC |
-						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_64000 |
-						SNDRV_PCM_RATE_88200 |
-						SNDRV_PCM_RATE_96000,
-					.rate_min = 64000,
-					.rate_max = 96000,
-					.nr_rates = 3,
-					.rate_table = (unsigned int[]) {
-						64000, 88200, 96000,
-					},
-					.sync_ep = 0x81,
-					.sync_iface = 0,
-					.sync_altsetting = 1,
-					.sync_ep_idx = 0,
-					.implicit_fb = 1,
-				},
-			},
-			{
-				QUIRK_DATA_AUDIOFORMAT(0) {
-					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-					.channels = 10, // outputs
-					.fmt_bits = 24,
-					.iface = 0,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.endpoint = 0x02,
-					.ep_idx = 1,
-					.ep_attr = USB_ENDPOINT_XFER_ISOC |
-						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_KNOT |
-						SNDRV_PCM_RATE_176400 |
-						SNDRV_PCM_RATE_192000,
-					.rate_min = 128000,
-					.rate_max = 192000,
-					.nr_rates = 3,
-					.rate_table = (unsigned int[]) {
-						128000, 176400, 192000,
-					},
-					.sync_ep = 0x81,
-					.sync_iface = 0,
-					.sync_altsetting = 1,
-					.sync_ep_idx = 0,
-					.implicit_fb = 1,
-				},
-			},
-			{
-				QUIRK_DATA_AUDIOFORMAT(0) {
-					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-					.channels = 32, // inputs
-					.fmt_bits = 24,
-					.iface = 0,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.endpoint = 0x81,
-					.ep_attr = USB_ENDPOINT_XFER_ISOC |
-						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_32000 |
-						SNDRV_PCM_RATE_44100 |
-						SNDRV_PCM_RATE_48000,
-					.rate_min = 32000,
-					.rate_max = 48000,
-					.nr_rates = 3,
-					.rate_table = (unsigned int[]) {
-						32000, 44100, 48000,
-					}
-				}
-			},
-			{
-				QUIRK_DATA_AUDIOFORMAT(0) {
-					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-					.channels = 16, // inputs
-					.fmt_bits = 24,
-					.iface = 0,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.endpoint = 0x81,
-					.ep_attr = USB_ENDPOINT_XFER_ISOC |
-						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_64000 |
-						SNDRV_PCM_RATE_88200 |
-						SNDRV_PCM_RATE_96000,
-					.rate_min = 64000,
-					.rate_max = 96000,
-					.nr_rates = 3,
-					.rate_table = (unsigned int[]) {
-						64000, 88200, 96000,
-					}
-				}
-			},
-			{
-				QUIRK_DATA_AUDIOFORMAT(0) {
-					.formats = SNDRV_PCM_FMTBIT_S32_LE,
-					.channels = 8, // inputs
-					.fmt_bits = 24,
-					.iface = 0,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.endpoint = 0x81,
-					.ep_attr = USB_ENDPOINT_XFER_ISOC |
-						USB_ENDPOINT_SYNC_ASYNC,
-					.rates = SNDRV_PCM_RATE_KNOT |
-						SNDRV_PCM_RATE_176400 |
-						SNDRV_PCM_RATE_192000,
-					.rate_min = 128000,
-					.rate_max = 192000,
-					.nr_rates = 3,
-					.rate_table = (unsigned int[]) {
-						128000, 176400, 192000,
-					}
-				}
-			},
-			QUIRK_COMPOSITE_END
-		}
-	}
-},
+			 */ \
+			{ QUIRK_DATA_STANDARD_MIXER(0) }, \
+			{ \
+				QUIRK_DATA_AUDIOFORMAT(0) { \
+					.formats = SNDRV_PCM_FMTBIT_S32_LE, \
+					.channels = 34, /* outputs */ \
+					.fmt_bits = 24, \
+					.iface = 0, \
+					.altsetting = 1, \
+					.altset_idx = 1, \
+					.endpoint = 0x02, \
+					.ep_idx = 1, \
+					.ep_attr = USB_ENDPOINT_XFER_ISOC | \
+						USB_ENDPOINT_SYNC_ASYNC, \
+					.rates = SNDRV_PCM_RATE_32000 | \
+						SNDRV_PCM_RATE_44100 | \
+						SNDRV_PCM_RATE_48000, \
+					.rate_min = 32000, \
+					.rate_max = 48000, \
+					.nr_rates = 3, \
+					.rate_table = (unsigned int[]) { \
+						32000, 44100, 48000, \
+					}, \
+					.sync_ep = 0x81, \
+					.sync_iface = 0, \
+					.sync_altsetting = 1, \
+					.sync_ep_idx = 0, \
+					.implicit_fb = 1, \
+				}, \
+			}, \
+			{ \
+				QUIRK_DATA_AUDIOFORMAT(0) { \
+					.formats = SNDRV_PCM_FMTBIT_S32_LE, \
+					.channels = 18, /* outputs */ \
+					.fmt_bits = 24, \
+					.iface = 0, \
+					.altsetting = 1, \
+					.altset_idx = 1, \
+					.endpoint = 0x02, \
+					.ep_idx = 1, \
+					.ep_attr = USB_ENDPOINT_XFER_ISOC | \
+						USB_ENDPOINT_SYNC_ASYNC, \
+					.rates = SNDRV_PCM_RATE_64000 | \
+						SNDRV_PCM_RATE_88200 | \
+						SNDRV_PCM_RATE_96000, \
+					.rate_min = 64000, \
+					.rate_max = 96000, \
+					.nr_rates = 3, \
+					.rate_table = (unsigned int[]) { \
+						64000, 88200, 96000, \
+					}, \
+					.sync_ep = 0x81, \
+					.sync_iface = 0, \
+					.sync_altsetting = 1, \
+					.sync_ep_idx = 0, \
+					.implicit_fb = 1, \
+				}, \
+			}, \
+			{ \
+				QUIRK_DATA_AUDIOFORMAT(0) { \
+					.formats = SNDRV_PCM_FMTBIT_S32_LE, \
+					.channels = 10, /* outputs */ \
+					.fmt_bits = 24, \
+					.iface = 0, \
+					.altsetting = 1, \
+					.altset_idx = 1, \
+					.endpoint = 0x02, \
+					.ep_idx = 1, \
+					.ep_attr = USB_ENDPOINT_XFER_ISOC | \
+						USB_ENDPOINT_SYNC_ASYNC, \
+					.rates = SNDRV_PCM_RATE_KNOT | \
+						SNDRV_PCM_RATE_176400 | \
+						SNDRV_PCM_RATE_192000, \
+					.rate_min = 128000, \
+					.rate_max = 192000, \
+					.nr_rates = 3, \
+					.rate_table = (unsigned int[]) { \
+						128000, 176400, 192000, \
+					}, \
+					.sync_ep = 0x81, \
+					.sync_iface = 0, \
+					.sync_altsetting = 1, \
+					.sync_ep_idx = 0, \
+					.implicit_fb = 1, \
+				}, \
+			}, \
+			{ \
+				QUIRK_DATA_AUDIOFORMAT(0) { \
+					.formats = SNDRV_PCM_FMTBIT_S32_LE, \
+					.channels = 32, /* inputs */ \
+					.fmt_bits = 24, \
+					.iface = 0, \
+					.altsetting = 1, \
+					.altset_idx = 1, \
+					.endpoint = 0x81, \
+					.ep_attr = USB_ENDPOINT_XFER_ISOC | \
+						USB_ENDPOINT_SYNC_ASYNC, \
+					.rates = SNDRV_PCM_RATE_32000 | \
+						SNDRV_PCM_RATE_44100 | \
+						SNDRV_PCM_RATE_48000, \
+					.rate_min = 32000, \
+					.rate_max = 48000, \
+					.nr_rates = 3, \
+					.rate_table = (unsigned int[]) { \
+						32000, 44100, 48000, \
+					} \
+				} \
+			}, \
+			{ \
+				QUIRK_DATA_AUDIOFORMAT(0) { \
+					.formats = SNDRV_PCM_FMTBIT_S32_LE, \
+					.channels = 16, /* inputs */ \
+					.fmt_bits = 24, \
+					.iface = 0, \
+					.altsetting = 1, \
+					.altset_idx = 1, \
+					.endpoint = 0x81, \
+					.ep_attr = USB_ENDPOINT_XFER_ISOC | \
+						USB_ENDPOINT_SYNC_ASYNC, \
+					.rates = SNDRV_PCM_RATE_64000 | \
+						SNDRV_PCM_RATE_88200 | \
+						SNDRV_PCM_RATE_96000, \
+					.rate_min = 64000, \
+					.rate_max = 96000, \
+					.nr_rates = 3, \
+					.rate_table = (unsigned int[]) { \
+						64000, 88200, 96000, \
+					} \
+				} \
+			}, \
+			{ \
+				QUIRK_DATA_AUDIOFORMAT(0) { \
+					.formats = SNDRV_PCM_FMTBIT_S32_LE, \
+					.channels = 8, /* inputs */ \
+					.fmt_bits = 24, \
+					.iface = 0, \
+					.altsetting = 1, \
+					.altset_idx = 1, \
+					.endpoint = 0x81, \
+					.ep_attr = USB_ENDPOINT_XFER_ISOC | \
+						USB_ENDPOINT_SYNC_ASYNC, \
+					.rates = SNDRV_PCM_RATE_KNOT | \
+						SNDRV_PCM_RATE_176400 | \
+						SNDRV_PCM_RATE_192000, \
+					.rate_min = 128000, \
+					.rate_max = 192000, \
+					.nr_rates = 3, \
+					.rate_table = (unsigned int[]) { \
+						128000, 176400, 192000, \
+					} \
+				} \
+			}, \
+			QUIRK_COMPOSITE_END \
+		} \
+	} \
+}
+
+QUIRK_RME_DIGIFACE(0x3f8c),
+QUIRK_RME_DIGIFACE(0x3fa0),
+
 #undef USB_DEVICE_VENDOR_SPEC
 #undef USB_AUDIO_DEVICE
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index c5fd180357d1e8cc4560bf03ae1ab3c12e6ee9d1..9f38288a1bede8a360abbd0296f571cdf9a72c7d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1638,6 +1638,7 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 			return snd_usb_motu_microbookii_boot_quirk(dev);
 		break;
 	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+	case USB_ID(0x2a39, 0x3fa0): /* RME Digiface USB (alternate) */
 		return snd_usb_rme_digiface_boot_quirk(dev);
 	}
 
@@ -1851,6 +1852,7 @@ void snd_usb_set_format_quirk(struct snd_usb_substream *subs,
 		mbox3_set_format_quirk(subs, fmt); /* Digidesign Mbox 3 */
 		break;
 	case USB_ID(0x2a39, 0x3f8c): /* RME Digiface USB */
+	case USB_ID(0x2a39, 0x3fa0): /* RME Digiface USB (alternate) */
 		rme_digiface_set_format_quirk(subs);
 		break;
 	}

---
base-commit: adc218676eef25575469234709c2d87185ca223a
change-id: 20241202-rme-digiface-usb-id-df05cf818653

Cheers,
~~ Lina


