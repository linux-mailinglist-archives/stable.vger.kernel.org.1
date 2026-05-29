Return-Path: <stable+bounces-256732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGtkN2PoGWpazwgAu9opvQ
	(envelope-from <stable+bounces-256732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:26:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067D607D28
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAE51306C305
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9473ACEE2;
	Fri, 29 May 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="X4t+REnQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218336F8F9
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082370; cv=none; b=i8b3opTuifExpYBIpN3E/c3Xgatd/x0I1Wv+Idh4aiygCfpBog5/pwes1AL9naCP3JwaAxB5MUYzdzvoaCEaoRuPGwwnC10vmwFqIjfOdnFjcEoN9RHu9Oi8ZCzFczeDy2pk06Mg25UOmTnWgbn1xu3SGmn98YcesV/GiDocaxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082370; c=relaxed/simple;
	bh=jkWZTD4QRHZiQqpe6ALyI6kMoPn3g9Suq0ijNAkRndY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=HobTXk4IkX3G8QpQJTRldz4ZGF0J0ziyEXDErRe1R21zpLObf3oFw8Mrs3LkYX23BwzqpTilcUMxtC40Lz6gKwxuniRLDYaBno4XJlZ/KxTYpC6wZmKhjbVISxwG9CeAoYqsqjmZh8HrMKoG/t47DZG0r2Pxy+iH0ewhz84MZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=X4t+REnQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so12980257a91.2
        for <stable@vger.kernel.org>; Fri, 29 May 2026 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780082368; x=1780687168; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/gCygVuvCix+pnQ33/MTL/P0DmU8fAWMpRNiF7Wi6A=;
        b=X4t+REnQGDH0cMNf6c4pG9G3Nin9oq66m+t7oExqOmaPUFpBqWIusRD1BUR+I4vjwx
         zd22YtofKieKZ2H5uqFB5hb+2uVVQDP7nc/00FEPr1yOzLsDbqkfNY/Mi4b/jf0CfH3f
         FNSQ/joJed7m0IYYdn+9wz1ZQj6ldx30+c5RKztQnu52gbByqiTLUTjfdseWwcJf15PY
         t3KH83PcDb6xbt9Do1ZG6yBW8cdaYb49amdAaTsHogZ2ceg5uV8sdoB7hDfDA1U3sZ4c
         cNCSSitU4TEozLsQH2qCPAk3uyvdc43nIR4apmnLENcnmr6NDAShRKcOoW0RG2CcMD4Y
         JAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780082368; x=1780687168;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/gCygVuvCix+pnQ33/MTL/P0DmU8fAWMpRNiF7Wi6A=;
        b=cfn1cgNc2+U0tNatacpHBE1nsK0THgvgqm+crCNskuKsT6ut+MQ9iJQGiWnZPXLR4B
         ksVjFSEL1SCnHUo4Nvz4qjWXQPJbke4GshBwHrhCKg352YdFo0LkPEPZowFnsWeowU+U
         oWv3LWjsrrcGQuBIAlM4XgZWeG5niJzU3kbqhLqcZ0pezpGAehzsUGu52DFZ9lQeo5W0
         8gSSqL8swSwhQWmUXDlgzWscNzT2tnwVeahZiomVGNm4K4IxCLk4ORBvWVvDNi52ITxO
         Ap3I46tdOcPcnUXryRUhEwiBB2nW6ZZHLyqa+dNiH9KrcFxBmLsVrNlpAwULYjz/3+LH
         s4SA==
X-Forwarded-Encrypted: i=1; AFNElJ+/hoQglg+muRIVJdUFi93cIflGPzJfUbaraOorVCZAXlT6eOwmXxX5Zch+nprqV9qIyP1cwvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaCbVZ69ziZxwK8OqCQJ0NV0oVU/AmFzJpnQWpOBn4It1Wyxix
	n+KfLygA1pMFXSyWZAPZlE7YCNv6r6XWz/PC+RV1FXwaDfhusAfN+N9huh/plky0YTY=
X-Gm-Gg: Acq92OFaw+UGq0Aj3pPq9eSAXqHTY0ATtMDGekJl56oJ3doUZIzImNakTjHDPFoCRq+
	OLnoLIsNJOrHTOwDIIbP42JQJMuqUs1Yw3kQqDioEA2kwq+5alvrWl+kUU3ZbARXXA+OAIjuWCO
	1fzoiKjnHnB/nG/pNbSzvp/+iZsGG6q/4ud9FGhRZdBdJpFVwOvtsXGAcWGQuHiFaozSNBYfmf7
	FT46he3UUqgkkF4aeJ3/L6ViTPHxoBUgWafsSLSqaqbSfHhMVnMHHb2AakK2IqPXUm+fg6VvtNa
	LokIVqZNtwQ99+FxwWvs9VBhEuvlAjQO+fb87suZaPayjCvNQUcdZJ+8pJWREaG4RVnNZJrlnwi
	lunyPYXzgxgL7O7Qnf36dFNmjV/2++MtaRT8WctGI1O7lNX6olklMvG7fTC6C3I69Ix7AxF+hu2
	XMmDz2cQ9HkrgoUZcOT4rcRwE8zw+yk4r8+Cs=
X-Received: by 2002:a17:90b:278f:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-36c4ff364dbmr495717a91.10.1780082367780;
        Fri, 29 May 2026 12:19:27 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6a34dabsm2787591a91.12.2026.05.29.12.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 12:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 15:19:26 -0400
Message-Id: <DIVEJ9TWTA69.N0GC1B4XBPTZ@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vlad Poenaru" <vlad.wing@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, lpm_trie: Allow lookups from sleepable BPF
 programs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
In-Reply-To: <20260529174233.2954240-1-vlad.wing@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256732-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,redhat.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6067D607D28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 29, 2026 at 1:42 PM EDT, Vlad Poenaru wrote:
> trie_lookup_elem() annotates its rcu_dereference_check() walks with
> only rcu_read_lock_bh_held(). Because rcu_dereference_check(p, c)
> resolves to "c || rcu_read_lock_held()", this passes for XDP/NAPI and
> classic RCU readers but fails for sleepable BPF programs, which enter
> via __bpf_prog_enter_sleepable() and hold only rcu_read_lock_trace().
>
> A sleepable LSM hook that ends up doing bpf_map_lookup_elem() on an LPM
> trie therefore triggers lockdep on debug kernels:
>
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>   WARNING: suspicious RCU usage
>   7.1.0-... Tainted: G            E
>   -----------------------------
>   kernel/bpf/lpm_trie.c:249 suspicious rcu_dereference_check() usage!
>   1 lock held by net_tests/540:
>    #0: (rcu_tasks_trace_srcu_struct){....}-{0:0},
>        at: __bpf_prog_enter_sleepable+0x26/0x280
>   Call Trace:
>    dump_stack_lvl
>    lockdep_rcu_suspicious
>    trie_lookup_elem
>    bpf_prog_..._enforce_security_socket_connect
>    bpf_trampoline_...
>    security_socket_connect
>    __sys_connect
>    do_syscall_64
>
> This is lockdep-only -- no UAF, since Tasks Trace RCU does serialize
> against the trie's reclaim path -- but it spams the console once per
> distinct callsite on every debug kernel running a sleepable BPF LSM
> that does map lookups on an LPM trie, which is increasingly common.
>
> Other map types already use the bpf_rcu_lock_held() helper, which
> accepts all three contexts (classic, BH, Tasks Trace). Use it here as
> well, matching the established convention.
>
> Fixes: 694cea395fde ("bpf: Allow RCU-protected lookups to happen from bh =
context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/lpm_trie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 0f57608b385d..ac36063cb7e6 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -246,7 +246,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
> =20
>  	/* Start walking the trie from the root node ... */
> =20
> -	for (node =3D rcu_dereference_check(trie->root, rcu_read_lock_bh_held()=
);
> +	for (node =3D rcu_dereference_check(trie->root, bpf_rcu_lock_held());
>  	     node;) {
>  		unsigned int next_bit;
>  		size_t matchlen;
> @@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
>  		 */
>  		next_bit =3D extract_bit(key->data, node->prefixlen);
>  		node =3D rcu_dereference_check(node->child[next_bit],
> -					     rcu_read_lock_bh_held());
> +					     bpf_rcu_lock_held());
>  	}
> =20
>  	if (!found)


