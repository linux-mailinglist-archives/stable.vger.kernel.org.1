Return-Path: <stable+bounces-56353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B7924017
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8793DB242CE
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 14:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82961B5820;
	Tue,  2 Jul 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G779swfP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194819DFAB
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929610; cv=none; b=rGVYgic0eCWE+BmMchNs4PU0HbG1lWHdt7UKxSn9zVhIyJiB11IcXVWSdMPy9M0HcuZLeAcpAFuYh1nnM/nr7jRbPOsf6Ei51UGx7l7FHaGUsCpYdUi5VlEW/CfR+U58CLdKqV2Ux8vF7SinzQ/mggliLt0V1UpLLfE1Pl1M4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929610; c=relaxed/simple;
	bh=W8ma8GmVIKNB+laQGg49aXyr6OSddSrzJPdz1MoO9ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxsMAF641jJVsaoui/+YuEGsConvDOkGRPYBRcXnA922OVGUoLctcLyFLy9SJMFv8mfJmdv0cAoUmEcnzvqILq8TWgkP2Lt409GaIH2xu8xPM22CPjSQs5qd/F6hqwMfAU1R8OiThmk6bOchN1IBlTDdJwBD7y94QxDSP2uEZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G779swfP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719929607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+HTbEUiUhDSkGqMfMqIxGuXG+kybzWGAQ6P5o85uNo=;
	b=G779swfPYUJRGOdVgpg8iym49alF70+nIFv+pxLV3C9AWvHqKWF0MsVXEsXea8M0hGGl/4
	oFz+PXNaqLYieXmjjmW0PqOHC3USH4ifqGgfOilKogB9WN2QmDRpbbiCtFQzyyAAq/TBzt
	CeveNfDRn8qS3ffunngRDul2oEhGarY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-pC04pJjQP_-DDjT9yDSNbQ-1; Tue, 02 Jul 2024 10:13:26 -0400
X-MC-Unique: pC04pJjQP_-DDjT9yDSNbQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a72b3066669so542697266b.0
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 07:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929605; x=1720534405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+HTbEUiUhDSkGqMfMqIxGuXG+kybzWGAQ6P5o85uNo=;
        b=rjTTZ4h+YJ8Ny/Y/Z5q0y0MOmHJ/5oEHBtx2nwtl2dj0HfXvW0YP46IXj8tCOgWdgY
         muLvY/2yJw+ouNYjuAsmiirWeTD5h3ICByBV8gpEyKuSrCgBRNfCXGzEodAdJhasKN36
         AArc0If7ova2oec1v6fFE/DkFxxsg/TKQCImiOMwgIlG//V2fUd5eYTilyZ1MetplVVP
         pcohaZ1IWUor6AZj2wZaUisFc9+KYuZmkqcTbFy+n2FVUkhgWcv/35foR213vCACJ/Xi
         byU9IgPMXhvZ9ui1HkgX7RCctiJVsZK+MiB8FiMYca2yylnxFltIxT/3GsTtITaOxzmX
         r2qg==
X-Forwarded-Encrypted: i=1; AJvYcCVIquctgYR73xVTrDHpR8aXbM5u8V0F7uDe/epCKrzu5FLqNfIwZMdit51wNchW6f+LvCauaRyZWd7ZtedtSwu7RlLsK2GL
X-Gm-Message-State: AOJu0YwQCCOo5hELu5P34+ijgqQi7nLoJKTLCuaBsz1JDl2ag7HOEv2T
	zKlrmV+U/Z2IYn/qXVQmRBxEziK4C+gPLluHk2ljFLjSXNUz+sUpOdfFw0wJ7GS1trxsk4gUVMj
	5DC6FchAbf/0vCpkJ0XJDstLcnDlT+VaFuswHtDkUy+AoxhvNqOYzww==
X-Received: by 2002:a17:907:7290:b0:a62:e450:b147 with SMTP id a640c23a62f3a-a72aefa5899mr991925666b.29.1719929605299;
        Tue, 02 Jul 2024 07:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKPiPtb8NwyGxQJpY/gGEECesBA1rxb03oF6BPyRYY0H82kLWkaLKyrveO8APzKTm55nHqog==
X-Received: by 2002:a17:907:7290:b0:a62:e450:b147 with SMTP id a640c23a62f3a-a72aefa5899mr991922066b.29.1719929604759;
        Tue, 02 Jul 2024 07:13:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:e7a9:b143:57e6:261b? (2001-1c00-2a07-3a01-e7a9-b143-57e6-261b.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:e7a9:b143:57e6:261b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72b033f3a3sm397718766b.187.2024.07.02.07.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 07:13:24 -0700 (PDT)
Message-ID: <3fee6650-a329-4be8-9c6e-78537beb3d09@redhat.com>
Date: Tue, 2 Jul 2024 16:13:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "platform/x86: toshiba_acpi: Add quirk for buttons
 on Z830"
To: Armin Wolf <W_Armin@gmx.de>, coproscefalo@gmail.com
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
 sashal@kernel.org, stable@vger.kernel.org
References: <20240702120646.10756-1-W_Armin@gmx.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240702120646.10756-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Armin,

On 7/2/24 2:06 PM, Armin Wolf wrote:
> This reverts commit 10c66da9f87a96572ad92642ae060e827313b11c.
> 
> The associated patch depends on the availability of the ACPI
> quickstart button driver, which will be available starting with
> kernel 6.10. This means that the patch brings no benifit for
> older kernels.
> 
> Even worse, it was found out that the patch is buggy, causing
> regressions for people using older kernels.
> 
> Fix this by simply reverting the patch from the 6.9 stable tree.

The fix heading toward mainline:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=e527a6127223b644e0a27b44f4b16e16eb6c7f0a

should work fine for the stable branches too and  AFAIK the stable
maintainer prefer to have a mainline fix over a stable specific fix.

I have added a Cc: stable to the fix and I plan to submit a PR with
this to Linus this Thursday, after which the stable scripts should
pick it up automatically for all relevant maintained branches since
it also has a Fixes: tag.

Regards,

Hans

> Cc: <stable@vger.kernel.org> # 6.9.x

p.s.

I believe that you could have used:

Cc: <stable@vger.kernel.org> # 6.1.x, 6.6.x, 6.9.x

here instead of sending this 3 times with only the version in
the stable tag being different in the 3 versions.



> Reported-by: kemal <kmal@cock.li>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/toshiba_acpi.c | 36 +++--------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 16e941449b14..77244c9aa60d 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -57,11 +57,6 @@ module_param(turn_on_panel_on_resume, int, 0644);
>  MODULE_PARM_DESC(turn_on_panel_on_resume,
>  	"Call HCI_PANEL_POWER_ON on resume (-1 = auto, 0 = no, 1 = yes");
> 
> -static int hci_hotkey_quickstart = -1;
> -module_param(hci_hotkey_quickstart, int, 0644);
> -MODULE_PARM_DESC(hci_hotkey_quickstart,
> -		 "Call HCI_HOTKEY_EVENT with value 0x5 for quickstart button support (-1 = auto, 0 = no, 1 = yes");
> -
>  #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"
> 
>  /* Scan code for Fn key on TOS1900 models */
> @@ -141,7 +136,6 @@ MODULE_PARM_DESC(hci_hotkey_quickstart,
>  #define HCI_ACCEL_MASK			0x7fff
>  #define HCI_ACCEL_DIRECTION_MASK	0x8000
>  #define HCI_HOTKEY_DISABLE		0x0b
> -#define HCI_HOTKEY_ENABLE_QUICKSTART	0x05
>  #define HCI_HOTKEY_ENABLE		0x09
>  #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
>  #define HCI_LCD_BRIGHTNESS_BITS		3
> @@ -2737,15 +2731,10 @@ static int toshiba_acpi_enable_hotkeys(struct toshiba_acpi_dev *dev)
>  		return -ENODEV;
> 
>  	/*
> -	 * Enable quickstart buttons if supported.
> -	 *
>  	 * Enable the "Special Functions" mode only if they are
>  	 * supported and if they are activated.
>  	 */
> -	if (hci_hotkey_quickstart)
> -		result = hci_write(dev, HCI_HOTKEY_EVENT,
> -				   HCI_HOTKEY_ENABLE_QUICKSTART);
> -	else if (dev->kbd_function_keys_supported && dev->special_functions)
> +	if (dev->kbd_function_keys_supported && dev->special_functions)
>  		result = hci_write(dev, HCI_HOTKEY_EVENT,
>  				   HCI_HOTKEY_SPECIAL_FUNCTIONS);
>  	else
> @@ -3269,14 +3258,7 @@ static const char *find_hci_method(acpi_handle handle)
>   * works. toshiba_acpi_resume() uses HCI_PANEL_POWER_ON to avoid changing
>   * the configured brightness level.
>   */
> -#define QUIRK_TURN_ON_PANEL_ON_RESUME		BIT(0)
> -/*
> - * Some Toshibas use "quickstart" keys. On these, HCI_HOTKEY_EVENT must use
> - * the value HCI_HOTKEY_ENABLE_QUICKSTART.
> - */
> -#define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)
> -
> -static const struct dmi_system_id toshiba_dmi_quirks[] = {
> +static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] = {
>  	{
>  	 /* Toshiba Portégé R700 */
>  	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
> @@ -3284,7 +3266,6 @@ static const struct dmi_system_id toshiba_dmi_quirks[] = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
>  		},
> -	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
>  	},
>  	{
>  	 /* Toshiba Satellite/Portégé R830 */
> @@ -3294,7 +3275,6 @@ static const struct dmi_system_id toshiba_dmi_quirks[] = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
>  		},
> -	 .driver_data = (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
>  	},
>  	{
>  	 /* Toshiba Satellite/Portégé Z830 */
> @@ -3302,7 +3282,6 @@ static const struct dmi_system_id toshiba_dmi_quirks[] = {
>  		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>  		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
>  		},
> -	 .driver_data = (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOTKEY_QUICKSTART),
>  	},
>  };
> 
> @@ -3311,8 +3290,6 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	struct toshiba_acpi_dev *dev;
>  	const char *hci_method;
>  	u32 dummy;
> -	const struct dmi_system_id *dmi_id;
> -	long quirks = 0;
>  	int ret = 0;
> 
>  	if (toshiba_acpi)
> @@ -3465,15 +3442,8 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	}
>  #endif
> 
> -	dmi_id = dmi_first_match(toshiba_dmi_quirks);
> -	if (dmi_id)
> -		quirks = (long)dmi_id->driver_data;
> -
>  	if (turn_on_panel_on_resume == -1)
> -		turn_on_panel_on_resume = !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUME);
> -
> -	if (hci_hotkey_quickstart == -1)
> -		hci_hotkey_quickstart = !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
> +		turn_on_panel_on_resume = dmi_check_system(turn_on_panel_on_resume_dmi_ids);
> 
>  	toshiba_wwan_available(dev);
>  	if (dev->wwan_supported)
> --
> 2.39.2
> 


