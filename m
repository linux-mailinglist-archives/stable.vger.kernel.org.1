Return-Path: <stable+bounces-225573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMzyHHwcuGlYZAEAu9opvQ
	(envelope-from <stable+bounces-225573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:06:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 811CE29BF9E
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 148D3300C567
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087139E187;
	Mon, 16 Mar 2026 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUS7nlHy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AAF39DBEC
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673521; cv=none; b=m45IG94Npc6E2OJ06ZZ73Fqnqtl3lLZyKknyLzacySx5JeoKigWB9k8tF4klVAAgeHqNHIGCB6EZKVuHuQarIz46TXPTbxrWMnnwlViy00hkOsvn7xvZCRqcIwiPqXSit3MLy09Wq4lNu+WOC4d1OQ795D8OTjh79QGzW95SzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673521; c=relaxed/simple;
	bh=RnzelXQEhcmD1T1EIc3JYmO2mAx5i3ChXWZTRK+KT6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGAxh5WSI9JpRHZIlLMFRbQDrG2ancIEQD0abx0S4TXzD4ko98gtx0fmlyE5xqtdWOOvkyzVybE4c24O19haq4b4kUeXPg9Db5+r4Vnv50wZzm1ddAeE8V/Z8mepvBQxya8hdmhSvuocf3oJuLgOeCYAM3jD5mpYkNRlcOJBlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUS7nlHy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b3cfc38edso2028165f8f.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773673518; x=1774278318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqco5SPEd6UaXLI10tvcOr9r7x/pSR9Rg9OAhUkP36s=;
        b=hUS7nlHyle7WeHcHg7sagZtDpm3MfyYPIVSEJToV9Y7WU5ONqqxdP0ET829XxrhXKi
         fppHrvTyudMI2SIhx+yAxkDsnHX3+YQTk0Uq0HuY03R1cTGXnxXhayTmCi2eXU9AjgW6
         C+Ppjaeo0ZL7uh5U7LBowOvMm1NUOVqapaiJOC2Rp2pgQv4iOghEPddJRDY+nb7SPxNe
         lXOSgiAWeYcjTxA9MN/nkV9lgoJTfO9nKLRi8C5w9VRL8Aseks/J+Uf3MOgLWn8DqCKY
         V/n2Yu5bPhdTgMfCox0DE7tydzanNvR+OhY+/j/Q4PnjjMGUcsgrDHNxnNVtJ3069yPk
         EbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673518; x=1774278318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqco5SPEd6UaXLI10tvcOr9r7x/pSR9Rg9OAhUkP36s=;
        b=G0kBL3trY8f2/ryY12fFLhBRLr3arIxLCoJWm2/8pXUZVaiTc6+8VXkW3+uaMm69nx
         koyHxd6RQavrDT3f2kpDFcpbiJAZpIP5cPndpP3hbUbnPfzCEkN0iNZnPtAyRHYxbIau
         n4I9yWKkrQe7++J1qno+4qlUY5nNFGBR1SmbQ5zNTzkz3iFsmdzg72tFBmUlkYeCB9UH
         I1IqLAjvsA5koHAbRcA95XMj/EUQYhzsKcm3Vj63UFvnbJVpW/9AVwfrT9M4ekTJ2jTC
         2BevhUihf8lYoQOvaKjLy5EmS7kRFr9eaOulv0I2cF5lHysrMNC5R03Z+iCleL8SqQeD
         +86Q==
X-Forwarded-Encrypted: i=1; AJvYcCUleSttEkHPur1B8fVk1uBakimPse1310jucln9B/vapuQlrM5DajdIvj1mIIUXO0auzdDgjPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6dNP6v3t/ZkVEqeIjNWisWh1ihoQcE6gm/YMVIaFY6ZnlM2J
	CMw1O/2O4/lnFHpvl4YEEnwv4q6wVWtlcd1K83ZL5tkMQCAucB0uHN1d
X-Gm-Gg: ATEYQzxw4nK8qkLybcsuCB6hi058t9mVbWhh5pmbQVxNbSbHUbBUJpgny40NECM/V0V
	KVPc9tLo5VivgrcKkdXNTf/39Fqg8tkkvM4kJc3DeF3dEgIEROLnXvYoc5QLUOaoPgg7oBFWl3Q
	tPoyj0FSvFu7VWfNEUQWsLE6FzLV9igoZTExLRH1LCYLqNPocG4/UbhdKFpkvyscSJs56dtZivj
	f7L2ZzaWKxz3QHGh2gq/AULQMmClB6/Ba72iujOO0WmIkREHbasFdcMFjY4Hsjt9JH3naMk2ahL
	7uqpIX8cGjHA8i3mzI2LVfDES+mza+2PztW1Qyz++N6AmEscRO3jlghR8tAlCu9hcA25bJ2Qkx4
	mH3aGOzdM8BNJCj29EcKV7PH56WKM6miSaM2AEfertzt3moov+xOLB3+h51NBSynAxOiZrHbjSY
	OD8NTofHN1COke3xEpLvVRi3BXjrilMEC3XyUtVd+hk6twPLLWy8RROFoLM0LO5JYRSLwwaah+E
	nuanLdB4VjK3eWnzp91pANwLHTRJQqByfxCAXfqGgUQHrRqZemmxNB7PYFVEWM+IXf83/D63zXH
	2/98KFkQGK0=
X-Received: by 2002:a05:600c:8b2c:b0:485:4bd1:4c7e with SMTP id 5b1f17b1804b1-485567148e8mr223653815e9.33.1773673517657;
        Mon, 16 Mar 2026 08:05:17 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0077fb9a9968087a66.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:77fb:9a99:6808:7a66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6c24sm398807025e9.5.2026.03.16.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:05:16 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:05:14 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Amery Hung <ameryhung@gmail.com>, linux-riscv@lists.infradead.org,
	stable@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
Message-ID: <abgcKvuSQc2ZYKw4@mail.gmail.com>
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225573-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 811CE29BF9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 12:02:48AM +0800, Levi Zim via B4 Relay wrote:
> From: Levi Zim <rsworktech@outlook.com>
> 
> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> For example, this causes bpf_task_storage_get with flag
> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
> 
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> for correctness. Add a comment about this limitation that architecture's
> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> bpf_local_storage_alloc always fail.
> 
> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---

Note there may be something broken with your setup as lore is reporting
that you sent this v3 email three times. Not sure if it could be an
issue.

[...]

> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
> index 8157e8da61d40..d8f2c5d63a80e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -18,6 +18,7 @@
>  #include <asm/rqspinlock.h>
>  
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE	16
> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE)
>  
>  struct bpf_local_storage_map_bucket {
>  	struct hlist_head list;
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
> index c2a2ead1f466d..cd18193c44058 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  
>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  {
> -	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> +	return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> +					   KMALLOC_NOLOCK_SUPPORTED);
>  }
>  
>  static void cgroup_storage_map_free(struct bpf_map *map)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 9c96a4477f81a..a6c240da87668 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>  	/* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
>  	 * preemptible context. Thus, enforce all storages to use
>  	 * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> +	 *
> +	 * However, kmalloc_nolock would fail on architectures that do not
> +	 * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> +	 * bpf_local_storage_alloc would always fail.
>  	 */
>  	smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
>  
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index 605506792b5b4..6e8597edea314 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  
>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
>  {
> -	return bpf_local_storage_map_alloc(attr, &task_cache, true);
> +	return bpf_local_storage_map_alloc(attr, &task_cache,
> +					   KMALLOC_NOLOCK_SUPPORTED);

I can confirm that this does fix one selftest using
BPF_LOCAL_STORAGE_GET_F_CREATE on riscv64: test_ls_map_kptr_ref1 in
map_kptr. Other tests using BPF_LOCAL_STORAGE_GET_F_CREATE are still
failing so I guess they have other issues.

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>

>  }
>  
>  static void task_storage_map_free(struct bpf_map *map)
> 
> ---
> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
> 
> Best regards,
> -- 
> Levi Zim <rsworktech@outlook.com>
> 
> 
> 

