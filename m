Return-Path: <stable+bounces-259755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOEPBligHmquDAAAu9opvQ
	(envelope-from <stable+bounces-259755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 11:20:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496062B4FE
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 11:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 618EE3078E48
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089743CDBC0;
	Tue,  2 Jun 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v2tljnKH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V9fvRhjx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v2tljnKH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V9fvRhjx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214C3C9EE6
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391484; cv=none; b=bcU1aQZm1qBEsjhYMcYOb1EC5ziIoX8hdT+av8+m/nEsAOeSquRxo25kSOdDVPdGW0+vSC7lBjWVaPGH6eVu0LZ5hjTc8zL0fV0G4nZHXscMY4mgrFVKzeLy0/lAJQNS9AlMAR1KZGwljHLN/YL4QjEYG2OR/jhcsLp2aj2ji7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391484; c=relaxed/simple;
	bh=kmYFTKG2SUmlBpuou8py97T6+0Zpvl4KZ/RWdzmEoQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnRRpDuO8kpDcJbYKMSIrdjDveNXxlWk+/uxMzCEnWzxgVpMrl5LGQpAs0S5kXdpXZhsOb/QprqRe5JXAST95Sb8NeniITwqiMJiWCgU+HSWxvKVQjVUlUEw3Ua1CAyYdH1BcHUkZOBKpCIYHqyn0++MPLISsEth0g1l1yOqpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v2tljnKH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V9fvRhjx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v2tljnKH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V9fvRhjx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDCE767142;
	Tue,  2 Jun 2026 09:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780391479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56S6nHTn6QLJXTKoYw39upu1bRnKRafvZtBNAP4v898=;
	b=v2tljnKHaq6gUr0smMyvmzxgdYG5qci7SJKfPGApxkxVyc4K/hb5h2Jh6pnRTuKumrtNNn
	tXnk/mEDCntbmNUhyq3tZUXQo6CGiUoNGGTpgqlG6GTSbax2Ipl3Q+zF/PveM5LonjdQHO
	kU2leV/aFaPx0sSKexCnGsCz/+AGJxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780391479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56S6nHTn6QLJXTKoYw39upu1bRnKRafvZtBNAP4v898=;
	b=V9fvRhjx34y6RXwCpaQ3DZxIA7UlXXXh7wOHYDPFPh6U5SdShBRKyXhjXvrwjuLcbcj5ct
	Zthva0hqIDNO8eBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v2tljnKH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V9fvRhjx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780391479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56S6nHTn6QLJXTKoYw39upu1bRnKRafvZtBNAP4v898=;
	b=v2tljnKHaq6gUr0smMyvmzxgdYG5qci7SJKfPGApxkxVyc4K/hb5h2Jh6pnRTuKumrtNNn
	tXnk/mEDCntbmNUhyq3tZUXQo6CGiUoNGGTpgqlG6GTSbax2Ipl3Q+zF/PveM5LonjdQHO
	kU2leV/aFaPx0sSKexCnGsCz/+AGJxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780391479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56S6nHTn6QLJXTKoYw39upu1bRnKRafvZtBNAP4v898=;
	b=V9fvRhjx34y6RXwCpaQ3DZxIA7UlXXXh7wOHYDPFPh6U5SdShBRKyXhjXvrwjuLcbcj5ct
	Zthva0hqIDNO8eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3EBD779A7;
	Tue,  2 Jun 2026 09:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gdvnKzeeHmqGOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jun 2026 09:11:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B26CA0EC1; Tue, 02 Jun 2026 11:11:11 +0200 (CEST)
Date: Tue, 2 Jun 2026 11:11:11 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org, Denis Arefev <arefev@swemel.ru>
Subject: Re: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH]
 block: Avoid mounting the bdev pseudo-filesystem in userspace)
Message-ID: <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV>
 <20260602013526.GO2636677@ZenIV>
 <20260602020444.GP2636677@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602020444.GP2636677@ZenIV>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 8496062B4FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259755-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.org.uk:email,suse.cz:dkim,suse.com:email,swemel.ru:email];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue 02-06-26 03:04:44, Al Viro wrote:
> one should *not* be allowed to mount one of those, new API or not.
> 
> Reported-by: Denis Arefev <arefev@swemel.ru>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Won't it make sense to actually check fc->sb_flags before we call
vfs_create_mount()? Otherwise it looks good to me.

								Honza

> ---
> [[ I still want to see the rest of the reproducer - report smells like a missing
> d_can_lookup() somewhere, on top of fsmount(2) bug]]
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..17777c837683 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4499,6 +4499,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>  	new_mnt = vfs_create_mount(fc);
>  	if (IS_ERR(new_mnt))
>  		return PTR_ERR(new_mnt);
> +	if (new_mnt->mnt_sb->s_flags & SB_NOUSER) {
> +		mntput(new_mnt);
> +		return -EINVAL;
> +	}
>  	new_mnt->mnt_flags = mnt_flags;
>  
>  	new_path.dentry = dget(fc->root);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

