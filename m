Return-Path: <stable+bounces-233685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLj7JpIx1Wly2QcAu9opvQ
	(envelope-from <stable+bounces-233685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:32:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CC13B1E23
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A99830036C7
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32DA3CD8A5;
	Tue,  7 Apr 2026 16:31:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4F33BBB1
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579501; cv=none; b=LsANNz6/txxFZBswO67kB6RHYezAjDiBs2fg56iAEXKruNEmQKepbCRTJ1VozcTosWLDtSn55Y4IU+fhMS6NxgWrdY/b70CTZ2YfpkP1tduOEBQbCct4ff5tEbxFwsxkmfHSj3gxQBon1hVOjehZFYHvEJlJRH1Rxk6emFBsr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579501; c=relaxed/simple;
	bh=RMzOSqw3TdL64CgoGnHs2Ofuy665uMQ/CKn30stnTsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhvut4F8/SkL4kg59HIkZq31JTUX1IR9RosIIsgIwJskrttVokJzMXB9P+j7+/7+75A3GheRSl/WgSR1uhHsHxIKxPZqJXUYLKMSXTD6B3A+8URv9+v/yZxs6LVZ+eY6Ry+Y1uRvzO3O257lX+3r0wLUDHIv5yvb6qjqx4Js48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55707.dip0.t-ipconnect.de [93.197.87.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 15C5C4C2C37D56;
	Tue, 07 Apr 2026 18:31:17 +0200 (CEST)
Message-ID: <c6763568-7773-43af-a43f-dcf6fc4ab0eb@molgen.mpg.de>
Date: Tue, 7 Apr 2026 18:31:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Cleanup PTP pins on
 probe failure
To: Matt Vollrath <tactii@gmail.com>
Cc: Kohei Enju <kohei@enjuk.jp>, intel-wired-lan@osuosl.org,
 stable@vger.kernel.org
References: <20260407161447.43645-1-tactii@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260407161447.43645-1-tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233685-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13CC13B1E23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Matt,


Thank you for the patch. Should you resend you could spell the verb 
*clean up* with a space:

 > i40e: Clean PTP pins up on probe failure

or

 > i40e: Clean up PTP pins on probe failure

But it’s not important.

Am 07.04.26 um 18:14 schrieb Matt Vollrath:
> PTP pin structs are allocated early in probe, but never cleaned up.
> 
> Fix this by calling i40e_ptp_free_pins in the error path.
> 
> To support this, i40e_ptp_free_pins is added to the header and
> pin_config is correctly nullified after being freed.
> 
> This has been an issue since i40e_ptp_alloc_pins was introduced.
> 
> Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
> Reported-by: Kohei Enju <kohei@enjuk.jp>
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 3 ++-
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index dcb50c2e1aa2..83e780919ac9 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1318,6 +1318,7 @@ void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
>   void i40e_ptp_init(struct i40e_pf *pf);
>   void i40e_ptp_stop(struct i40e_pf *pf);
>   int i40e_ptp_alloc_pins(struct i40e_pf *pf);
> +void i40e_ptp_free_pins(struct i40e_pf *pf);
>   int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset);
>   int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
>   int i40e_get_partition_bw_setting(struct i40e_pf *pf);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 926d001b2150..c7062aa476dd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16112,6 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	i40e_clear_interrupt_scheme(pf);
>   	kfree(pf->vsi);
>   err_switch_setup:
> +	i40e_ptp_free_pins(pf);
>   	i40e_reset_interrupt_capability(pf);
>   	timer_shutdown_sync(&pf->service_timer);
>   err_mac_addr:
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 404a716db8da..7d07c389bb23 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -940,12 +940,13 @@ int i40e_ptp_hwtstamp_get(struct net_device *netdev,
>    *
>    * Release memory allocated for PTP pins.
>    **/
> -static void i40e_ptp_free_pins(struct i40e_pf *pf)
> +void i40e_ptp_free_pins(struct i40e_pf *pf)
>   {
>   	if (i40e_is_ptp_pin_dev(&pf->hw)) {
>   		kfree(pf->ptp_pins);
>   		kfree(pf->ptp_caps.pin_config);
>   		pf->ptp_pins = NULL;
> +		pf->ptp_caps.pin_config = NULL;
>   	}
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

