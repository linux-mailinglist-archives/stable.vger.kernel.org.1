Return-Path: <stable+bounces-208131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B410BD1351B
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1CD53063F6C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB92E2BDC32;
	Mon, 12 Jan 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="mKEUVPHR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19512BE035
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229268; cv=none; b=NIy3OsaaceuK0g2Z02dHMmfc1Fn7Nwn4xrV8nW2ZXhJNMHkHE+1MZsoE4u50NGW9Zsi77j3TkgNL2GQfmeyZjTzmOr41lQhpXmOfcRMxtALeYBHY8KZP6MLubNicXAECW7rGWvrbd5nF+NW1eWPrPvhjvckJqzXC3WcfHRgq1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229268; c=relaxed/simple;
	bh=Q7uNIoVs6EvhTLNsF+A8tnPvlJqfykDARYEptFQK0rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjUE2br8IFfQ2Zk8Y2PNCE+vEhTNrtFUNeQMjOk2tdyBytWsU8OUJn+Dg44pmk1nb+u7XT2Lo16k1jaeI5jXlX7yg4hy5nYDKbWNocoB0tnlZ7+YibsC/1zotnsvXjm0loJFWwEX1BeQw8egicYTNB0xwOeLhXjxyKGa3zRGlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=mKEUVPHR; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2ea2b9631so744624485a.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1768229266; x=1768834066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=66Wy9X7ugeW5bewzeljPlJ6DqPEghHzvFsNM3r+AfsU=;
        b=mKEUVPHRt16xBTNGK2ZwJqMIwuok/3omAuXfn6jpwelRs9DntTUtH5V14+PEC1E50C
         ztZ5xafbhSJyHYkLmYez1e/+Xz7RZyf35pkO8LbzwRnisON6S2lySgs+ri5nVERxeRjT
         Mdt5SHbBHtqt3fbKKUy2ONrE+050PC81/X53xNI/nCj7LjO70EBm9tYoGwX0EptALuTM
         IkuTdUa3pOCb+vOKOLMJeqLIZ7+L9KZtQBS94wRuJB2cKhmkU0SFaZ3WrPOTT/CAt+kz
         6K9hGQ2GZsemj2EPLDDmP8k5rmA+TreQFsDk+WaCiF50PMQ+mV5B6UaMnUTiKI3VZLg4
         +/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229266; x=1768834066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66Wy9X7ugeW5bewzeljPlJ6DqPEghHzvFsNM3r+AfsU=;
        b=DIJf0Ml4nA0Y/+2xO/8+cO7ysB7lR3dBk7zxNE9deWDCZGjUxG7sJfTV+cM3SfcbEY
         CfTPoG8cODWe/PohRHI5vbX8vpz9JVSBNb2aEoq0eMXRyszU6MphxM1o44RcTTcY8KZg
         +xYS4yHgAogTFxcqHEa0WZwNu4wKZM9SFeEqjA1sA8GSYY7YH3+YZaAFqzA+uIGmri0O
         dr4B4zqd6DnvvcrNlJxSf0f3gg/FdK6KytJX/PjBZeFoaWkdFgEd0PsOqbAvxof1DuYP
         wfsLxO6tXEMU7ODj1ezQ8Q4JqaS11vYyALPlgHQpQ/4478WjePHH1uZsz5pYUTClyPqa
         NLrw==
X-Forwarded-Encrypted: i=1; AJvYcCVLh+TCmutdq/N6Zhgo9/nOPdaMLCmas2hn51xF5qwreZ3N4aVJ/6MTUTC1q89UqU89HsgncB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfyx71PaQxutJ8IBkIx+vq4SnhtVMCa4VcxWLk8sPcBst00U5F
	ur445lPqtZs+Oz7zdsplyipZDI+opwbf6Q+Xi51LNW3vdUFt3gDLLRdfETlutaqcIw==
X-Gm-Gg: AY/fxX7kr69zmuDQoF3Vi1TpbXPnj0gGGTDwCOMqMy+SnAqm8S9PW4ECpmYrt7+ZBgG
	Q6mQKI6DSjJWvwVNtarXK/FcOoy3s5K3t8jwWXuNvmB/odYA8kyxauE6pvbajss9NVakVS/8ju2
	XYIMz1NVIDxGwT6XDppjmN8Zxnjg4PgCkzzWe1wy2RUrGNA737ly2WCi0C0lRMphJNl0996hBan
	W4agwb1fFdsjr404+2QzQMEk7zUBr2AS/jc/rSzwFNGTpELkWRbsDJovehzkqq4Bi1tYwkRsUp3
	b0ybIefcKFO5UC+tiQVPhXTYrLpBzgtQVjVHJhnZjRJ/1lvl+ppfatzEM5KlMEnOBkLJhCvejrL
	qE/f2rQfC4gCqMe9CstIUtapWiPV0okFH7uMtSiglunQ/sJTSu/AoYCMnS1ZuUiRG9gtDnnt6s/
	JGApzsCrFBjs5S4sT0k+evFxx/e5XIDA==
X-Google-Smtp-Source: AGHT+IHNPfK5E/6kxAdWbW5EOVjXjBOCl0/onefYJWefU+oa4TlgqTn3RHl/5dDKkgIMPHHkE2sRPQ==
X-Received: by 2002:a05:620a:46ab:b0:85c:bb2:ad8c with SMTP id af79cd13be357-8c389406276mr2499235885a.74.1768229265555;
        Mon, 12 Jan 2026 06:47:45 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a63acsm1516812785a.6.2026.01.12.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:47:45 -0800 (PST)
Date: Mon, 12 Jan 2026 09:47:42 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Shengwen Xiao <atzlinux@sina.com>
Subject: Re: [PATCH] USB: OHCI/UHCI: Add soft dependencies on ehci_platform
Message-ID: <f43a2ce7-7ffa-4b53-8610-52455ac9d16a@rowland.harvard.edu>
References: <20260112084802.1995923-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112084802.1995923-1-chenhuacai@loongson.cn>

On Mon, Jan 12, 2026 at 04:48:02PM +0800, Huacai Chen wrote:
> Commit 9beeee6584b9aa4f ("USB: EHCI: log a warning if ehci-hcd is not
> loaded first") said that ehci-hcd should be loaded before ohci-hcd and
> uhci-hcd. However, commit 05c92da0c52494ca ("usb: ohci/uhci - add soft
> dependencies on ehci_pci") only makes ohci-pci/uhci-pci depend on ehci-
> pci, which is not enough and we may still see the warnings in boot log.
> 
> To eliminate the warnings we should make ohci-hcd/uhci-hcd depend on
> ehci-hcd. But Alan said that the warning introduced by 9beeee6584b9aa4f
> is bogus, we only need the soft dependencies in the PCI level rather
> than the HCD level.
> 
> However, there is really another neccessary soft dependencies between
> ohci-platform/uhci-platform and ehci-platform, which is added by this
> patch. The boot logs are below.
> 
> 1. ohci-platform loaded before ehci-platform:
> 
>  ohci-platform 1f058000.usb: Generic Platform OHCI controller
>  ohci-platform 1f058000.usb: new USB bus registered, assigned bus number 1
>  ohci-platform 1f058000.usb: irq 28, io mem 0x1f058000
>  hub 1-0:1.0: USB hub found
>  hub 1-0:1.0: 4 ports detected
>  Warning! ehci_hcd should always be loaded before uhci_hcd and ohci_hcd, not after
>  usb 1-4: new low-speed USB device number 2 using ohci-platform
>  ehci-platform 1f050000.usb: EHCI Host Controller
>  ehci-platform 1f050000.usb: new USB bus registered, assigned bus number 2
>  ehci-platform 1f050000.usb: irq 29, io mem 0x1f050000
>  ehci-platform 1f050000.usb: USB 2.0 started, EHCI 1.00
>  usb 1-4: device descriptor read/all, error -62
>  hub 2-0:1.0: USB hub found
>  hub 2-0:1.0: 4 ports detected
>  usb 1-4: new low-speed USB device number 3 using ohci-platform
>  input: YSPRINGTECH USB OPTICAL MOUSE as /devices/platform/bus@10000000/1f058000.usb/usb1/1-4/1-4:1.0/0003:10C4:8105.0001/input/input0
>  hid-generic 0003:10C4:8105.0001: input,hidraw0: USB HID v1.11 Mouse [YSPRINGTECH USB OPTICAL MOUSE] on usb-1f058000.usb-4/input0
> 
> 2. ehci-platform loaded before ohci-platform:
> 
>  ehci-platform 1f050000.usb: EHCI Host Controller
>  ehci-platform 1f050000.usb: new USB bus registered, assigned bus number 1
>  ehci-platform 1f050000.usb: irq 28, io mem 0x1f050000
>  ehci-platform 1f050000.usb: USB 2.0 started, EHCI 1.00
>  hub 1-0:1.0: USB hub found
>  hub 1-0:1.0: 4 ports detected
>  ohci-platform 1f058000.usb: Generic Platform OHCI controller
>  ohci-platform 1f058000.usb: new USB bus registered, assigned bus number 2
>  ohci-platform 1f058000.usb: irq 29, io mem 0x1f058000
>  hub 2-0:1.0: USB hub found
>  hub 2-0:1.0: 4 ports detected
>  usb 2-4: new low-speed USB device number 2 using ohci-platform
>  input: YSPRINGTECH USB OPTICAL MOUSE as /devices/platform/bus@10000000/1f058000.usb/usb2/2-4/2-4:1.0/0003:10C4:8105.0001/input/input0
>  hid-generic 0003:10C4:8105.0001: input,hidraw0: USB HID v1.11 Mouse [YSPRINGTECH USB OPTICAL MOUSE] on usb-1f058000.usb-4/input0
> 
> In the later case, there is no re-connection for USB-1.0/1.1 devices,
> which is expected.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Shengwen Xiao <atzlinux@sina.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ohci-platform.c | 1 +
>  drivers/usb/host/uhci-platform.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 2e4bb5cc2165..c801527d5bd2 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -392,3 +392,4 @@ MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_AUTHOR("Hauke Mehrtens");
>  MODULE_AUTHOR("Alan Stern");
>  MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: ehci_platform");
> diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
> index 5e02f2ceafb6..f4419d4526c4 100644
> --- a/drivers/usb/host/uhci-platform.c
> +++ b/drivers/usb/host/uhci-platform.c
> @@ -211,3 +211,4 @@ static struct platform_driver uhci_platform_driver = {
>  		.of_match_table = platform_uhci_ids,
>  	},
>  };
> +MODULE_SOFTDEP("pre: ehci_platform");
> -- 
> 2.47.3
> 

