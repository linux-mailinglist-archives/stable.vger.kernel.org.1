Return-Path: <stable+bounces-238127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JKQJgSM32l5VAAAu9opvQ
	(envelope-from <stable+bounces-238127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:00:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D584049C9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0AE93008D40
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19738AC88;
	Wed, 15 Apr 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbNZ7LSN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92738AC70;
	Wed, 15 Apr 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258046; cv=none; b=UCfZ7AdoRdgy1w3O0zfKFiS6se+lFPR90ZaP5BVrckyswh25G7J/qehcquiHTUvWMdq9612NyEe/Ku6sAaBcBDpCQKnXqpLoRleyfwgQFOf69yHY1cUEFwhpCSKKsz06tB0/Q4LsUUtD3nTHicpVXBoGBXKjuSHnocBwbYWGFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258046; c=relaxed/simple;
	bh=/wccTYWZkHPLieysDH0nItTYtUN2HBNV8VPv1JcjhNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKYMyyn4b718+bxFhwwP6uGNzJKwlMsFdvLJ8k8Yjqe1SHtSxKH9N/5tEzhSQNr+PG3ZFevhz2G3kzBy4ixtsbDnvXy2WCSHf8sskeDJeQzpCe5PDxBrIc8eATDVSOsr2/an3ABO0Pqi+4NxwVJmLSkLiaoi/4WT5HvWtv/j8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbNZ7LSN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776258046; x=1807794046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/wccTYWZkHPLieysDH0nItTYtUN2HBNV8VPv1JcjhNY=;
  b=IbNZ7LSNPBdbTEtPHL/V+92f7QoFGPJIRh5MnktbOe6iSxOmJzwc4Ih1
   Xj6vy0uANHDL3+7/49RcXW4worSjGlnw464CRh7lmEx8ZdZNKTw8Giw14
   ka+yPRFBlbEbdVCdycP8Ww0ZQWjgT30Y/4slHHnfBSnowO/i84JttSOtT
   /TPos6M1R7dYWPOdPMQKrnt89DyQfHopTm08cJnzfbgcdK5ZvtvRO+dvD
   y6v1NxeLTj8Y93QDzQ6wf5hh+Id5OHGzc2gZcxVp3tdPOZestmOpn/yBQ
   bNVQozEJfeFN+wweWJo8X0ScxsevUEP/7wvAnNxXfQuw0XlO5n8j9E4mg
   A==;
X-CSE-ConnectionGUID: yPNtaw3GQ3624iNqXETOtw==
X-CSE-MsgGUID: KBjWguGiQwe8XUUhK9qZhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88313864"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88313864"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 06:00:45 -0700
X-CSE-ConnectionGUID: 0y2B0AZdSyKAIrvs1wiC8Q==
X-CSE-MsgGUID: U+Luu9TuSl2B/4+jYIOGyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223912003"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 15 Apr 2026 06:00:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 12B2495; Wed, 15 Apr 2026 15:00:41 +0200 (CEST)
Date: Wed, 15 Apr 2026 15:59:49 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kyle Tso <kyletso@google.com>, Guenter Roeck <groeck@chromium.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: reset internal port states on soft
 reset AMS
Message-ID: <ad-LxWf5pYemrT9c@kuha>
References: <20260414-fix-soft-reset-v1-1-01d7cb9764e2@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-fix-soft-reset-v1-1-01d7cb9764e2@google.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238127-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3D584049C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 12:58:32AM +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Reset internal port states (such as vdm_sm_running and
> explicit_contract) on soft reset AMS as the port needs to negotiate a
> new contract. The consequence of leaving the states in as-is cond are as
> follows:
>   * port is in SRC power role and an explicit contract is negotiated
>     with the port partner (in sink role)
>   * port partner sends a Soft Reset AMS while VDM State Machine is
>     running
>   * port accepts the Soft Reset request and the port advertises src caps
>   * port partner sends a Request message but since the explicit_contract
>     and vdm_sm_running are true from previous negotiation, the port ends
>     up sending Soft Reset instead of Accept msg.
> 
> Stub Log:
> [  203.653942] AMS DISCOVER_IDENTITY start
> [  203.653947] PD TX, header: 0x176f
> [  203.655901] PD TX complete, status: 0
> [  203.657470] PD RX, header: 0x124f [1]
> [  203.657477] Rx VDM cmd 0xff008081 type 2 cmd 1 len 1
> [  203.657482] AMS DISCOVER_IDENTITY finished
> [  203.657484] cc:=4
> [  204.155698] PD RX, header: 0x144f [1]
> [  204.155718] Rx VDM cmd 0xeeee8001 type 0 cmd 1 len 1
> [  204.155741] PD TX, header: 0x196f
> [  204.157622] PD TX complete, status: 0
> [  204.160060] PD RX, header: 0x4d [1]
> [  204.160066] state change SRC_READY -> SOFT_RESET [rev2 SOFT_RESET_AMS]
> [  204.160076] PD TX, header: 0x163
> [  204.162486] PD TX complete, status: 0
> [  204.162832] AMS SOFT_RESET_AMS finished
> [  204.162840] cc:=4
> [  204.162891] AMS POWER_NEGOTIATION start
> [  204.162896] state change SOFT_RESET -> AMS_START [rev2 POWER_NEGOTIATION]
> [  204.162908] state change AMS_START -> SRC_SEND_CAPABILITIES [rev2 POWER_NEGOTIATION]
> [  204.162913] PD TX, header: 0x1361
> [  204.165529] PD TX complete, status: 0
> [  204.165571] pending state change SRC_SEND_CAPABILITIES -> SRC_SEND_CAPABILITIES_TIMEOUT @ 60 ms [rev2 POWER_NEGOTIATION]
> [  204.166996] PD RX, header: 0x1242 [1]
> [  204.167009] state change SRC_SEND_CAPABILITIES -> SRC_SOFT_RESET_WAIT_SNK_TX [rev2 POWER_NEGOTIATION]
> [  204.167019] AMS POWER_NEGOTIATION finished
> [  204.167020] cc:=4
> [  204.167083] AMS SOFT_RESET_AMS start
> [  204.167086] state change SRC_SOFT_RESET_WAIT_SNK_TX -> SOFT_RESET_SEND [rev2 SOFT_RESET_AMS]
> [  204.167092] PD TX, header: 0x16d
> [  204.168824] PD TX complete, status: 0
> [  204.168854] pending state change SOFT_RESET_SEND -> HARD_RESET_SEND @ 60 ms [rev2 SOFT_RESET_AMS]
> [  204.171876] PD RX, header: 0x43 [1]
> [  204.171879] AMS SOFT_RESET_AMS finished
> 
> This causes COMMON.PROC.PD.11.2 check failure for
> TEST.PD.VDM.SRC.2_Rev2Src test on the PD compliance tester.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Fixes: 8d3a0578ad1a ("usb: typec: tcpm: Respond Wait if VDM state machine is running")
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 8e0e14a2704e..c73e5daafcf1 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5534,6 +5534,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
>  		port->partner_source_caps = NULL;
>  		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
> +		port->vdm_sm_running = false;
> +		port->explicit_contract = false;
>  		tcpm_ams_finish(port);
>  		if (port->pwr_role == TYPEC_SOURCE) {
>  			port->upcoming_state = SRC_SEND_CAPABILITIES;
> 
> ---
> base-commit: 81dc1e4d32b064ac47abc60b0acbf49b66a34d52
> change-id: 20260407-fix-soft-reset-e857ff5e9d36
> 
> Best regards,
> -- 
> Amit Sunil Dhamne <amitsd@google.com>
> 

-- 
heikki

