Return-Path: <stable+bounces-105140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C19F624D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 11:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0821885A4B
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E7197556;
	Wed, 18 Dec 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5HoYhFx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E7126F1E;
	Wed, 18 Dec 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516229; cv=none; b=rTvfFmCnxxCXCEe2qYKp1J+OJFebVuGVVpZaxB/3W7r1KeoCpvtxf20+EzHdNcKvS6Zf2zyunv0TvoTv2GyjAGFVg8qj8Jq0LdOg/vK5eF8l+x2lnP2++Pm55fec/rykvf0X6R+M62Wr2mkCdrPLQRWOsRp80e/iMI6O5H9RB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516229; c=relaxed/simple;
	bh=4MW1sRUQw5YWXsGlxupTf64ZpNbnKMtbaoSL0VoG000=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HylqiBvZ/gOlROF7o+PRftambVuRWmFqVNAjFDupBM9qxl4P9q8cCg+ljYEETWHukDTPXOanzR+N6TwKMup2X/1lbqw57hFl6W7scrNM2Wx1oKNWeoeEbur+zmUCJiI8zmZCdkUHEj75Evxu+6YU4C9/TNV9fW3iwQNnAYmHUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5HoYhFx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734516224; x=1766052224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4MW1sRUQw5YWXsGlxupTf64ZpNbnKMtbaoSL0VoG000=;
  b=a5HoYhFx+sy56DKaz+pZpAgYTDyovYl8QWM6Qyw09Lvk8uDxY778N9WK
   wTXW52J3TN54cm2g1SXRmfZIFuq7RhkXS6j0q3GJXkq+zMOGLdEWxSK8d
   Y1Deu7Lz57RmKdrh6f5L2WalVIjQ7cY0BVGrHk/POL7o2rugjNlvdnohn
   g8arK2fHpBBe3uzCM8SfnsNvgcdBw9bBaBMkPSP4TsDowXPM2X7F3XkV4
   Fm0GVYus6yI3EWZJBn5fEesS9IjwXH2gSOqD3MHZwKY0tYCa9A1qqDNvr
   YSyu2ajP2Yjm1BeKXG2jKx3r7IDRD3YvKJHBpBdR40bN8D+h4PCI8n+rU
   Q==;
X-CSE-ConnectionGUID: dMmGFSVlRqe0gPfVpT/Sfw==
X-CSE-MsgGUID: VP5n82u5SJ+JXcB9PnhZPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="38658953"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="38658953"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 02:03:42 -0800
X-CSE-ConnectionGUID: b+KnILdDQxOYL/+3ety8XA==
X-CSE-MsgGUID: 3wCQ1mRSQBm/mF/csyQRFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97599713"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 18 Dec 2024 02:03:39 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 18 Dec 2024 12:03:38 +0200
Date: Wed, 18 Dec 2024 12:03:38 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: joswang <joswang1221@gmail.com>,
	Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: tcpm: fix the sender response time issue
Message-ID: <Z2Kd-k5icFTLeJkT@kuha.fi.intel.com>
References: <20241215125013.70671-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215125013.70671-1-joswang1221@gmail.com>

Hi,

On Sun, Dec 15, 2024 at 08:50:13PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> According to the USB PD3 CTS specification, the requirements

What is "USB PD3 CTS specification"? Please open it here.

> for tSenderResponse are different in PD2 and PD3 modes, see
> Table 19 Timing Table & Calculations. For PD2 mode, the
> tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> tSenderResponse min 27ms and max 33ms.
> 
> For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> item, after receiving the Source_Capabilities Message sent by
> the UUT, the tester deliberately does not send a Request Message
> in order to force the SenderResponse timer on the Source UUT to
> timeout. The Tester checks that a Hard Reset is detected between
> tSenderResponse min and max，the delay is between the last bit of
> the GoodCRC Message EOP has been sent and the first bit of Hard
> Reset SOP has been received. The current code does not distinguish
> between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> This will cause this test item and the following tests to fail:
> TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> 
> Considering factors such as SOC performance, i2c rate, and the speed
> of PD chip sending data, "pd2-sender-response-time-ms" and
> "pd3-sender-response-time-ms" DT time properties are added to allow
> users to define platform timing. For values that have not been
> explicitly defined in DT using this property, a default value of 27ms
> for PD2 tSenderResponse and 30ms for PD3 tSenderResponse is set.
> 
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>

If this is a fix, then I think it's fixing commit 2eadc33f40d4
("typec: tcpm: Add core support for sink side PPS"). That's where the
pd_revision was changed to 3.0.

Badhri, could you take a look at this (and how about that
maintainer role? :-) ).

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 50 +++++++++++++++++++++++------------
>  include/linux/usb/pd.h        |  3 ++-
>  2 files changed, 35 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 6021eeb903fe..3a159bfcf382 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -314,12 +314,16 @@ struct pd_data {
>   * @sink_wait_cap_time: Deadline (in ms) for tTypeCSinkWaitCap timer
>   * @ps_src_wait_off_time: Deadline (in ms) for tPSSourceOff timer
>   * @cc_debounce_time: Deadline (in ms) for tCCDebounce timer
> + * @pd2_sender_response_time: Deadline (in ms) for pd20 tSenderResponse timer
> + * @pd3_sender_response_time: Deadline (in ms) for pd30 tSenderResponse timer
>   */
>  struct pd_timings {
>  	u32 sink_wait_cap_time;
>  	u32 ps_src_off_time;
>  	u32 cc_debounce_time;
>  	u32 snk_bc12_cmpletion_time;
> +	u32 pd2_sender_response_time;
> +	u32 pd3_sender_response_time;
>  };
>  
>  struct tcpm_port {
> @@ -3776,7 +3780,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
>  			} else if (port->pwr_role == TYPEC_SOURCE) {
>  				tcpm_ams_finish(port);
>  				tcpm_set_state(port, HARD_RESET_SEND,
> -					       PD_T_SENDER_RESPONSE);
> +					       port->negotiated_rev >= PD_REV30 ?
> +					       port->timings.pd3_sender_response_time :
> +					       port->timings.pd2_sender_response_time);
>  			} else {
>  				tcpm_ams_finish(port);
>  			}
> @@ -4619,6 +4625,9 @@ static void run_state_machine(struct tcpm_port *port)
>  	enum typec_pwr_opmode opmode;
>  	unsigned int msecs;
>  	enum tcpm_state upcoming_state;
> +	u32 sender_response_time = port->negotiated_rev >= PD_REV30 ?
> +				   port->timings.pd3_sender_response_time :
> +				   port->timings.pd2_sender_response_time;
>  
>  	if (port->tcpc->check_contaminant && port->state != CHECK_CONTAMINANT)
>  		port->potential_contaminant = ((port->enter_state == SRC_ATTACH_WAIT &&
> @@ -5113,7 +5122,7 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
>  		} else {
>  			tcpm_set_state_cond(port, hard_reset_state(port),
> -					    PD_T_SENDER_RESPONSE);
> +					    sender_response_time);
>  		}
>  		break;
>  	case SNK_NEGOTIATE_PPS_CAPABILITIES:
> @@ -5135,7 +5144,7 @@ static void run_state_machine(struct tcpm_port *port)
>  				tcpm_set_state(port, SNK_READY, 0);
>  		} else {
>  			tcpm_set_state_cond(port, hard_reset_state(port),
> -					    PD_T_SENDER_RESPONSE);
> +					    sender_response_time);
>  		}
>  		break;
>  	case SNK_TRANSITION_SINK:
> @@ -5387,7 +5396,7 @@ static void run_state_machine(struct tcpm_port *port)
>  			port->message_id_prime = 0;
>  			port->rx_msgid_prime = -1;
>  			tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP_PRIME);
> -			tcpm_set_state_cond(port, ready_state(port), PD_T_SENDER_RESPONSE);
> +			tcpm_set_state_cond(port, ready_state(port), sender_response_time);
>  		} else {
>  			port->message_id = 0;
>  			port->rx_msgid = -1;
> @@ -5398,7 +5407,7 @@ static void run_state_machine(struct tcpm_port *port)
>  				tcpm_set_state_cond(port, hard_reset_state(port), 0);
>  			else
>  				tcpm_set_state_cond(port, hard_reset_state(port),
> -						    PD_T_SENDER_RESPONSE);
> +						    sender_response_time);
>  		}
>  		break;
>  
> @@ -5409,8 +5418,7 @@ static void run_state_machine(struct tcpm_port *port)
>  			port->send_discover = true;
>  			port->send_discover_prime = false;
>  		}
> -		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
> -				    PD_T_SENDER_RESPONSE);
> +		tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT, sender_response_time);
>  		break;
>  	case DR_SWAP_ACCEPT:
>  		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
> @@ -5444,7 +5452,7 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  			break;
>  		}
> -		tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, PD_T_SENDER_RESPONSE);
> +		tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, sender_response_time);
>  		break;
>  	case FR_SWAP_SEND_TIMEOUT:
>  		tcpm_set_state(port, ERROR_RECOVERY, 0);
> @@ -5475,8 +5483,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case PR_SWAP_SEND:
>  		tcpm_pd_send_control(port, PD_CTRL_PR_SWAP, TCPC_TX_SOP);
> -		tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT,
> -				    PD_T_SENDER_RESPONSE);
> +		tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT, sender_response_time);
>  		break;
>  	case PR_SWAP_SEND_TIMEOUT:
>  		tcpm_swap_complete(port, -ETIMEDOUT);
> @@ -5574,8 +5581,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case VCONN_SWAP_SEND:
>  		tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP, TCPC_TX_SOP);
> -		tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT,
> -			       PD_T_SENDER_RESPONSE);
> +		tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT, sender_response_time);
>  		break;
>  	case VCONN_SWAP_SEND_TIMEOUT:
>  		tcpm_swap_complete(port, -ETIMEDOUT);
> @@ -5656,23 +5662,21 @@ static void run_state_machine(struct tcpm_port *port)
>  		break;
>  	case GET_STATUS_SEND:
>  		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS, TCPC_TX_SOP);
> -		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
> -			       PD_T_SENDER_RESPONSE);
> +		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT, sender_response_time);
>  		break;
>  	case GET_STATUS_SEND_TIMEOUT:
>  		tcpm_set_state(port, ready_state(port), 0);
>  		break;
>  	case GET_PPS_STATUS_SEND:
>  		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS, TCPC_TX_SOP);
> -		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
> -			       PD_T_SENDER_RESPONSE);
> +		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT, sender_response_time);
>  		break;
>  	case GET_PPS_STATUS_SEND_TIMEOUT:
>  		tcpm_set_state(port, ready_state(port), 0);
>  		break;
>  	case GET_SINK_CAP:
>  		tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP, TCPC_TX_SOP);
> -		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_RESPONSE);
> +		tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, sender_response_time);
>  		break;
>  	case GET_SINK_CAP_TIMEOUT:
>  		port->sink_cap_done = true;
> @@ -7109,6 +7113,18 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
>  	ret = fwnode_property_read_u32(fwnode, "sink-bc12-completion-time-ms", &val);
>  	if (!ret)
>  		port->timings.snk_bc12_cmpletion_time = val;
> +
> +	ret = fwnode_property_read_u32(fwnode, "pd2-sender-response-time-ms", &val);
> +	if (!ret)
> +		port->timings.pd2_sender_response_time = val;
> +	else
> +		port->timings.pd2_sender_response_time = PD_T_PD2_SENDER_RESPONSE;
> +
> +	ret = fwnode_property_read_u32(fwnode, "pd3-sender-response-time-ms", &val);
> +	if (!ret)
> +		port->timings.pd3_sender_response_time = val;
> +	else
> +		port->timings.pd3_sender_response_time = PD_T_PD3_SENDER_RESPONSE;
>  }

I can't see the whole thread, but I guess those properties were
okay(?).

thanks,

-- 
heikki

