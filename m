Return-Path: <stable+bounces-104523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B828A9F4FA0
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899E61884624
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7261F758D;
	Tue, 17 Dec 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP8/78+d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A51F7545
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449784; cv=none; b=Dnxdq0qa7nf8noa8AaInWEJrJx5M0Q9jHBM1dOd2O5jHxl86tLA09J/lMh8JX3RRGzDaNVMguqSOUv1b8+DEHq8Cr5abi+BIUO6hGBzBj0qxnMZ6aR6W2SXa1eauLQdRi2mQz+CgPopR9SxwZLhTmMmyDLnO80BJd8bOyUbUcCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449784; c=relaxed/simple;
	bh=L2RdFTWG6oSIyICdaKEs1mwda/kVm1ty5AfAhzU3y2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAzM+OHfMq1ipS/biElvHkSQv6q3RcQIVRisldTgHuruvRD0mrmHKOzUj9A1eyCnL3Lv/kyRFG54tDG6+h7kToBB25/I2kf4RTs+r1QrH2bMMsFvtXpW5Sidqu+iUsRLU7gPoMVNaGCWfAAoKT5617Jyanj/rdLsBM8aNQ5Rx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP8/78+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0238C4CED3;
	Tue, 17 Dec 2024 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449784;
	bh=L2RdFTWG6oSIyICdaKEs1mwda/kVm1ty5AfAhzU3y2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LP8/78+ddxnpxlwh7mEF5NNOO5PuPlnw0RFbXe8j1P7Mbh8v5yaesEhIIHNr9qgA7
	 7UbCyswmn/7oOsjLwT4bMUMDQaUDOpH6tys2NXY0jdXg7a8y37Qxih27ImIcnUP/SP
	 bE93kbMYWfx0F29YJ6id1HQObmeqAVBqU2KCfXYjY5FvB6gyMqPN7DwOlrEUAK7YsY
	 K2hc4a+d5srZE77XT0k8GjISHlmfuUWbzHPMl90KW8KvRHlY7hy+u4GeEkiQdr+ah7
	 77h5g1D17I9cAda+BgdAZB2nG9nSbLKS1WSLinql1pAzm4IeMaeHj0Po2hQg4UYxQl
	 Y9L+xjBkWRQpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y v2] ALSA: usb-audio: Fix a DMA to stack memory bug
Date: Tue, 17 Dec 2024 10:36:22 -0500
Message-Id: <20241217102127-c49d8e467c3f9643@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217131343.763822-1-bsevens@google.com>
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

Found matching upstream commit: f7d306b47a24367302bd4fe846854e07752ffcd9

WARNING: Author mismatch between patch and found commit:
Backport author: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Commit author: Dan Carpenter <dan.carpenter@linaro.org>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 7f1292f8d4d6)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f7d306b47a24 ! 1:  483c2942243f ALSA: usb-audio: Fix a DMA to stack memory bug
    @@ Commit message
         Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
         Link: https://patch.msgid.link/60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain
         Signed-off-by: Takashi Iwai <tiwai@suse.de>
    +    (cherry picked from commit f7d306b47a24367302bd4fe846854e07752ffcd9)
    +    [Benoît: there is no mbox3 suppport and no __free macro in 5.15]
    +    Signed-off-by: Benoît Sevens <bsevens@google.com>
     
      ## sound/usb/quirks.c ##
     @@ sound/usb/quirks.c: int snd_usb_create_quirk(struct snd_usb_audio *chip,
    @@ sound/usb/quirks.c: int snd_usb_create_quirk(struct snd_usb_audio *chip,
      {
      	struct usb_host_config *config = dev->actconfig;
     -	struct usb_device_descriptor new_device_descriptor;
    -+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
    ++	struct usb_device_descriptor *new_device_descriptor = NULL;
      	int err;
      
      	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) == EXTIGY_FIRMWARE_SIZE_OLD ||
    @@ sound/usb/quirks.c: static int snd_usb_extigy_boot_quirk(struct usb_device *dev,
      		else
     -			memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
     +			memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
    ++		kfree(new_device_descriptor);
      		err = usb_reset_configuration(dev);
      		if (err < 0)
      			dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
    @@ sound/usb/quirks.c: static void mbox2_setup_48_24_magic(struct usb_device *dev)
      {
      	struct usb_host_config *config = dev->actconfig;
     -	struct usb_device_descriptor new_device_descriptor;
    -+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
    ++	struct usb_device_descriptor *new_device_descriptor = NULL;
      	int err;
      	u8 bootresponse[0x12];
      	int fwsize;
    @@ sound/usb/quirks.c: static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
      	else
     -		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
     +		memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
    - 
    - 	err = usb_reset_configuration(dev);
    - 	if (err < 0)
    -@@ sound/usb/quirks.c: static void mbox3_setup_defaults(struct usb_device *dev)
    - static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
    - {
    - 	struct usb_host_config *config = dev->actconfig;
    --	struct usb_device_descriptor new_device_descriptor;
    -+	struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
    - 	int err;
    - 	int descriptor_size;
    - 
    -@@ sound/usb/quirks.c: static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
    - 
    - 	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
    - 
    -+	new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
    -+	if (!new_device_descriptor)
    -+		return -ENOMEM;
     +
    - 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
    --		&new_device_descriptor, sizeof(new_device_descriptor));
    -+		new_device_descriptor, sizeof(*new_device_descriptor));
    - 	if (err < 0)
    - 		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
    --	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
    -+	if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
    - 		dev_dbg(&dev->dev, "MBOX3: error too large bNumConfigurations: %d\n",
    --			new_device_descriptor.bNumConfigurations);
    -+			new_device_descriptor->bNumConfigurations);
    - 	else
    --		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
    -+		memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
    ++	kfree(new_device_descriptor);
      
      	err = usb_reset_configuration(dev);
      	if (err < 0)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

