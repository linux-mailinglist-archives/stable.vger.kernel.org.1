Return-Path: <stable+bounces-222994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOONKzXdp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-222994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:20:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEA41FB863
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 694E1300A7E6
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B570344D8E;
	Wed,  4 Mar 2026 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hN0k24ip";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P9HA76O0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SojPgUT8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LoPTDziY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4F308F1D
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608803; cv=none; b=u1HZPspWSjskiogwrX93RXWSYJ/quw0o8jaMSlwpoB0fklKkF2V0w++yjGxMJAuXBcj+/mhwgFNtK0RU4UpfEJ4iP7yW5ZZqS3Ar/8lCq+W5OOUx2HmAf69+freJ/kFl2R/LMZ3/6gEkDKCDiG77+4j8R8Ain7itIVvcb4/n1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608803; c=relaxed/simple;
	bh=5oOIfoX0FPPNQwdyJyv6FEPUF4M+YrHbfkzzIu+MU0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPb0iJJ3sxfXkm9wpIhg7CXh7U7TbLLMKseGnxk7BdyKkNRyr7ifuPAC1cy+3tY++XBJxf+LI/FFt+dbBTEuRzHekluXxOm5ESyG6uryOceI1/Gmrxxzus0LcAqFPdXiDodTyw1y8sV7/bIWqWaO5/NLblKv7bRRHKxbYHTyQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hN0k24ip; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P9HA76O0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SojPgUT8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LoPTDziY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07A033F279;
	Wed,  4 Mar 2026 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=;
	b=hN0k24ipHUTDTgZH23H5wzTOxWfhswghlpacDRjzh8NMBxgj/3e/sjxZTHw8SQ3u+zsYvI
	g8xl5plTeEGNuf5LS1uLt09QZb2/kiEmWXpDiyQVUlOpZE0QCXKHLCHVdh0aooUwYk4eLX
	Qi0PgHbGv84+RtVP4qmQHDeTryxOOcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=;
	b=P9HA76O0gsknC4RHhVmxZgsGXoO/RoxkbjMWxGqer9bRjAy68RYW0NvjYandLyTYK2NcQl
	VcLDIhziw9qGrDAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=;
	b=SojPgUT8nmw2gRXR7xho2zNPizqR8JwLtG6cJ4Gf49Mv28ANeWuIXmALrbfFlx6m8LVjcr
	ajn1L5zNSR5dDEDuVoCbhSNtKYKAbjzFC0pZEJuqWY97tpWWEb3qioKubPIPzd0ERt6cPs
	y0DBCO5ooZNkm57l7U9YcsX2Z/yVagI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2KW9e3b5m/hO+gKjgmse68Y8IAqEKUxVDionruVq64=;
	b=LoPTDziYgj6ZhvILSPpDQKEuzflbXh5CJue59KZEFz/nsRNNLAIaZKXhL5iNCUMJNQiCRE
	4/ieXEq7Pnq9X0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFEB43EA69;
	Wed,  4 Mar 2026 07:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9AaEKB/dp2naRAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Mar 2026 07:19:59 +0000
Message-ID: <2b40f93f-f987-423d-8263-ba9b10a1bcaf@suse.de>
Date: Wed, 4 Mar 2026 08:19:59 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmet-auth: Don't log DHCHAP keys in
 nvmet_setup_auth()
To: Thorsten Blum <thorsten.blum@linux.dev>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
 <20260303190350.78705-4-thorsten.blum@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260303190350.78705-4-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5AEA41FB863
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222994-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On 3/3/26 20:03, Thorsten Blum wrote:
> When debug logging is enabled, nvmet_setup_auth() logs the host and
> controller DHCHAP key bytes. Remove the keys from debug logs to avoid
> exposing key material.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/nvme/target/auth.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 2eadeb7e06f2..f24add0bb86f 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -199,10 +199,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
>   		ctrl->host_key = NULL;
>   		goto out_free_hash;
>   	}
> -	pr_debug("%s: using hash %s key %*ph\n", __func__,
> +	pr_debug("%s: using hash %s\n", __func__,
>   		 ctrl->host_key->hash > 0 ?
> -		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
> -		 (int)ctrl->host_key->len, ctrl->host_key->key);
> +		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none");
>   
>   	nvme_auth_free_key(ctrl->ctrl_key);
>   	if (!host->dhchap_ctrl_secret) {
> @@ -217,10 +216,9 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
>   		ctrl->ctrl_key = NULL;
>   		goto out_free_hash;
>   	}
> -	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
> +	pr_debug("%s: using ctrl hash %s\n", __func__,
>   		 ctrl->ctrl_key->hash > 0 ?
> -		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
> -		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
> +		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none");
>   
>   out_free_hash:
>   	if (ret) {

Without the key the pr_debug calls are pretty much pointless anyway,
so you might want to remove them, too.

However, these debug prints really help when trying to figure out
authentication failures.
I think it would be better to add a compile-time option to disable
these outputs entirely.

I'll send a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

