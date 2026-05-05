Return-Path: <stable+bounces-244213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNxqCHQY+mlYJQMAu9opvQ
	(envelope-from <stable+bounces-244213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 18:19:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6D34D11E1
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BA6330A0564
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944E648B373;
	Tue,  5 May 2026 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFqmNkwz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2298481257
	for <stable@vger.kernel.org>; Tue,  5 May 2026 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997498; cv=none; b=YISGgT9BGhV8WeVR7QKkQfl8SnwnK61YpngBDwOp5NaKw3JFNjTQu57OIE6Pa+euhQ9fAfik0RhzsaQHfOf1WqPvjQnIJndLcWpmV7QS/LLOLhcMKOqIG9/3rxKcrX1g3FHlUyLYHCa2elzkxmiyeg5N7jqhmNeGwFgBfGo8VG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997498; c=relaxed/simple;
	bh=Qflkkm/CQAQrIoUGNyccI6IVq5NOizMVdJ4CG/Wx3YI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SNto3yZzV7WexDCqsdHHWFbpJcHgMaum6wAp0c0M+OpYuNR5jKKnZtU37ghGRspqisSbzkQ8H+qGcO9G9OlsH8xLsc5r7edU4mQD+F6in0T64K2Bz8JZSeHEZAG6i7DGKAXyvBeRo9Cdc0VoHfuMe9fZpsdqkMsKf2pvjj7yX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFqmNkwz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79885f4a8ffso53486707b3.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777997496; x=1778602296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezuVIzME6POM2AEJaoHAJrjUF5+Hch9VDQkjGxLVMvA=;
        b=nFqmNkwzyJGHGJMN0u13YKGAnWCkpc6of3aZSqvHJFiiOVJYEdlf4vdqAozIMt6koD
         6g1tfLJGofgyFszjAuiaDyRZxF44PYuL2ds9uh0LZiDXS+iUiRox8+1JKynGKhZSPQX/
         0mPCjm2oOUbZAHQBCDnROzTEgSBcwa68mdeMUoGHiAONM0yjiNtWl8hh5N6efdhFO5o7
         SMRAR/Ev78hVSuhf9KuBpZhOEPRmsF4ac0kH8c84A+xHYfkqDOtxnUFXAo6qJjeIdLZS
         OXfXrNOYXk1WWZXer3xUuCBgRPaaoF07yFfZMn0s5e7tW4TEMMuDWSOcg5FFdIGdfQa8
         wmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997496; x=1778602296;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezuVIzME6POM2AEJaoHAJrjUF5+Hch9VDQkjGxLVMvA=;
        b=rT6lmBrv9R8FiRT7SetFHCmRXZrfNTGT8fFwsMH1jADYSTrgk5tkqH+oJKKxwdd0tY
         BqKMmd8gigEI8m7yrWtqTK0dO6D9AmWViA/sUc+e3/TmCn+YEHzir2ohlDJDZXqrXlQ1
         sFwHynazN87HbgIm1v7JGg9CkiCjiw9O4qsicGxIqg8vzsJ321XVB/w/8yFFxA29/4em
         i4wMn8mdaSaqc5RS0dDOENTODGgB9vpaxNAry13vL4i4vgZttV9rw/8RQvZiRB+vWAkZ
         a8fIytL/FKMxlCNEI0gxd8JTX6o4wbSDyd9jebe35b8lrk6Zra6gquTJ8TgmA132ATPM
         jVrA==
X-Forwarded-Encrypted: i=1; AFNElJ8FSvGF4R8vw24MW7JI+BpHwTHUz4wED9NWHQR6Iynj8QXkZETrilr4zA0GxKhgU4edHRbdj18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy10wVjxIXwBfqRHLjJtjwL9niH7TlinRYxDgA8VJE73AdAEyN6
	rOrcBUrNibAPlIYGJImxy5m/eHxzvPi5xhvb1sk9Uy8mEKDcusRxTTmP
X-Gm-Gg: AeBDievIoh7GhxnhhHJTlm/fBK/8HUm5JQyQ8SkBNZdoztBn2+5J7U0zDMLfRCrAUzr
	ZbV3m0zE2TWKhIC+N5VTaKLyQz90Fx6jX/tX3FTlGFJYGyCE1I2ofQzUu8EKkJdKXn9SQKuSGuw
	Bpinuxlaxt75u9AUfX8WcIQ/NYkGQ7VrtCCrPzmRo7xuAKnWGQ4WcXtPqOuupPdFslyJfu+GSsl
	Zi8Dd8XN5o0i1ha7Yb7ltI46v669oxBGeTj72qggvQEMUGif50wv1vvMY+6GqhzJfDRAZwAgAfz
	JMXZA+DqR91jV3uUQRJudCP0ucEz6ZLOlvjea8Q26htcZJ5M2oog6E/nxS8QCzS2F3LAzmk4lg0
	oby1ZulX+xVpvgJNz6lOvLhb/AQgowcQyHCHqjpyBvjFE5nOlWxYLqvciXRfHK+Uif1SnVlo54C
	7r6yNZUQwbzR4LLcQKAI0t4T2o4M5d1zleEM5Bqf+QYN4ro4opbZ8q04CqdzTDN9gezjR5nQLDx
	ddOZEo1oB3uJUM=
X-Received: by 2002:a05:690c:110:b0:7bd:7b2e:f079 with SMTP id 00721157ae682-7bd7b2ef1e7mr132263037b3.44.1777997495762;
        Tue, 05 May 2026 09:11:35 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm65629577b3.44.2026.05.05.09.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:11:35 -0700 (PDT)
Date: Tue, 05 May 2026 12:11:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2b6abb6aae1d8@gmail.com>
In-Reply-To: <20260505072015.1672730-2-maoyi.xie@ntu.edu.sg>
References: <20260505072015.1672730-1-maoyi.xie@ntu.edu.sg>
 <20260505072015.1672730-2-maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH net v7 1/2] ipv6: flowlabel: take ip6_fl_lock across
 mem_check and fl_intern
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8A6D34D11E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ntu.edu.sg:email]

Maoyi Xie wrote:
> mem_check() in net/ipv6/ip6_flowlabel.c reads fl_size without
> holding ip6_fl_lock. fl_intern() takes the lock immediately
> afterwards. The two checks therefore race against concurrent
> fl_intern, ip6_fl_gc and ip6_fl_purge writers, which makes the
> mem_check budget check approximate.
> 
> Move spin_lock_bh(&ip6_fl_lock) and the matching unlock from
> fl_intern() into its only caller ipv6_flowlabel_get(). The
> mem_check() call now runs under the same critical section as the
> fl_intern() insert, so the budget check is exact.
> 
> With all writers and the read of fl_size under ip6_fl_lock,
> convert fl_size from atomic_t to plain int. The four sites that
> update or read fl_size are fl_intern (insert path), ip6_fl_gc
> (garbage collector, the !sched check and the per-entry decrement),
> ip6_fl_purge (per-netns purge), and mem_check (budget check), and
> all four now run under ip6_fl_lock.
> 
> This is a prerequisite for adding a per-netns budget alongside
> fl_size. The follow-up patch adds netns_ipv6::flowlabel_count and
> folds it into mem_check().
> 

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Suggested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

Please update either your git config name or Signed-off-by to make
sure that the two are the same. Not sure whether that requires a
respin.

With those asides

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for fixing this along with your main fix.

> ---
>  net/ipv6/ip6_flowlabel.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index c92f98c6f..43b5e9ce9 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -40,7 +40,7 @@
>  #define FL_HASH_MASK	255
>  #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
>  
> -static atomic_t fl_size = ATOMIC_INIT(0);
> +static int fl_size;
>  static struct ip6_flowlabel __rcu *fl_ht[FL_HASH_MASK+1];
>  
>  static void ip6_fl_gc(struct timer_list *unused);
> @@ -163,7 +163,7 @@ static void ip6_fl_gc(struct timer_list *unused)
>  				if (time_after_eq(now, ttd)) {
>  					*flp = fl->next;
>  					fl_free(fl);
> -					atomic_dec(&fl_size);
> +					fl_size--;
>  					continue;
>  				}
>  				if (!sched || time_before(ttd, sched))
> @@ -172,7 +172,7 @@ static void ip6_fl_gc(struct timer_list *unused)
>  			flp = &fl->next;
>  		}
>  	}
> -	if (!sched && atomic_read(&fl_size))
> +	if (!sched && fl_size)
>  		sched = now + FL_MAX_LINGER;
>  	if (sched) {
>  		mod_timer(&ip6_fl_gc_timer, sched);
> @@ -196,7 +196,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
>  			    atomic_read(&fl->users) == 0) {
>  				*flp = fl->next;
>  				fl_free(fl);
> -				atomic_dec(&fl_size);
> +				fl_size--;
>  				continue;
>  			}
>  			flp = &fl->next;
> @@ -205,6 +205,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
>  	spin_unlock_bh(&ip6_fl_lock);
>  }
>  
> +/* Caller must hold ip6_fl_lock. */

nit: lockdep_assert_held as used below is preferable over comments


> @@ -464,10 +459,14 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
>  
>  static int mem_check(struct sock *sk)
>  {
> -	int room = FL_MAX_SIZE - atomic_read(&fl_size);
> +	int room;
>  	struct ipv6_fl_socklist *sfl;
>  	int count = 0;
>  
> +	lockdep_assert_held(&ip6_fl_lock);
> +
> +	room = FL_MAX_SIZE - fl_size;
> +
>  	if (room > FL_MAX_SIZE - FL_MAX_PER_SOCK)
>  		return 0;
>  

