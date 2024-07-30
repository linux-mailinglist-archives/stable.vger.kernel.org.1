Return-Path: <stable+bounces-64105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74691941C21
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310BE2839B4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23CF188003;
	Tue, 30 Jul 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ayqHZ6U7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9501A6192;
	Tue, 30 Jul 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359006; cv=none; b=dQegP+rFzrQqn9S7lDib6p5Y3zvphVeFTDEg+zw6n1Mw6gMdsQUvqC/qnV9n4O3WtQXEjxOdAclX/Ac+uWSEbeLl8OnNkOGGd8+bHjwJaqmJPuFW7aDof/MLQ5K8qsx+s0MbRJDpA9+w862lUul67tdiAfEJ9fFdcDdkpjPjI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359006; c=relaxed/simple;
	bh=jgkR1WBd1wpyCJLsJgkzNJuVQ12OuzUWiIjqrUpECWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0YbCu/73rYnRU6c8dVfkt0HZkv1Yw0/GTtSDXiNPU8rythni7iaIbHQR/oAbbLz3bKcJQKChUCGLf5EOAc+D+DHSr4jC/5sMSCkwuDPa7uoQm/EFPLGOJdbngS0V2jVqVkI/CA4cveu69N0K5YGuawPnx5cpqPTGyLU4P0eT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ayqHZ6U7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE33EC32782;
	Tue, 30 Jul 2024 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359006;
	bh=jgkR1WBd1wpyCJLsJgkzNJuVQ12OuzUWiIjqrUpECWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayqHZ6U7e8wvXu8/EJ97iqPHsX8A+15DKPF5xERWJI/apgsbc1eGKMRzBsAmCZzAQ
	 D4D6JxD8n7IN6Gk7hHj5fk+FNzQltoBTt+Mi9wAb9irs1XEYkcV6w1K0sI5QPy80HR
	 moKb3PQmjSwr8/xhdG8tVNCig7br6aqF4dSUjsgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangdicheng <wangdicheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 419/568] ALSA: usb-audio: Fix microphone sound on HD webcam.
Date: Tue, 30 Jul 2024 17:48:46 +0200
Message-ID: <20240730151656.246717392@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: wangdicheng <wangdicheng@kylinos.cn>

commit 74dba240881820b46b9b1c62ef4de3bfff47fbd4 upstream.

I own an external usb Webcam, HD webcam, which had low mic volume and
inconsistent sound quality. Video works as expected.

(snip)
[   95.473820][ 1] [   T73] usb 5-2.2: new high-speed USB device number 7 using xhci_hcd
[   95.773974][ 1] [   T73] usb 5-2.2: New USB device found, idVendor=1bcf, idProduct=2281, bcdDevice= 0.05
[   95.783445][ 1] [   T73] usb 5-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   95.791872][ 1] [   T73] usb 5-2.2: Product: HD webcam
[   95.797001][ 1] [   T73] usb 5-2.2: Manufacturer: Sunplus IT Co
[   95.802996][ 1] [   T73] usb 5-2.2: SerialNumber: 20200513
[   96.092610][ 2] [ T3680] usb 5-2.2: Warning! Unlikely big volume range (=4096), cval->res is probably wrong.
[   96.102436][ 2] [ T3680] usb 5-2.2: [5] FU [Mic Capture Volume] ch = 1, val = 0/4096/1

Set up quirk cval->res to 16 for 256 levels,
Set GET_SAMPLE_RATE quirk flag to stop trying to get the sample rate.
Confirmed that happened anyway later due to the backoff mechanism,
After 3 failures.

All audio stream on device interfaces share the same values,
apart from wMaxPacketSize and tSamFreq :

      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       4
      bNumEndpoints           1
      bInterfaceClass         1 Audio

Interface Descriptor:
  bLength                 9
  bDescriptorType         4
  bInterfaceNumber        3
  bAlternateSetting       4
  bNumEndpoints           1
  bInterfaceClass         1 Audio
  bInterfaceSubClass      2 Streaming
  bInterfaceProtocol      0
  iInterface              0
  AudioStreaming Interface Descriptor:
    bLength                 7
    bDescriptorType        36
    bDescriptorSubtype      1 (AS_GENERAL)
    bTerminalLink           3
    bDelay                  1 frames
    wFormatTag         0x0001 PCM
  AudioStreaming Interface Descriptor:
    bLength                11
    bDescriptorType        36
    bDescriptorSubtype      2 (FORMAT_TYPE)
    bFormatType             1 (FORMAT_TYPE_I)
    bNrChannels             1
    bSubframeSize           2
    bBitResolution         16
    bSamFreqType            1 Discrete
    tSamFreq[ 0]        48000
  Endpoint Descriptor:
    bLength                 9
    bDescriptorType         5
    bEndpointAddress     0x86  EP 6 IN
    bmAttributes            5
      Transfer Type            Isochronous
      Synch Type               Asynchronous
      Usage Type               Data
    wMaxPacketSize     0x0064  1x 100 bytes
    bInterval               4
    bRefresh                0
    bSynchAddress           0
    AudioStreaming Endpoint Descriptor:
      bLength                 7
      bDescriptorType        37
      bDescriptorSubtype      1 (EP_GENERAL)
      bmAttributes         0x01
        Sampling Frequency
      bLockDelayUnits         0 Undefined
      wLockDelay         0x0000
(snip)

Testing patch provides consistent good sound recording quality and volume range.

(snip)
[   95.473820][ 1] [   T73] usb 5-2.2: new high-speed USB device number 7 using xhci_hcd
[   95.773974][ 1] [   T73] usb 5-2.2: New USB device found, idVendor=1bcf, idProduct=2281, bcdDevice= 0.05
[   95.783445][ 1] [   T73] usb 5-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   95.791872][ 1] [   T73] usb 5-2.2: Product: HD webcam
[   95.797001][ 1] [   T73] usb 5-2.2: Manufacturer: Sunplus IT Co
[   95.802996][ 1] [   T73] usb 5-2.2: SerialNumber: 20200513
[   96.110630][ 3] [ T3680] usbcore: registered new interface driver snd-usb-audio
[   96.114329][ 7] [ T3677] usb 5-2.2: Found UVC 1.00 device HD webcam (1bcf:2281)
[   96.167555][ 7] [ T3677] usbcore: registered new interface driver uvcvideo

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20240719020906.8078-1-wangdich9700@163.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/mixer.c  |    7 +++++++
 sound/usb/quirks.c |    2 ++
 2 files changed, 9 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1211,6 +1211,13 @@ static void volume_control_quirks(struct
 			cval->res = 16;
 		}
 		break;
+	case USB_ID(0x1bcf, 0x2281): /* HD Webcam */
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 16\n");
+			cval->res = 16;
+		}
+		break;
 	}
 }
 
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2185,6 +2185,8 @@ static const struct usb_audio_quirk_flag
 		   QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x534d, 0x2109, /* MacroSilicon MS2109 */
 		   QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */



