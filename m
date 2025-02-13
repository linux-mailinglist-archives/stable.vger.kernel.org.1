Return-Path: <stable+bounces-115146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64065A340E6
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF27188CC48
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD838DC8;
	Thu, 13 Feb 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/2Md6kD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C5E24BBE0;
	Thu, 13 Feb 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454995; cv=none; b=JuOli79Uv0Dba6r1cjC+WRhKSINHCNnQNo1Vm5HnLbiLKkU5FVP+KYhjqZxbmOc1dEBymvpeBCfNhQEU0bIixbLwGYnyoqx1p2MLCZ6aMCxyleIBKSyndKq0+cHo1bLo10GIzIeUZlpxohY/gMevaMSO14PhEvpNv5bS1iZmhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454995; c=relaxed/simple;
	bh=rRHidVDXPWVK+x9+ECREWygbSwTa4kcxMK3/9SuWWMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDNID4vBzxnHeAuZzegHZcrBdKOzwb4jDyHT7PYsKfsJ8aun8c/XKzRrBKnCtKolhE0jOMTSeLFJT+eX32IeJxEgokfSSfs0fl8deggIwDwBrMt7YJfl9l+l4O2lwwKATQf73VCGI7r+wiw4Cr/tEhZe5ihQ1sBYa7lo1oJ44Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/2Md6kD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454993; x=1770990993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rRHidVDXPWVK+x9+ECREWygbSwTa4kcxMK3/9SuWWMo=;
  b=h/2Md6kDXdZ5sMbQNL9+oxQ7fA0VsU4q4yEmQNx8vk4Y57I/GY4g8tqV
   xmFRbMX2oRa64SSVMwc4IgpWcBCpNFzUFDtJ/5su9QYmd+LiMNy/v/ZuA
   AFcexFO6Tm2xzVH5T9yQuxu1A6J+e9j+3s7HOGEJGHnEZFfvKisSW3VOa
   tAsa/ITddv449eRgkiTGDjwUSDVqkkcbBg8yNzU0+3YIrguDYCZkL5FHJ
   1EyPIcLL+2KkU8ENgTmCAw+moo0AqT7+AsHXuRbyPaA99Bk5b6v27cLNa
   4R/Uskxyyu8X8w4NLsOmQW/0hsXPa4yqpPh120LeU2hU0XM4TpLGRSLfn
   A==;
X-CSE-ConnectionGUID: usuFaIf2S3W2cZUFNp6THw==
X-CSE-MsgGUID: gm+bhbl6Q9aV6/gpNUX2JQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40020193"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40020193"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:56:32 -0800
X-CSE-ConnectionGUID: tBdZYrHFTp2+93dA3mNCjQ==
X-CSE-MsgGUID: yvVN0Zu6TNqP5j8o4PthVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118081248"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 13 Feb 2025 05:56:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Feb 2025 15:56:26 +0200
Date: Thu, 13 Feb 2025 15:56:26 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fedor Pchelkin <boddah8794@gmail.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Pearson <mpearson@squebb.ca>,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] acpi: typec: ucsi: Introduce a ->poll_cci method
Message-ID: <Z636Cn5rbvWmfRbc@kuha.fi.intel.com>
References: <20250206184327.16308-1-boddah8794@gmail.com>
 <20250206184327.16308-2-boddah8794@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206184327.16308-2-boddah8794@gmail.com>

On Thu, Feb 06, 2025 at 09:43:14PM +0300, Fedor Pchelkin wrote:
> From: "Christian A. Ehrhardt" <lk@c--e.de>
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> Tested-by: Fedor Pchelkin <boddah8794@gmail.com>
> Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Add the explicit WARNING splat and slightly increase the length of text
> lines in the changelog.
> Original patch: https://lore.kernel.org/linux-usb/Z2Cf1AI8CXao5ZAn@cae.in-ulm.de/
> 
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

-- 
heikki

