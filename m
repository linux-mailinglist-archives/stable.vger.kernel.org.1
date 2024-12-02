Return-Path: <stable+bounces-96136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004D9E095C
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F981683DC
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F3A1D9592;
	Mon,  2 Dec 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEKC+vc6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9513C8E8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158648; cv=none; b=UZ9VU2p6CnPQ9lptTcwNFsC1XULmxWp8gQ8nJzxjuG7jAGNBUJTwWG/ErhQxE4ikYXdxha9aZffMQWXteY6v6HMbl1r0DOuGQ8t4hLj/u3kGn+mLoqrk9ewMgySv8eN8gpULTJqO33U3lEXEU7XMy6m2xHD/EvYXKK4Q1yrnJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158648; c=relaxed/simple;
	bh=MlLWYloo5hnIGAlyI1UsiDhAQg6VuK4fX5LmyeOireM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erGrfJNa+zaPFjt88UvB/IdA8gRVAEKoriV5DHE/4HSMH4ieZbFbK+tM+/4ldkQQSSZ/08KV8g56vVPzu9yRauPUnL6f7E9amgYjaa28pnNRTeD7A6d1qnWGSM6p88+fxlMf7P2xINLXb7S6mQHBuhJ8suhLiAX/9I+pJ3lpOMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEKC+vc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E877C4CED1;
	Mon,  2 Dec 2024 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158647;
	bh=MlLWYloo5hnIGAlyI1UsiDhAQg6VuK4fX5LmyeOireM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEKC+vc6AvJgatsoI+e37xtU1P/5f4a0RybKFsWNFlUXvPrRKNs7twvrjsy3pJEmM
	 QWQiFqoHXDapkhgbyOTAjJkr/OUXILVdOGoj+sSHteaf7UffbjDkZ7de4UVj4c1BVb
	 86XiRhNcIIogIaPJ//sRqf33o37lW5vaJbsD5FGhf9eGXOOLF2NlfTFYyntp16r8vY
	 qaUoU18dPirf/EgQh5tNE2pfqQqF9eBx67Hu3aYJjmnRIuC+r8rkFYPLPE96+InYNk
	 lwqDT8CEkhKTzsQfH0zcY5bwALexLoZNJoek/7alQ2ZH7Yf0Dp+fv7TSyPu2AwOXNp
	 eMqGP9XJ189XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
Date: Mon,  2 Dec 2024 11:57:25 -0500
Message-ID: <20241202111035-077ebb246a8e1256@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202121546.2369555-1-bsevens@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  b909df18ce2a9 ! 1:  1b0dc2e079fb8 ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
    @@ Commit message
         This can lead to out-of-bounds accesses later, e.g. in
         usb_destroy_configuration.
     
    -    Signed-off-by: Benoît Sevens <bsevens@google.com>
         Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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
    +@@ sound/usb/quirks.c: static void mbox3_setup_48_24_magic(struct usb_device *dev)
      static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
      {
      	struct usb_host_config *config = dev->actconfig;
    @@ sound/usb/quirks.c: static void mbox3_setup_defaults(struct usb_device *dev)
      	int descriptor_size;
      
     @@ sound/usb/quirks.c: static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
    - 	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
    + 	dev_dbg(&dev->dev, "device initialised!\n");
      
      	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
     -		&dev->descriptor, sizeof(dev->descriptor));
     -	config = dev->actconfig;
     +		&new_device_descriptor, sizeof(new_device_descriptor));
      	if (err < 0)
    - 		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
    + 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
     +	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
    -+		dev_dbg(&dev->dev, "MBOX3: error too large bNumConfigurations: %d\n",
    ++		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
     +			new_device_descriptor.bNumConfigurations);
     +	else
     +		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

