Return-Path: <stable+bounces-237646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGm3LvxG3WkrbwkAu9opvQ
	(envelope-from <stable+bounces-237646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:41:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8233F2D32
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DB8C3019D6D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B03E315D;
	Mon, 13 Apr 2026 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg0aIYjJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1196390987
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109303; cv=none; b=jB+IB0GfvebAzYfMunRynyEMQfkzilKd6M18WPJKLOVSGMcYFuOhSUvZSalDGvcYp2Jeu/V5VWOumhRSCKSDLSdN7bU4dX58FYXOI6o7n/kIcovaceX/j08wzvqWd8UuG2WW1HqmfVrLTMwclSUTldBnjDQLu+FwUd/7yagybZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109303; c=relaxed/simple;
	bh=jwK3bLV4GxtoCkmegUJr4VKRQMzcMAIORxcLbU7V8sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVD5M3u5rwYoLN1kStdOT+c7UBG/4KlnB7lN2JSgsUzJ4DQm+/mpYQgt/1kO3H6XmOoMNNwcTXzAH76MX/4plP1g5aGtJ0CIzTZODbk+GsqbheBUtShj3J1s2OpILhwjbya1QDFqgEjC+eKUuohoS3A1ZNiNRCZ0ZFJFArjLlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg0aIYjJ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d64c756111so4929756eec.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776109301; x=1776714101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+e5A6rrRb07CI/0TyJFt1WuefeVIntv7J60tzg/4E4=;
        b=eg0aIYjJQ41bXmqzs1es9EM9ueVMLPDxAyYesmqcuF3h1r92LDmiAguFYUFiJ9P3pI
         2fqGwUgcP/yBGtbdy6c09sxgieAv3bOPwJBEooYbsz4GpLFwtdzGaikogtWpXh3Zsp6R
         NMqUVMA1xZ8+YNeD2GOfDJoFcQYKXhkRJqh4aakLVsRIvvpUF1iS3sl4ANBsGX1YSf6T
         MnL9SjQKUa6yR+ICI/5bMJabbSjJu8N35t2DO47xDh1WpI3lAmpV7VhgoO83bLzuwbte
         QUGGHy4Rb0cskpVrMKcdnRpCdU1b8NC/XDnTshOJrgHAmlfwZf00WKtLPQPTTDeJyWLg
         F4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109301; x=1776714101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+e5A6rrRb07CI/0TyJFt1WuefeVIntv7J60tzg/4E4=;
        b=s2LpV+HlGx4T9vsCtSwzSF/9WjBHBolKBjOojhlIe7WYASBmGh/1zQglgjhn2ab3PX
         yrxPWTTFkehH0a9+viDD66QPSfmWr0T/flQYu6SGPtD0CnxYqm40lyYAbGmZtg2W+JHq
         sJ88n7czSCQmNw2R1+qCO88Cwn6VEjxmEwk7V2jPVhg9fZfyX3hwagt9GiuJIbWTYA5o
         2Ro4YckcRCxBiWRTsZawkgKYPDGKQqGyulwjb+jZVzuX1x8wUFQ/RlWirPBZkln3x1Jr
         oIouTzxfgzLVpx2HP3QW7iX5zdDujvS7eCJ2Sisr/05ea667XEe9HZnoVagO3FmXQKqe
         Qx4w==
X-Forwarded-Encrypted: i=1; AFNElJ84H16F+Z/eBVHHUMv6TL9vrr56ocz6loHWMBgIEwBsuM+5UX+9zlKYoMZt5CYfvc+QGTqJc5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOWLhx3Alpz53yLhLAAvVQE77PKA4YiNPn0mWswdHK6eWngV3
	FOlFO8E/lTt0/7rDPYjYQ8sPyIbkkIUIKor8uZA/1zk4I+EXRqeGh9p8
X-Gm-Gg: AeBDietK7KFpu4UasAI079SxIjNGy9OIee0TRWYLyN6DF8N2NifREuX60yiKvbqQ8Xo
	rFLpG+EpVPCgmtDNB8AhWDFf02Hyf1LLC36zpK9xENNckQgdG6FGbXBeiy5uHtHyzQyjeXFSFt/
	u/6xBH3d/xecTTJnlWTZUAmVdJZr08wXAIyXZOohKZX2V32ELg+CTX6R/Jg7VX9a2whIkGDhJI/
	FmKK3EkaYFs1E+mCaqkHiegDLqPGZmfc8YAp7O50vAJuFATw1nypnmqFVb1hKolUCBy9j8uJiZ4
	uQqtohnckxH+c3VkAuBbYkt60CdvT1RCch4R/q2s7fdL/8AGXmhAPoaHxKVezy5W9naPfAC8GQw
	2TISskjhKoiWmmiOULszwKjQAe6lvCjDgZwMwSRZg+bti7cua7/6wXbJUs14gwUCjaGVXVjaZLp
	sgw+T5fAH5UULyDbRiMRsHp/hk1pxgYaxaWMkOwxC6h0d1gYJS
X-Received: by 2002:a05:7301:1f17:b0:2d2:ff9e:c07d with SMTP id 5a478bee46e88-2d5888a0fe0mr7287600eec.24.1776109300931;
        Mon, 13 Apr 2026 12:41:40 -0700 (PDT)
Received: from palisades.local ([136.25.84.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa586bsm21063373eec.11.2026.04.13.12.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:41:38 -0700 (PDT)
Date: Mon, 13 Apr 2026 12:41:36 -0700
From: Dennis Zhou <dennisszhou@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, shakeel.butt@linux.dev,
	inwardvessel@gmail.com, hannes@cmpxchg.org, josef@toxicpanda.com,
	"Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, martin.lau@linux.dev, usama.arif@linux.dev,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm: blk-cgroup: fix use-after-free in
 cgwb_release_workfn()
Message-ID: <ad1G8IuNgI2Xy_wU@palisades.local>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,google.com,suse.com,kernel.dk,linux.dev,gmail.com,cmpxchg.org,toxicpanda.com,kvack.org,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-237646-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennisszhou@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,palisades.local:mid]
X-Rspamd-Queue-Id: 5C8233F2D32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

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
> ---
>  mm/backing-dev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 7a18fa6c72725..cecbcf9060a65 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -618,12 +618,13 @@ static void cgwb_release_workfn(struct work_struct *work)
>  	wb_shutdown(wb);
>  
>  	css_put(wb->memcg_css);
> -	css_put(wb->blkcg_css);
> -	mutex_unlock(&wb->bdi->cgwb_release_mutex);
>  
>  	/* triggers blkg destruction if no online users left */
>  	blkcg_unpin_online(wb->blkcg_css);
>  
> +	css_put(wb->blkcg_css);
> +	mutex_unlock(&wb->bdi->cgwb_release_mutex);
> +

I haven't been in this code for quite some time, but does this need to
be protected by cgwb_release_mutex? My understanding is that
cgwb_release_mutex serializes wb_shutdown() between
cgwb_bdi_unregister() and cgwb_release_workfn().

>  	fprop_local_destroy_percpu(&wb->memcg_completions);
>  
>  	spin_lock_irq(&cgwb_lock);
> 
> ---
> base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
> change-id: 20260413-blkcg-9b82762430f4
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

Whoops. I think I made a bad assumption that wb implied a blkg existed
but if it never created one yet, then there's no blkg pinning the blkcg.
Either way that is tougher / more wrong than just keeping the blkcg_css
ref.

Reviewed-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis

