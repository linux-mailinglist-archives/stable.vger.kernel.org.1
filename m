Return-Path: <stable+bounces-121624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C7A5883C
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726AD7A28EC
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE6518FDC5;
	Sun,  9 Mar 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/NEDrcr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92B145A18
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741553211; cv=none; b=E3lRPD6heMVjInfz25aXRVwfzLkt57/VoOKmrSZqksArxzuQtJptWuRBikPEyVzNRsToIrgdfT0idbnhWGPRCXyFKyaGp2sTxY0erIAmHJgw76abM5t/EeMiz27xzOWKhrR/KsInBpKCV0kvzqeKR7hhuxLMCpRKncqgxQB4jCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741553211; c=relaxed/simple;
	bh=gqD9Lg03jjRwHLSnN560AZHrM5W9ZWaHXUe5k9F7VC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLERtKTKkzPf7UArWAqCrTeeTDzSbeCLbCIkO/usH3FEkXXgwFBhvoGwtp5TIpzUASoarC2vhVYta6bCMXqwecEQRj/fknk6vsucl+CijcKEBKHRjZrP53lCaYEMtwyte0c1dnWy+RvthyF0tZawV6R4DI0kaO6w//y9F9Kpr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/NEDrcr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so3617859e87.3
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741553207; x=1742158007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=De4c73TZo2aMarhixfoNUZAvRIIJWMV8jmo8FEVSrWg=;
        b=b/NEDrcrnq+JA1lexGu1ZqNpI0IFSJaoiMrj8gkG5oL8NSXz6Rp3U+tlBLUOtYKwzz
         g8fKwxKteV/FaFqzArxswXxoejeGr02Ji/eUOEQC4u2wsjXpw+z/tNiTPQPXqW4zAYhC
         o+L015gAB7jMB1Pqo7hSl54GXDv47D2cKGOAI6qjzf59bgaE0FyDdw/WicP6+5sEJSNE
         J5CCrj+bG95TXdZIC4KJCe0ggiUa+2rUmzyD7GhuH5+V6ezE2IcuTGjZhEaLCLgALhKR
         mpyWXy+HfI4CqfPuchCr1hUDxwZSqM7608CRDeFQTRqJlh2hlXTVDWGkUuxrgbkddDtl
         U+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741553207; x=1742158007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De4c73TZo2aMarhixfoNUZAvRIIJWMV8jmo8FEVSrWg=;
        b=kiD6TzDzAdCddXb8EFpoMdJew42GW6Fu6w2HCwDyMd6fk3Hm2wXuRErpgAm7BLVkAV
         g4gyd0hriJVt4uMicATDJg3MN2sD2WWA5sEKE2zZhM4KKSckv43g5RRExCQKSNT7dJvA
         ThSLl/jZTZLU0g4hrNMfb0P/z7NlAeKG540mpPZjopi76oDqR6N7hvpMRDI2hiooa2QD
         Ch1MiStpmgGqnTUL2HRQIkSz5SFSAJnp0PfK4kNxPJGhafNk+uss56hbhiFd6/I8n/J2
         Hp4Do1ZISgIyqrCkJmK6fpu0+L0QZPgqcfBcA3J0UV99pZLAi+SRCwGAuJfzm74m5vqp
         +AYg==
X-Forwarded-Encrypted: i=1; AJvYcCVrF/r2wEOP7afQy3mjIYC47hut0MXlhZzB2AFBjXwCtrdtJo9FdF0buYE9oIiHodd0tRpO5nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpT9hX8QWLCTsVJKZ/voSsb6aLdcJ+5MJghUZ1PnPkuUuut0m2
	bIWl+/yDfX9Ox2OLnu2HUchcYiQx3jydMjZ8HWklfyGbfcfEwcEqELBiKw==
X-Gm-Gg: ASbGncsmiuuUwlqRhttbvijRRrUP0TkRXm4VqQhCH0UzE+d8AaBAcwwxno5PH3UHCLt
	5BKncTL+4gM0HEI8o7YOzyHqqIGiV/6qf4nqF08OSjCPv9j1nGMENiAiszP001865eVsP2XEwgN
	IzyF5FEdDLJgq/48d5I1ZxXSKZMf40rih+Aj2woUxPKgi4N+EYhY9j0PKK/vryYx6OXQzxZ8jRs
	Q9k+Bgu9SRzYZCRYtkPbb99IQoTgt5STOLdY0VYPyx8vRUf0Tqn81T+R6jNPgIdZ/Cf9NYa8Udr
	03IEB6ENSzGmjNL+TVuAc52JUS1HUJQouas45ac2sYFVBoY2l+pXqQ==
X-Google-Smtp-Source: AGHT+IF5PV9CZuZcDG+ua6cTFKCTcl0mICdPVAQIBeaijmm/JNeoF1knHvuZCLJfQnNnLMeA5Otivw==
X-Received: by 2002:a05:6512:3ba5:b0:545:2544:6ae2 with SMTP id 2adb3069b0e04-54990e3ee03mr4386642e87.16.1741553206977;
        Sun, 09 Mar 2025 13:46:46 -0700 (PDT)
Received: from localhost (morra.ispras.ru. [83.149.199.253])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bcf82sm1216965e87.154.2025.03.09.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 13:46:46 -0700 (PDT)
Date: Sun, 9 Mar 2025 23:46:43 +0300
From: Fedor Pchelkin <boddah8794@gmail.com>
To: gregkh@linuxfoundation.org
Cc: lk@c--e.de, heikki.krogerus@linux.intel.com, stable@vger.kernel.org
Subject: Re: patch "acpi: typec: ucsi: Introduce a ->poll_cci method" added
 to usb-linus
Message-ID: <6y2km6lrqjfzgmf6aoetm6ts2b5okzoxzejtqpulkppudwgc5i@ja2oaw6ljqml>
References: <2025021909-thirstily-esteemed-c72c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025021909-thirstily-esteemed-c72c@gregkh>

On Wed, 19. Feb 15:20, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     acpi: typec: ucsi: Introduce a ->poll_cci method
> 
> to my usb git tree which can be found at
>     git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
> in the usb-linus branch.
> 
> The patch will show up in the next release of the linux-next tree
> (usually sometime within the next 24 hours during the week.)
> 
> The patch will hopefully also be merged in Linus's tree for the
> next -rc kernel release.
> 
> If you have any questions about this process, please let me know.
> 
> 
> From 976e7e9bdc7719a023a4ecccd2e3daec9ab20a40 Mon Sep 17 00:00:00 2001
> From: "Christian A. Ehrhardt" <lk@c--e.de>
> Date: Mon, 17 Feb 2025 13:54:39 +0300
> Subject: acpi: typec: ucsi: Introduce a ->poll_cci method
> 
> For the ACPI backend of UCSI the UCSI "registers" are just a memory copy
> of the register values in an opregion. The ACPI implementation in the
> BIOS ensures that the opregion contents are synced to the embedded
> controller and it ensures that the registers (in particular CCI) are
> synced back to the opregion on notifications. While there is an ACPI call
> that syncs the actual registers to the opregion there is rarely a need to
> do this and on some ACPI implementations it actually breaks in various
> interesting ways.
> 
> The only reason to force a sync from the embedded controller is to poll
> CCI while notifications are disabled. Only the ucsi core knows if this
> is the case and guessing based on the current command is suboptimal, i.e.
> leading to the following spurious assertion splat:
> 
> WARNING: CPU: 3 PID: 76 at drivers/usb/typec/ucsi/ucsi.c:1388 ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi]
> CPU: 3 UID: 0 PID: 76 Comm: kworker/3:0 Not tainted 6.12.11-200.fc41.x86_64 #1
> Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN45WW 03/17/2023
> Workqueue: events_long ucsi_init_work [typec_ucsi]
> RIP: 0010:ucsi_reset_ppm+0x1b4/0x1c0 [typec_ucsi]
> Call Trace:
>  <TASK>
>  ucsi_init_work+0x3c/0xac0 [typec_ucsi]
>  process_one_work+0x179/0x330
>  worker_thread+0x252/0x390
>  kthread+0xd2/0x100
>  ret_from_fork+0x34/0x50
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> 
> Thus introduce a ->poll_cci() method that works like ->read_cci() with an
> additional forced sync and document that this should be used when polling
> with notifications disabled. For all other backends that presumably don't
> have this issue use the same implementation for both methods.
> 
> Fixes: fa48d7e81624 ("usb: typec: ucsi: Do not call ACPI _DSM method for UCSI read operations")
> Cc: stable <stable@kernel.org>

Oh, the stable tag has been mangled here.. I didn't notice this, sorry.
Now Cc'ing the appropriate list.

Could you apply the patch to stables based on Fixes tag then, please?
They are 6.12 and 6.13.

Thanks!

> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> Tested-by: Fedor Pchelkin <boddah8794@gmail.com>
> Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Link: https://lore.kernel.org/r/20250217105442.113486-2-boddah8794@gmail.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/typec/ucsi/ucsi.c           | 10 +++++-----
>  drivers/usb/typec/ucsi/ucsi.h           |  2 ++
>  drivers/usb/typec/ucsi/ucsi_acpi.c      | 21 ++++++++++++++-------
>  drivers/usb/typec/ucsi/ucsi_ccg.c       |  1 +
>  drivers/usb/typec/ucsi/ucsi_glink.c     |  1 +
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c   |  1 +
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c |  1 +
>  7 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index fcf499cc9458..0fe1476f4c29 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1346,7 +1346,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
>  
>  	mutex_lock(&ucsi->ppm_lock);
>  
> -	ret = ucsi->ops->read_cci(ucsi, &cci);
> +	ret = ucsi->ops->poll_cci(ucsi, &cci);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -1364,7 +1364,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
>  
>  		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
>  		do {
> -			ret = ucsi->ops->read_cci(ucsi, &cci);
> +			ret = ucsi->ops->poll_cci(ucsi, &cci);
>  			if (ret < 0)
>  				goto out;
>  			if (cci & UCSI_CCI_COMMAND_COMPLETE)
> @@ -1393,7 +1393,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
>  		/* Give the PPM time to process a reset before reading CCI */
>  		msleep(20);
>  
> -		ret = ucsi->ops->read_cci(ucsi, &cci);
> +		ret = ucsi->ops->poll_cci(ucsi, &cci);
>  		if (ret)
>  			goto out;
>  
> @@ -1929,8 +1929,8 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
>  	struct ucsi *ucsi;
>  
>  	if (!ops ||
> -	    !ops->read_version || !ops->read_cci || !ops->read_message_in ||
> -	    !ops->sync_control || !ops->async_control)
> +	    !ops->read_version || !ops->read_cci || !ops->poll_cci ||
> +	    !ops->read_message_in || !ops->sync_control || !ops->async_control)
>  		return ERR_PTR(-EINVAL);
>  
>  	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 82735eb34f0e..28780acc4af2 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -62,6 +62,7 @@ struct dentry;
>   * struct ucsi_operations - UCSI I/O operations
>   * @read_version: Read implemented UCSI version
>   * @read_cci: Read CCI register
> + * @poll_cci: Read CCI register while polling with notifications disabled
>   * @read_message_in: Read message data from UCSI
>   * @sync_control: Blocking control operation
>   * @async_control: Non-blocking control operation
> @@ -76,6 +77,7 @@ struct dentry;
>  struct ucsi_operations {
>  	int (*read_version)(struct ucsi *ucsi, u16 *version);
>  	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
> +	int (*poll_cci)(struct ucsi *ucsi, u32 *cci);
>  	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t val_len);
>  	int (*sync_control)(struct ucsi *ucsi, u64 command);
>  	int (*async_control)(struct ucsi *ucsi, u64 command);
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 5c5515551963..ac1ebb5d9527 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -59,19 +59,24 @@ static int ucsi_acpi_read_version(struct ucsi *ucsi, u16 *version)
>  static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
>  {
>  	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> -	int ret;
> -
> -	if (UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
> -		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
> -		if (ret)
> -			return ret;
> -	}
>  
>  	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
>  
>  	return 0;
>  }
>  
> +static int ucsi_acpi_poll_cci(struct ucsi *ucsi, u32 *cci)
> +{
> +	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> +	int ret;
> +
> +	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
> +	if (ret)
> +		return ret;
> +
> +	return ucsi_acpi_read_cci(ucsi, cci);
> +}
> +
>  static int ucsi_acpi_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
>  {
>  	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> @@ -94,6 +99,7 @@ static int ucsi_acpi_async_control(struct ucsi *ucsi, u64 command)
>  static const struct ucsi_operations ucsi_acpi_ops = {
>  	.read_version = ucsi_acpi_read_version,
>  	.read_cci = ucsi_acpi_read_cci,
> +	.poll_cci = ucsi_acpi_poll_cci,
>  	.read_message_in = ucsi_acpi_read_message_in,
>  	.sync_control = ucsi_sync_control_common,
>  	.async_control = ucsi_acpi_async_control
> @@ -142,6 +148,7 @@ static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
>  static const struct ucsi_operations ucsi_gram_ops = {
>  	.read_version = ucsi_acpi_read_version,
>  	.read_cci = ucsi_acpi_read_cci,
> +	.poll_cci = ucsi_acpi_poll_cci,
>  	.read_message_in = ucsi_gram_read_message_in,
>  	.sync_control = ucsi_gram_sync_control,
>  	.async_control = ucsi_acpi_async_control
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 740171f24ef9..4b1668733a4b 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -664,6 +664,7 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
>  static const struct ucsi_operations ucsi_ccg_ops = {
>  	.read_version = ucsi_ccg_read_version,
>  	.read_cci = ucsi_ccg_read_cci,
> +	.poll_cci = ucsi_ccg_read_cci,
>  	.read_message_in = ucsi_ccg_read_message_in,
>  	.sync_control = ucsi_ccg_sync_control,
>  	.async_control = ucsi_ccg_async_control,
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index fed39d458090..8af79101a2fc 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -206,6 +206,7 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
>  static const struct ucsi_operations pmic_glink_ucsi_ops = {
>  	.read_version = pmic_glink_ucsi_read_version,
>  	.read_cci = pmic_glink_ucsi_read_cci,
> +	.poll_cci = pmic_glink_ucsi_read_cci,
>  	.read_message_in = pmic_glink_ucsi_read_message_in,
>  	.sync_control = ucsi_sync_control_common,
>  	.async_control = pmic_glink_ucsi_async_control,
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index 6923fad31d79..57ef7d83a412 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -424,6 +424,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
>  static const struct ucsi_operations ucsi_stm32g0_ops = {
>  	.read_version = ucsi_stm32g0_read_version,
>  	.read_cci = ucsi_stm32g0_read_cci,
> +	.poll_cci = ucsi_stm32g0_read_cci,
>  	.read_message_in = ucsi_stm32g0_read_message_in,
>  	.sync_control = ucsi_sync_control_common,
>  	.async_control = ucsi_stm32g0_async_control,
> diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> index 4cae85c0dc12..d33e3f2dd1d8 100644
> --- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> +++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> @@ -74,6 +74,7 @@ static int yoga_c630_ucsi_async_control(struct ucsi *ucsi, u64 command)
>  static const struct ucsi_operations yoga_c630_ucsi_ops = {
>  	.read_version = yoga_c630_ucsi_read_version,
>  	.read_cci = yoga_c630_ucsi_read_cci,
> +	.poll_cci = yoga_c630_ucsi_read_cci,
>  	.read_message_in = yoga_c630_ucsi_read_message_in,
>  	.sync_control = ucsi_sync_control_common,
>  	.async_control = yoga_c630_ucsi_async_control,
> -- 
> 2.48.1
> 
> 

