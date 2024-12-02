Return-Path: <stable+bounces-96128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FA49E0953
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B0D161F1F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3227F1D95A3;
	Mon,  2 Dec 2024 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1M1DuO4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA713C8E8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158631; cv=none; b=qu7pz/HFPXji+t1RnqdGfq7SZ7dWGpZpo3FCRybeGfzwsB7lfFEGPdBL0LBtsi6E872Ebrurb6s02BducNw2ZXhz4YEMFHn/NZyRHbyWw+H42+IbU1excdCGlGVRZvhs1gJ+w1v+Im1g23g+jtQPaXNe5SKihJi7WCfRU+d6Iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158631; c=relaxed/simple;
	bh=3i3i2hIJCOlRQpSGUMZELlBhc1GbdxeJFJWLNwZD644=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDAHuJQmRdjLrpJnCEzjFZ0lu+c8g2xD0nulo6NYTAG3tB1kv08WktEm1FN81JlJOgE4rIgAVutRgSRwr/txw7ZAdrbhIKQM0HobZggnY0GNJZWWng/XcDT8UivkIvIjbh9ynHTc4TFTvn1EBa+F5tFT/y5BWSNwhbi/vQ6GUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1M1DuO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50369C4CED1;
	Mon,  2 Dec 2024 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158630;
	bh=3i3i2hIJCOlRQpSGUMZELlBhc1GbdxeJFJWLNwZD644=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1M1DuO4u7E0ypZo+5thncXYB2V3cF/8zNwk9ZCqe9TYaJCEbSbO2zPXAeAr6P1pn
	 nLmxkNN4xYkLvoRvLxM7UAq5exPW+faLP3SPyq68WNarokb/aOumV0LDX5sPv7Y4Jn
	 ClOwJa6vXahAhXLRvcqhzRuqTqvIVQ1K0v6wfZTcP8ga8PHWXIZITqygc7FxiFMGaT
	 pT0c/9oQtkHLdhnPcXGfYwH7QY/1ahUNjwKYT6Grnp7StuQNsbroMLjaAf/ZYQnK/w
	 38ORb0IF0p1m1HqH+sXQ6UzzGDNZPYt2Kuye1s8jdvKJCkTaHbgpLXnzI0J0Qi4Zo6
	 i/GjMk3BNp+Fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
Date: Mon,  2 Dec 2024 11:57:08 -0500
Message-ID: <20241202105943-527c3cb524056944@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202123900.2397922-1-bsevens@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: b909df18ce2a998afef81d58bbd1a05dc0788c40


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b909df18ce2a9 ! 1:  45794b0e36471 ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
    @@ Commit message
         Cc: stable@kernel.org
         Link: https://patch.msgid.link/20241120124144.3814457-1-bsevens@google.com
         Signed-off-by: Takashi Iwai <tiwai@suse.de>
    +    (cherry picked from commit b909df18ce2a998afef81d58bbd1a05dc0788c40)
    +    Signed-off-by: Benoît Sevens <bsevens@google.com>
     
      ## sound/usb/quirks.c ##
     @@ sound/usb/quirks.c: int snd_usb_create_quirk(struct snd_usb_audio *chip,
    @@ sound/usb/quirks.c: static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
      
      	err = usb_reset_configuration(dev);
      	if (err < 0)
    -@@ sound/usb/quirks.c: static void mbox3_setup_defaults(struct usb_device *dev)
    - static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
    - {
    - 	struct usb_host_config *config = dev->actconfig;
    -+	struct usb_device_descriptor new_device_descriptor;
    - 	int err;
    - 	int descriptor_size;
    +@@ sound/usb/quirks.c: static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
    + 	return 0;
    + }
      
    -@@ sound/usb/quirks.c: static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
    - 	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
    +-
    + #define MICROBOOK_BUF_SIZE 128
      
    - 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
    --		&dev->descriptor, sizeof(dev->descriptor));
    --	config = dev->actconfig;
    -+		&new_device_descriptor, sizeof(new_device_descriptor));
    - 	if (err < 0)
    - 		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
    -+	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
    -+		dev_dbg(&dev->dev, "MBOX3: error too large bNumConfigurations: %d\n",
    -+			new_device_descriptor.bNumConfigurations);
    -+	else
    -+		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
    - 
    - 	err = usb_reset_configuration(dev);
    - 	if (err < 0)
    + static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

