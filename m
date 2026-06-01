Return-Path: <stable+bounces-259659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEpJCI/vHWotgAkAu9opvQ
	(envelope-from <stable+bounces-259659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 22:46:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED562550D
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F80E3024924
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CD8387590;
	Mon,  1 Jun 2026 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hrrMw5Xx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5133358C4;
	Mon,  1 Jun 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346669; cv=none; b=JYSl6Q3f0xWrZlCXPl0rq6+ruj0NMpBocY5WeHZoweKSxAOHJ+zFm3h/aXYooZ2Tr6zGSjyeCt+elR9ug9eS67fGxwpOp73CZVSgsjA2zSIRJ/psWj/2DblBJ1xIWDdLNSSTCdhiIxF5cpiR05I/8rsrbnVxfN3LxADqYYAN1uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346669; c=relaxed/simple;
	bh=rUZOBdM9EjHb9Ij1KI0G6nXjC8r3Of2qZtSZyBmeWxU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a/i8/H7GHvjdOAuBX5ea1lA0T+anBff2sBQyRF+9P88OvcIIOkHjirze09nbNa3kL63/8/ip/2qVr5tyy1wuNbdy4bcDZeXAaYQmnbWF4MMCLK0TVp/8hOMMHtn1H9VaOZoFaEffhXYym73L3o+IqI4W9zOlSDDh81TON4aObkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hrrMw5Xx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6858A1F00893;
	Mon,  1 Jun 2026 20:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780346668;
	bh=x1Ita4ALRIwbUma+e/SouNp6V9HdLIRsvnqj4QVKvVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hrrMw5Xx9njrDfRhxz8cA2HudadDAyZ/Tq/XTLaaWnSpxkbH7q96Xak4yU+QSv52M
	 QAPXFegY6c4cYCJjYPzFdkmx1oksfr/gs4pKXzc6kLSZdy54qt58pLrhha3ANm+XnO
	 Lc/OdZmlpzwyZ//IdLHBeaiJf88jBAyJH073AIi8=
Date: Mon, 1 Jun 2026 13:44:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
 jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/compaction: guard move_freelist_head() against
 invalid freepage
Message-Id: <20260601134427.dda82558dfb2da579d66cbb0@linux-foundation.org>
In-Reply-To: <20260601133941.111989-2-giorgitchankvetadze1997@gmail.com>
References: <20260601133941.111989-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-259659-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: B0ED562550D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  1 Jun 2026 17:39:42 +0400 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com> wrote:

> In fast_isolate_freepages(), freepage is declared uninitialized and
> is only assigned a valid page pointer if list_for_each_entry_reverse
> exits via break. If the loop runs to completion (all pages in the
> freelist have pfn < min_pfn), freepage holds the list head sentinel
> and high_pfn remains zero, so the high_pfn fallback does not update
> it either.
> 
> The subsequent unconditional call to move_freelist_head(freelist,
> freepage) then passes the sentinel as a page pointer, which is
> invalid.
> 
> Guard move_freelist_head() inside the existing 'if (page)' block
> where freepage is guaranteed to refer to a real page.

Seems correct from my reading.  That code is rather twisty.

> This issue was identified via Coccinelle (use_after_iter.cocci).

But AI review is worried:
	https://sashiko.dev/#/patchset/20260601133941.111989-2-giorgitchankvetadze1997@gmail.com



