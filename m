Return-Path: <stable+bounces-96134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD509E0B5E
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1257CB60E0A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78E51DA31F;
	Mon,  2 Dec 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGlYvSyO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5518A6B8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158643; cv=none; b=TlPPeCNKAYttc2osf7jmikSed+FXfDh7adHXjsBv5YTwPpohJbbC+ZllvS0g4b3YKMWHb7vGyFLpoo2XRQH1TYHoVgUURNiC9KC/+DnN+s7tDJGjlSgDvg9U2EIhoR9ntrFzKE3fuCvLfIwZJEYj2nIBsenN1zJVgu4atM68OYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158643; c=relaxed/simple;
	bh=neKYMfrpNpBUqoLyDJjB8lEOfUKNoZUFaKUxleYHkX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itifuFL0GwWFZ9OzDxG6HwxQn+/jnIuG2x/8tBh+R2GzayVHnBPvlymCnN8YRb7+M3qv5giG+ZkyBcssEYUo8hSbYluxX1DxuSBoRGR7FfIrlZp50pgiBlinWHHp6ruNBpRcpVT4eKa5kqnuUbQIUJ399etCmeJIT3hZHVM8xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGlYvSyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73849C4CED9;
	Mon,  2 Dec 2024 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158642;
	bh=neKYMfrpNpBUqoLyDJjB8lEOfUKNoZUFaKUxleYHkX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGlYvSyOpigIiEYSu3ucJGIxq3asDRJNJmVuL9kzoq1qaLbP8iX0T/9HGHM/WzUCA
	 VqrTYhZWCUYTTNxevaVEsDl8R8j9r8q1qycWr3/WauZPTPP7qxMlHFZad1ZDOieUGz
	 8ougBK8+oOSUCw3C8XQ13q/hY7TUeqAVgLTP0MoLBApg0SlFb4e/+Zq3A16D1gmIu/
	 +W5GNDxpMuIdqoygQD90W+okEHprpMKfBxThwwuBNnF9NPMASziU3haF8pb5Z98ASQ
	 DTU7S8TGWxdJgm9thPcJRHx33XPhZVrn4KvSLI6WFzdDzvoMiOByADyyskr6U+GyDM
	 2q43AGJFyNaVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
Date: Mon,  2 Dec 2024 11:57:21 -0500
Message-ID: <20241202102240-31cc940ea30775da@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202130917.2486019-1-bsevens@google.com>
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
5.10.y | Not found
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b909df18ce2a9 ! 1:  0b77f74c2156e ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
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
    - 
    -@@ sound/usb/quirks.c: static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
    - 	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
    - 
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

