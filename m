Return-Path: <stable+bounces-222993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHr9BY7cp2lnkgAAu9opvQ
	(envelope-from <stable+bounces-222993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:17:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED61FB7BD
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854F93013687
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5399344D8E;
	Wed,  4 Mar 2026 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yg9bSYkr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NQCGCIgB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yg9bSYkr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NQCGCIgB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4E351C2A
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608629; cv=none; b=G9JBfwXFQnfhYKCYZq7VwDcb3DQW18qPXiJxfS7Hi0vs94BSpZmPf4OBfO9tv6HiuS+eWm9rBUGekgBTABCq09pL/YhmKbe3jLbL+bH9i9dbDDSSj9/oUJudoMJKcXVjJKE23g+36GfRD7FeUoNualA9qfsRuBKcXGDyAD6D6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608629; c=relaxed/simple;
	bh=y9y5rZt6osFsgO0kktoPB9ZSd8wFxoGCLYc1/ZbCDVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTb5TtXh/DYmA+D6NI/wQ3dgulQyRiJ2Y+UyyBXUc+4OsD3DekqHIEriMtqyMOQNXDM29pk6MRZemFUrBUAnC+yC9yPN2RbrBX0qnbJgky3hkZdLWLPM2diWGZNqAaVdELip4marTiQPlw+SXZ1BOi0jy5e4C6id5dXHtqBPFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yg9bSYkr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NQCGCIgB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yg9bSYkr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NQCGCIgB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 591683E84E;
	Wed,  4 Mar 2026 07:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=;
	b=yg9bSYkrBPiHKTep63OepIt0SxIrypLaIF2GmYDCY+2SBFOI04ac3KPZDNh2+4JNEaLy/f
	TNAhF2vfqchGpOUJSbWTq/LwBg3YhqUk9WYymkdeZYIGRyAK7hyZZ79zH09OdLjdc+1nRK
	W1e8IqHCtwSW+48BQo88uNTT8FdbgVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=;
	b=NQCGCIgBPGPu0frHX1K3ba1Axta9IcWUKCkVXtboo3jbW6I+Lf6KlgTVoFy6q/2TuD4Ymc
	o4qHbovzXzbGTPDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yg9bSYkr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NQCGCIgB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772608624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=;
	b=yg9bSYkrBPiHKTep63OepIt0SxIrypLaIF2GmYDCY+2SBFOI04ac3KPZDNh2+4JNEaLy/f
	TNAhF2vfqchGpOUJSbWTq/LwBg3YhqUk9WYymkdeZYIGRyAK7hyZZ79zH09OdLjdc+1nRK
	W1e8IqHCtwSW+48BQo88uNTT8FdbgVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772608624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iGl6mqxcn65GDFAjH3OxbirgOiR+EQup6fNmIB7y+k=;
	b=NQCGCIgBPGPu0frHX1K3ba1Axta9IcWUKCkVXtboo3jbW6I+Lf6KlgTVoFy6q/2TuD4Ymc
	o4qHbovzXzbGTPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15CE63EA69;
	Wed,  4 Mar 2026 07:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mcGGA3Dcp2ndQQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Mar 2026 07:17:04 +0000
Message-ID: <655d293e-51ce-4e24-93d1-587480d0680f@suse.de>
Date: Wed, 4 Mar 2026 08:17:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-auth: Don't log shared secret in
 nvme_auth_dhchap_exponential()
To: Thorsten Blum <thorsten.blum@linux.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 6EED61FB7BD
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
	TAGGED_FROM(0.00)[bounces-222993-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Action: no action

On 3/3/26 20:03, Thorsten Blum wrote:
> When debug logging is enabled, nvme_auth_dhchap_exponential() logs the
> DHCHAP shared secret. Remove the log to avoid exposing key material.
> 
> Fixes: b61775d185a3 ("nvme-auth: Diffie-Hellman key exchange support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/nvme/host/auth.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 405e7c03b1cf..5e4df2ac3cc0 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -655,8 +655,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
>   		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
>   		return ret;
>   	}
> -	dev_dbg(ctrl->device, "shared secret %*ph\n",
> -		(int)chap->sess_key_len, chap->sess_key);
>   	return 0;
>   }
>   

Yeah, that was primarily for debugging.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

