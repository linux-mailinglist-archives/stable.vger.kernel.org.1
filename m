Return-Path: <stable+bounces-269617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8rcoKknmQWoRvwkAu9opvQ
	(envelope-from <stable+bounces-269617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 05:28:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C836D5AA3
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 05:28:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=mjRpffcB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269617-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269617-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16DCA300DE01
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810C37E2EE;
	Mon, 29 Jun 2026 03:28:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433A37DE84;
	Mon, 29 Jun 2026 03:27:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703680; cv=none; b=es220QO2N00EchfviwVY2xbOM+vQrrWXhdBD3uoyDuSyFJZq2n/T+Kmvirk7tmX1SthJHGLZ2GJ88xY8Yq5OJX3zyDpRUV9hx5CCkOgQvxOEXD5uXakNHPna7QL5+Od9kO9/z6/Zej4UDyuWCEPnfROeEgH0xGUBhEutsWIHW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703680; c=relaxed/simple;
	bh=Mh0HCfG+EqC71QqziUOSeBTvb7e5Dd2WJzMcOo/E+Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOg+Wbhbwi0EV8I6MaCByonE4RH7PS8MyFlIFzpdlxQqaVXJ1MrOQVwKXwBiyb8/22yx1ao5VlqixfLpH39sDlBfs/OTP/JfmgUJmYDrVvCZiueXXFqZcU8rnL3QTVSVyDEZgVb8n8kf/DAm1Hqdy6AH86f79lDj3hmCKgbBb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mjRpffcB; arc=none smtp.client-ip=115.124.30.113
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782703668; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GnuCCBI3ALRCI/rId03CW8nskbsRqSLSxoX75VBaEXk=;
	b=mjRpffcBLVZJT32bHFGBQkykRhoZ2HpkcTs9dxecugboXuSFNuzAAhSQQ5T5au1grTXfNOd8Ant1/+Vp68xxX9VpbBLmrD7phndRrU/6xJCA2R27JmAgDCcW5eClO4z60qyoUHQ1z+A4x85958ZCY1xcs8WagLm/G/oAM1+2ucs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X5luln4_1782703667;
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X5luln4_1782703667 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 11:27:48 +0800
Message-ID: <dde92cd4-c6fe-4339-a892-004ca78ebc30@linux.alibaba.com>
Date: Mon, 29 Jun 2026 11:27:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tmpfs: zero unused folio tail for long symlinks
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com,
 Barry Song <baohua@kernel.org>
References: <20260628004314.27370-1-alhouseenyousef@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260628004314.27370-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269617-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:hughd@google.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com,m:baohua@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	FORGED_SENDER(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable,bf5586280a66e9ccdfa9];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,vger.kernel.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3C836D5AA3

CC Barry.

On 6/28/26 8:43 AM, Yousef Alhouseen wrote:
> shmem_symlink() marks the entire folio uptodate after copying only the
> NUL-terminated link target. The remainder of the freshly allocated folio
> is left uninitialized.
> 
> Reclaim may pass the whole folio to a swap compressor. KMSAN observed
> sw842_compress() computing a checksum over the uninitialized tail. If
> the folio is written to a swap device, those bytes can also leave the
> kernel.
> 
> Zero the remainder of the folio before marking it uptodate and dirty.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bf5586280a66e9ccdfa9
> Cc: stable@vger.kernel.org

Do we need CC stable? Have you observed any actual impact?

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>   mm/shmem.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b51f83c970bb..b06c1ae2f50c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4057,6 +4057,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   			goto out_remove_offset;
>   		inode->i_op = &shmem_symlink_inode_operations;
>   		memcpy(folio_address(folio), symname, len);
> +		folio_zero_range(folio, len, folio_size(folio) - len);
>   		folio_mark_uptodate(folio);
>   		folio_mark_dirty(folio);
>   		folio_unlock(folio);

Thanks. Barry sent the same fix before[1] (though I forgot why it didn't 
get merged). I think this is a reasonable fix. So:

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

[1] https://lore.kernel.org/lkml/20251224020424.52976-1-21cnbao@gmail.com/

