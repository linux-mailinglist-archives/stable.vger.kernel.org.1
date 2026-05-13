Return-Path: <stable+bounces-246797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO1JE6BKBGrNGgIAu9opvQ
	(envelope-from <stable+bounces-246797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:55:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7047530FF7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BB1830C60AD
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69176387581;
	Wed, 13 May 2026 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rTU84VUG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V7Rxr3aq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rTU84VUG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V7Rxr3aq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEF73859DF
	for <stable@vger.kernel.org>; Wed, 13 May 2026 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665655; cv=none; b=SXOqTp6PlUOxdLWAhJwTDa4wKDSEdI3jhrPEr9gKvSEguzEF990w4Qt5OpWbohiI/bab7P/4QUxfDIMiqYIOcBCNuXYJnzrCYn8zYEDH7i9sv1l2szFoz8Jx1xF/+egaj97K5TQPm8zCZQPvtUMKjdulUSgvHXQDiAY5t5XViEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665655; c=relaxed/simple;
	bh=HUzEpswVCyyAW2Ewl65pwnczTFhdeK04DrvwUYipUSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8f1BykqBXXa3st9sw7tYdie6/zwqKlRsmh4aPO3EV8cokBVllsfuDqovdpnqOcRKSiotiE8nPLCNWl23gVxCs5e6ywpXqRyJ9+06UVK35mZZfKeTWOaNmO4VHgphjVgAh6pg6M72kH1tMd+BTAV2lt6edBHbeP/dFI4e1n4uuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rTU84VUG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V7Rxr3aq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rTU84VUG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V7Rxr3aq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B34C625DF;
	Wed, 13 May 2026 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778665647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvF4XmaIpA1Bhq1Js4sxvrYKvTxg38IRQ85Tq0Zt6mg=;
	b=rTU84VUG1yTwIIvV6asNppCVS38m5RIPb8yCrZ7rJdsGCSErxJyW0kb2r9Cvcx/vc+ptLH
	OC5stGPZYvywfGBvVaiH9r7JLrYdX2hGPnfjKuasVv7RCDornpN5ZbLfL0fesU7juFgRLI
	CtKD2o6fcyIEbMujMbIXBMCSyNATCcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778665647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvF4XmaIpA1Bhq1Js4sxvrYKvTxg38IRQ85Tq0Zt6mg=;
	b=V7Rxr3aqL5+C6x85b81iU9SZf8+G99bFLIJ2jnajqINs8Vdy7g0LADUg7ZxRhl+40J+gQZ
	cLmbhToITEk35dAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rTU84VUG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V7Rxr3aq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778665647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvF4XmaIpA1Bhq1Js4sxvrYKvTxg38IRQ85Tq0Zt6mg=;
	b=rTU84VUG1yTwIIvV6asNppCVS38m5RIPb8yCrZ7rJdsGCSErxJyW0kb2r9Cvcx/vc+ptLH
	OC5stGPZYvywfGBvVaiH9r7JLrYdX2hGPnfjKuasVv7RCDornpN5ZbLfL0fesU7juFgRLI
	CtKD2o6fcyIEbMujMbIXBMCSyNATCcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778665647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvF4XmaIpA1Bhq1Js4sxvrYKvTxg38IRQ85Tq0Zt6mg=;
	b=V7Rxr3aqL5+C6x85b81iU9SZf8+G99bFLIJ2jnajqINs8Vdy7g0LADUg7ZxRhl+40J+gQZ
	cLmbhToITEk35dAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E5AC593AA;
	Wed, 13 May 2026 09:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sW2xIq9IBGoofAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 May 2026 09:47:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4089FA0800; Wed, 13 May 2026 11:47:19 +0200 (CEST)
Date: Wed, 13 May 2026 11:47:19 +0200
From: Jan Kara <jack@suse.cz>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>, 
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] jbd2: fix integer underflow in
 jbd2_journal_initialize_fast_commit()
Message-ID: <dekyomnjc5t3k3thj62nlw556pdiumwbzhbscbpbyeubv3ufeu@tcdr7t4qe4jc>
References: <SYBPR01MB78813DD23B28BD49B1AA1123AF392@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <SYBPR01MB7881663C927DE9D7BBF4D1DFAF062@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB7881663C927DE9D7BBF4D1DFAF062@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: A7047530FF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246797-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,outlook.com:email,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[mit.edu,suse.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed 13-05-26 17:28:40, Junrui Luo wrote:
> jbd2_journal_initialize_fast_commit() validates journal capacity by
> checking (journal->j_last - num_fc_blks < JBD2_MIN_JOURNAL_BLOCKS).
> Both j_last and num_fc_blks are unsigned, so when num_fc_blks exceeds
> j_last the subtraction wraps to a large value, bypassing the bounds
> check.
> 
> The resulting underflow corrupts j_last, j_fc_first, and j_free,
> leading to journal abort.
> 
> Fix by checking num_fc_blks against j_last before the subtraction,
> returning -EFSCORRUPTED.
> 
> Fixes: 6866d7b3f2bb ("ext4 / jbd2: add fast commit initialization")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Return -EFSCORRUPTED instead of -ENOSPC
> - Link to v1: https://lore.kernel.org/all/SYBPR01MB78813DD23B28BD49B1AA1123AF392@SYBPR01MB7881.ausprd01.prod.outlook.com/
> ---
>  fs/jbd2/journal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index cb2c529a8f1b..0bb97459fbf0 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2263,6 +2263,8 @@ jbd2_journal_initialize_fast_commit(journal_t *journal)
>  	unsigned long long num_fc_blks;
>  
>  	num_fc_blks = jbd2_journal_get_num_fc_blks(sb);
> +	if (num_fc_blks > journal->j_last)
> +		return -EFSCORRUPTED;
>  	if (journal->j_last - num_fc_blks < JBD2_MIN_JOURNAL_BLOCKS)
>  		return -ENOSPC;
>  
> 
> ---
> base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
> change-id: 20260513-fixes-e6dcda3273d4
> 
> Best regards,
> -- 
> Junrui Luo <moonafterrain@outlook.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

