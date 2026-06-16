Return-Path: <stable+bounces-263532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kD3xKvjEMGrhXAUAu9opvQ
	(envelope-from <stable+bounces-263532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:37:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118568BB69
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:37:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TDzDfxOS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263532-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263532-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0182030453AA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1D3C4168;
	Tue, 16 Jun 2026 03:37:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C583C277B;
	Tue, 16 Jun 2026 03:37:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581043; cv=none; b=JhdlBuzeeoNnJ2n8pmasooDHBlXrlGmknXoaMmvcmI/i0VdZ5qHY5f+Yp0mUK9UAkUuMs1qE3w6b7ZOOIlsHFD1ArNe3QUjSxFXmsGdv4eptzHm/cDOvMFo6B8sgWw5X93Da8fADkdlrU2rYObJqn7vaFNQpfupZt/NrsZLDIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581043; c=relaxed/simple;
	bh=7GAZmDnMMEhKEEApQwwsXu8Ha+az/9RmzgMjko+7xaE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G85fdfkqZ3NKQzhniBbMknpZjGGWASLm4eAmsTJdde2XuLuIOwTkAq8ZrS5eJ5Bu/zAjqz/+FUb9MPmaGiF5k6ijof7KNbmg/L5khRtXN+jtHa+DMQzOicoQpNsaZU8qpii5paxjtkUCBHb51P7HfxIJhx0MDa7NgIMXx++V+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDzDfxOS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53591F000E9;
	Tue, 16 Jun 2026 03:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781581042;
	bh=yl9lakeIMTfMDdeq/Ttt7hj01mSxIfxp4XHyTh90FBI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=TDzDfxOSQ616YflIoWjXhIztKRzYDGZ/YsXJMdo8tp1bEHHfpBy1aHSEMF2eV5/kA
	 5SMUKvejUtB+uwLgZM+6RWobLKu+4nj3TVKD389njKrBB1Qka3KeDX3bP6m97Ktaw9
	 ZkNfxZ27aJjx95hciQNzb6SXIMToaurNo2ZxRdrTmJC0xlo9H9OHdykYqx3Djw9nye
	 t1t9ehmbdzpek3II2v7E4DQ3qCRKxWGWo/VZKpLFljUj3YuUetB8lRKboXZ09XihMK
	 e1W23yw9bVLzOsiVo8IYyAlCDeEhulsGcrES2esyMymyEPB6/QmMGxU+ywDdJDaPzm
	 5gP14mcI7T+vg==
Message-ID: <bd3d9950-80b9-4099-a088-d2d07fb3092c@kernel.org>
Date: Tue, 16 Jun 2026 11:37:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, geoo115@gmail.com, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 qiwenjie@xiaomi.com
Subject: Re: [PATCH v4] f2fs: use post-decrement count for cp_wait wakeup
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260616033146.127000-1-qiwenjie@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260616033146.127000-1-qiwenjie@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263532-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.sourceforge.net,xiaomi.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:geoo115@gmail.com,m:stable@vger.kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:qiwenjie@xiaomi.com,m:qwjhust@gmail.com,m:jaegeuk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chao@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0118568BB69

On 6/16/26 11:31, Wenjie Qi wrote:
> f2fs_write_end_io() decrements the writeback page counter and then
> reads it again with get_pages() to decide whether the last
> F2FS_WB_CP_DATA completion should wake cp_wait.
> 
> Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
> decision is made from the value produced by the decrement itself. Keep
> the existing dec_page_count() path for other writeback counters.
> 
> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")

Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")

Thanks,

> Cc: stable@vger.kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> Changes in v4:
> - Add Fixes and Cc stable tags.
> 
>  fs/f2fs/data.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d83a21998ec2..58d23eb74ec2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
>  		if (f2fs_in_warm_node_list(folio))
>  			f2fs_del_fsync_node_entry(sbi, folio);
>  
> -		dec_page_count(sbi, type);
> -
>  		/*
>  		 * we should access sbi before folio_end_writeback() to
>  		 * avoid racing w/ kill_f2fs_super()
>  		 */
> -		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> -			wake_up(&sbi->cp_wait);
> +		if (type == F2FS_WB_CP_DATA) {
> +			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
> +			    wq_has_sleeper(&sbi->cp_wait))
> +				wake_up(&sbi->cp_wait);
> +		} else {
> +			dec_page_count(sbi, type);
> +		}
>  
>  		folio_clear_f2fs_gcing(folio);
>  		folio_end_writeback(folio);


