Return-Path: <stable+bounces-240576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJGeHAgo62mPJQAAu9opvQ
	(envelope-from <stable+bounces-240576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:21:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1D45B5C1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEF2730039A8
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC853318EC7;
	Fri, 24 Apr 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0Eji6hN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A993112D0
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018882; cv=pass; b=XajNmq48ElS+IDyd4nuJ963wBLL+FDQyH7i4Nmm2GiNCT2wNWxjzgm5h33v372nwm8Gcji7sGiW6lEMxtz2EY/vHw+cPuUR6U4BDfYNIL6ROyi+VFungjIFZrerbVBnX9iAi+N+9piyciEx8MXyt+OsXjrsGTiMPKErd7Eo3O+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018882; c=relaxed/simple;
	bh=EkxhpX3dsWvMyJ8rGVJ+AKSKNmbgPJbUvzxlbNzy9k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POiZviQkWVPcHdIIqNFysnrypNVSJKxSaXmAci/kJ2Pe7h5kXWn/0jPUDLfiRbombRtBcAjysn+0eQSUvSVUCYeVrWxxcII3olU4CMOc/j29r2RzD0g3NZZCxhBTbXyFW1iGF0w1P16qO0cnQj3TRukFJOz1i9KxTzTdAUV9zVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0Eji6hN; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64eb84d1e37so6189069d50.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018880; cv=none;
        d=google.com; s=arc-20240605;
        b=UGmjlBgL0GpJtgP6UDqy9P5eme8wSwmPVVUJzrEU3JaAeOqAtTL+3vtFWukLqbuN4O
         76rCHc7Tk4smxMMBJIjU+nZx3wiCnf81pJzOp+z4IQVlJUzIydVH4UUMAU8981TFTemo
         3nUv2TYKlN/myKyWmOqWpcmXFu6Rw/YEEWupQiDVovhqMWqfsVLN6JkHr02dgwJDCVey
         yFGpcU74WRyEdkGW6zcruH4pO3QUIYm3haAQEAwA654tCVpw2c4cfq5WGOgeMXaI3sxh
         It8JKIt+0x0/t4bRCNxMUWVY8x8rF4zA+rp2nrADzAyRvpPfQ9fg6FuhD5MnXZvTEcD4
         0DMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6euPSUC2VLFGi/47245dCgRHHrkyFRpNBSjWLyGCoNY=;
        fh=AZC9kE6Vvcj7Sdn/EwzF/QmgRvx73y3bYVzugHESMsM=;
        b=BFHMfIiYj8wym45MP5hd6Ds/mzT6DoQPlP8v2P7GqAeFsPzZU+M7FPdj8FBjvJ+qZT
         BNXuMQibYL7RxKmjsYeM/5w0QGGRdnZ0U2e0kG690CvM+rgnHPnPSlHiX67+RSdG8rTm
         OmR6myIOMcOcDh9Ex7jLUj+oOHgL45biMVNisfw9nkanuyD5jOw4ESIdq64O1sRKu4eW
         2bPVBg9cFEqUoooC2KmMTcTQvzQlGT2FH7mRQyU/fnekQRiLAXxIwuTllubQR1gTjuTK
         lbx3V5lZK5UwiAwo7K0WzGMyWTGZoXfWAFucDTZiVv335+ysoIvKhRVguo6Tx7y0gvzd
         gSTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018880; x=1777623680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6euPSUC2VLFGi/47245dCgRHHrkyFRpNBSjWLyGCoNY=;
        b=q0Eji6hNh4IRrZvhRR43EGQuc8z+SIbj/NB2oVIOFho7KtuNyC24mYTfmqyvJgG0Br
         GxdFZLB3FldW1oKRT73zP4Lt5RSyZvTDBhydzB61fVNtAQeds70Epf6ZAU7jxIW/c5D+
         KsXcDjDGvh4kzIQWCURXD5avKt0uifbuXM1HVKBxuxa6bl5nUO7RP9OKSk/G8DIwVw0k
         RaYT1OG7rKsfRwlUhotDih+Bf4BC2gRmNvu/sp6sRJjtJfaLYVbZ9fUAXX2Eo/7s8JOC
         iE7WQRRStbUXYTr7O3jTckyBl0sYUjmOGxM0HOmnWDUgm+D1xLBypVxhofsM1o0IghyP
         3Hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018880; x=1777623680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6euPSUC2VLFGi/47245dCgRHHrkyFRpNBSjWLyGCoNY=;
        b=W7L5u4adK6Ew8m6X5pdt46tHx7d4FfocwOjlspLJpMItm6hIc/6fBMyb9OiGlCU7Jn
         W9YihRCxkr/PDfMtlWr6lP1DsQw9PEEeCBWCX8TXH4SyKM4IHva+qnckCzsuz+/KtxHp
         ovqDNZ0RwZNEbQL8ePQGxjCxsXlM4eZoZzAh8oY07BtA/pmk1iNDs2acHQZkLHJbrBIa
         n5NA5GGA1GUJzfrZliqGbZ5T2OVwrbRudwEATHeoD88qOzs8R0ph/P0SFOQpXmjQqM1p
         Ex+y8bpw6avAKmWw+fF0ulWHxpmZmp+7m/ZDCHuxWepsQune+Y6D6KJhXTEZSn3h/dAf
         kHPA==
X-Forwarded-Encrypted: i=1; AFNElJ+rDrp0ZqvBbf5xhYUfBvhJxb52+aj1HW9xnWfz3kOjIVlvtKsuDo10Tx7QNo+oQjLHfCG9CUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtFZtCs4WLkjsBXTWa1WsVttGduBK6ZHc9ZEoJxHjWixr+WEr
	UUgyHVN+WtXhJsbnn/iXQ04vhWIGrXGjHT0Z5IGwmRoada3wCnk6CdI+wgmaBSBAuBuNIU4ar+6
	QhoaD8K34mI2XUx9le+rNU29IAD8B8zQ=
X-Gm-Gg: AeBDiesnTRZGRdMqTm7eqMy56hRtjWcc37ZLQDY9oFiNReyQw5p5ufz+f5ZXppZxVfe
	j8KJD4/JmhetGsiaK5r6D37Jkp88m+lRZJW+8kP20yTngOUQE8rCY/71FU/c/wNQ4TDP23zrsrB
	NHysgSQI5vf9diKz6iIRhDLOPpFKcbev4iqoiPi1nuJnpLC21he+aSpN4PEvagY2ckR/j/3rFuN
	/cRgZ8ZkVRas6nv61U3Xei2oJFSfjX5NujxRVrZW0E7Y+T1CXH8uKAn0y9zSWMS1AJvUOlS8ck7
	3VqBKk7WyrKyOXsdARlz
X-Received: by 2002:a05:690e:418d:b0:654:1261:8b88 with SMTP id
 956f58d0204a3-6541261952dmr20685626d50.29.1777018880503; Fri, 24 Apr 2026
 01:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415165203.3584869-1-lgs201920130244@gmail.com> <aeCVOuLGrcm0L5rP@ashevche-desk.local>
In-Reply-To: <aeCVOuLGrcm0L5rP@ashevche-desk.local>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:21:05 +0800
X-Gm-Features: AQROBzD1Z4NdRru87pauu50PzHl6eVyZ3jXKKIGOOL-NBoM1BPWh0HuJeGDk1ys
Message-ID: <CANUHTR9-p7Cc7i=eSjaE2Wp_dEq-1Gw1LWaYDySP86u6=FmJoA@mail.gmail.com>
Subject: Re: [PATCH] eeprom: digsy_mtc: fix reference leak on failed device registration
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CFE1D45B5C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240576-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email]

Hi Andy, all,

Thanks for the review.

Please disregard this patch.

On Thu, 16 Apr 2026 at 15:52, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 16, 2026 at 12:52:02AM +0800, Guangshuo Li wrote:
> > When platform_device_register() fails in digsy_mtc_eeprom_devices_init(),
> > the embedded struct device in digsy_mtc_eeprom has already been
> > initialized by device_initialize(), but the failure path only removes
> > the software node and does not drop the device reference for the current
> > platform device:
> >
> >   digsy_mtc_eeprom_devices_init()
> >     -> platform_device_register(&digsy_mtc_eeprom)
> >        -> device_initialize(&digsy_mtc_eeprom.dev)
> >        -> setup_pdev_dma_masks(&digsy_mtc_eeprom)
> >        -> platform_device_add(&digsy_mtc_eeprom)
> >
> > This leads to a reference leak when platform_device_register() fails.
> > Fix this by calling platform_device_put() after removing the software
> > node.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
>
> Thanks for catching this up!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

After re-checking it, digsy_mtc_eeprom is a static platform_device and it
does not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the confusion, and thanks again for the review.

Best regards,
Guangshuo Li

