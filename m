Return-Path: <stable+bounces-232597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN/FD4JNzGksSQYAu9opvQ
	(envelope-from <stable+bounces-232597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9A0372749
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FDEA302F0C1
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6385A4657DA;
	Tue, 31 Mar 2026 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E2lmhWqJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247E45BD5C;
	Tue, 31 Mar 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996807; cv=none; b=GdNJjSj8WED+2k8dz3+nL8A6GrGEQwfPztvo02RAhU3m6KAYj9IxjzFKHS3Y8MIiSJ5juz49iNaTlmhUy+Eju844RQG/9JF7iWP+kVuyV4KyrMrXAkdwmkosvxpNd+Gppxinq6FsqJELxmGCuMoOdlZk9lww8IwYeT0pFI83xYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996807; c=relaxed/simple;
	bh=rl4/17UJ02DrCORAEhhWxTz7VUCl9Xg85++OigKCpx0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PBY7J6UBYcTJANdBqGWkyUf6N5vOJ+/Jj4C5wSvBSEXxFpVlMaAoAcv40q/zpB5w4Uv0HFbNVg+w6ARI9NKuDkPW2mSZ/BI+3erAht0cDs01GLoixngFPDlArGs+PA4ipNEKp3lL2dd/x2Z3j3BQlPZCRm72Qo3UyhCqxIPOpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E2lmhWqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA53C19423;
	Tue, 31 Mar 2026 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774996806;
	bh=rl4/17UJ02DrCORAEhhWxTz7VUCl9Xg85++OigKCpx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2lmhWqJngQkNc0t2bSGmbkbQ9CydxkrIfPDRpvweyNCbhBotNOv0k3eKUBcWEuYz
	 1EJCKHKdVMSa1Zc1Irfvpi5sOeF+xnv6TYAYOGgSPHveAttww4OWnJ4zmjNfUAzHgg
	 J1OWpqsoljMNSc1t9GEHp4YIxsDWTajqizST3nws=
Date: Tue, 31 Mar 2026 15:40:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Baoquan He <bhe@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, lirongqing
 <lirongqing@baidu.com>
Subject: Re: [PATCH v3] mm/vmalloc: Use dedicated unbound workqueues for
 vmap drain
Message-Id: <20260331154005.4471389e14061f467ab1e433@linux-foundation.org>
In-Reply-To: <20260331202352.879718-1-urezki@gmail.com>
References: <20260331202352.879718-1-urezki@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232597-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F9A0372749
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 22:23:52 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> drain_vmap_area_work() function can take >10ms to complete
> when there are many accumulated vmap areas in a system with
> high CPU count, causing workqueue watchdog warnings when run
> via schedule_work():
> 
>   workqueue: drain_vmap_area_work hogged CPU for >10000us
> 
> Move the top-level drain work to a dedicated WQ_UNBOUND
> workqueue so the scheduler can run this background work
> on any available CPU, improving responsiveness. Use the
> WQ_MEM_RECLAIM to ensure forward progress under memory
> pressure.
> 
> Move purge helpers to separate WQ_UNBOUND | WQ_MEM_RECLAIM
> workqueue. This allows drain_vmap_work to wait for helpers
> completion without creating dependency on the same rescuer
> thread and avoid a potential parent/child deadlock.
> 
> Simplify purge helper scheduling by removing cpumask-based
> iteration to iterating directly over vmap nodes checking
> work_queued state.

Great, thanks.

> Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")

That was a couple of years ago so I see no need to rush this into
mainline.  I added it to the next-merge-window pile - it'll trickle
back into -stable kernels later on.


