Return-Path: <stable+bounces-96137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313309E095A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDF6168458
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73841D9A5F;
	Mon,  2 Dec 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct4IodZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC61D9A5D
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158649; cv=none; b=Dtj+7YyTbYbyfolYPpmqeaWDeFlreLfNpuKxRxdL4yfvFH7sIRTIbc9atcTRpG6+01vTp7hNgaD/KAZUlV1FbyRhvnt7AJ0NRGE6CnRSZb+3Za3DykjMu2oBZpAGcmWgpjHNpVrwh59vZFhy0OCboZ3HqcHmqmT/amlTveg/xQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158649; c=relaxed/simple;
	bh=nqtl8ltdwQSmbiMa6y0faqEoYUS0bP/4yMHu0vuYE/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSt3Xvb0atDFSfMlkv0Zu9CpqrS/CKzP1Ofk8A2F0lLqiBTVw4DsA47mv5h5wnutFUTGyszVvxxfdiGOZl8cpE245KOV4R1QukpXwGSOwzSMbhHzf71faCvDjv+Ah3abNyGHwUlSDkjmyjEuGCpT66+15Tt/ffROKO6iH5vPpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct4IodZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D300C4CED2;
	Mon,  2 Dec 2024 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158649;
	bh=nqtl8ltdwQSmbiMa6y0faqEoYUS0bP/4yMHu0vuYE/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ct4IodZHs9sgEdVTwWZSeLAChJ8fHCfsMv88Yb9nQOz+1I4PNzGw9WLbnosAQ7Zrd
	 oISom1SxO++Khzjobs2Y7nRiUGnsZYhhjOh5LzMv51GAnkDE2WTGxBHH3OrdF0EaB0
	 aI85tCy2JaAnzZ9yPOh/vem+eEtZrWt4M6dkvIRiaJFATYTEFTqpT7/XzzTd7h/q38
	 G9QVsF/Ved4W9De4zJwkU+4F9J1A+6lFTKUArXgzvBDQEg6n4UmFs3bDZCJK1AMaMA
	 DVDeY57E+h6zsufGO//unjtdDPwPGUDIlrC/1wuE+HzRIwpVydwaztb7TtvK0rcaSX
	 vuo/nCFajHcUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
Date: Mon,  2 Dec 2024 11:57:27 -0500
Message-ID: <20241202101654-c772f9e3cfca0408@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202122659.2387604-1-bsevens@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  b909df18ce2a9 ! 1:  3ff25a47e0cd2 ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
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
| stable/linux-6.1.y        |  Success    |  Success   |

