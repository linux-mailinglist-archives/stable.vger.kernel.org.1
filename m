Return-Path: <stable+bounces-196767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A85C81A9B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 17:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2DC34E621C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362FF314B83;
	Mon, 24 Nov 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="eVMzGw+l"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13C2BDC05
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002988; cv=none; b=X+Wkq8OXKucLbdra1u4+EYDnUTKMd7pvc6cyqN/o2Ds2ZAU+C4frYD9agoJY/EYWfuXno+FYgecGJTTN1NUY0PC2ln/j07sxyIB0j0ThXBI6jb8npo97uV7xpAYFStPvtiUw1FrX/QA/WfUENcBcOXP4uxXlNRp+Xnx2iunL1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002988; c=relaxed/simple;
	bh=5q+m+70L8W6/MtJ6J2PXmMYiDdxIy6zTsSH9/gU2w/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogjF32BJDTVKyNQvbVBhVPTNGkxdF1PkN1vPJbWBdpDtHbqImFkBawfyHpKycZ2vAt0Gkr2+VphRHkQHqllY2CxN7KCtqDpyYx4HnRP7W5iyeUEaR7uOuNc90CAwycmZaXG4AemEjTdvbWEfqs5VluGobOREdDx21ujUNIdi27c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=eVMzGw+l; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-882451b353fso32774416d6.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 08:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1764002985; x=1764607785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32HmhasQZgNPGsGzmYAFxW5zQ2p5OywfOicHnjZoIfo=;
        b=eVMzGw+lIe8BpaRm7SNXkhBwUf5p2wiC/6j4zB7TUH6aw68gp9PE3fChtD/wM/Aicy
         pcSDwcOrU0L7dBg2J1jKg9Qxx54gxHoQh7KEd6xJzwd4zI7SMHPGlQuKziB0OXkp96a9
         05hIeXotdEnvpTaGwRR/vIp96xp0XTU393Fv8TAv6s5lPw5RZgwyx+wsTgLtM+MduNju
         hSf8JQ5OmHGP51N580YZl4QH31YGs65Bf/YMcRJzqPydsAF1rbK6tK4K+g1HRUDQdOPO
         K8tONuYzVe9aSwh6QwePWp7EK76LZGZ/Od/e/aVoTOhScOgsNPLoJ63lcI0Fq4tymk5m
         cl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764002985; x=1764607785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32HmhasQZgNPGsGzmYAFxW5zQ2p5OywfOicHnjZoIfo=;
        b=XBi2EAsxAY5A2NFcFgWzTBogxLWUcBmaiGN7qmBKkHr2fH3Ux/2g7c0rt0KzG3gYBo
         CnmLZzHc4TYp47/T6g172IujZl1lMHnKUG+ozb+Ji8+fIwVUJY1DGwmQ7na2hnflCV3K
         0cWYTp/j7URJ523lpPFF63zvkAOEYRZMN6ZtrM/6Ex0NOj37nnEq64Dbz76Owsd7/D39
         xZ8iTIqD7spxgt3vjOQHN7FX5RB4hKoySnomeGgEJNyVxowfbDO3FYqqjIwkVQurElLg
         FwWokqj+1akunfV4p1zX9HTI2V6gf6HAvbZ5VbqTIsY7Ytk57L4ViABpgIhyl2u10TEB
         DNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYacDvXKQBPSd/0FehkxHG4vessD/mzUwgUe6KMC++ToNpgIwPjc15zX6r/01osSq4FFG3V5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcj574yqhfSZVfKZTiHReSNfLw4pBwreMxOE6ziz8VfOdqjpY
	xTqQT8u19a0LIptCYgpfFWg+c014YVk0IyluJ3vpGOv+YZaRX4KgMfipuVCk7BAdAg==
X-Gm-Gg: ASbGncttT0hSRtcTrsOfc3IvBDUEKBbcJAOiYxLzUAhjra9wGME1Fujxv3kwYAxULJ/
	rVEqgT6D9UtMCdscWcvEn5N0HZBeCfBRpKyuIcuYX8G6XRXSZ0gcYhD4+4ew1gncebIoeT6dk/9
	RjpmFV9h7jlsLE1jz8qoW8Cc3kr5DT0PCRFRyKqYPnfV9KogKuGoialNw9EBQrgNdhjGT8EZiAh
	E9Kzc1LahlNy5RTO5IKMf5VGvlXNKLyZfUH+7mnbxBU0GT14qm8C0NyDxuz957i4TuPmX8P8LIA
	MZfKMK/DZwyrYgj9o0ZNOBoqGpeHllm/b2YE8ybhry9mCs02A9a9+kiIqnubeLxfvMBIPhLR8r/
	wRux0mNyxVSKoyOQ7YZLLnRuxOXhev8ezCmJ8+w5ydyW2WZgDSf1ENHuHnasiH6wjQHut/UU6Sp
	VpB7HnKsMCNFXO
X-Google-Smtp-Source: AGHT+IHocwxdXpk5RDYixJT4zq5tyh6blA48vmJIcPgVQzo441r/3lc83iLf5nSVxOzoet7kQOBP2A==
X-Received: by 2002:a05:6214:19c5:b0:882:3ecd:20ec with SMTP id 6a1803df08f44-8847c57a6c3mr180093406d6.60.1764002985111;
        Mon, 24 Nov 2025 08:49:45 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::eaae])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54c32csm103250496d6.37.2025.11.24.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:49:44 -0800 (PST)
Date: Mon, 24 Nov 2025 11:49:41 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Antoine Jacquet <royale@zerezo.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	lvc-project@linuxtesting.org,
	syzbot+0335df380edd9bd3ff70@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dvb-usb: dtv5100: rewrite i2c message usb_control
 send/recv
Message-ID: <1097a93c-89d7-49e1-9b36-3fb9e51ede54@rowland.harvard.edu>
References: <20251121132332.3983185-1-Sergey.Nalivayko@kaspersky.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121132332.3983185-1-Sergey.Nalivayko@kaspersky.com>

On Fri, Nov 21, 2025 at 04:23:31PM +0300, Nalivayko Sergey wrote:
> syzbot reports a WARNING issue as below:
> 
> usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType c0
> WARNING: CPU: 0 PID: 5833 at drivers/usb/core/urb.c:413 usb_submit_urb+0x1112/0x1870 drivers/usb/core/urb.c:411

...

> The issue occurs due to insufficient validation of data passed to the USB API.
> In the current implementation, the dtv5100 driver expects two I2C non-zero 
> length messages for a combined write/read request. However, when 
> only a single message is provided, the driver incorrectly processes message
> of size 1, passing a read data size of zero to the dtv5100_i2c_msg function.

Then why not fix the validation instead of trying to cope with invalid 
data in dtv5100_i2c_msg()?

> When usb_control_msg() is called with a PIPEOUT type and a read length of
> zero, a mismatch error occurs between the operation type and the expected
> transfer direction in function usb_submit_urb. This is the trigger
> for warning.
> 
> Replace usb_control_msg() with usb_control_msg_recv() and
> usb_control_msg_send() to rely on the USB API for proper validation and
> prevent inconsistencies in the future.

The reason those two functions were created was to simplify the calling 
sequence by removing the need for callers to allocate temporary buffers 
-- not to do any extra validation.  That reason don't seem to apply in 
this case.

It seems like there would be no need to change dtv5100_i2c_msg() at all 
if its inputs were properly vetted.  Am I missing something?

Alan Stern

