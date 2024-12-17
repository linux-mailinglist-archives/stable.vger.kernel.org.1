Return-Path: <stable+bounces-104522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E719F4F9B
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51C316894D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6C1F76A0;
	Tue, 17 Dec 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQrLydME"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F571F755A
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449782; cv=none; b=OAw/qnLk07FrrCETtzvl6falYfZ18aT2MrJ2E+I2/0TrMFOTMp6H60p+nbwHtJfg0KBqQcGiEhgChb+fGAOwAXYHrNKUejAt/VekGPto2cZtyQPxR49holEJ1n/NauknhIifXbRFGYN0b0XcIuSApHGFlX1e0um4e0wpZIeiwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449782; c=relaxed/simple;
	bh=1o6n8uF0al/bnaX904Llid3Y7ZQgRCfcVfi9gOUbgc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmR3Q6z2ZC9WhCBl9q+QVbXe5QDH7tIslDEv2hiQdA3KCFACMYgjzV3rezRKLkR6pWlaBivzDI1DAIL8ScHoCWXb3bvvchM8ML0Y3z+hNLg2o9wPOZQCMDAdMBR96Szir5XNJOtNdIwp/5N44TYUP70VhcCOcBvEFnJUjI5i/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQrLydME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90227C4CED3;
	Tue, 17 Dec 2024 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449782;
	bh=1o6n8uF0al/bnaX904Llid3Y7ZQgRCfcVfi9gOUbgc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQrLydMEUUBYoEdlaeSW4L7MabpTggkqVeoka8NQPGgWEZVg5ga/59f8ljlz2JEqH
	 j8W/w0iTDSxZu2ZRtDg4wA8sgeIpafL5/bhCqE8XkluG5Ida0NY067vOlp0t3QMrZO
	 JJ5lXGTeG4SRqp6GW3eDEfZ6u370Xj+cHuv+xJaYiE5GCgXz82ju6/cjjP47Kjtb9w
	 nrJhqOp7kgZ34/BEq7NdLDVRm5Vd+TQutTzgoRu0xrGvFUR7QA4BY8Z8WMeMyoTxRP
	 jVD1HXagfMXbujpmeAkPqq8BmBmYHlG46Gk/OO+nGHi/oVTm6QFrUtlsySkqJAVYI5
	 Dpd4wjpbPs/7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ALSA: usb-audio: Fix a DMA to stack memory bug
Date: Tue, 17 Dec 2024 10:36:20 -0500
Message-Id: <20241217101729-bf0881835db108d6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217123933.732180-1-bsevens@google.com>
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
1:  f7d306b47a24 ! 1:  c80406b311f1 ALSA: usb-audio: Fix a DMA to stack memory bug
    @@ Commit message
         Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
         Link: https://patch.msgid.link/60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain
         Signed-off-by: Takashi Iwai <tiwai@suse.de>
    +    (cherry picked from commit f7d306b47a24367302bd4fe846854e07752ffcd9)
    +    [Benoît: there is no mbox3 suppport and no __free macro in 5.15]
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
    -+
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
    - 
    - 	err = usb_reset_configuration(dev);
    - 	if (err < 0)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.15.y:
    sound/usb/quirks.c: In function 'snd_usb_extigy_boot_quirk':
    sound/usb/quirks.c:594:61: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__free'
      594 |         struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
          |                                                             ^~~~~~
    sound/usb/quirks.c:594:61: error: implicit declaration of function '__free'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
      594 |         struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
          |                                                             ^~~~~~
          |                                                             kvfree
    sound/usb/quirks.c:594:75: error: lvalue required as left operand of assignment
      594 |         struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
          |                                                                           ^
    sound/usb/quirks.c:595:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      595 |         int err;
          |         ^~~
    sound/usb/quirks.c:606:17: error: 'new_device_descriptor' undeclared (first use in this function); did you mean 'usb_device_descriptor'?
      606 |                 new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
          |                 ^~~~~~~~~~~~~~~~~~~~~
          |                 usb_device_descriptor
    sound/usb/quirks.c:606:17: note: each undeclared identifier is reported only once for each function it appears in
    sound/usb/quirks.c: In function 'snd_usb_mbox2_boot_quirk':
    sound/usb/quirks.c:949:61: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__free'
      949 |         struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
          |                                                             ^~~~~~
    sound/usb/quirks.c:949:75: error: lvalue required as left operand of assignment
      949 |         struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
          |                                                                           ^
    sound/usb/quirks.c:950:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      950 |         int err;
          |         ^~~
    sound/usb/quirks.c:984:9: error: 'new_device_descriptor' undeclared (first use in this function); did you mean 'usb_device_descriptor'?
      984 |         new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
          |         ^~~~~~~~~~~~~~~~~~~~~
          |         usb_device_descriptor
    cc1: some warnings being treated as errors
    make[2]: *** [scripts/Makefile.build:289: sound/usb/quirks.o] Error 1
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:552: sound/usb] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1906: sound] Error 2
    make: Target '__all' not remade because of errors.

