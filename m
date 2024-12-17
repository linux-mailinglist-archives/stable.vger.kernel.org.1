Return-Path: <stable+bounces-104491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A349F4B58
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F94F7A2A72
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81EA1F37DE;
	Tue, 17 Dec 2024 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFIBx3wb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772EF1F131A
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440140; cv=none; b=YI5LgNpFMBnSIbcB8uK3t8EIPEj5lS5kDsIFR4ZuXQRRrSQJ6e/EECuq+M3yu4U196WeB6tCozutvwGgUXa6kqv40PSztBsCkHkjtARoenYH2UwwoQ0aY7PZVnPZu7HJGmF7qPpnst1m/fYMX/H1Wx1UKQxIIJTStHT6grU/bU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440140; c=relaxed/simple;
	bh=EUR2lw1K1v+pAOyuB+RwKdvAOHh/w/Pzc8C5oPHS6EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2JNbwqFYagwRxKY8OadTsqntTyxT9C1OqS94Ng7GNEhGvx29H667mYLIfaocVdGeTUSxvwjvdFmWk+uilqMyyBJ/RqgfauGZREIwO0cLi8LcJDJsj6YXUx687Ll1TDcOG/xw2lBhBspUXWJORlzK5YYRwTWVPTTKAFuEKDCqtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFIBx3wb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D07C4CED3;
	Tue, 17 Dec 2024 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440140;
	bh=EUR2lw1K1v+pAOyuB+RwKdvAOHh/w/Pzc8C5oPHS6EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFIBx3wbAtiZo8flDostqx7eOP4jbvZxI1iqOp2ZX2W2AbkyZmrAX5t3GYy3ciPRs
	 FfkWQcC+EaJalKx1GJslHAAPnZuOg0ZeP0i3iTwegTDbgTKptVSD7yLSFtlL6yZhae
	 XD1GK2/1+4zh5JrYZb9XCQe/z4eGtuubSpGy0ZYeCqaMYXAs0kHa3jdL46j3vmQN77
	 CtAECngxF51kGXhhC2/LsI5MQi2b90eaHuqrHXHxBqEl2IwjbkIICALA81NSxvvYnB
	 lI2IUd2B9HSy6yywWcwd0480QhHWaTLYmZj9dv/lLz4Lk07gl00WmtzY7ABS+Jb7vg
	 q+oGnPVytRCnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ALSA: usb-audio: Fix a DMA to stack memory bug
Date: Tue, 17 Dec 2024 07:55:38 -0500
Message-Id: <20241217073727-eaff937ebfe124cf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217121141.705217-1-bsevens@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  f7d306b47a24 ! 1:  4deadc91ddb0 ALSA: usb-audio: Fix a DMA to stack memory bug
    @@ Commit message
         Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
         Link: https://patch.msgid.link/60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain
         Signed-off-by: Takashi Iwai <tiwai@suse.de>
    +    (cherry picked from commit f7d306b47a24367302bd4fe846854e07752ffcd9)
    +    [Benoît: backport for changed error message format]
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
      
     @@ sound/usb/quirks.c: static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
      
    - 	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
    + 	dev_dbg(&dev->dev, "device initialised!\n");
      
     +	new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
     +	if (!new_device_descriptor)
    @@ sound/usb/quirks.c: static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
     -		&new_device_descriptor, sizeof(new_device_descriptor));
     +		new_device_descriptor, sizeof(*new_device_descriptor));
      	if (err < 0)
    - 		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
    + 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
     -	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
     +	if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
    - 		dev_dbg(&dev->dev, "MBOX3: error too large bNumConfigurations: %d\n",
    + 		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
     -			new_device_descriptor.bNumConfigurations);
     +			new_device_descriptor->bNumConfigurations);
      	else
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

