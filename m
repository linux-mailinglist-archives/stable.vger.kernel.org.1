Return-Path: <stable+bounces-238253-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1RFnK/564GnlhgAAu9opvQ
	(envelope-from <stable+bounces-238253-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:00:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD2840A86E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2EA308B595
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964B037997A;
	Thu, 16 Apr 2026 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ehFFvkhi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9YzYW3MA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ehFFvkhi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9YzYW3MA"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD5246BD5
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 05:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318995; cv=none; b=mpV/Q+UJuW6O+X/A031+vIM8scd436kEu/6o7O7cXOnyETbJ8ioghjF9b1T0ST7yn0NsmHkBa6vuvuA4E7J+ipZHNJ2QpeYCoIxR91F8/SsPLLyKjkmLrNays86/NvpRfsKFeis4fY766u9F7Nq7cJyduAmFKofWXnHlheQN5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318995; c=relaxed/simple;
	bh=Tttr+tR0fGOtJ0poJ/lLXD8aGGLtNnDogdfNOS4wLB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiDtRS0+FbLMCduN9g4C16wK18jHBqsoDNlw9FlwbOLFCgko9Wlaq8lPTyrDxwEHZmqce4gqwjfDXwQR/DY2GahG/emdnugvk1Rke0OVKDAhH3kgs8fRGEGIIyz39tsu60OBtsfGwTYhnmWr0a/fTlGeP/ar71LD2OMHQ3/9Hik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ehFFvkhi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9YzYW3MA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ehFFvkhi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9YzYW3MA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 101E16A7F7;
	Thu, 16 Apr 2026 05:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776318992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDXOJ61nOfkKVbOun3TVsc5Zj5wppHAKXRe0qq9CS6o=;
	b=ehFFvkhi8BKdo28onBBPnDMfS9M0NldVi1HxtcaJ7rCGTxtJOllb0f2BmrPFnDECIgYtAd
	zBD6LSxG0RAv8Vlhq1YA9UxrZFtEG52JMZ4sk1afdK1uQeDqk2lkKNNynkh8U4V5bgcSKZ
	oH6xNx5T3zCMhho8dXIGDPeQMw0Ydao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776318992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDXOJ61nOfkKVbOun3TVsc5Zj5wppHAKXRe0qq9CS6o=;
	b=9YzYW3MAporsxPSw9lBp8mN1LgbHiU8AVsNyC2UrDR7kEioAKnO9bulb/b/eLScu+5juYl
	lRP/nXkJxNGylsDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ehFFvkhi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9YzYW3MA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776318992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDXOJ61nOfkKVbOun3TVsc5Zj5wppHAKXRe0qq9CS6o=;
	b=ehFFvkhi8BKdo28onBBPnDMfS9M0NldVi1HxtcaJ7rCGTxtJOllb0f2BmrPFnDECIgYtAd
	zBD6LSxG0RAv8Vlhq1YA9UxrZFtEG52JMZ4sk1afdK1uQeDqk2lkKNNynkh8U4V5bgcSKZ
	oH6xNx5T3zCMhho8dXIGDPeQMw0Ydao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776318992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDXOJ61nOfkKVbOun3TVsc5Zj5wppHAKXRe0qq9CS6o=;
	b=9YzYW3MAporsxPSw9lBp8mN1LgbHiU8AVsNyC2UrDR7kEioAKnO9bulb/b/eLScu+5juYl
	lRP/nXkJxNGylsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE9B04BDE2;
	Thu, 16 Apr 2026 05:56:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Bk8LQ964GlbFgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 16 Apr 2026 05:56:31 +0000
Message-ID: <9479445f-36ae-4460-9104-3bbf9b20c148@suse.de>
Date: Thu, 16 Apr 2026 07:56:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: smartpqi: use shost_to_hba() in
 pqi_scan_finished()
To: Martin Wilck <martin.wilck@suse.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microchip.com>
Cc: linux-scsi@vger.kernel.org, Lee Duncan <lduncan@suse.com>,
 Martin Wilck <mwilck@suse.com>, storagedev@microchip.com,
 stable@vger.kernel.org
References: <20260415204850.799431-1-mwilck@suse.com>
 <20260415204850.799431-2-mwilck@suse.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260415204850.799431-2-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-238253-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[hare.suse.de:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 4CD2840A86E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 22:48, Martin Wilck wrote:
> shost_to_hba() is used everywhere except to obtain pqi_ctrl_info
> from shosti, except in pqi_scan_finished(), where shost_priv() is used.
> This causes one pointer dereference to be missed, as shost->hostdata
> is a pointer in smartpqi. Fix it.
> 
> Fixes: 6c223761eb54 ("smartpqi: initial commit of Microsemi smartpqi driver")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> Cc: Don Brace <don.brace@microchip.com>
> Cc: storagedev@microchip.com
> Cc: stable@vger.kernel.org
> ---
>   drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index b4ed991..65ff509 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -2642,7 +2642,7 @@ static int pqi_scan_finished(struct Scsi_Host *shost,
>   {
>   	struct pqi_ctrl_info *ctrl_info;
>   
> -	ctrl_info = shost_priv(shost);
> +	ctrl_info = shost_to_hba(shost);
>   
>   	return !mutex_is_locked(&ctrl_info->scan_mutex);
>   }
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

