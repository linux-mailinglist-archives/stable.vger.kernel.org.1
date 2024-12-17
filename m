Return-Path: <stable+bounces-104490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF49F4B57
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AE97A2911
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5281F37D7;
	Tue, 17 Dec 2024 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RE91eYSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF921F2360
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440138; cv=none; b=Dv91gMcbPcuZVm/gnaCtGxim8ge0W86qxhp3gYxvbB1fTHLcRPFlLk3hpzQmArU8YG2vgeZUIfZSWQR/wL0rEQE04Pc9BP+hjqvr3Kn7CPLvqgQLmvXauaDXGed/YIZa1bETLNtG1S8aysNgXeHocCS2MrkJYtUyYZNwLY2HzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440138; c=relaxed/simple;
	bh=SaIvQE/6CtnRkNGkR/hrYCuo6XwvvflX8NcXqM/a8p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEGIdc7I+x05jv3yeetreprtZQTOmze91dx7mjYUVPBXYDvYwCMY15kl7KcH2PYkpiHcWU/aIpMPLbQtuEnIoc6G/YuV8zDXwRhpyF/9vrt/+Dl1o6e0tZA3aZTYuJ4fSUkpoooFgS33LizjZBctY+4QR47AY1PsqydyXbn9NyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RE91eYSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D06C4CED3;
	Tue, 17 Dec 2024 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440138;
	bh=SaIvQE/6CtnRkNGkR/hrYCuo6XwvvflX8NcXqM/a8p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RE91eYSoJnp78gfo0O+qWaFiNiqcRq4IM+Uv39vfPBxT4Lr/ErjM90m2bchYwsoMr
	 dbngtHEbVq5y8gfgR9PdxATbGesWpU8QdsUnVKdWoQXEOQPJUGdbAvNeDWXrW+0WO5
	 Eqf44bzfSqPdsc6Cb6/yyYeSZNHHTCjCy41HrO+VT0dCUz0AyxlDRDx+ms5TEuk/Y+
	 eziGn0e+SW5NXJHPj7h+LIVq01L9sp+jnyXF+vuWJ+tJiC+gtBzd25NPePG6r/s6Yy
	 aqp0zNsfend88swQ10wnImnrlYW3CwOGzcNXhV8G/Rat0wV6v0Hk4khq9IsYoiiDJY
	 AveBtA2SOKTTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] ALSA: usb-audio: Fix a DMA to stack memory bug
Date: Tue, 17 Dec 2024 07:55:36 -0500
Message-Id: <20241217074127-0bfa41d9096d0a10@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217115858.688737-1-bsevens@google.com>
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

Note: The patch differs from the upstream commit:
---
1:  f7d306b47a24 ! 1:  5164cdff6b91 ALSA: usb-audio: Fix a DMA to stack memory bug
    @@ Commit message
         Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
         Link: https://patch.msgid.link/60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain
         Signed-off-by: Takashi Iwai <tiwai@suse.de>
    +    (cherry picked from commit f7d306b47a24367302bd4fe846854e07752ffcd9)
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
| stable/linux-6.6.y        |  Success    |  Success   |

