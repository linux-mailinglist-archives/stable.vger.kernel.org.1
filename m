Return-Path: <stable+bounces-262340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 75YlK4FIKGpSBgMAu9opvQ
	(envelope-from <stable+bounces-262340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:08:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A2662C3F
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:08:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=XeQ5AIDi;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262340-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262340-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D872630B4E3A
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616447D941;
	Tue,  9 Jun 2026 16:36:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FC3B840F
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:36:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022984; cv=none; b=LypOaIABSTcdGEuEKbwF7AMxC3NUuZ+ozFh3XwTo1tSqQKgIk5ZSsEJTzyPWqtSbPh+I5cMErhpPgfHxOl2kRmeCoJ+WUK5I6uqv562ADOlTWBWf9SL2qfDw97Ku+5z7LIx5coGZrniI8yTt8yVogmtr1i8oLzCbcYu0vynqna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022984; c=relaxed/simple;
	bh=oVxXvNlK+2x3E33IMRV6GjfD0zx1nEbsNx5xYHuYv2w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TX6idVVnlckJVMkPyMceyu17eKv+bmJxMuh+xq45kyIqQkbfhhfFy69MXXUzBtzg3dvkNy0m3ePgWUYRBgXsBYEB7IDMmxZourjBuhoLhu4FuzpiaSGDPI/I+pRbeAw3tHOf3IRZM5DI63f1ZMMuaTMmwRMKyPBx9aG1P17p1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=XeQ5AIDi; arc=none smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1370417c01cso7613159c88.1
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781022982; x=1781627782; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zm66UDgugDuJh+suaGoWf+oPueZ1pKYv/n0XCt6RiE=;
        b=XeQ5AIDiFHtmODUR12yVSegTZDC6+2LTuwQS/yAuk5g/SAHha0Il8F90wJ/geXl95B
         vMWVKK7PsGjDAzKSRKX1Yx+d/BVJqc0Iumf5Jsec5f2FVpi0wbiGXvL7T799z9uDHs/Y
         nCKUPhEcnNjwQS9Fh0t7ra2HqLz35VTEV1sJgGoiWWT3nT7BE/Shk2pz8Fy0XawiMKa8
         ebeDmFY06BgotWJ2SI1Zu/4ZQmB1w09FjMACltvSTw3yWaqD6n/swVVz1gyHkUmMcO8o
         7dXel3SCd7sybYdXP51Km8JhqZgFs/dv9vIXAaUhqXFFdDed/dSsX8J51NCNSeKlRYw4
         q40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022982; x=1781627782;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Zm66UDgugDuJh+suaGoWf+oPueZ1pKYv/n0XCt6RiE=;
        b=ewndJU5Yy5CkpA4gfqRQ62fWhsign/6tU1gdtaN1dtSK85OC3WGowhsIbcmwmJsDBe
         pOF69hsx8NhfEOvh5Sowy2QBecUn50OTOjV4fwREQQKNNBA3tOSqu3fzQhXC7N7y5jyz
         h/2fGPN3v1mCEy27/gZjbwLS+4H84H+xYaNXgZ2cy0jQtz7Q7vTf2A7ad1pULU3hzq3N
         Iu35y0rOj9NXFYns1YK98UwQo+zzrsIW8PjYmIUMBz50kF3EAvLMit3zwOt4+CmcTp6b
         H4RsPuPBdaysHh6C+GjjuzWfg8hqR74RHbw9UNoazeaJl347JeAI7fsvzX3nnPoQR4+2
         zhkQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hF1cEYOmru8N9YQazpBo6Yn7WSJt4Yvenym2uFt+bW5kpM8Go0KTtP4EktIusa20cuQy3RM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcbqGzjQDFKJ6mSLwvfP4UXZMX1Z1i0Xjq40zWjhYSFem97P8
	DnaYUfE6JJxcPhePE4E+gTWtYEmtouRtmdhQoKTN9lOsatBpx3hbyqg6OxlAnQRhyG0=
X-Gm-Gg: Acq92OHRSSjmVerg02TX+zaiQ49r5S3mrYqBu7QNOZxttq9IC7SH/CwLIivWUpSGu3S
	YTNjRVFgBHTSY3KOLLDeW7HPBAhjq8lptVeoDswJAKC32BX9RnHHx96zJXEfzx5dy97riXXm6Rh
	t+yWktt3punKIlILIym3wCFdlgBhQKBjOAwb8X848cgxo75Rh5BCmx9IIP3HJXtiYauM3We2lmR
	D5hHNAUTaCS2/IpLaypxNPM75v7EG0NsmQCOwHZ+gASkgxEinF0GZ7cgBkjorXxY85h1M9GA5hG
	kr/a9AnJp6tpqE3+ZlI8/da4fz3x++Gvy8MIOXMQQCHzfy2gSAKYBi/a1pj4crdAcP8ZOxOjhls
	jCoQ2ZYPJBpKNB+gGIHj5XvB5hjxUgxezHahVNGKBO2rqMgF5EyatVdxCkl1TRA4lhmaQ2CoaCP
	h0johGJEXFbn/NfGA=
X-Received: by 2002:a05:7022:ef18:b0:134:cf34:b8e0 with SMTP id a92af1059eb24-13806660872mr11361311c88.9.1781022981682;
        Tue, 09 Jun 2026 09:36:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3297])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f554f732sm15063231c88.12.2026.06.09.09.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 12:36:18 -0400
Message-Id: <DJ4NYD3BBJ3A.3TEL5PAOUE579@etsalapatis.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, lpm_trie: Allow access from sleepable
 BPF programs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vlad Poenaru" <vlad.wing@gmail.com>, <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260529174233.2954240-1-vlad.wing@gmail.com>
 <20260609135558.193287-1-vlad.wing@gmail.com>
 <20260609135558.193287-2-vlad.wing@gmail.com>
In-Reply-To: <20260609135558.193287-2-vlad.wing@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vlad.wing@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:toke@redhat.com,m:emil@etsalapatis.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vladwing@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,redhat.com];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,stable@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262340-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis.com:email,etsalapatis.com:mid,etsalapatis.com:from_mime,etsalapatis-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 085A2662C3F

On Tue Jun 9, 2026 at 9:55 AM EDT, Vlad Poenaru wrote:
> trie_lookup_elem() annotates its rcu_dereference_check() walks with
> only rcu_read_lock_bh_held().  Because rcu_dereference_check(p, c)
> resolves to "c || rcu_read_lock_held()", this passes for XDP/NAPI and
> classic RCU readers but fails for sleepable BPF programs, which enter
> via __bpf_prog_enter_sleepable() and hold only rcu_read_lock_trace().
>
> trie_update_elem() and trie_delete_elem() have the same problem in a
> different form: they walk the trie with plain rcu_dereference(), which
> asserts rcu_read_lock_held() unconditionally.  Both are reachable from
> sleepable BPF programs via the bpf_map_update_elem / bpf_map_delete_elem
> helpers, and from the syscall path under classic rcu_read_lock().  In
> the writer paths the trie is actually protected by trie->lock (an
> rqspinlock taken across the walk); we never relied on the RCU read-side
> lock to keep nodes alive there.
>
> A sleepable LSM hook that ends up touching an LPM trie therefore
> triggers lockdep on debug kernels:
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
> that touches an LPM trie, which is increasingly common.
>
> For the lookup path, switch the rcu_dereference_check() annotation
> from rcu_read_lock_bh_held() to bpf_rcu_lock_held(), which accepts all
> three contexts (classic, BH, Tasks Trace).  Other map types already
> follow this convention.
>
> For trie_update_elem() and trie_delete_elem(), annotate the walks as
> rcu_dereference_protected(*p, 1) -- matching trie_free() in the same
> file -- since trie->lock is held across the walk.  rqspinlock has no
> lockdep_map, so the predicate degenerates to '1' rather than
> lockdep_is_held(&trie->lock); the protection is real but not
> machine-verifiable.  trie_get_next_key() also uses bare
> rcu_dereference() but is reachable only from the BPF syscall, which
> holds classic rcu_read_lock() before dispatching, so it is left
> untouched.
>
> Fixes: 694cea395fde ("bpf: Allow RCU-protected lookups to happen from bh =
context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/lpm_trie.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 0f57608b385d..4d6f25db9ba1 100644
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
> @@ -359,7 +359,7 @@ static long trie_update_elem(struct bpf_map *map,
>  	 */
>  	slot =3D &trie->root;
> =20
> -	while ((node =3D rcu_dereference(*slot))) {
> +	while ((node =3D rcu_dereference_protected(*slot, 1))) {
>  		matchlen =3D longest_prefix_match(trie, node, key);
> =20
>  		if (node->prefixlen !=3D matchlen ||
> @@ -482,7 +482,7 @@ static long trie_delete_elem(struct bpf_map *map, voi=
d *_key)
>  	trim =3D &trie->root;
>  	trim2 =3D trim;
>  	parent =3D NULL;
> -	while ((node =3D rcu_dereference(*trim))) {
> +	while ((node =3D rcu_dereference_protected(*trim, 1))) {
>  		matchlen =3D longest_prefix_match(trie, node, key);
> =20
>  		if (node->prefixlen !=3D matchlen ||


