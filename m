Return-Path: <stable+bounces-223627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAMoO3q/rmlEIgIAu9opvQ
	(envelope-from <stable+bounces-223627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:39:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F20238FA7
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1BD630480DF
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298133AE6F7;
	Mon,  9 Mar 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ks+zwjWs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C339B497;
	Mon,  9 Mar 2026 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059689; cv=none; b=OHW+Yp7kMCllW5MAJ2ma7R+4TVhcW0KGxSWtu/2UD090dujUbVKZlgx0ptsLW+eSeA1aabp9kBWA1hkjjvEb3VzROKMjiwzATmHkOq2Z5cAUMvwJefTcpbohIH+bkbdX1gskyP9AY7SBfTeYey5jb44DAa8Zqc+qXu0ES6KI+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059689; c=relaxed/simple;
	bh=wg8mg67bFchKR6v8pq2bgoEz70tjgDBBfZfCusw7MDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgxTOubvXKO8AiaaLZHUnSKhmollHpEbHnYnsMdeVODF/Pou0FO8zWqW4cmSEdoz4Q09itA+fZt+V6YzzCEVaoLzEAmARLe7PkKpZjDJDP6BmbGDT6AVkg+5LMmtP2BfFP/nx8awRdmswMWQTnVUu+G/1WZMBmOt7yCWJECRicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ks+zwjWs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773059687; x=1804595687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wg8mg67bFchKR6v8pq2bgoEz70tjgDBBfZfCusw7MDI=;
  b=ks+zwjWseahKp/NCxIzahYuJnYugY/Ckz4kOCxaNcauOe+3Ksx54oBmW
   H3H8abEAD0TIhe7LBi2WnxfpKVBOCHMnAM3LrprtASzvqGVefoNpFnCmb
   9/vTgXqrilO85N04grRc7i0aYn0RmRdXKgGpD/8V/Od0cmHUqKTrdXzkw
   44E/8IeHBQA5hxMuLt9y7HUglOn2O4VFUpg9FDlw5NN/2g4mZmqeCuC83
   XQ1oGo3rdGxCGpsJBqtwGLb4UT0xbY2emBwQQ5deq04U8sXMa35ThM/rV
   1uiSq1I7FSTwG5G9Pzja/zPt/+5KEwEF5iDC/DOJYPXY4qGgSHhSliVQj
   w==;
X-CSE-ConnectionGUID: vFt3yaXdRIu8drU4firY5A==
X-CSE-MsgGUID: tqMiT+jiSymW4UUzOQR8Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73957781"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73957781"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 05:34:46 -0700
X-CSE-ConnectionGUID: +gRFDYFiSqySHoRVZ6kxKg==
X-CSE-MsgGUID: kdNVr1ghSlSqyE5hPjuTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224439229"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 09 Mar 2026 05:34:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0282198; Mon, 09 Mar 2026 13:34:42 +0100 (CET)
Date: Mon, 9 Mar 2026 14:34:01 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: improve handling of DISCOVER_MODES
 failures
Message-ID: <aa6-OfD4JQ68uBCL@kuha>
References: <20260303-tcpm-discover-modes-nak-fix-v2-1-5a630070025a@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-tcpm-discover-modes-nak-fix-v2-1-5a630070025a@collabora.com>
X-Rspamd-Queue-Id: 55F20238FA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223627-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.961];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,collabora.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Tue, Mar 03, 2026 at 05:29:10PM +0100, Sebastian Reichel kirjoitti:
> UGREEN USB-C Multifunction Adapter Model CM512 (AKA "Revodok 107")
> exposes two SVIDs: 0xff01 (DP Alt Mode) and 0x1d5c. The DISCOVER_MODES
> step succeeds for 0xff01 and gets a NAK for 0x1d5c. Currently this
> results in DP Alt Mode not being registered either, since the modes
> are only registered once all of them have been discovered. The NAK
> results in the processing being stopped and thus no Alt modes being
> registered.
> 
> Improve the situation by handling the NAK gracefully and continue
> processing the other modes.
> 
> Before this change, the TCPM log ends like this:
> 
> (more log entries before this)
> [    5.028287] AMS DISCOVER_SVIDS finished
> [    5.028291] cc:=4
> [    5.040040] SVID 1: 0xff01
> [    5.040054] SVID 2: 0x1d5c
> [    5.040082] AMS DISCOVER_MODES start
> [    5.040096] PD TX, header: 0x1b6f
> [    5.050946] PD TX complete, status: 0
> [    5.059609] PD RX, header: 0x264f [1]
> [    5.059626] Rx VDM cmd 0xff018043 type 1 cmd 3 len 2
> [    5.059640] AMS DISCOVER_MODES finished
> [    5.059644] cc:=4
> [    5.069994]  Alternate mode 0: SVID 0xff01, VDO 1: 0x000c0045
> [    5.070029] AMS DISCOVER_MODES start
> [    5.070043] PD TX, header: 0x1d6f
> [    5.081139] PD TX complete, status: 0
> [    5.087498] PD RX, header: 0x184f [1]
> [    5.087515] Rx VDM cmd 0x1d5c8083 type 2 cmd 3 len 1
> [    5.087529] AMS DISCOVER_MODES finished
> [    5.087534] cc:=4
> (no further log entries after this point)
> 
> After this patch the TCPM log looks exactly the same, but then
> continues like this:
> 
> [    5.100222] Skip SVID 0x1d5c (failed to discover mode)
> [    5.101699] AMS DFP_TO_UFP_ENTER_MODE start
> (log goes on as the system initializes DP AltMode)
> 
> Cc: stable@vger.kernel.org
> Fixes: 41d9d75344d9 ("usb: typec: tcpm: add discover svids and discover modes support for sop'")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20260213-tcpm-discover-modes-nak-fix-v1-0-9bcb5adb4ef6@collabora.com
> - Squash patches (Badhri Jagan Sridharan)
> - Add Fixes tag (Badhri Jagan Sridharan)
> - Move common svdm_consume_modes out of conditional statement (Badhri Jagan Sridharan)
> - Add TCPM log to commit message (Badhri Jagan Sridharan)
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 97 +++++++++++++++++++++++++++----------------
>  1 file changed, 61 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 1d2f3af034c5..cd5260f408fb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1995,6 +1995,55 @@ static bool tcpm_cable_vdm_supported(struct tcpm_port *port)
>  	       tcpm_can_communicate_sop_prime(port);
>  }
>  
> +static void tcpm_handle_discover_mode(struct tcpm_port *port,
> +				      const u32 *p, int cnt, u32 *response,
> +				      enum tcpm_transmit_type rx_sop_type,
> +				      enum tcpm_transmit_type *response_tx_sop_type,
> +				      struct pd_mode_data *modep,
> +				      struct pd_mode_data *modep_prime,
> +				      int svdm_version, int *rlen,
> +				      bool success)
> +

Extra newline.

Why not just make this function return rlen?

> +{
> +	struct typec_port *typec = port->typec_port;
> +
> +	/* 6.4.4.3.3 */
> +	if (success)
> +		svdm_consume_modes(port, p, cnt, rx_sop_type);

This condition does not look very useful.

> +	if (rx_sop_type == TCPC_TX_SOP) {
> +		modep->svid_index++;
> +		if (modep->svid_index < modep->nsvids) {
> +			u16 svid = modep->svids[modep->svid_index];
> +			*response_tx_sop_type = TCPC_TX_SOP;
> +			response[0] = VDO(svid, 1, svdm_version,
> +					  CMD_DISCOVER_MODES);
> +			*rlen = 1;
> +		} else if (tcpm_cable_vdm_supported(port)) {
> +			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
> +			response[0] = VDO(USB_SID_PD, 1,
> +					  typec_get_cable_svdm_version(typec),
> +					  CMD_DISCOVER_SVID);
> +			*rlen = 1;
> +		} else {
> +			tcpm_register_partner_altmodes(port);
> +		}
> +	} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
> +		modep_prime->svid_index++;
> +		if (modep_prime->svid_index < modep_prime->nsvids) {
> +			u16 svid = modep_prime->svids[modep_prime->svid_index];
> +			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
> +			response[0] = VDO(svid, 1,
> +					  typec_get_cable_svdm_version(typec),

You could use svdm_version in this case too, no?

If you read it separately like that, then you might as well do the
same with typec_get_negotiated_svdm_version() in the other condition.

> +					  CMD_DISCOVER_MODES);
> +			*rlen = 1;
> +		} else {
> +			tcpm_register_plug_altmodes(port);
> +			tcpm_register_partner_altmodes(port);
> +		}
> +	}
> +}
> +
>  static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			const u32 *p, int cnt, u32 *response,
>  			enum adev_actions *adev_action,
> @@ -2252,41 +2301,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			}
>  			break;
>  		case CMD_DISCOVER_MODES:
> -			if (rx_sop_type == TCPC_TX_SOP) {
> -				/* 6.4.4.3.3 */
> -				svdm_consume_modes(port, p, cnt, rx_sop_type);
> -				modep->svid_index++;
> -				if (modep->svid_index < modep->nsvids) {
> -					u16 svid = modep->svids[modep->svid_index];
> -					*response_tx_sop_type = TCPC_TX_SOP;
> -					response[0] = VDO(svid, 1, svdm_version,
> -							  CMD_DISCOVER_MODES);
> -					rlen = 1;
> -				} else if (tcpm_cable_vdm_supported(port)) {
> -					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
> -					response[0] = VDO(USB_SID_PD, 1,
> -							  typec_get_cable_svdm_version(typec),
> -							  CMD_DISCOVER_SVID);
> -					rlen = 1;
> -				} else {
> -					tcpm_register_partner_altmodes(port);
> -				}
> -			} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
> -				/* 6.4.4.3.3 */
> -				svdm_consume_modes(port, p, cnt, rx_sop_type);
> -				modep_prime->svid_index++;
> -				if (modep_prime->svid_index < modep_prime->nsvids) {
> -					u16 svid = modep_prime->svids[modep_prime->svid_index];
> -					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
> -					response[0] = VDO(svid, 1,
> -							  typec_get_cable_svdm_version(typec),
> -							  CMD_DISCOVER_MODES);
> -					rlen = 1;
> -				} else {
> -					tcpm_register_plug_altmodes(port);
> -					tcpm_register_partner_altmodes(port);
> -				}
> -			}
> +			tcpm_handle_discover_mode(port, p, cnt, response,
> +						  rx_sop_type, response_tx_sop_type,
> +						  modep, modep_prime, svdm_version,
> +						  &rlen, true);

Just call svdm_consume_modes() directly from here and drop a few
parameters from that tcpm_handle_discover_mode() function:

        		svdm_consume_modes(port, p, cnt, rx_sop_type);
			tcpm_handle_discover_mode(port, response,
						  rx_sop_type, response_tx_sop_type,
						  modep, modep_prime, svdm_version,
						  &rlen);

>  			break;
>  		case CMD_ENTER_MODE:
>  			*response_tx_sop_type = rx_sop_type;
> @@ -2329,9 +2347,16 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  		switch (cmd) {
>  		case CMD_DISCOVER_IDENT:
>  		case CMD_DISCOVER_SVID:
> -		case CMD_DISCOVER_MODES:
>  		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
>  			break;
> +		case CMD_DISCOVER_MODES:
> +			tcpm_log(port, "Skip SVID 0x%04x (failed to discover mode)",
> +				 PD_VDO_SVID_SVID0(p[0]));
> +			tcpm_handle_discover_mode(port, p, cnt, response,
> +						  rx_sop_type, response_tx_sop_type,
> +						  modep, modep_prime, svdm_version,
> +						  &rlen, false);
> +			break;
>  		case CMD_ENTER_MODE:
>  			/* Back to USB Operation */
>  			*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;


I would also use local variable for modep (modep_prime is modep in
case of TCPC_TX_SOP_PRIME) instead of passing both modep and
modep_prime to the function.

With all these changes, the prototype would look like this:

static int tcpm_handle_discover_mode(struct tcpm_port *port, u32 *response,
				     enum tcpm_transmit_type rx_sop_type,
				     enum tcpm_transmit_type *response_tx_sop_type);

thanks,

-- 
heikki

