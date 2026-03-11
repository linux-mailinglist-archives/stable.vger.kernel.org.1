Return-Path: <stable+bounces-224691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDu2D8lssWlVvAIAu9opvQ
	(envelope-from <stable+bounces-224691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:23:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01F264679
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 14:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 89C3E30255F9
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D461A257825;
	Wed, 11 Mar 2026 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+/PZ23o"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C73148D5;
	Wed, 11 Mar 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235393; cv=none; b=YV66RhHS3PUPNDaV09122tPkcUYVuOJ31n326WC5ki/G4O7tvNn21QvVObNgRpdfMSIo2B+UPaibtQdwjm0bNQxw5ka32xJx6fB/HBDPiB8zkCy460wcPkEzrMmbGbHc/shGCwAN8JQdimmUcW2ykp0Pa6iEv5cwsvY1ejgf1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235393; c=relaxed/simple;
	bh=dCY+6Ti/q3Hr4akww4dzwV2iDFbjGA6B1vd666DRTDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/tnGveD/S7lAHv+ivot61WN5PUlb9UEp0g0qh+XKxNlrMQydWDrfGHjiMA/8BYZWQmGm58IQqYZG+kcCJr+0E/fVc9UL8SSVSB/ch6OAR23aF/azR3Qi2SIA44Mp2W1pBiwaEm+72mIwXGVGh0QwNjgshSt8LF8vKYsbtI+ipE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+/PZ23o; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773235392; x=1804771392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dCY+6Ti/q3Hr4akww4dzwV2iDFbjGA6B1vd666DRTDo=;
  b=h+/PZ23oYqhJKiitZBKC1NCeeZAB/4datsiaDXxh7dqnCizxVl+7hCxh
   cGswNNkNG1urednu38x/EA5SxKmRKM5yjGkbwRHbjS/xgQ4kBeeH7C6+I
   DJQjbocD8EaU3nr8b1drdcwTRCS+jTNEHBqKxoz/azWsMoLPDnsV9bvIH
   EqnkllBJoRfkJKjMcjOtAlmi2u+7yCf4YVGMohOInHlzJrrhAa7fYhZNO
   BAWjdSRgsmT4lwAvuw3VdKjIwVKOHs5l+IQMXZCgWqjSoLGqH4HhbAWZG
   1kmD1p0AW7TBTsAUiqdhYRHareRhkOtR8jfhat2aia0tlfg8z84ueMQBm
   g==;
X-CSE-ConnectionGUID: 8uYvtWwBShm/pnldoAc/pg==
X-CSE-MsgGUID: xd08qnurSDa4dbh/fs67Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91873022"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91873022"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 06:23:11 -0700
X-CSE-ConnectionGUID: AMehrHb/R5WaAUt3/GFE8g==
X-CSE-MsgGUID: Npqlv/KISpWq7FfmvO/jfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="219608817"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 11 Mar 2026 06:23:09 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id A154C95; Wed, 11 Mar 2026 14:23:07 +0100 (CET)
Date: Wed, 11 Mar 2026 15:22:27 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: tcpm: improve handling of DISCOVER_MODES
 failures
Message-ID: <abFsk-hWvBUfr9xB@kuha>
References: <20260309-tcpm-discover-modes-nak-fix-v3-1-a4447f5c1c61@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-tcpm-discover-modes-nak-fix-v3-1-a4447f5c1c61@collabora.com>
X-Rspamd-Queue-Id: 1F01F264679
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-224691-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DMARC_DNSFAIL(0.00)[intel.com : query timed out];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,collabora.com:email]
X-Rspamd-Action: no action

Mon, Mar 09, 2026 at 04:15:28PM +0100, Sebastian Reichel kirjoitti:
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v3:
> - Link to v2: https://lore.kernel.org/r/20260303-tcpm-discover-modes-nak-fix-v2-1-5a630070025a@collabora.com
> - Move svdm_consume_modes() out of tcpm_handle_discover_mode() (Heikki Krogerus)
> - Move rlen return pointer argument into proper return code (Heikki Krogerus)
> - Drop multiple tcpm_handle_discover_mode() arguments by re-getting them
>   in the function  (Heikki Krogerus)
> - Restructure if/else branches after these changes to make checkpatch happy
> - Did not pick up R-b tag from Badhri Jagan Sridharan due to the amount
>   of changes
> 
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
> index 1d2f3af034c5..97a35b5590d9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1995,6 +1995,55 @@ static bool tcpm_cable_vdm_supported(struct tcpm_port *port)
>  	       tcpm_can_communicate_sop_prime(port);
>  }
>  
> +static int tcpm_handle_discover_mode(struct tcpm_port *port, u32 *response,
> +				     enum tcpm_transmit_type rx_sop_type,
> +				     enum tcpm_transmit_type *response_tx_sop_type)
> +{
> +	struct typec_port *typec = port->typec_port;
> +	struct pd_mode_data *modep;
> +
> +	if (rx_sop_type == TCPC_TX_SOP) {
> +		modep = &port->mode_data;
> +		modep->svid_index++;
> +
> +		if (modep->svid_index < modep->nsvids) {
> +			u16 svid = modep->svids[modep->svid_index];
> +			*response_tx_sop_type = TCPC_TX_SOP;
> +			response[0] = VDO(svid, 1,
> +					  typec_get_negotiated_svdm_version(typec),
> +					  CMD_DISCOVER_MODES);
> +			return 1;
> +		}
> +
> +		if (tcpm_cable_vdm_supported(port)) {
> +			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
> +			response[0] = VDO(USB_SID_PD, 1,
> +					  typec_get_cable_svdm_version(typec),
> +					  CMD_DISCOVER_SVID);
> +			return 1;
> +		}
> +
> +		tcpm_register_partner_altmodes(port);
> +	} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
> +		modep = &port->mode_data_prime;
> +		modep->svid_index++;
> +
> +		if (modep->svid_index < modep->nsvids) {
> +			u16 svid = modep->svids[modep->svid_index];
> +			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
> +			response[0] = VDO(svid, 1,
> +					  typec_get_cable_svdm_version(typec),
> +					  CMD_DISCOVER_MODES);
> +			return 1;
> +		}
> +
> +		tcpm_register_plug_altmodes(port);
> +		tcpm_register_partner_altmodes(port);
> +	}
> +
> +	return 0;
> +}
> +
>  static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			const u32 *p, int cnt, u32 *response,
>  			enum adev_actions *adev_action,
> @@ -2252,41 +2301,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
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
> +			/* 6.4.4.3.3 */
> +			svdm_consume_modes(port, p, cnt, rx_sop_type);
> +			rlen = tcpm_handle_discover_mode(port, response,
> +							 rx_sop_type,
> +							 response_tx_sop_type);
>  			break;
>  		case CMD_ENTER_MODE:
>  			*response_tx_sop_type = rx_sop_type;
> @@ -2329,9 +2348,15 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  		switch (cmd) {
>  		case CMD_DISCOVER_IDENT:
>  		case CMD_DISCOVER_SVID:
> -		case CMD_DISCOVER_MODES:
>  		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
>  			break;
> +		case CMD_DISCOVER_MODES:
> +			tcpm_log(port, "Skip SVID 0x%04x (failed to discover mode)",
> +				 PD_VDO_SVID_SVID0(p[0]));
> +			rlen = tcpm_handle_discover_mode(port, response,
> +							 rx_sop_type,
> +							 response_tx_sop_type);
> +			break;
>  		case CMD_ENTER_MODE:
>  			/* Back to USB Operation */
>  			*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
> 
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260213-tcpm-discover-modes-nak-fix-09070bb529c5
> 
> Best regards,
> -- 
> Sebastian Reichel <sebastian.reichel@collabora.com>

-- 
heikki

