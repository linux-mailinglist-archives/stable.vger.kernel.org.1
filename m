Return-Path: <stable+bounces-141801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F318DAAC29B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98EDC7B8CA9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 11:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277E27A471;
	Tue,  6 May 2025 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SN8dQJpX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57872627;
	Tue,  6 May 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530834; cv=none; b=Vf9qO1rCLXL7+WISW5BjZJL5l5kTC3UYn/RQLYvJGcCUMDFYBQPc4eF4/om6dv5P4RS/60uvcXjvtvI5weOFwOC1VRRoK2C6IZJb7EK/zV+yBBKUmyHm26dkKiEnLVH3o7bFTLovLk4fyVEarPQWAFYcPA83ZBVmqwRs+67RCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530834; c=relaxed/simple;
	bh=9EF9UJoz/+dWUP5w1cdIK76VhKZ6qJwu09x9cqS8els=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F24dJMJsmbJl4Xn0AsKuIZFA0HI00z4WqhJB48//699G5R0S2E3mQe2fDA64FY3qUtqpRHM4dWXRQ290an/VYUgquZ/Rq/TQt96o+j6RQwRT/Mem/r6UwO+Mfcu3rnummKmtlbMejt0F+547g7Ac2OA57Npb0wADFxaSwuq1ROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SN8dQJpX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746530833; x=1778066833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9EF9UJoz/+dWUP5w1cdIK76VhKZ6qJwu09x9cqS8els=;
  b=SN8dQJpXMcqV7VlyS8m8NYnNM3ajBy+L0P/MOniUF/BzpvvXNZ4srcMb
   ozNxQXYe1Ze/kWNRjh1xS+uX1UlqzR+We0VG0GCLmi/n95AZn1duDO78J
   di8m9FN77jIVlvUZvuJ+lhiG7Q3dKLTtlM4doXUrwSbhclhU3vR9BX5gv
   3BCYJ1P+xbMBYVO9O9inom+8k65yJWQg7WJv9vERSvrOwJEZbfvia1+Pf
   qYgg2df6GZd9JtJV10SOUFsGDfw1h/fI1c9moqcVHZGBojrnL/IIK4ykP
   6/Byemv8TGE6mKRJdz4AJ74D/YoKsXVaADquIn0eQHdzDyWMv6EjFgNJM
   g==;
X-CSE-ConnectionGUID: J8ztO2xeRjKY54p06e24og==
X-CSE-MsgGUID: M4G/8qfqQ6SU8qM7UM8JRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48064398"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="48064398"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 04:27:13 -0700
X-CSE-ConnectionGUID: uVjdQnw7Rui1qGxHDP0Gag==
X-CSE-MsgGUID: YywYDH9EThSPC4tzV73gzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="136087280"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 06 May 2025 04:27:09 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 06 May 2025 14:27:08 +0300
Date: Tue, 6 May 2025 14:27:08 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: RD Babiera <rdbabiera@google.com>
Cc: badhri@google.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: move tcpm_queue_vdm_unlocked to
 asynchronous work
Message-ID: <aBnyDL-GK9WFFXzs@kuha.fi.intel.com>
References: <20250429234908.3751116-2-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429234908.3751116-2-rdbabiera@google.com>

On Tue, Apr 29, 2025 at 11:49:08PM +0000, RD Babiera wrote:
> A state check was previously added to tcpm_queue_vdm_unlocked to
> prevent a deadlock where the DisplayPort Alt Mode driver would be
> executing work and attempting to grab the tcpm_lock while the TCPM
> was holding the lock and attempting to unregister the altmode, blocking
> on the altmode driver's cancel_work_sync call.
> 
> Because the state check isn't protected, there is a small window
> where the Alt Mode driver could determine that the TCPM is
> in a ready state and attempt to grab the lock while the
> TCPM grabs the lock and changes the TCPM state to one that
> causes the deadlock.
> 
> Change tcpm_queue_vdm_unlocked to queue for tcpm_queue_vdm_work,
> which can perform the state check while holding the TCPM lock
> while the Alt Mode lock is no longer held. This requires a new
> struct to hold the vdm data, altmode_vdm_event.
> 
> Fixes: cdc9946ea637 ("usb: typec: tcpm: enforce ready state when queueing alt mode vdm")
> Cc: stable@vger.kernel.org
> Signed-off-by: RD Babiera <rdbabiera@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 91 +++++++++++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 784fa23102f9..9b8d98328ddb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -597,6 +597,15 @@ struct pd_rx_event {
>  	enum tcpm_transmit_type rx_sop_type;
>  };
>  
> +struct altmode_vdm_event {
> +	struct kthread_work work;
> +	struct tcpm_port *port;
> +	u32 header;
> +	u32 *data;
> +	int cnt;
> +	enum tcpm_transmit_type tx_sop_type;
> +};
> +
>  static const char * const pd_rev[] = {
>  	[PD_REV10]		= "rev1",
>  	[PD_REV20]		= "rev2",
> @@ -1610,18 +1619,68 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
>  	mod_vdm_delayed_work(port, 0);
>  }
>  
> -static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
> -				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
> +static void tcpm_queue_vdm_work(struct kthread_work *work)
>  {
> -	if (port->state != SRC_READY && port->state != SNK_READY &&
> -	    port->state != SRC_VDM_IDENTITY_REQUEST)
> -		return;
> +	struct altmode_vdm_event *event = container_of(work,
> +						       struct altmode_vdm_event,
> +						       work);
> +	struct tcpm_port *port = event->port;
>  
>  	mutex_lock(&port->lock);
> -	tcpm_queue_vdm(port, header, data, cnt, tx_sop_type);
> +	if (port->state != SRC_READY && port->state != SNK_READY &&
> +	    port->state != SRC_VDM_IDENTITY_REQUEST) {
> +		tcpm_log_force(port, "dropping altmode_vdm_event");
> +		goto port_unlock;
> +	}
> +
> +	tcpm_queue_vdm(port, event->header, event->data, event->cnt, event->tx_sop_type);
> +
> +port_unlock:
> +	kfree(event->data);
> +	kfree(event);
>  	mutex_unlock(&port->lock);
>  }
>  
> +static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
> +				   const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
> +{
> +	struct altmode_vdm_event *event;
> +	u32 *data_cpy;
> +	int ret = -ENOMEM;
> +
> +	event = kzalloc(sizeof(*event), GFP_KERNEL);
> +	if (!event)
> +		goto err_event;
> +
> +	data_cpy = kcalloc(cnt, sizeof(u32), GFP_KERNEL);
> +	if (!data_cpy)
> +		goto err_data;
> +
> +	kthread_init_work(&event->work, tcpm_queue_vdm_work);
> +	event->port = port;
> +	event->header = header;
> +	memcpy(data_cpy, data, sizeof(u32) * cnt);
> +	event->data = data_cpy;
> +	event->cnt = cnt;
> +	event->tx_sop_type = tx_sop_type;
> +
> +	ret = kthread_queue_work(port->wq, &event->work);
> +	if (!ret) {
> +		ret = -EBUSY;
> +		goto err_queue;
> +	}
> +
> +	return 0;
> +
> +err_queue:
> +	kfree(data_cpy);
> +err_data:
> +	kfree(event);
> +err_event:
> +	tcpm_log_force(port, "failed to queue altmode vdm, err:%d", ret);
> +	return ret;
> +}
> +
>  static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
>  {
>  	u32 vdo = p[VDO_INDEX_IDH];
> @@ -2832,8 +2891,7 @@ static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
>  	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
> -	return 0;
> +	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
>  }
>  
>  static int tcpm_altmode_exit(struct typec_altmode *altmode)
> @@ -2849,8 +2907,7 @@ static int tcpm_altmode_exit(struct typec_altmode *altmode)
>  	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
> -	return 0;
> +	return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
>  }
>  
>  static int tcpm_altmode_vdm(struct typec_altmode *altmode,
> @@ -2858,9 +2915,7 @@ static int tcpm_altmode_vdm(struct typec_altmode *altmode,
>  {
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
> -
> -	return 0;
> +	return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
>  }
>  
>  static const struct typec_altmode_ops tcpm_altmode_ops = {
> @@ -2884,8 +2939,7 @@ static int tcpm_cable_altmode_enter(struct typec_altmode *altmode, enum typec_pl
>  	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
> -	return 0;
> +	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
>  }
>  
>  static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_index sop)
> @@ -2901,8 +2955,7 @@ static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plu
>  	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
>  	header |= VDO_OPOS(altmode->mode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
> -	return 0;
> +	return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
>  }
>  
>  static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
> @@ -2910,9 +2963,7 @@ static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug
>  {
>  	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
>  
> -	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
> -
> -	return 0;
> +	return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
>  }
>  
>  static const struct typec_cable_ops tcpm_cable_ops = {
> 
> base-commit: 615dca38c2eae55aff80050275931c87a812b48c
> -- 
> 2.49.0.967.g6a0df3ecc3-goog

-- 
heikki

