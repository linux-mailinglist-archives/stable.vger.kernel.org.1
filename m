Return-Path: <stable+bounces-233609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKrjFksb1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:57:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B67853B075E
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B072305E12F
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2333A9DE;
	Tue,  7 Apr 2026 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE0XifjP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CA32ED3A
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573454; cv=pass; b=ODR9ZiOzo15MVGtdHR7gOS+RDvhCZi0qa0cqVVyF/kFq1Q5yBQuO3jMjRkb5pi5s/QoOEcOFfpj/+ZQvAwpIZhfTNt+N+pMW3HvNDzoAJzOgTQfmiq2lynf6vPpPU5LipjYRsSVxggId1tqgT+nsqsjadJCo6rcRaQlSGSJv0qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573454; c=relaxed/simple;
	bh=hG/FTwzy/ZE2SWNV7WriQV09KuIc7XMwXJVmR4rclLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a19e23MceWP31juF8Gdz2EwUGsD134zSP75MKmbqcjl7TpQ5Nbhw0MhMHx7IS/7xWq7Vjsmf4BlPsvb83QDVn76ng2eb7cx+suDNeARxuqCHTrAzJUdS8GBy4p0rEwzgbc3VhRNtTLUlCM0SO3P969GeKacOyw0J6oVgfTXzfG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE0XifjP; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so69061835e9.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 07:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775573451; cv=none;
        d=google.com; s=arc-20240605;
        b=ZJZXO6A7EY6zvS8uxol3IKrqdiXMhwuRIjrWt4ZoEsHCfyGV6+ZDr067Wa1j6NUkgJ
         x2ZEiJNwpGiMCmN0beeXJEzT392W7d8TPiUF4ixRfZb7JOs3JMap1KAOLnaG4QhK6zrb
         GCNv718YyKg48bOylilCwd4/UOmBsbtUKduijtZUj88BlVPYccQazo+HASkhAw1FwdNj
         OH31OKsP9Q70L8u4BQGuzlF0+u1fYVZChy9caZ7eIlxdd6hesUfP9tm1MooasxZn110J
         vImxpnKen7TalOj+IFG6VOnby4TEC22p6mxJP/NU0yTi+0H5l7muB+Lh8aBQiPhiNAaD
         XP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F43DvoPLQ89GUslUWbajzpb04hbr9eseroihgGmJ9Cc=;
        fh=PNRtosLJhkeXLG/40ZCHah6Ys6UY5IywTjt4R/pDrDI=;
        b=P+AJ3RpJ61tBFtSLXTgi4fcYO74bCoJnDvsUyCZJRe371DJTkZgbjbdKQSb++H1D9s
         NqBWRu/gkVbGBAY1PGtkEd05hKRf/m5adZmloLXt2kbWDrl4PpLmItx53QZb6WbT+K0X
         5bpUrE6uHxrU92ItwJ27OyiJ37z3qqg1KFZ7Zrq1863LzLQIoBiiJnDeJRQD02T/Tc+d
         LYaW0tRh050PI3GLdb6xAhBVfqZgbG/ZT317GWgzV/7OFD00hQ9CmoULSwq6RrHQfgLQ
         ROJ4SOGvETB9NhbizMfjZA4urqGZNKGDSCm5ctZxUO8TN+k+spWTGLf8d/zvGxphl/oq
         OH5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573451; x=1776178251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F43DvoPLQ89GUslUWbajzpb04hbr9eseroihgGmJ9Cc=;
        b=IE0XifjPI6pCdNxwwaV2KCkBy1PDjBAazo7B4h6NEDEwSLml8mO6kvC7CG5PYXQIif
         YntET/Kbc4f1VQtzRsAOH1QVSdJgjDeRBvWCyP4yEL8AREIrlBTAtAC23FqS9PrBWT/h
         6S4jSG6KzBOBGCsizeG0RBmlRe/jjyzRCeWmmr+bbHS2FtUBhdQt1qyjXAmrO3E8vd5q
         +VE+eAvZBOdNnjaWtB97OxBjfHcvfoiQnY6v7R6m88Ec9piMPlb82+C4RlHxpvtmk3Oh
         wiveOzkYuMladuysL+GjZFG0zExGXCTRl4XWltdnAqAUUWt8w40VHF/E3HADIJSgcCLr
         FwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573451; x=1776178251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F43DvoPLQ89GUslUWbajzpb04hbr9eseroihgGmJ9Cc=;
        b=pWTrvgxZxSr90C2uvdfW54FsYviiY4m/EwCRzhIC+uFd/dfyy5ehQo1sZtdfmNy9jl
         XHiWobvSToeVCZImtyF5UP2E2kstXdvkDHQhCTN8M6XLA25hYMEyNd1J9Bu/mVaM8jAA
         qQ6by9ZB1IJFuItsUjN5Mqj6Mqsnn2haE6+DVq6uQjLIegDlx0O4UMA4VLo3YKSlJmie
         IRUT7qyIt1T+HHA4Ymw8kRRMWhthqAISun+A8uWGixEcHdsyIAVR8fLWOXl3csxOZ8cZ
         fuzuFnxUpM1LdNS0aTs0e21TFqX3E1DYw9kkrC8h9XnKhrE9aYrKWHej/a3PnFCCo8aR
         rbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPks/Ve8VB+JEbFfttRpRJaNrPOwF8KVX37ym0/e6rxFl3sBtjod5ANSHrgQbfiNtC9jzwKBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoIMxizNXVcRV7T7DED4JpCub9IX4qI6tW7IseM7Whd0j1CPom
	CTwD5SYaRJeIqLQ6QcqbEhqfB1NxK7srindQtCowNOp1YYHcqd8JYLRv6LtWjpx5z3UUbgGw/Oq
	t5wgiAtSrKNcFNF+nTRfw13NCrN6DwN0=
X-Gm-Gg: AeBDies9TSOxgwova3aWuHhP8C7CA7Nt9jQlKpsNrXATH0dvPVm6AtGR+BHjDxbPS4f
	CF1IsHvS5iUBVMuEEnWGcV4kyYqd3vwXJcXlMUJRahcurkgEM351jGUqXTWOB/QVAbAepq8q0S9
	1D+A0Ecd7k6F+qfKE5VDoun8V5vkfthQy8g7bX8QnLFBufrFSq2cOTMz9AMJyE7sSZ6BjolJ1iZ
	rqD+zx6o8NklzfihCihKZHxB774DfiUrPyrnXt9EdrrIzQWGgNn/O0Ccw0Pm5+71aVFrutalBkF
	HoVYauJpI12/7/dtlxekE1zyfPT5jvKJnKQKz48fbZaSuO7YlZuBzIvHhDYi5AxPU4XP5WTuvUX
	LK6nLKl3qIBwfmMekTiAL3FVoOvfRF4PDyyTx
X-Received: by 2002:a05:600c:3f08:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-488996d2323mr285113035e9.3.1775573450574; Tue, 07 Apr 2026
 07:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-bpf_rcu-v1-1-fbc9398d05c5@debian.org>
In-Reply-To: <20260407-bpf_rcu-v1-1-fbc9398d05c5@debian.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 07:50:38 -0700
X-Gm-Features: AQROBzDp9hrsf35BhvzwwyjXQEk6_grrb8c07DLrm0nLORrAsgPCMCgQlbwgd2Q
Message-ID: <CAADnVQ+NBOORC510MWz1OAyWw=Xbg-LRYVFG56xR7BzH31VgfQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix suspicious RCU usage in LPM trie for sleepable programs
To: Breno Leitao <leitao@debian.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233609-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,redhat.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B67853B075E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 3:48=E2=80=AFAM Breno Leitao <leitao@debian.org> wro=
te:
>
> trie_lookup_elem() uses rcu_dereference_check() with
> rcu_read_lock_bh_held() as the lockdep condition. This is insufficient
> when the lookup is called from a sleepable BPF program, which holds
> rcu_read_lock_trace() (via __bpf_prog_enter_sleepable) instead of
> rcu_read_lock_bh(). With CONFIG_PROVE_LOCKING enabled, this triggers the
> following warning:
>
>   WARNING: suspicious RCU usage
>   kernel/bpf/lpm_trie.c:249 suspicious rcu_dereference_check() usage!
>
>   rcu_scheduler_active =3D 2, debug_locks =3D 1
>   1 lock held by .../...:
>    #0: ffffffff86ca5bd8 (rcu_tasks_trace_srcu_struct){....}-{0:0},
>        at: __bpf_prog_enter_sleepable+0x26/0x280
>
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x69/0xa0
>    lockdep_rcu_suspicious+0x13f/0x1d0
>    trie_lookup_elem+0x99e/0x9d0
>    bpf_prog_3980d36ecbef0e34_net_check_ip_pod+0x42a/0x510
>    bpf_prog_57df4ce643736a70_enforce_security_socket_connect+0x3e9/0x69e
>    bpf_trampoline_6442540179+0x60/0xf9
>    security_socket_connect+0x25/0x80
>    __sys_connect+0x15c/0x280
>    __x64_sys_connect+0x76/0x80
>    do_syscall_64+0xe6/0x930
>
> Use bpf_rcu_lock_held() instead, which checks all three RCU flavors
> (regular, bh, and trace) and is the canonical helper for BPF map
> operations.
>
> Fixes: 694cea395fded ("bpf: Allow RCU-protected lookups to happen from bh=
 context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> I've hacked a reproducer for this issue, and it could be found at
> https://github.com/leitao/linux/commit/59c83f313face36107ef1e8392e27b1cf4=
887b70
> ---
>  kernel/bpf/lpm_trie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index 0f57608b385d4..ac36063cb7e62 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -246,7 +246,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
>
>         /* Start walking the trie from the root node ... */
>
> -       for (node =3D rcu_dereference_check(trie->root, rcu_read_lock_bh_=
held());
> +       for (node =3D rcu_dereference_check(trie->root, bpf_rcu_lock_held=
());
>              node;) {
>                 unsigned int next_bit;
>                 size_t matchlen;
> @@ -280,7 +280,7 @@ static void *trie_lookup_elem(struct bpf_map *map, vo=
id *_key)
>                  */
>                 next_bit =3D extract_bit(key->data, node->prefixlen);
>                 node =3D rcu_dereference_check(node->child[next_bit],
> -                                            rcu_read_lock_bh_held());
> +                                            bpf_rcu_lock_held());

This is not a fix.
The issue is deeper than it looks. We discussed it before.

