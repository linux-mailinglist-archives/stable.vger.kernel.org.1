Return-Path: <stable+bounces-273668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RS8QHdXZVGpffwAAu9opvQ
	(envelope-from <stable+bounces-273668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 14:28:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70F74AF10
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 14:28:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iuP4U7s6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ANHOzPXf;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U8CbI0yT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ya+j8VU9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273668-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273668-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8067B3055D0B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CFD409298;
	Mon, 13 Jul 2026 12:16:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667B40756E
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:16:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945011; cv=none; b=AQ9hqDnCeuN7txHjn33rC+UWw/k0F8mRUIT5faznYXvsfzuOMuspB3COLkcssboLANaTj71sSe4VYl58YdIRiOTL5svz+8agC1J+fHzA37PLdPmbJjUxBZJLf1e50yMHKjVpx5KWao925WxuwjNOBqUWD0Q9p6o3/fkUNGyI6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945011; c=relaxed/simple;
	bh=ZvrxzDz4VJp9YWoA71W3GebSHfN/LE/a/CMiuLKqzSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAWZ5FXRnM3TD7wQzUuEtsQ4sSlugDSzmWwKqwAelz9vnwvFnCt0fFx63hdVtWVFAuhsaqT1uqexj9uverDCOu2kMlhM20343s2+7P4B2hzPpYk/HI7aTMHHI9eJSK/eq/wc0m71ScoDPbnYZm+tHXVXDHuFilsOHWFv7TVJyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iuP4U7s6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANHOzPXf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U8CbI0yT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ya+j8VU9; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E66C277523;
	Mon, 13 Jul 2026 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783945007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFa3CkPB5/zsm1kI7wziE+HM9O4DamB/IWX3voiemsQ=;
	b=iuP4U7s6SUoY5Rj0/R+wZCiJjmKvHHdxCYdndFZZrDwxid3dh5Gizgi6pR3iCVJqPkuFVn
	kewvRlJEFuapc1Y2smeFOv8buAacVhsogl/rR68UwysIxDq3wleOpuMrF3dPsqadouCn0O
	EcVg+ZvQnZ89vBpkKVALgNL9wHCCPFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783945007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFa3CkPB5/zsm1kI7wziE+HM9O4DamB/IWX3voiemsQ=;
	b=ANHOzPXfxSeXDSGHiwbS85/aSBpS0KYmnljCCz02esJYJG9T1dibkZAu3rlGe6SaSBuyzE
	BjAMLLmi+cx+dcAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783945005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFa3CkPB5/zsm1kI7wziE+HM9O4DamB/IWX3voiemsQ=;
	b=U8CbI0yTC6+vNVfaCTj1KgTZh/1IKuGOeplzkSqjv07C74PDjCdb24O74bXf+CZrjKQ/o0
	/nbzOq1RLlq35d8K4xBe4mZ4IPHZVpTY9BsLTECdrBCPoB8d5BKcjU5Dz2D6H3BVN+sPjG
	crl6q/56YvqIEqt7eqSChbJ5q6gSg6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783945005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pFa3CkPB5/zsm1kI7wziE+HM9O4DamB/IWX3voiemsQ=;
	b=ya+j8VU9SnwI3thpLYZqwBQFIrd/CaonD9Eyfkr3G1paiK03KkXc2u+DY4w244src3tjOm
	1rWie1VdEF87jEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9729779AE;
	Mon, 13 Jul 2026 12:16:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a1YPNS3XVGpOJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Jul 2026 12:16:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C404A131A; Mon, 13 Jul 2026 14:16:45 +0200 (CEST)
Date: Mon, 13 Jul 2026 14:16:45 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] jbd2: check need_resched() when skipping busy
 checkpoint buffers
Message-ID: <aexnpfdnuwyhydqo5lxvcxf7nezbiqmb5j7dg6yqqj2n4b5d2b@4qwrxth5wgla>
References: <20260713102229.1598812-1-max.kellermann@ionos.com>
 <20260713102229.1598812-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713102229.1598812-2-max.kellermann@ionos.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:max.kellermann@ionos.com,m:tytso@mit.edu,m:jack@suse.com,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:from_mime,suse.cz:email,suse.cz:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,ionos.com:email,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[jack@suse.cz,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-273668-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F70F74AF10

On Mon 13-07-26 12:22:28, Max Kellermann wrote:
> journal_shrink_one_cp_list() skips busy checkpoint buffers when called
> with JBD2_SHRINK_BUSY_SKIP.  The continue statement on this path also
> skips the need_resched() check at the end of the loop body.
> 
> Consequently, when a checkpoint list contains mostly busy buffers, the
> shrinker can walk the entire list while holding journal->j_list_lock,
> even when a reschedule has been requested.  Large checkpoint lists under
> memory pressure can therefore cause long lock hold times and leave other
> CPUs spinning on j_list_lock, resulting in soft lockups or RCU stalls.
> 
> Route the busy-buffer path through the need_resched() check so that the
> shrinker can release j_list_lock and reschedule promptly, restoring
> parity with the clean-buffer path, which already checks need_resched().
> This does not change which checkpoint buffers are eligible for removal.
> 
> Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Good catch! Thanks for fixing this. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 1508e2f54462..5266017565ac 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -389,7 +389,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>  			ret = jbd2_journal_try_remove_checkpoint(jh);
>  			if (ret < 0) {
>  				if (type == JBD2_SHRINK_BUSY_SKIP)
> -					continue;
> +					goto next;
>  				break;
>  			}
>  		}
> @@ -400,6 +400,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
>  			break;
>  		}
>  
> +next:
>  		if (need_resched())
>  			break;
>  	} while (jh != last_jh);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

