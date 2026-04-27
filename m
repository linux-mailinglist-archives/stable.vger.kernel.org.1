Return-Path: <stable+bounces-241256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LeCNPwU72l85wAAu9opvQ
	(envelope-from <stable+bounces-241256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:49:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A546E929
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D56F13004F09
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF7E35B653;
	Mon, 27 Apr 2026 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0zemnqdL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="flHFUWs1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bdH024rO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QmA/N/+b"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA933537F8
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276154; cv=none; b=XHqr2qE7NnHWlqBvturxU2TaQL3xUNfXwPSpNfy2Lb9Ape7OVLwBFxkCQxGFdgnoIeiygDqouO0snz1W8ww3IYu2bMcrdAQVFATnU4gu+9m+hhZiS9W25o6xu6Bs4fEbmUGSTH2LC4Ot+94twDuBASnl7DB5W5kfhY7kYMfTpqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276154; c=relaxed/simple;
	bh=mKxnLWO8Hs+000xP7Y3fG6/BTTvgqFVWuahY7VFXHbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfkyBytyzQSP5qbugjE5R53HQh8ygmTqBh+5RdZL32MxXIy5D+MUo7Cpaz7dib/lwRMmxagLpKV/uNXQ2Sk3CUdIeOVU+fv7oYARpXCOw8oaFIrv5H6vYAoUrFJHZFJ8AQKZWXjuO5oblo2dU8w24vWrffVVgKhwYAkd7IWSO5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0zemnqdL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=flHFUWs1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bdH024rO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QmA/N/+b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AC896A817;
	Mon, 27 Apr 2026 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777276151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arplvSPi2JFlECX/+/+1OAM+U1qZByH2H1+6yaAluqQ=;
	b=0zemnqdLbFzIuiF6POubYzCgnUdYGnENR6z9NkwoYCGp+fkx2UHmXv2x81dag/ZfORCL8i
	2XrznKWKZ/avFNycDXj+W71too2CV0CW4sTNiTcRob0hkb6s90EZDkxJ7VOKVCWjsJ50Vr
	ESpukY4GRDk+8UrH85E1P0wQnLT2p7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777276151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arplvSPi2JFlECX/+/+1OAM+U1qZByH2H1+6yaAluqQ=;
	b=flHFUWs1SEZyeXMjuj6GNmcSL9G50Lha6N+QAValj8e1sC8qo4sMedr9dn4MDTURQqoA4a
	AwdIIrsQY2Ek4gDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777276150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arplvSPi2JFlECX/+/+1OAM+U1qZByH2H1+6yaAluqQ=;
	b=bdH024rOeWnBryCQK53sX6ziBaA1h2RmcW+LhYa9OwCDd5bPDLOZfhceikcf3BGA7SzK+4
	vMYDEXtgBUqDENyr2s+koaIc1AgiSX9iP/52tdpnCfnwaKY1HpRmqzTpLI4VSXcjtSEfW2
	Xtcg82Nmm0oFgAD37JaAYypqBRMP1JE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777276150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=arplvSPi2JFlECX/+/+1OAM+U1qZByH2H1+6yaAluqQ=;
	b=QmA/N/+bhu33buru0WCSMhITNsx0qoAHm76iR1WJ6RjitDrfJVENulhibZrVyUIzNhrxrF
	L/y1t1+xVnoVGQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8035A593B0;
	Mon, 27 Apr 2026 07:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UaCCHPUU72nrbAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 27 Apr 2026 07:49:09 +0000
Date: Mon, 27 Apr 2026 09:49:03 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, muchun.song@linux.dev,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memory_hotplug: fix memory block reference leak
 on remove
Message-ID: <ae8U73RyTE2a6bdp@localhost.localdomain>
References: <20260426144447.817722-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426144447.817722-1-songmuchun@bytedance.com>
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Queue-Id: 900A546E929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241256-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linuxfoundation.org,linux.dev,gmail.com,intel.com,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:dkim,suse.de:email,localhost.localdomain:mid]

On Sun, Apr 26, 2026 at 10:44:46PM +0800, Muchun Song wrote:
> remove_memory_blocks_and_altmaps() looks up each memory block with
> find_memory_block(), which acquires a reference to the memory block
> device.
> 
> That reference is never dropped on this path, resulting in a leaked
> device reference when removing memory blocks and their altmaps. Drop
> the reference after retrieving mem->altmap and clearing mem->altmap,
> before removing the memory block device.
> 
> Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

The change looks good but some comments below:

Acked-by: Oscar Salvador <osalvador@suse.de>

The outcome of leaking the reference is that the final call to put_device()
in device_unregister() leaves the memory block device linked in the
system under /sys/ ? (besides not deleting the struct I guess)

> ---
>  mm/memory_hotplug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a943ec57c85..4426abb05655 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1422,6 +1422,7 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>  
>  		altmap = mem->altmap;
>  		mem->altmap = NULL;
> +		put_device(&mem->dev);

1) Six months from now we might not remember why we need to call
   put_device() here.

   I would put a comment like remove_memory_block has:

   "/* drop the ref. we got via find_memory_block() */" or something like
   that.

2) I kind of dislike having an internal put_device() lingering here in
   memory-hotplug code, it feels like it does not really belong here.
   Ideally we should have a high-level function in drivers/base/memory.c
   that calls put_device itself.
   Something like "put_memblock_dev", dunno, names are hard.
 

-- 
Oscar Salvador
SUSE Labs

