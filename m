Return-Path: <stable+bounces-242603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGomHlD99WntRAIAu9opvQ
	(envelope-from <stable+bounces-242603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:34:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 818564B22F6
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 15:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 999A53004697
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 13:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D928643C;
	Sat,  2 May 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTgakDz0"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891722A7F0
	for <stable@vger.kernel.org>; Sat,  2 May 2026 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777728841; cv=none; b=V+kiAFwBEnv2C2tlL8tJM2jwkSeAcHKi0uRza3UbaPH8Y+ny5pKCeaKO1oPsnSSPRhsOB2D6dd9RHRfxgpXtv0JG/RKbJX2Ba1JQ5mks+gcAc6qaQMy9zaEx4AhD7zbKT7VT2mTAJCaEvucOP2d5CVyRoMrSW7Vrd/OfJukzqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777728841; c=relaxed/simple;
	bh=AZ67Up3J+Lw8gQpCeX9dILqmHFCACAvb+Eh5CTxVt4U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IlVJw4+ivFa4/frkvfn9PpKxQDH+Vdp0bky+aaUJgUIG0MhxZaVIhV4o49F65UN2TL6hl0sz4Em5udgWViRwfXkjJzuABJ71+G+K8VPNyLcfjhxaO3alZPmQhJP1G/BTcs3u+0rtP0XZWM0UNMwEEsG+gO4yQqAa2RLRIrd/fA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTgakDz0; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651bc83e74aso2413735d50.2
        for <stable@vger.kernel.org>; Sat, 02 May 2026 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777728838; x=1778333638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJLk920qj6m+fkV0PzZ6Aaob+A5EwJlY0//ShcXomiU=;
        b=KTgakDz0OfagPZxy/g2lRkaKmGGtBshdkACcVEKWsmNdgTbWkZgG+wNZzj+bEGniuV
         16SsYKK/+6WueAXHPbN4ZRTE/xCk4XAespVRcrDBVwfJBOwtTFstRrAPCQBaP3tBj6ni
         KjacbSuM/kgNFQ5qrhE+cKNOkcbtiriL+PWyIq6Lgsx5VjuNYjCJmEhfTN1mu+iAmiKf
         a8tS7FITtmXoxl9/eJpuXP5rDSmq2sIXotHcxjRQ+H4iPQS4ckKSaibCnf9oMWYSSCU8
         ERCifZSibSBaj6IqIdEoSAv+7fbtGaErA0/Yq25cLxRlozwuqly31wKsqY5sgwVBxbvu
         KBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777728838; x=1778333638;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJLk920qj6m+fkV0PzZ6Aaob+A5EwJlY0//ShcXomiU=;
        b=J9zZ4U4UxRiHiX2Be0K/HLyxT2N4bb/lasJR7SFFaprDbpnZKm7iaJ0n8rDjrQlzRQ
         OZL4Ce0qmaV06wDzQgGKJqE7dtQLwj8BVk+NJSRQNRhHgbCIG8y1cEDU1KoMV9FV2iih
         E0vG41h/qB9pgKGXpKytV5N7J0YHkrhM9Sl/wC9W3MVf/OopFDyK6af7WNcxp/Rz9cZB
         aiZetHQkW7USN+toNWV8Snv4WWRdjn+XpbHZ4RpM3H5NBaoEmMPwEkalkrBMrQdtRBXJ
         YSodWJdOBvotM6jTlBpJutQMieoHdMX0jAujFWlT0k1voXuRn8AytFprv1/ZShI1Vvg4
         a+PQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Vw5D0xErMnXPI5KnaFSo8VtpC+JNgKTZIOQCDE9cmvZzJDnvyfGOagblG4mAg7DMYOjgEYUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVvd/aQdlIzQszpRHV1Mt+T41cIBNsADTdN8ulns0Srgx5Bvy
	p/LEp1emdUu1RQ6oDOw9MiIoHYi8f64VnPi6OBTxfVubVaHWfzJxTn2X
X-Gm-Gg: AeBDiesWb7uEZ3BJWRJ2f9EahilJ1t2pj5pht4obPP0eXF2qeQXEvA11FWrjYOb+Qqd
	sB6iEYWm+RcJf9XfdIkcwh8A9sOVa1RjwZkj2tjzxsrlLaJE/l5/vucimm0M5MJ2TJj1xX/C/wt
	4CABxsk7UX11ANgCLv4iLlOzzb4JcRELUybzRYTzuRwkDxnRmJeScT/cTNHVt8m3fZrkDrkDqyu
	v5na04TSesjvA3BK8ONomhACmm9YRRYgoTeggtb0UmAWzIo5jGHj86goOuCyC6Lkc7XcaNUlN7f
	XD4B1tN51uRLwJKZ/EsLvJembN4XyheH+BPsJk45TbtX8ay4OerFNSRJLXopa/YZXGSaLIt7rIz
	ZlCfr+cRU7sS65MR2wDtp/h4Nu4zru/JwFg2aFxGKswd5FTrXHLII2/y4HoHC7vpkavtNO38FVT
	a+79M+33bXNE8OO8B4+/fjpGfkUxnLh0nBDfj8nvNzcIsDkPIczWK0DsqrYZ/3m0VMvzXWSCsi9
	QmPm5TbJmaVFYc=
X-Received: by 2002:a05:690e:4396:b0:651:d634:6d32 with SMTP id 956f58d0204a3-65c3d9fb469mr1993284d50.20.1777728838205;
        Sat, 02 May 2026 06:33:58 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1ce958sm2626253d50.8.2026.05.02.06.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 06:33:55 -0700 (PDT)
Date: Sat, 02 May 2026 09:33:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuznet@ms2.inr.ac.ru, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.baf2d17bd197@gmail.com>
In-Reply-To: <20260502050037.3800122-1-maoyi.xie@ntu.edu.sg>
References: <20260502050037.3800122-1-maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH net v5] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 818564B22F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242603-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,davemloft.net,ms2.inr.ac.ru,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Maoyi Xie wrote:
> fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
> scope and shared across netns. mem_check() reads fl_size to decide
> whether to deny non-CAP_NET_ADMIN callers; capable() runs against
> init_user_ns, so an unprivileged user in any non-init userns can
> push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
> other unprivileged userns on the host.
> 
> Add struct netns_ipv6::flowlabel_count, bumped and decremented next
> to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new field
> is placed in the existing 4-byte hole after ipmr_seq, so struct
> netns_ipv6 stays the same size on 64-bit builds.
> 
> Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
> was added; machines and connection counts have grown.
> 
> mem_check() folds an extra per-netns ceiling into the existing
> non-CAP_NET_ADMIN conditional. The ceiling is half of the total
> budget that unprivileged callers have ever been able to use, i.e.
> (FL_MAX_SIZE - FL_MAX_SIZE/4) / 2 = 3072 entries. With FL_MAX_SIZE
> doubled, this preserves the original per-user reach (~3K, what an
> unprivileged caller could already obtain before this change) while
> forcing an attacker to spread allocations across at least two
> netns to exhaust the global non-CAP_NET_ADMIN budget.
> 
> CAP_NET_ADMIN against init_user_ns still bypasses both caps.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

No longer applies cleanly to net. Conflict on
include/net/netns/ipv6.h. Please update your tree.

> ---
> v5 (this submission, addressing v4 review by Willem):
>     - Replaced the per-netns ceiling FL_MAX_SIZE/8 with the
>       computed unpriv_user_limit = (FL_MAX_SIZE - FL_MAX_SIZE/4)/2,
>       which evaluates to 3072. v4's FL_MAX_SIZE/8 = 1024 would have
>       reduced the per-user budget below the ~3K an unprivileged
>       caller could already obtain before any of this work, defeating
>       the reason FL_MAX_SIZE was doubled in the first place. The new
>       ceiling preserves the original per-user reach while still
>       requiring an attacker to spread across at least two netns to
>       drain the global non-CAP_NET_ADMIN budget.
>     - Reworded the corresponding paragraph in the commit body.
> v4: addressed Willem's v3 review on netdev. Dropped the
>     flowlabel_has_excl cacheline argument in favour of "fills the
>     existing 4-byte hole after ipmr_seq", and reordered
>     atomic_dec(&...flowlabel_count) to sit immediately after
>     atomic_dec(&fl_size) in ip6_fl_gc and ip6_fl_purge.
> v3: addressed Willem's review on the private security@ thread.
>     Merged FL_MAX_SIZE doubling, dropped test data, moved
>     flowlabel_count near ipmr_seq, inlined fl->fl_net in ip6_fl_gc.
> v2: per-netns counter + cap, sent to security@ as a 2-patch series.
> v1: fix-shape sketch in original disclosure.
> 
>  include/net/netns/ipv6.h |  1 +
>  net/ipv6/ip6_flowlabel.c | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index 34bdb1308..329482373 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -119,6 +119,7 @@ struct netns_ipv6 {
>  	struct fib_notifier_ops	*notifier_ops;
>  	struct fib_notifier_ops	*ip6mr_notifier_ops;
>  	unsigned int ipmr_seq; /* protected by rtnl_mutex */
> +	atomic_t		flowlabel_count;
>  	struct {
>  		struct hlist_head head;
>  		spinlock_t	lock;
> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index c92f98c6f..758a2fc4d 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -36,7 +36,7 @@
>  /* FL hash table */
>  
>  #define FL_MAX_PER_SOCK	32
> -#define FL_MAX_SIZE	4096
> +#define FL_MAX_SIZE	8192
>  #define FL_HASH_MASK	255
>  #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
>  
> @@ -162,8 +162,9 @@ static void ip6_fl_gc(struct timer_list *unused)
>  				ttd = fl->expires;
>  				if (time_after_eq(now, ttd)) {
>  					*flp = fl->next;
> -					fl_free(fl);
>  					atomic_dec(&fl_size);
> +					atomic_dec(&fl->fl_net->ipv6.flowlabel_count);
> +					fl_free(fl);

Do not touch fl_free (here and below)
>  					continue;
>  				}
>  				if (!sched || time_before(ttd, sched))
> @@ -195,8 +196,9 @@ static void __net_exit ip6_fl_purge(struct net *net)
>  			if (net_eq(fl->fl_net, net) &&
>  			    atomic_read(&fl->users) == 0) {
>  				*flp = fl->next;
> -				fl_free(fl);
>  				atomic_dec(&fl_size);
> +				atomic_dec(&net->ipv6.flowlabel_count);
> +				fl_free(fl);
>  				continue;
>  			}
>  			flp = &fl->next;
> @@ -245,6 +247,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
>  	fl->next = fl_ht[FL_HASH(fl->label)];
>  	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
>  	atomic_inc(&fl_size);
> +	atomic_inc(&net->ipv6.flowlabel_count);
>  	spin_unlock_bh(&ip6_fl_lock);
>  	rcu_read_unlock();
>  	return NULL;
> @@ -464,6 +467,9 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
>  
>  static int mem_check(struct sock *sk)
>  {
> +	const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
> +	const int unpriv_user_limit = unpriv_total_limit / 2;
> +	struct net *net = sock_net(sk);
>  	int room = FL_MAX_SIZE - atomic_read(&fl_size);
>  	struct ipv6_fl_socklist *sfl;
>  	int count = 0;
> @@ -478,7 +484,9 @@ static int mem_check(struct sock *sk)
>  
>  	if (room <= 0 ||
>  	    ((count >= FL_MAX_PER_SOCK ||
> -	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
> +	      (count > 0 && room < FL_MAX_SIZE/2) ||
> +	      room < FL_MAX_SIZE/4 ||
> +	      atomic_read(&net->ipv6.flowlabel_count) >= unpriv_user_limit) &&
>  	     !capable(CAP_NET_ADMIN)))
>  		return -ENOBUFS;
>  
> -- 
> 2.34.1
> 



