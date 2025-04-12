Return-Path: <stable+bounces-132327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 262F7A86F0A
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 20:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D5A17F8CD
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 18:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD52204C00;
	Sat, 12 Apr 2025 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="oYikrqxR"
X-Original-To: stable@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4112147F2
	for <stable@vger.kernel.org>; Sat, 12 Apr 2025 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483996; cv=none; b=FxSx2nbl4jVo5gwsrC+GrKPqcHGF+7HsixHqMsL0xvU1oStCGoDdqSESyD0utGR9nJxGNbAfgtCbyiujwt+mehqD8zsboe752wshB2qyl8wbbB64QvLg6zFlguTbGn0NIUUkyk1k4m+lGQm2pQWvDGANTfY4r+l76zfmtPUB83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483996; c=relaxed/simple;
	bh=goPVb5BCE+crd0NK6y26sFzlS2zUcuxq5lv9NzI6Ufo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGglwXuIZfy/OlwkhQBgKK3E5JSktheoxjJS2amQpMusIs64TbFevnKXSUeZQIUCn/7J8R2+v37bp7nAm0sAHHaRKdchZBzMRb65V+HlWmVtlDlMS6xFUAwa6ZluE8PIoHy8YgAEo6gzhpzg0fcEpToo4oz9XEhpmZwZ4vQSiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=oYikrqxR; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 35038 invoked from network); 12 Apr 2025 20:53:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1744483984; bh=Dp6oLScgnb/dCOq/mF3bQK0cZiW8Aj30L/mlH51rgq0=;
          h=From:To:Cc:Subject;
          b=oYikrqxRbn1HLnc1I9aR9i3nc5/5TInL42TtAUTlYssuZODVin3stUfpXcVExfNWL
           ufR2uqaY0z6ZFE9mTvoETDnjz3jOb5N4DcbQUxarLk187+OR8H+xgGEsKwr++yrRbO
           +a9hR+hSBknX2FgS0+8Z6tK1j2br+eQP5zpE+zZTaEz8xHEDsGWW5D0uQ9ZIVzd4Hu
           xYzWnk16zlhu07Q5gzVuRlr0auTWQ6hOs94zUZCBFvV8/UEbaC83SKPdxQF0qm1phG
           sabMt+ZWX+NhgeCzpYEDABoTKumia9gokdjfC4z22B1cgpU5TthFRQPJ9mJb+0c3h6
           n/B6gTovHYnMg==
Received: from 89-64-9-62.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.62])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <aitsygunka@yandex.ru>; 12 Apr 2025 20:53:03 +0200
Date: Sat, 12 Apr 2025 20:53:03 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Andrey Tsygunka <aitsygunka@yandex.ru>
Cc: Matthieu CASTET <castet.matthieu@free.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: ueagle-atm: wait for a firmware upload to
 complete
Message-ID: <20250412185303.GA43859@wp.pl>
References: <20250410093146.3776801-1-aitsygunka@yandex.ru>
 <20250410093146.3776801-2-aitsygunka@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410093146.3776801-2-aitsygunka@yandex.ru>
X-WP-MailID: c93ac509e5ff1cbd4568114573df5e7a
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [AWNk]                               

On Thu, Apr 10, 2025 at 12:31:46PM +0300, Andrey Tsygunka wrote:
> Syzkaller reported:
> 
> sysfs group 'power' not found for kobject 'ueagle-atm!adi930.fw'
> WARNING: CPU: 1 PID: 6804 at fs/sysfs/group.c:278 sysfs_remove_group+0x120/0x170 fs/sysfs/group.c:278
> Modules linked in:
> CPU: 1 PID: 6804 Comm: kworker/1:5 Not tainted 6.1.128 #1
> Hardware name: linux,dummy-virt (DT)
> Workqueue: events request_firmware_work_func
> Call trace:
>  sysfs_remove_group+0x120/0x170 fs/sysfs/group.c:278
>  dpm_sysfs_remove+0x9c/0xc0 drivers/base/power/sysfs.c:837
>  device_del+0x1e0/0xb30 drivers/base/core.c:3861
>  fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:120 [inline]
>  fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
>  firmware_fallback_sysfs+0x880/0xa30 drivers/base/firmware_loader/fallback.c:234
>  _request_firmware+0xcc0/0x1030 drivers/base/firmware_loader/main.c:884
>  request_firmware_work_func+0xf0/0x240 drivers/base/firmware_loader/main.c:1135
>  process_one_work+0x878/0x1770 kernel/workqueue.c:2292
>  worker_thread+0x48c/0xe40 kernel/workqueue.c:2439
>  kthread+0x274/0x2e0 kernel/kthread.c:376
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:864
> 
> When calling the usb-device probe() method, request_firmware_nowait()
> is called, an async task is created that creates a child device
> to load the firmware and waits (fw_sysfs_wait_timeout()) for the
> firmware to be ready. If an async disconnect event occurs for
> usb-device while waiting, we may get a WARN() when calling
> firmware_fallback_sysfs() about "no sysfs group 'power' found
> for kobject" because it was removed by usb_disconnect().
> 
> To avoid this, add a routine to wait for the firmware loading process
> to complete to prevent premature device disconnection.
> 
> Fixes: b72458a80c75 ("[PATCH] USB: Eagle and ADI 930 usb adsl modem driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Tsygunka <aitsygunka@yandex.ru>

Hi, thanks for the patch, but I do not see benefit of fix ex-WARN and
now pr_debug(). Only downside of adding extra 40 lines of code.

Nacked-by: Stanislaw Gruszka <stf_xl@wp.pl>

>  drivers/usb/atm/ueagle-atm.c | 40 +++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
> index cd0f7b4bd82a..eaa5ad316d89 100644
> --- a/drivers/usb/atm/ueagle-atm.c
> +++ b/drivers/usb/atm/ueagle-atm.c
> @@ -570,6 +570,12 @@ MODULE_PARM_DESC(annex,
>  #define LOAD_INTERNAL     0xA0
>  #define F8051_USBCS       0x7f92
>  
> +struct uea_interface_data {
> +	struct completion fw_upload_complete;
> +	struct usb_device *usb;
> +	struct usb_interface *intf;
> +};
> +
>  /*
>   * uea_send_modem_cmd - Send a command for pre-firmware devices.
>   */
> @@ -599,7 +605,8 @@ static int uea_send_modem_cmd(struct usb_device *usb,
>  static void uea_upload_pre_firmware(const struct firmware *fw_entry,
>  								void *context)
>  {
> -	struct usb_device *usb = context;
> +	struct uea_interface_data *uea_intf_data = context;
> +	struct usb_device *usb = uea_intf_data->usb;
>  	const u8 *pfw;
>  	u8 value;
>  	u32 crc = 0;
> @@ -669,15 +676,17 @@ static void uea_upload_pre_firmware(const struct firmware *fw_entry,
>  	uea_err(usb, "firmware is corrupted\n");
>  err:
>  	release_firmware(fw_entry);
> +	complete(&uea_intf_data->fw_upload_complete);
>  	uea_leaves(usb);
>  }
>  
>  /*
>   * uea_load_firmware - Load usb firmware for pre-firmware devices.
>   */
> -static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
> +static int uea_load_firmware(struct uea_interface_data *uea_intf_data, unsigned int ver)
>  {
>  	int ret;
> +	struct usb_device *usb = uea_intf_data->usb;
>  	char *fw_name = EAGLE_FIRMWARE;
>  
>  	uea_enters(usb);
> @@ -702,7 +711,7 @@ static int uea_load_firmware(struct usb_device *usb, unsigned int ver)
>  	}
>  
>  	ret = request_firmware_nowait(THIS_MODULE, 1, fw_name, &usb->dev,
> -					GFP_KERNEL, usb,
> +					GFP_KERNEL, uea_intf_data,
>  					uea_upload_pre_firmware);
>  	if (ret)
>  		uea_err(usb, "firmware %s is not available\n", fw_name);
> @@ -2586,6 +2595,7 @@ static struct usbatm_driver uea_usbatm_driver = {
>  static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  {
>  	struct usb_device *usb = interface_to_usbdev(intf);
> +	struct uea_interface_data *uea_intf_data;
>  	int ret;
>  
>  	uea_enters(usb);
> @@ -2597,8 +2607,23 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  
>  	usb_reset_device(usb);
>  
> -	if (UEA_IS_PREFIRM(id))
> -		return uea_load_firmware(usb, UEA_CHIP_VERSION(id));
> +	if (UEA_IS_PREFIRM(id)) {
> +		uea_intf_data = devm_kzalloc(&usb->dev, sizeof(*uea_intf_data), GFP_KERNEL);
> +		if (!uea_intf_data)
> +			return -ENOMEM;
> +
> +		init_completion(&uea_intf_data->fw_upload_complete);
> +		uea_intf_data->usb = usb;
> +		uea_intf_data->intf = intf;
> +
> +		usb_set_intfdata(intf, uea_intf_data);
> +
> +		ret = uea_load_firmware(uea_intf_data, UEA_CHIP_VERSION(id));
> +		if (ret)
> +			complete(&uea_intf_data->fw_upload_complete);
> +
> +		return ret;
> +	}
>  
>  	ret = usbatm_usb_probe(intf, id, &uea_usbatm_driver);
>  	if (ret == 0) {
> @@ -2618,6 +2643,7 @@ static int uea_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  static void uea_disconnect(struct usb_interface *intf)
>  {
>  	struct usb_device *usb = interface_to_usbdev(intf);
> +	struct uea_interface_data *uea_intf_data;
>  	int ifnum = intf->altsetting->desc.bInterfaceNumber;
>  	uea_enters(usb);
>  
> @@ -2629,6 +2655,10 @@ static void uea_disconnect(struct usb_interface *intf)
>  		usbatm_usb_disconnect(intf);
>  		mutex_unlock(&uea_mutex);
>  		uea_info(usb, "ADSL device removed\n");
> +	} else {
> +		uea_intf_data = usb_get_intfdata(intf);
> +		uea_info(usb, "wait for completion uploading firmware\n");
> +		wait_for_completion(&uea_intf_data->fw_upload_complete);
>  	}
>  
>  	uea_leaves(usb);
> -- 
> 2.25.1
> 

