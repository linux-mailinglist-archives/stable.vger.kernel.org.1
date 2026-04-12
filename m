Return-Path: <stable+bounces-235846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEVHJofm22laIgkAu9opvQ
	(envelope-from <stable+bounces-235846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:37:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2053E56BD
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE91E3011BD2
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D83624A5;
	Sun, 12 Apr 2026 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H8c866ev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4305299959;
	Sun, 12 Apr 2026 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018926; cv=none; b=VvcJVzHOMHtVQWh0bQFUzhZDutyi6qYrCXANK2roVXV5bayVGHvWmT5t6NbCpWhIrDg3uHMCBImMzujs+KgSOmPNkYu5/rVc1Z+6jyNKt2l+bzWOgmxA0si4SJm9Ym62aHPKQCGAKO/3I0U6MogheiPdx2B0vAVzUSbJIL2CXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018926; c=relaxed/simple;
	bh=So/3lxgYie/RFC6n3vqqdr/LETFNhsSstDNNMcIkf3Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kNTR54/fJUtiDp1KGC/LrhrPuv7K98UkYIDUrgtZ/h7f2f20XMNgyN6TrEXzpcPsC0W2Pdod3TmEwwClxoGYGrrx/jJb9z579GJy8j4RItKnRryZA5ZhB6S3GV4XuI4wDqpjKbdR9/dZjiEnum9LYYEsf9Ph02IJ1o9KFe0wtu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H8c866ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A684C19424;
	Sun, 12 Apr 2026 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776018925;
	bh=So/3lxgYie/RFC6n3vqqdr/LETFNhsSstDNNMcIkf3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H8c866evefI92Se05d+uNHgaZ0YwhuRVksrZmupUBpRLIui9yH3GbIJ4hhcQu5nYr
	 mPvFcAkyOhJSzNKEfb2lopgLsXI1BmMtU8sOHGQFmzRy39y2oXRUzU+uyQ1QKKtCJN
	 tSg4Ux6bB0v29wmUwTQ/DP97TArKYuh8sW1f/6/k=
Date: Sun, 12 Apr 2026 11:35:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: thp: Fix refcount leak in thpsize_create() error
 path
Message-Id: <20260412113518.af50cc58b0ac8635f7e9e086@linux-foundation.org>
In-Reply-To: <20260412175428.2613383-1-lgs201920130244@gmail.com>
References: <20260412175428.2613383-1-lgs201920130244@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235846-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C2053E56BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 01:54:28 +0800 Guangshuo Li <lgs201920130244@gmail.com> wrote:

> After kobject_init_and_add(), the lifetime of the embedded struct
> kobject is expected to be managed through the kobject core reference
> counting.
> 
> In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
> directly with kfree() rather than releasing the kobject reference with
> kobject_put(). This may leave the reference count of the embedded struct
> kobject unbalanced, resulting in a refcount leak.
> 
> Fix this by using kobject_put(&thpsize->kobj) in the failure path and
> letting thpsize_release() handle the final cleanup.

OK...

> 
> ...
>
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -726,10 +726,8 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
>  
>  	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
>  				   "hugepages-%lukB", size);
> -	if (ret) {
> -		kfree(thpsize);
> +	if (ret)
>  		goto err;

So this should be goto err_put?

> -	}
>  
>  
>  	ret = sysfs_add_group(&thpsize->kobj, &any_ctrl_attr_grp);
> -- 
> 2.43.0

