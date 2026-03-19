Return-Path: <stable+bounces-227310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ec0LcIEvGmurAIAu9opvQ
	(envelope-from <stable+bounces-227310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:14:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188902CC7E6
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C798531AA2CA
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C963033E1;
	Thu, 19 Mar 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RcxlEzdk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y7gqp0g8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RcxlEzdk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y7gqp0g8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FA2E1758
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929376; cv=none; b=nUWru469LzQj5+QI00C8y4pUkCSKybBHXuweWbMJ5YO4Il/zs/hg7QyzVj0vulD3xGhQDEOCG1+LUDho7v5xYegLo8gWdOs4m59s6FmngFDKs2g/ywK1LrvRUyfdyINE9OOdbW/GNQ3QGs8ppTdTVlfREWg1axKtI4bhb6JkW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929376; c=relaxed/simple;
	bh=fOI8eN9rd9kMsKQJxSiYGzp/yD0pAciKF79jw/xtEqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZSEKQkiZkPTddICG+y+VrXDKC/YPmKemzCtS9bycMXiGo2z4Mc0BlP9TdkB6yONX9M/9+Ig+ozNR8mkw/kyIliJw40STxLkeRV2e02HEgy2CABDKzL2l3QyEi+AT/Oo9AKauRKC8PDymqYCgKCaSSICTSCys8Z2NvbVYGvNne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RcxlEzdk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y7gqp0g8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RcxlEzdk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y7gqp0g8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 740CE5BD53;
	Thu, 19 Mar 2026 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773929371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gtNVT6lBlUD6HXtpj1xTMUkJFpRDQo6iy/yYhqZbqE=;
	b=RcxlEzdkcNBh9H09PzYEue7iAJJVPvM01U4hoOUMyQTe3Few3LnA/mmfymMwzkBvyZurAG
	AyrsoTK2RScyzdVJTRnCU47W8OZvGOYCaaaC2EW27q3Vo/wQICcGjJvx20yDlERNywoO5n
	OFog1s8w6OzgKU1SeRFKlR/kXAeczmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773929371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gtNVT6lBlUD6HXtpj1xTMUkJFpRDQo6iy/yYhqZbqE=;
	b=y7gqp0g8DhUpoU+lkkS+6Qf/8+v3z8HD5z/vEVoALiTZYmuTyDt4a3FLLvIRxWZl8Fi8av
	4PXqeMftCGNH0oAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RcxlEzdk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=y7gqp0g8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773929371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gtNVT6lBlUD6HXtpj1xTMUkJFpRDQo6iy/yYhqZbqE=;
	b=RcxlEzdkcNBh9H09PzYEue7iAJJVPvM01U4hoOUMyQTe3Few3LnA/mmfymMwzkBvyZurAG
	AyrsoTK2RScyzdVJTRnCU47W8OZvGOYCaaaC2EW27q3Vo/wQICcGjJvx20yDlERNywoO5n
	OFog1s8w6OzgKU1SeRFKlR/kXAeczmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773929371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gtNVT6lBlUD6HXtpj1xTMUkJFpRDQo6iy/yYhqZbqE=;
	b=y7gqp0g8DhUpoU+lkkS+6Qf/8+v3z8HD5z/vEVoALiTZYmuTyDt4a3FLLvIRxWZl8Fi8av
	4PXqeMftCGNH0oAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AFF44273B;
	Thu, 19 Mar 2026 14:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tJYYGpsDvGllYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 14:09:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23775A0B32; Thu, 19 Mar 2026 15:09:31 +0100 (CET)
Date: Thu, 19 Mar 2026 15:09:31 +0100
From: Jan Kara <jack@suse.cz>
To: Seohyeon Maeng <bioloidgp@gmail.com>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] udf: fix partition descriptor append bookkeeping
Message-ID: <g4r2hk7lv4cl3pzhpiuzlrdtrzlucwlgctd4ic32hvhwpdw5xg@3jari52t5jwn>
References: <20260310081652.21220-1-bioloidgp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310081652.21220-1-bioloidgp@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227310-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,suse.cz:server fail,suse.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 188902CC7E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue 10-03-26 17:16:52, Seohyeon Maeng wrote:
> Mounting a crafted UDF image with repeated partition descriptors can
> trigger a heap out-of-bounds write in part_descs_loc[].
> 
> handle_partition_descriptor() deduplicates entries by partition number,
> but appended slots never record partnum. As a result duplicate
> Partition Descriptors are appended repeatedly and num_part_descs keeps
> growing.
> 
> Once the table is full, the growth path still sizes the allocation from
> partnum even though inserts are indexed by num_part_descs. If partnum is
> already aligned to PART_DESC_ALLOC_STEP, ALIGN(partnum, step) can keep
> the old capacity and the next append writes past the end of the table.
> 
> Store partnum in the appended slot and size growth from the next append
> count so deduplication and capacity tracking follow the same model.
> 
> Fixes: ee4af50ca94f ("udf: Fix mounting of Win7 created UDF filesystems")
> Cc: stable@vger.kernel.org
> Signed-off-by: Seohyeon Maeng <bioloidgp@gmail.com>

Thanks! I've merged the fix to my tree with a slight modification to set:

	new_size = data->num_part_descs + PART_DESC_ALLOC_STEP;

instead of the +1 and ALIGN() calls which were mostly pointless.

								Honza

> ---
>  fs/udf/super.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 27f463fd1d89..3c3c645de0bc 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1694,7 +1694,8 @@ static struct udf_vds_record *handle_partition_descriptor(
>  			return &(data->part_descs_loc[i].rec);
>  	if (data->num_part_descs >= data->size_part_descs) {
>  		struct part_desc_seq_scan_data *new_loc;
> -		unsigned int new_size = ALIGN(partnum, PART_DESC_ALLOC_STEP);
> +		unsigned int need = data->num_part_descs + 1;
> +		unsigned int new_size = ALIGN(need, PART_DESC_ALLOC_STEP);
>  
>  		new_loc = kzalloc_objs(*new_loc, new_size);
>  		if (!new_loc)
> @@ -1705,6 +1706,7 @@ static struct udf_vds_record *handle_partition_descriptor(
>  		data->part_descs_loc = new_loc;
>  		data->size_part_descs = new_size;
>  	}
> +	data->part_descs_loc[data->num_part_descs].partnum = partnum;
>  	return &(data->part_descs_loc[data->num_part_descs++].rec);
>  }
>  
> 
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

