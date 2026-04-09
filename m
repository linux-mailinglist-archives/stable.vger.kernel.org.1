Return-Path: <stable+bounces-235423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6D/MBla512l0SAgAu9opvQ
	(envelope-from <stable+bounces-235423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:36:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C853CC152
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02433074A0A
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873903DBD72;
	Thu,  9 Apr 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+6sNB4o"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE83DBD6C
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745004; cv=pass; b=Z+nTKH6D53FsfGri573Y4awgbdpzb2vp8YLDslzm4ylDb0moXYpJ2nwbPy+dPktB2R4wil5Qwb3fqzOw0JSDn1Bd59clRidqj/ZGLqd4/MafLZph3Rbu9W0/ImVkkpSmtb5Z4a2uKs881pgnPD/ynlk6BTbt2M9CZ7mvTANlqLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745004; c=relaxed/simple;
	bh=aiz98qC5uuUB98pxDGSrJs8vIwp/65s1qr19/1CjLTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnrsQg17Pi8ry/GHYwVrc3yHuPH//dXqD+bLPjqXDNLxONkwPgmm4Tesl8cK9zIaHlmYw5uDSWjOv7rui32Q9LwdxRfnVt8hCoKiHjQL9WsAIetZjE1TB84a/zadNpSHkmXETZzmM1UM2pm680mobyRnhVxiNzVfZAxOBZ4unLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+6sNB4o; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d02a71526so573856f8f.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 07:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775745001; cv=none;
        d=google.com; s=arc-20240605;
        b=ZtDme9Dmp9qy/OpGe/QGoRRKTDus/lYvG1co5OxGdegIo7F4EfWNLvGzIxYl2KFHaj
         0fY/tJnhLhSrZuQn0/xAinTU3gU3eoml2/btwVlf+J9YW6rcc149Vctt/y58Dcy/xnZP
         FmE7ZtBNTF4eLenc0boTkTWoLe4L2PjobY6Kvm1tR+bukwlgy7LlvY765J0Y7Ol5eKnp
         j0JbAvkX3HsKnFA96MEAz8HuktHFjCgSupcyxhYb0OYd0epy4Lb6sD+EvukR5V61mler
         eRUMo8NtuiYGa4WGUmEyJe8XmXKynZanktraq06iRCTqVKb0Xr4C9Cvik9kXrF4VoF3o
         +lMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        fh=fi4Rlm/53qrUVE12OToghAWcEuhjssJzzcJ5Dfh+TeQ=;
        b=UeFcd7PfrQ9hlBMTftH/+tQHtQ+m4ONoetHk3LOKua8nBqr5DiMIhHupfj2YWTf1RX
         mmehF+jgmH7otDEvBEAT65BDEaI7Y+k8iWs8+kH2c22Q0uBahlLDYGYx/U0TTALaVy8G
         IUSuj2XaaqnAfzWJS5rkpOCJc5I4SrwthQYERzlybLbqQSLo+t3qKNGIPuLvWULELE3Z
         p0k+QkA0RnJpdi8s2hetmHM9we/oA0ZNXPS/HEvpd21zDC7y/6Cxas3PnK1qHKZkFZQb
         ArH/rio4Ebbnyb6v3VmpuBKqbuaRN7JQTfEjE0gmavuPXSOn0rlqNURaEA6UxP9P5k9e
         z81Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775745001; x=1776349801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        b=R+6sNB4oNQPK9IWW0WP6NZ7e8XKcqazpLb3HQLzI979uJShdR1bjPiXVh+GiQwdAfi
         7qIwrp9BWtIu2WMvND9WRKEEnUdC+ulFYCeuEh4laRTdvrHkesN7dV+wlCUOXfbjpEeE
         DBNnjiN3Z3CLR8lsh5+8GXW4GYAvc/vsumJbCNVANiGJI9lDhraIDa9f9h2Ckpd7QnrB
         PREjGjBWYHTT3k5OEyD/jCciY8Ko7DECj0E8Ve2r3CeyY/B31gVqMn637CGnjvpJPrjF
         qnvRUUyy96BEmnhfYozGX7NLCf9bGfxR+NYR+YuziVmRnAZCgnadA6TEnjYUvnAlP/OM
         epqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775745001; x=1776349801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2B9qE/aSznRzr95piluDzuDSrf64tY/r70hHnVKdTQ=;
        b=iE11qTPtwqa42jAA7ifEAxUXYWny3o8uNuxGxzZybFPv2dy97RX5w2sbNuVjjUzt4s
         8MASAkLvtN9q867ioNzT+IdSLWQembqzfaxFoZwZGyk4xjR3PmWA6RhEv6qfcCMC4VG6
         SMvKPincb8okLf1aNcplcRP5/c3Rt/y8GjqmSgWj540tYCAOw1hfe9Di9i6lNi8sr8fb
         1YmDX2lCbyesjox8a63IYZhOumMOoWsE9rgJFsBSQUIntM4LCpT34SyLGUpuhSLwDNOp
         ARctTGtOquc7CJI6IbZMJ6ZFf2GINWGJN6mwfkvhMQgg1EtYpP603zB8NmFEg0wfYDi4
         6nyw==
X-Forwarded-Encrypted: i=1; AJvYcCV5Q8nfKnkVRB10sGTl005Lh6FO8euDmFKCnDJZ4f964kY0FCaS6MWmJXum0xJ7xTN9Qt5/sJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBJI0PpE7ASH59tsb+T/2hZqiNDKtZ5UZVu+H2yNX6JLq3rWL
	szSjOi8SQVoNSD83SptpSRwqTezhx6o5f0daH/kWjO6bHXReiP0QP/npU92H3BjsRAidZdvQ5FB
	AOvm9HcV0VP4CAtuHkKZux48/Y+LMCDI=
X-Gm-Gg: AeBDietlQHig6bf8RGb7hb8LqReAVBOAVtgnRsVfIiigjuciP/bHdb7srRLmbggmAfe
	8LboA/kXPKiHgUDWP1tribyrF9GvaG02K0e0wYlwAGbsV/YikUSM+U+1HPL8END28bqH5HDZhK/
	A/MMszI9uJ/L8tkNYeYnDArD7s8gjbMBkzUY0SuWvRK+t357R5QSLVGw5/1CTB1NTgp95jVpPYh
	EWnEf5yZaWmOhvbsxERYvCsW2Sf6RQUFvrT+JSbWNFO9ZbmIDfE3cT83amYayfPLJ4wkU8IW+n+
	Rx8aCSmVpwqtVmuv4RNdPGsNakGZ2mMJl0a1YwB3sSpz6L1pz7cAoluvCcaww+FtVzVmHHg7Dnn
	M8CpzQin+Qab91e8AhtPlJrwyng==
X-Received: by 2002:a5d:5c84:0:b0:43a:16d8:96e8 with SMTP id
 ffacd0b85a97d-43d5a089c3amr5137406f8f.0.1775745000893; Thu, 09 Apr 2026
 07:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406224953.2787289-1-werner@verivus.com> <20260409061026.3926858-1-werner@verivus.com>
In-Reply-To: <20260409061026.3926858-1-werner@verivus.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Apr 2026 07:29:48 -0700
X-Gm-Features: AQROBzA77CgnGz0GMfcb6aUuD-xSsenSGs755KZkihl8giw17FumU7yK1I768zo
Message-ID: <CAADnVQK0Toai=KZ3BggnR33DK20Oks1VcjphueRShCWuyuh3pA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: guard sock_ops rtt_min access with is_locked_tcp_sock
To: Werner Kasselman <werner@verivus.ai>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235423-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,verivus.ai:email]
X-Rspamd-Queue-Id: 74C853CC152
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 11:10=E2=80=AFPM Werner Kasselman <werner@verivus.ai=
> wrote:
>
> sock_ops_convert_ctx_access() emits guarded reads for tcp_sock-backed
> bpf_sock_ops fields such as snd_cwnd, srtt_us, snd_ssthresh, rcv_nxt,
> snd_nxt, snd_una, mss_cache, ecn_flags, rate_delivered, and
> rate_interval_us. Those accesses go through SOCK_OPS_GET_TCP_SOCK_FIELD()=
,
> which checks is_locked_tcp_sock before dereferencing sock_ops.sk.
>
> The rtt_min case is different. Because it reads a subfield of
> struct minmax, it uses a custom open-coded load sequence instead of the
> usual helper macro, and that sequence currently dereferences sock_ops.sk
> without checking is_locked_tcp_sock first.
>
> This is unsafe when sock_ops.sk points to a request_sock-backed object
> instead of a locked full tcp_sock. That is reachable not only from the
> SYNACK header option callbacks, but also from other request_sock-backed
> sock_ops callbacks such as BPF_SOCK_OPS_TIMEOUT_INIT,
> BPF_SOCK_OPS_RWND_INIT, and BPF_SOCK_OPS_NEEDS_ECN. In those cases,
> reading ctx->rtt_min makes the generated code treat a request_sock as a
> tcp_sock and read beyond the end of the request_sock allocation.
>
> Fix the rtt_min conversion by adding the same is_locked_tcp_sock guard
> used for the other tcp_sock field reads. Also make the accessed subfield
> explicit by using offsetof(struct minmax_sample, v).
>
> Add a selftest that verifies request_sock-backed sock_ops callbacks see
> ctx->rtt_min as zero after the fix.
>
> Found via AST-based call-graph analysis using sqry.
>
> Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  net/core/filter.c                             | 53 +++++++++++++++----
>  .../selftests/bpf/prog_tests/tcpbpf_user.c    |  9 ++++
>  .../selftests/bpf/progs/test_tcpbpf_kern.c    | 21 ++++++++
>  tools/testing/selftests/bpf/test_tcpbpf.h     |  6 +++
>  4 files changed, 79 insertions(+), 10 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158..5040bf7e4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10827,16 +10827,49 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>         case offsetof(struct bpf_sock_ops, rtt_min):
>                 BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=3D
>                              sizeof(struct minmax));
> -               BUILD_BUG_ON(sizeof(struct minmax) <
> -                            sizeof(struct minmax_sample));
> -
> -               *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> -                                               struct bpf_sock_ops_kern,=
 sk),
> -                                     si->dst_reg, si->src_reg,
> -                                     offsetof(struct bpf_sock_ops_kern, =
sk));
> -               *insn++ =3D BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
> -                                     offsetof(struct tcp_sock, rtt_min) =
+
> -                                     sizeof_field(struct minmax_sample, =
t));
> +               BUILD_BUG_ON(sizeof_field(struct bpf_sock_ops, rtt_min) !=
=3D
> +                            sizeof_field(struct minmax_sample, v));
> +               off =3D offsetof(struct tcp_sock, rtt_min) +
> +                     offsetof(struct minmax_sample, v);
> +
> +               {
> +                       int fullsock_reg =3D si->dst_reg, reg =3D BPF_REG=
_9, jmp =3D 2;
> +

please de-claude your patches before posting.

pw-bot: cr

