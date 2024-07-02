Return-Path: <stable+bounces-56890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F39247FC
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3441C25351
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC81C68BB;
	Tue,  2 Jul 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Nha3BSwg"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7031514DC
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947865; cv=none; b=VycqjH9lWw01roH0kwi93/E9dGvPwvtt49ixM5C6f5lLr2a42TfbiVGCGjopfvw+Kizz2kn6NEpOWeuUTmfVMj8nMK9s/tV7i5GGErgQcCymxZ3BiDH4cpi/629ZskqDFcMbzZ4Mo46EIXwvLgMep9ZEuZoDopHwv+sZaZeC6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947865; c=relaxed/simple;
	bh=1LOZ5UGpniNe8buFK3O+7rXgAKHgRQNbuLerJJdaPpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvpD+/l1POHM/FBfTuyWCHtTkAcq8jpsGCmsInpiRr+wOlVc4OdyxlTSUE85ibCl4V9rQ+7eioLVBsgbYiDRcpz13RF5gs0P8WcKknkSBUKY4937x1z2lSGI8lHbq6pFyKdBR2dXd16cZQBUUgNhIskf43kILRC1OjoSVxtUqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Nha3BSwg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719947848; x=1720552648; i=w_armin@gmx.de;
	bh=NaCDkM/93HEgJ40mrN5ZT/sQB2K1u3dspNXc/NmjZvE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nha3BSwgoUO4Wid4LENeoJ4zFvhqX9liAIWFblGtWHi6gxVwLbtQ6mrlirC6JsGj
	 HU7FnFCH6JTx3QNPlJovMFHFLirIW5rep2qH/osTWDhsn0zCf5LTzqJk1kNbqQEPo
	 If3zruEQN9naCBsKMZfByZ0VMZC2U0A3zfVoE1sS1gQa4NBl+UTHeMPqUzcZVQ+kH
	 3AOC5tQrDCjE8RqUm1MXISX5QCO+sg7Vi3C5aXGnrXgH2xVRcCAPAFdnJoRrmF8To
	 RfDg/Im57NUHmqakgA8TdUm3kUdpVUt5BZcT510BFzFw15ECjBuphUkzzQPAfyhKc
	 +NV401lNA6F4sHukwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1sgWyH3JXF-00KUDk; Tue, 02
 Jul 2024 21:17:28 +0200
Message-ID: <7080ecb8-c887-4e26-8215-e4d040e2db1d@gmx.de>
Date: Tue, 2 Jul 2024 21:17:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "platform/x86: toshiba_acpi: Add quirk for buttons
 on Z830"
To: Hans de Goede <hdegoede@redhat.com>, coproscefalo@gmail.com
Cc: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org,
 sashal@kernel.org, stable@vger.kernel.org
References: <20240702120646.10756-1-W_Armin@gmx.de>
 <3fee6650-a329-4be8-9c6e-78537beb3d09@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3fee6650-a329-4be8-9c6e-78537beb3d09@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4WxCx2kRKaVFNqk052UyAcZ/qt63Vb3rkkjCK13Fvmv2q723tyF
 3v4nhCUb5SeDrbQlDJgbBRAyzZMu7hf7rbb5UP9byI9SqthqNnIXwjbXQc48rsZT4ilXZwc
 2iDrCMqYK9TPbixgHTmuvXhjkDtf7M3HH6d8rDlkcXw25V+m51rsSNYmynBV07daawbMbJ2
 OssL7ke/pi+kAjxhRYLIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DA1PyYtqgXE=;JyUsCMNNstx3oKgIYhTKkzcoSuB
 POhMBuEfQxUC6OKvZAiOYsKOTsoOxOJiFnRZ337K3mPr7MKXrcmVNAjWqFGEn+bY7NGw+H0VO
 TAsvw6SNNKodZVWdBavmUp3CrodbXgAKodyn4pr8S6eg0NxxYBXd0FEa4mW2rl5e7P8OULbPH
 NLJ7AE0LfbcGuZ0RjrtjdRI6HqH9B0fhbW5XppJQuaT9k1s/tFlz5fJsxywNi6Y3HeU8luKgH
 hc+XsLFi4cvKn1vu/9611+pFANJdPgqzVnXqlWbnv21EeYNGf0QAGAsUz3Z+U+RL4mb/+hsh3
 6rJT3U6ELjVoDyq3lz1NCDRSgkl74Uc/HyvRlTR0Tj0mublRRX5MpMJmoOWvJKX8q8FZwTi38
 pkqzzIUrlBeeNTHqPkZ72n3WGsATIZyyBZqok34qtLFdYNRC3vguv3XhqH8JxA7oHKKBqn4gE
 BYt0dpFxzWnjZXeUvp94/QjxZkjKKSTsQv5ERxjTCQizcTNBLeQuE4tssWrl7GfTM5990FRaE
 //rShp4lsmj2Cf9TxWYSuHumUtQyrXVTXhcjhID4iMksZvkMcOK1xzGHA5evO8MtOdK5DrF8j
 r/8ZWZYJP822fjJvNEXIgPwFyfqeX3gOQmCIP90MIDkuyvj9pDR9SMvmdgKKCXlhff2gar0Y1
 LRz2CeWl0hvT5tzyJVl6EAMLd/t0eom9Plk/zXkFQvb9RPmnMcAErl26aap9fASrJtiWp92po
 X9dnqVtjx5fIiPtTDX9J7BE4W7E2r+55tixjMJbTirOz9Jl1z+yOv+Sk1tBtHrLH+gWeutF1p
 6JaABc3NF3g0v9LjzAUpaAWIBt8F1MNUwnJX93TGtYPyDCOeANUwWehC/sldB5I1KXAE7mvk0
 QzRjunwQxp1WhQg==

Am 02.07.24 um 16:13 schrieb Hans de Goede:

> Hi Armin,
>
> On 7/2/24 2:06 PM, Armin Wolf wrote:
>> This reverts commit 10c66da9f87a96572ad92642ae060e827313b11c.
>>
>> The associated patch depends on the availability of the ACPI
>> quickstart button driver, which will be available starting with
>> kernel 6.10. This means that the patch brings no benifit for
>> older kernels.
>>
>> Even worse, it was found out that the patch is buggy, causing
>> regressions for people using older kernels.
>>
>> Fix this by simply reverting the patch from the 6.9 stable tree.
> The fix heading toward mainline:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x=
86.git/commit/?h=3Dfixes&id=3De527a6127223b644e0a27b44f4b16e16eb6c7f0a
>
> should work fine for the stable branches too and  AFAIK the stable
> maintainer prefer to have a mainline fix over a stable specific fix.

Ok, in this case i will take back the three patches.

>
> I have added a Cc: stable to the fix and I plan to submit a PR with
> this to Linus this Thursday, after which the stable scripts should
> pick it up automatically for all relevant maintained branches since
> it also has a Fixes: tag.
>
> Regards,
>
> Hans
>
>> Cc: <stable@vger.kernel.org> # 6.9.x
> p.s.
>
> I believe that you could have used:
>
> Cc: <stable@vger.kernel.org> # 6.1.x, 6.6.x, 6.9.x
>
> here instead of sending this 3 times with only the version in
> the stable tag being different in the 3 versions.

The commit id of the reverted commit was different for each kernel version=
,
that why i decided to send three different patches.

Thanks,
Armin Wolf

>
>> Reported-by: kemal <kmal@cock.li>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/toshiba_acpi.c | 36 +++-------------------------=
-
>>   1 file changed, 3 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86=
/toshiba_acpi.c
>> index 16e941449b14..77244c9aa60d 100644
>> --- a/drivers/platform/x86/toshiba_acpi.c
>> +++ b/drivers/platform/x86/toshiba_acpi.c
>> @@ -57,11 +57,6 @@ module_param(turn_on_panel_on_resume, int, 0644);
>>   MODULE_PARM_DESC(turn_on_panel_on_resume,
>>   	"Call HCI_PANEL_POWER_ON on resume (-1 =3D auto, 0 =3D no, 1 =3D yes=
");
>>
>> -static int hci_hotkey_quickstart =3D -1;
>> -module_param(hci_hotkey_quickstart, int, 0644);
>> -MODULE_PARM_DESC(hci_hotkey_quickstart,
>> -		 "Call HCI_HOTKEY_EVENT with value 0x5 for quickstart button support=
 (-1 =3D auto, 0 =3D no, 1 =3D yes");
>> -
>>   #define TOSHIBA_WMI_EVENT_GUID "59142400-C6A3-40FA-BADB-8A2652834100"
>>
>>   /* Scan code for Fn key on TOS1900 models */
>> @@ -141,7 +136,6 @@ MODULE_PARM_DESC(hci_hotkey_quickstart,
>>   #define HCI_ACCEL_MASK			0x7fff
>>   #define HCI_ACCEL_DIRECTION_MASK	0x8000
>>   #define HCI_HOTKEY_DISABLE		0x0b
>> -#define HCI_HOTKEY_ENABLE_QUICKSTART	0x05
>>   #define HCI_HOTKEY_ENABLE		0x09
>>   #define HCI_HOTKEY_SPECIAL_FUNCTIONS	0x10
>>   #define HCI_LCD_BRIGHTNESS_BITS		3
>> @@ -2737,15 +2731,10 @@ static int toshiba_acpi_enable_hotkeys(struct t=
oshiba_acpi_dev *dev)
>>   		return -ENODEV;
>>
>>   	/*
>> -	 * Enable quickstart buttons if supported.
>> -	 *
>>   	 * Enable the "Special Functions" mode only if they are
>>   	 * supported and if they are activated.
>>   	 */
>> -	if (hci_hotkey_quickstart)
>> -		result =3D hci_write(dev, HCI_HOTKEY_EVENT,
>> -				   HCI_HOTKEY_ENABLE_QUICKSTART);
>> -	else if (dev->kbd_function_keys_supported && dev->special_functions)
>> +	if (dev->kbd_function_keys_supported && dev->special_functions)
>>   		result =3D hci_write(dev, HCI_HOTKEY_EVENT,
>>   				   HCI_HOTKEY_SPECIAL_FUNCTIONS);
>>   	else
>> @@ -3269,14 +3258,7 @@ static const char *find_hci_method(acpi_handle h=
andle)
>>    * works. toshiba_acpi_resume() uses HCI_PANEL_POWER_ON to avoid chan=
ging
>>    * the configured brightness level.
>>    */
>> -#define QUIRK_TURN_ON_PANEL_ON_RESUME		BIT(0)
>> -/*
>> - * Some Toshibas use "quickstart" keys. On these, HCI_HOTKEY_EVENT mus=
t use
>> - * the value HCI_HOTKEY_ENABLE_QUICKSTART.
>> - */
>> -#define QUIRK_HCI_HOTKEY_QUICKSTART		BIT(1)
>> -
>> -static const struct dmi_system_id toshiba_dmi_quirks[] =3D {
>> +static const struct dmi_system_id turn_on_panel_on_resume_dmi_ids[] =
=3D {
>>   	{
>>   	 /* Toshiba Port=C3=A9g=C3=A9 R700 */
>>   	 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D21012 */
>> @@ -3284,7 +3266,6 @@ static const struct dmi_system_id toshiba_dmi_qui=
rks[] =3D {
>>   		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>>   		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R700"),
>>   		},
>> -	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
>>   	},
>>   	{
>>   	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 R830 */
>> @@ -3294,7 +3275,6 @@ static const struct dmi_system_id toshiba_dmi_qui=
rks[] =3D {
>>   		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>>   		DMI_MATCH(DMI_PRODUCT_NAME, "R830"),
>>   		},
>> -	 .driver_data =3D (void *)QUIRK_TURN_ON_PANEL_ON_RESUME,
>>   	},
>>   	{
>>   	 /* Toshiba Satellite/Port=C3=A9g=C3=A9 Z830 */
>> @@ -3302,7 +3282,6 @@ static const struct dmi_system_id toshiba_dmi_qui=
rks[] =3D {
>>   		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>>   		DMI_MATCH(DMI_PRODUCT_NAME, "Z830"),
>>   		},
>> -	 .driver_data =3D (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_=
HOTKEY_QUICKSTART),
>>   	},
>>   };
>>
>> @@ -3311,8 +3290,6 @@ static int toshiba_acpi_add(struct acpi_device *a=
cpi_dev)
>>   	struct toshiba_acpi_dev *dev;
>>   	const char *hci_method;
>>   	u32 dummy;
>> -	const struct dmi_system_id *dmi_id;
>> -	long quirks =3D 0;
>>   	int ret =3D 0;
>>
>>   	if (toshiba_acpi)
>> @@ -3465,15 +3442,8 @@ static int toshiba_acpi_add(struct acpi_device *=
acpi_dev)
>>   	}
>>   #endif
>>
>> -	dmi_id =3D dmi_first_match(toshiba_dmi_quirks);
>> -	if (dmi_id)
>> -		quirks =3D (long)dmi_id->driver_data;
>> -
>>   	if (turn_on_panel_on_resume =3D=3D -1)
>> -		turn_on_panel_on_resume =3D !!(quirks & QUIRK_TURN_ON_PANEL_ON_RESUM=
E);
>> -
>> -	if (hci_hotkey_quickstart =3D=3D -1)
>> -		hci_hotkey_quickstart =3D !!(quirks & QUIRK_HCI_HOTKEY_QUICKSTART);
>> +		turn_on_panel_on_resume =3D dmi_check_system(turn_on_panel_on_resume=
_dmi_ids);
>>
>>   	toshiba_wwan_available(dev);
>>   	if (dev->wwan_supported)
>> --
>> 2.39.2
>>

