Return-Path: <stable+bounces-96132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 148099E0B31
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD19BB471BB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD871D9A60;
	Mon,  2 Dec 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZYRvVgS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB41D79BE
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158639; cv=none; b=OBTbnXQ381onXWS3Kd4qpWhg2fOlXa0hJfQYnRVIYQQkRLWveAfzrv9m4gXUjf/avHVQKQq/9FXE+dDsLKqngzSK29tiHSDUgeMGS7Kv6M600b2FN1nPduN1SMTI3ZEDdd3fVt1b5QgXRJJou4+oMc1xRsAnfetIE7wBfTBznDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158639; c=relaxed/simple;
	bh=D5giJKW+DbgYWJrsncVZiFMVnlhu3N8VFjr8CzYomk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enmBt/NIe/Quuqrabl5w3HoB+zV9SB02lYRSlkSbxGKVsBKZWHJgOTVrwRDv/0kDULxHRyFQBngLEWCsM5ItoB3R7daQwh5MUlnhpa0f89Qaxeg0zu4nhEd6y82nUBgIUpojG8Br/fWa8X4WzwxsflXl8hLHwUl/S6pZA455v/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZYRvVgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB22C4CED2;
	Mon,  2 Dec 2024 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158638;
	bh=D5giJKW+DbgYWJrsncVZiFMVnlhu3N8VFjr8CzYomk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZYRvVgSsFBMvEkfvg/fE9N3Xt+W6C3URe+BGbc6Kg3drhW30olSyVgAF52hN8YaV
	 b2nenL3e8qeatfKSzRpVsfSpY8lqIY3M7B21aBBPGT2rCcGTAk45QQ0yVEsdlD6yEm
	 JZeOGht3Vng7uq7m2PLjmxjej4D2mpvWgwykZ64GPSI7MzAWd8/4Xonv9enYgRXSKs
	 TCBl7Y+W6kFOWZBwdd1xtQBg2fz5rif8NZXmIhvp6Et6kT2jZ/exXI9So66nRTD1kn
	 13V6eg73Lw7xCIUroQIeqvKxsvVDN7snHJSVy1FWc6FupDvtSi2jOeaREb44DMqasK
	 EpmNTwHhpfbOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
Date: Mon,  2 Dec 2024 11:57:17 -0500
Message-ID: <20241202103538-766eb716ba873293@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202130605.2475446-1-bsevens@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  b909df18ce2a9 ! 1:  60d67a01d849c ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
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
| stable/linux-5.10.y       |  Success    |  Success   |

