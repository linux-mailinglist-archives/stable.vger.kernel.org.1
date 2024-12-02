Return-Path: <stable+bounces-96135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7BD9E095B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5181615BA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687A11D9A42;
	Mon,  2 Dec 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8qzv8x/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F213C8E8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158645; cv=none; b=Whh+3QrWfjdiSHn/f+wXXc9Qdj7yy+zpRRALF12Yr4Rr51rG6HdiG4rq3DJKJl2VbOmkYFgIRiNTICPypYPqGJaVLqCc93R39a6YZPQpgscGEDxCUzN+Hs9DjhfCDR7zs4qaF5IiG+jAiNRzqCF5f6KZvl2DeST7GS2ztRtMGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158645; c=relaxed/simple;
	bh=CurG0neacwyPB7zfAschNwhZRULnFyZedWvH/iFBE2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1rlsI6xCpqUY8Y3Sht15EHvfElYEwxABNAUykJvsYvxIfwbKfLt6PT7UXkNSna7xjfVkHu/98DIB7th69npfaypBf/6TDKiE5lwD9YMch2+9Lo8W62IqMFiQnLyHqHRIMw6B1T//193s+j04AlMMZvNFW53hQ2wb3BghiiokQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8qzv8x/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900FBC4CED6;
	Mon,  2 Dec 2024 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158645;
	bh=CurG0neacwyPB7zfAschNwhZRULnFyZedWvH/iFBE2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8qzv8x/6GybVWv3o1eNoqfjHtGjJzOiuyj/2S5Gg0O0U6kCabQvReTx9RkGSVQF6
	 QO98LMZS5rxn1v19zhxx19cpVranwmb0RBaggv+uLP6u21Zv1bhfsNREN9YxIc9pNo
	 OVIdnf87XkOy+KzkdqneeqpXJy63HAKJDZIHfyEPIwzFLmcaBWa+WdBmfB2B8/ynFp
	 H7U+0MdMt5Jt4HiyLTsEIciuS00JI6+r4aB2Lla4VNIpxa4OZj+U8YHSLGEU8bBIT4
	 a2uJ0cJMa/d3Iir7zbAyaerLU8kD9z9G/QVhynuNyNvbnklUYOzUxBPPSH0OttUgnX
	 1U+RwTz6h1PUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19.y] ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
Date: Mon,  2 Dec 2024 11:57:23 -0500
Message-ID: <20241202102754-c16a2695d76727c8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202131417.2496201-1-bsevens@google.com>
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
4.19.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b909df18ce2a9 ! 1:  8cac602fcdf27 ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
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
| stable/linux-4.19.y       |  Success    |  Success   |

