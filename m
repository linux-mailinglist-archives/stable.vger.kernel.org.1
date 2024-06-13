Return-Path: <stable+bounces-50494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EDB906A4B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07B41F21D88
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8C142E8F;
	Thu, 13 Jun 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFxjG76h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0141428F7;
	Thu, 13 Jun 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275479; cv=none; b=h9vybopRTvuF+S8Hwrw23X9U3fIvHArbBzp48GCWrAwNIGI3PkkPdB/focXEd0Sn4VId4wCAldQeNV+v6szVQwd+cAjbAuCDTiJ5PMqSlS6KYi8MmUWMyb/hTVgnN/yaFxivTxuDOHp2MLH8lxSemo87rfFzBcBJamSRpaIe7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275479; c=relaxed/simple;
	bh=W3+ttgDIdBTkKzgo2dVVa4/yBGEx95jS9AbN62ug2yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWlpxtyELTN7G7H2CLoYx70Zb0vT/9T+Z+r1oxgNzI1UcGnIyoPmdSfzDOLUhrjv4qufs+xP+kyFsiChdq8Eb0SyvyBv/pWwzJzVHCzlyc+X7jG1nBHbjR8X/z1e0iFVbYdUcKD3Gm3IaEoXpANhTOYrBQxIlOR06SXFnYNjeXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFxjG76h; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718275478; x=1749811478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W3+ttgDIdBTkKzgo2dVVa4/yBGEx95jS9AbN62ug2yQ=;
  b=TFxjG76hS0fnzlOPH6AHoqSvpJ6CGK1vzwfBGJkINGWFmjnAC42VTSOS
   fGU1hd8OI8LDh6ZQI6M1LYZM2cqi1oK3/9GJg4eP2d+g2o30fd9JjrJX1
   fpQgQQgPj+NETeoNeNUowS47iIDl807WNlJXO/Hb55fzQ+VhAkjVBjvHL
   4WT7EoMr2l683Q7PoTYIpprXjH7gyg7UDW/yte3NXAu1qt8D/rOIypPf1
   cZtaK/eusevyPZ220Xx6nvquefjlxd1A3xje6YoRdMm4j3kmDLj1P7q06
   Xh3TwLk1TRlQYZkEMW4ZJe1XcaJ38soNGeyI3qgAWiBtP6LqzQIrK5whL
   Q==;
X-CSE-ConnectionGUID: bFSaHCXxT3+0nnnLtHjpTg==
X-CSE-MsgGUID: u65If41HQfOCgCEHusugMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15212925"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15212925"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 03:44:37 -0700
X-CSE-ConnectionGUID: MSJrrvwrR6iuPIQgX7QQNA==
X-CSE-MsgGUID: eA9bH91KSbKf3OF5CWMfOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40585831"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa006.jf.intel.com with SMTP; 13 Jun 2024 03:44:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Jun 2024 13:44:33 +0300
Date: Thu, 13 Jun 2024 13:44:33 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org,
	dmitry.baryshkov@linaro.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] usb: ucsi: stm32: fix command completion handling
Message-ID: <ZmrNkTXkOQIcbwGa@kuha.fi.intel.com>
References: <20240612124656.2305603-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612124656.2305603-1-fabrice.gasnier@foss.st.com>

On Wed, Jun 12, 2024 at 02:46:56PM +0200, Fabrice Gasnier wrote:
> Sometimes errors are seen, when doing DR swap, like:
> [   24.672481] ucsi-stm32g0-i2c 0-0035: UCSI_GET_PDOS failed (-5)
> [   24.720188] ucsi-stm32g0-i2c 0-0035: ucsi_handle_connector_change:
>  GET_CONNECTOR_STATUS failed (-5)
> 
> There may be some race, which lead to read CCI, before the command complete
> flag is set, hence returning -EIO. Similar fix has been done also in
> ucsi_acpi [1].
> 
> In case of a spurious or otherwise delayed notification it is
> possible that CCI still reports the previous completion. The
> UCSI spec is aware of this and provides two completion bits in
> CCI, one for normal commands and one for acks. As acks and commands
> alternate the notification handler can determine if the completion
> bit is from the current command.
> 
> To fix this add the ACK_PENDING bit for ucsi_stm32g0 and only complete
> commands if the completion bit matches.
> 
> [1] https://lore.kernel.org/lkml/20240121204123.275441-3-lk@c--e.de/
> 
> Fixes: 72849d4fcee7 ("usb: typec: ucsi: stm32g0: add support for stm32g0 controller")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2: rebase and define ACK_PENDING as commented by Dmitry.
> ---
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> index ac48b7763114..ac69288e8bb0 100644
> --- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> +++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
> @@ -65,6 +65,7 @@ struct ucsi_stm32g0 {
>  	struct device *dev;
>  	unsigned long flags;
>  #define COMMAND_PENDING	1
> +#define ACK_PENDING	2
>  	const char *fw_name;
>  	struct ucsi *ucsi;
>  	bool suspended;
> @@ -396,9 +397,13 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
>  				   size_t len)
>  {
>  	struct ucsi_stm32g0 *g0 = ucsi_get_drvdata(ucsi);
> +	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
>  	int ret;
>  
> -	set_bit(COMMAND_PENDING, &g0->flags);
> +	if (ack)
> +		set_bit(ACK_PENDING, &g0->flags);
> +	else
> +		set_bit(COMMAND_PENDING, &g0->flags);
>  
>  	ret = ucsi_stm32g0_async_write(ucsi, offset, val, len);
>  	if (ret)
> @@ -406,9 +411,14 @@ static int ucsi_stm32g0_sync_write(struct ucsi *ucsi, unsigned int offset, const
>  
>  	if (!wait_for_completion_timeout(&g0->complete, msecs_to_jiffies(5000)))
>  		ret = -ETIMEDOUT;
> +	else
> +		return 0;
>  
>  out_clear_bit:
> -	clear_bit(COMMAND_PENDING, &g0->flags);
> +	if (ack)
> +		clear_bit(ACK_PENDING, &g0->flags);
> +	else
> +		clear_bit(COMMAND_PENDING, &g0->flags);
>  
>  	return ret;
>  }
> @@ -429,8 +439,9 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
>  	if (UCSI_CCI_CONNECTOR(cci))
>  		ucsi_connector_change(g0->ucsi, UCSI_CCI_CONNECTOR(cci));
>  
> -	if (test_bit(COMMAND_PENDING, &g0->flags) &&
> -	    cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))
> +	if (cci & UCSI_CCI_ACK_COMPLETE && test_and_clear_bit(ACK_PENDING, &g0->flags))
> +		complete(&g0->complete);
> +	if (cci & UCSI_CCI_COMMAND_COMPLETE && test_and_clear_bit(COMMAND_PENDING, &g0->flags))
>  		complete(&g0->complete);
>  
>  	return IRQ_HANDLED;
> -- 
> 2.25.1

-- 
heikki

