Return-Path: <stable+bounces-222995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGYnLkbdp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-222995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:20:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3E61FB875
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D77C3017783
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA39F342CA2;
	Wed,  4 Mar 2026 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VwyR3XUP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fwjHdyjY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VwyR3XUP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fwjHdyjY"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA463090F5
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608835; cv=none; b=oaOqPfRXIRNhtJZQOS3hich04rnElp9FC/yIkwtjbOP2ROM5zHiKhQf/5R9Q8P22+gc+vtsPx3BhsUJp7n/C3ZZZ3Po7gqazbz/z0sT0AmP8gjoGevxH8JhlsuavvqIywcXH9cV8tg1+SfSN6rLF8KYmNYy3DqFqu1RHj8rWvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608835; c=relaxed/simple;
	bh=DpK40hQs/hsvOlNoUwEXi8QAgOm5EbCfmfV6WGMgEMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azEVOyEfbVnGDFU2GVTH96zfCQa4GIDpPhiabeGgS3hvz+qZqFiMyMiV9rWW8sLAFSlYLwue3UB2ma9VZp5cdyUUh8Hlsbr7Peu6/pWF7ZN1//QS5wVjlSTxUtndjiOljCx7NO9l4T4vKKoqVKPXuqex9zgXcTcyIs/mokiO4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VwyR3XUP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fwjHdyjY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VwyR3XUP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fwjHdyjY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 801B45BD4B;
	Wed,  4 Mar 2026 07:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeYalW8jhq1NZYwVgh60QQY623yLOr+NtDNXomRTfr0=;
	b=VwyR3XUPMwHkz3g9V3/3klEBMEFZsPVFJ3gn+Wz7S+P2SQHdVt0dc2Y7Xsln7Gq76T544d
	ofRKe0qg37JXyo815kRBt8wFD0yuDrxgG6Pzft62LbGOUKo9XXb0yk1Rg8WgJjINwC3VnE
	avR3tf7I2nm4oUdSD1UIpjAznvFtMCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeYalW8jhq1NZYwVgh60QQY623yLOr+NtDNXomRTfr0=;
	b=fwjHdyjYh4wwrVT9AMyMUc/9X8aZ7Cgmloh79ptZrxyifKynzXI264XBVzGQL1GAB++Wv3
	Nm52KZo0nNM+lxDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VwyR3XUP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fwjHdyjY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeYalW8jhq1NZYwVgh60QQY623yLOr+NtDNXomRTfr0=;
	b=VwyR3XUPMwHkz3g9V3/3klEBMEFZsPVFJ3gn+Wz7S+P2SQHdVt0dc2Y7Xsln7Gq76T544d
	ofRKe0qg37JXyo815kRBt8wFD0yuDrxgG6Pzft62LbGOUKo9XXb0yk1Rg8WgJjINwC3VnE
	avR3tf7I2nm4oUdSD1UIpjAznvFtMCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeYalW8jhq1NZYwVgh60QQY623yLOr+NtDNXomRTfr0=;
	b=fwjHdyjYh4wwrVT9AMyMUc/9X8aZ7Cgmloh79ptZrxyifKynzXI264XBVzGQL1GAB++Wv3
	Nm52KZo0nNM+lxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35D8B3EA69;
	Wed,  4 Mar 2026 07:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1OeFC0Ddp2kZRQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Mar 2026 07:20:32 +0000
Message-ID: <786d1145-3ba8-4332-8d03-c0ff2da616d7@suse.de>
Date: Wed, 4 Mar 2026 08:20:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmet-auth: Don't log DHCHAP shared secret in
 nvmet_auth_ctrl_sesskey()
To: Thorsten Blum <thorsten.blum@linux.dev>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
 <20260303190350.78705-6-thorsten.blum@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260303190350.78705-6-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 1B3E61FB875
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222995-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On 3/3/26 20:03, Thorsten Blum wrote:
> When debug logging is enabled, nvmet_auth_ctrl_sesskey() logs the DHCHAP
> shared secret. Remove the log to avoid exposing key material.
> 
> Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/nvme/target/auth.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index f24add0bb86f..f62fed6bd897 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -544,10 +544,6 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
>   					  req->sq->dhchap_skey_len);
>   	if (ret)
>   		pr_debug("failed to compute shared secret, err %d\n", ret);
> -	else
> -		pr_debug("%s: shared secret %*ph\n", __func__,
> -			 (int)req->sq->dhchap_skey_len,
> -			 req->sq->dhchap_skey);
>   
>   	return ret;
>   }
As indicated in the previous patch, we should use a compile time option
to disable the messages.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

