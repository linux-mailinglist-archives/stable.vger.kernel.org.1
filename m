Return-Path: <stable+bounces-237615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHfwFhUu3Wn1aQkAu9opvQ
	(envelope-from <stable+bounces-237615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:55:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B73F1B51
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C77E3056FE6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B6377551;
	Mon, 13 Apr 2026 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kF82xfwR"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027F376BCA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102299; cv=none; b=WsLD7oVJ81p8isudfW0WlWLp66a+jmLibKG4D4k6iolakynivuppCynIKkUzeHpb+RZbb1us9TVbn3xegXx4C2k3atKacWGRWjZmynIwK8g+rrl7vJj3t2HTlvVyWBvIACf7ZDwizY5PYmD/7qZAJeoQwyAB9fpTqs/y1CfFLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102299; c=relaxed/simple;
	bh=sOP7MTQef0cqRh+VRrISotffDSTqwCVfwDOGc92oW7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lakby+FVXI7/ilEd1R1XlE90BfoVM/NHJzS00YUMqr4DNpszzEusQpgMNvQi8I4+xF2LuujPFbYw4Qs6lXt02Zn4BLkVmmLKM5Lgj+i8Niu3RXbQgpQ2vAFZgZZempWP6rNzuwzKz5iuo6NG+nTbkgZiK9lrTTDea0tFDdmoP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kF82xfwR; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 13 Apr 2026 10:44:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776102286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0j9S/oeWv9cGrOnlEmdvesYiWMQozAk+6ZeIzA0Owc=;
	b=kF82xfwRKUDeEAuXqOchwk9JzjnHGoGfLr6ipXkTHA8Y9gDscmQu3i/dgmUx3cPA8uIVZb
	a4vMT/H+Owd+AsXn3B5FTclx+2LzDPYcGlTlnvfjefVUU4SzorZ631Fwoh1XzU06KX+uM+
	TEyj96yOsj7dLckLcRg5oq87cs83K3A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	inwardvessel@gmail.com, hannes@cmpxchg.org, josef@toxicpanda.com, 
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, martin.lau@linux.dev, usama.arif@linux.dev, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: blk-cgroup: fix use-after-free in
 cgwb_release_workfn()
Message-ID: <ad0rbPUaeGJozbSe@linux.dev>
References: <20260413-blkcg-v1-1-35b72622d16c@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-blkcg-v1-1-35b72622d16c@debian.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237615-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,google.com,suse.com,kernel.dk,gmail.com,cmpxchg.org,toxicpanda.com,kvack.org,vger.kernel.org,linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: A43B73F1B51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 03:09:19AM -0700, Breno Leitao wrote:
> cgwb_release_workfn() calls css_put(wb->blkcg_css) and then later
> accesses wb->blkcg_css again via blkcg_unpin_online(). If css_put()
> drops the last reference, the blkcg can be freed asynchronously
> (css_free_rwork_fn -> blkcg_css_free -> kfree) before blkcg_unpin_online()
> dereferences the pointer to access blkcg->online_pin, resulting in a
> use-after-free:
> 
>   BUG: KASAN: slab-use-after-free in blkcg_unpin_online (./include/linux/instrumented.h:112 ./include/linux/atomic/atomic-instrumented.h:400 ./include/linux/refcount.h:389 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 block/blk-cgroup.c:1367)
>   Write of size 4 at addr ff11000117aa6160 by task kworker/71:1/531
>    Workqueue: cgwb_release cgwb_release_workfn
>    Call Trace:
>     <TASK>
>      blkcg_unpin_online (./include/linux/instrumented.h:112 ./include/linux/atomic/atomic-instrumented.h:400 ./include/linux/refcount.h:389 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 block/blk-cgroup.c:1367)
>      cgwb_release_workfn (mm/backing-dev.c:629)
>      process_scheduled_works (kernel/workqueue.c:3278 kernel/workqueue.c:3385)
> 
>    Freed by task 1016:
>     kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6246 mm/slub.c:6561)
>     css_free_rwork_fn (kernel/cgroup/cgroup.c:5542)
>     process_scheduled_works (kernel/workqueue.c:3302 kernel/workqueue.c:3385)
> 
> ** Stack based on commit 66672af7a095 ("Add linux-next specific files
> for 20260410")
> 
> I am seeing this crash sporadically in Meta fleet across multiple
> kernel versions. A full reproducer is available at:
> https://github.com/leitao/debug/blob/main/reproducers/repro_blkcg_uaf.sh
> 
> (The race window is narrow. To make it easily reproducible, inject
> a msleep(100) between css_put() and blkcg_unpin_online() in
> cgwb_release_workfn(). With that delay and a KASAN-enabled kernel, the
> reproducer triggers the splat reliably in less than a second.)
> 
> Fix this by moving blkcg_unpin_online() before css_put(), so the
> cgwb's CSS reference keeps the blkcg alive while blkcg_unpin_online()
> accesses it.
> 
> Fixes: 59b57717fff8 ("blkcg: delay blkg destruction until after writeback has finished")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

