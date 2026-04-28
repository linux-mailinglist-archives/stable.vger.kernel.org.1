Return-Path: <stable+bounces-241788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGEZEbM38Wm/egEAu9opvQ
	(envelope-from <stable+bounces-241788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A048CAD3
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C7B303AF10
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D4E35A393;
	Tue, 28 Apr 2026 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="W865jJwU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446DF37C928
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416111; cv=pass; b=UgBMRJtMJ/q9gFPHL1LI+Yh/QZ4brzIZbZP9FVV11zV7WrEqFIIV59D6sDF1fFbr+3gqw2EqPiTrpLiq0LR9qg2S4uPHK9yQDrKHOY9EfoAUB/EvcmgZ/+rgBshGVIJu5XbH8/UtgcECV8n1E33ylnE89Asn5VORDUJDAMrcK4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416111; c=relaxed/simple;
	bh=fRRtuYPqUDqXkQZhqKCI1YmyvrOJ2Wxos56nOQYYnfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ei+BUAGARTSOHjZ2jMg/3BqQJlhDiYW1rfETlDzC9YCtb4+DzS66HfXQX+G2vXHG1BEiV7LmBngK+XPaaLrZ0PD0gjgJv6l/y2Yg4l19QKOdp6ZfZBJnCm2YvnHd0K8ndo/eFkD6ky3XTn9xqakzzBrE5p2aWnf48RoFpTFYVoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=W865jJwU; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2429f98d0so71211565ad.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 15:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777416109; cv=none;
        d=google.com; s=arc-20240605;
        b=Dkmfl+RMP2qrGxful5+Ihh4NiJyF0GvZEE1VWoyNkVijsxCqkEaMMljaOlZEGF7zXv
         IQ4iRX23/sCMZ2g2JKnfOmK3t2ev0yXNc9A9fMEQhR28ULi9Vf5eKBwl8P4RmEwtV/gg
         iCvPscoFF3YGSSR/hvW/4Yt3M4dtgkugZ6GgntnsYxYeYhBxqSnbbz5pp5NiLzV8mQDn
         WU1e2e4po4O56Pev1aJxgv2YY4QkYeXzbsPbJpj2edAIY0/pggBXHBhQ2A3eQmUKts1J
         vSAGwm1LbE8dqTcl5spHCx3Jxkc0at2ic19WkJ1SLojMU39ozsMh7Xo9/MJT6oysGdTL
         btfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvLu59kcs425P14L4ru3Y/A7BUkRkF4ykMA0MkTCOQs=;
        fh=k7wKBc9HA3Jmk/hbczES1UfaUGZvDdtjLsBJUY5m2R4=;
        b=CFylv75fmlVL2AmnkSjKHeFCMxFNA/Xj/HYyoWVO/zdgiANH7VyY7QcW/tP3AvYdja
         eBazQq2H8m4fBYbHgQ5w+VO7iEOaj6U84F5DBOjoudM1/R2nBNlSerG6tR66WgiGcH2S
         movq6Awp9fa77YdNqOru+oPIAQoY4d+5JKQ3N/uXQHN2pMUjZVP/DKQCRj5sZ4xWHry5
         35+qd1AvimIkHAD0py1S6uuRhihFrla1tmpaFGJ1ll09kiaIzBMIipWuxSSw95jfQygZ
         08lx8l1rfjSumvwnyZ0/YB4cZc7MVjKSAC9citiR3PeQT1O9VPZmE+TB1OmSukK3ude/
         erhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1777416109; x=1778020909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvLu59kcs425P14L4ru3Y/A7BUkRkF4ykMA0MkTCOQs=;
        b=W865jJwUbM7+bKDyZLZZ43dGo3WOzcCCnAsr70cKBbtltyDXk2FT4zsiqex4G11FvV
         Se1XJcnZpxg08NSYSpAHyLKOYrYCiKweftDP4IHV6CZJiCcijhX+hKox1fjJGg4h/zjm
         d8iKB4C8ZNTLRzSjYSUXwFTlqjM59ph8PBDhCrawXjQwATN12eV9f1PhflwrgbzD5voc
         OAa6agIr+CPPubBcnd2nIVcVva+ussXD4jsH9dC2tufjPS1UAel7USH6loutUzCblz9o
         W1lTAe5z9+6Qqr7T+Rx8aqN6dcnJK9JN+z2PmfzDU0LsB6SJXTBFDPkND7WfJ82BqzgP
         A0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416109; x=1778020909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvLu59kcs425P14L4ru3Y/A7BUkRkF4ykMA0MkTCOQs=;
        b=DMR42sUrDMvtezM1/WajUfYu5idr+W0e91zV71Ah38DMjWOs/VIBXhzscDJOtpgIOO
         p5QYs8E97arV22tV8qUsz9wc5cBD+X26eJtF9+5q195pV21QVOkJIJynaP+1fE4zn+qG
         L5CTnZo0X/y1M32M+CaYHjSn6e4Y1TU1QOYmY4I2ZHZUCX/TzxADlVF6n27yBPVkhcJX
         Sd4WZYhq3BuZJQmbbnzPqGSlh9d08ym+8f/bVhokwQCw2g/7S6eSUspT2F0DTLfTQuVg
         juKe80GpuwLQkLMxDbB+bmyvRkUoCU50iw6I2R5c0H4m0jZxeh8/3RU81JIcW6eYxumu
         0N4g==
X-Forwarded-Encrypted: i=1; AFNElJ+FPjJzJSjq0VfSyaOZwygv9Z6JGyZd19RzkJ4Irh70ZsghuUpc/fbgF3vsoem7EllNx7jQau0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXiWZrCCISrIUnWl323FbUTWMI1bc9JM+y9WY47m4unpO733V
	ey7Mz9VrFWllJu79lgEeim29HaALK2y953eeg1czVvtTkCpkg7EARNalcgm41OyepITFknhL670
	xiV7oGPEk96SVk8OqKsceiIDT26tfU3U0dFP1pSH2
X-Gm-Gg: AeBDietKlt1pID54dLkOiOOrOM9E4FSPbbZ74UiWD5RmWn6iYaC5y1P9jzoPnqcWsxY
	OFSr39G521MiGe/6EDZjwuThfOjv89EWqAaD3u+7uU8NyjmD43fFa24wNpGLYBPPAc0RfPdVIis
	dUKhusJYCI0LOaGrEUTnMw7HOyPe1vLV3LDUvhInHkF3OPKNYlMzhAVoPWOMcDFFjQppKqMshhT
	v4aUdXe7gf0SPzCcgdiQ7XounYWdyjOPNkTCyHirtif+yrvUK1th6eP/zRWaxqQly775N3IQXOi
	QVGrTnlIb7msgBY8dGQ=
X-Received: by 2002:a17:903:22ca:b0:2b0:7026:24c2 with SMTP id
 d9443c01a7336-2b97c4e391dmr51018695ad.36.1777416109377; Tue, 28 Apr 2026
 15:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428104138.reply-bonding-6.12@kernel.org> <20260428163203.796681-1-kpberry@google.com>
In-Reply-To: <20260428163203.796681-1-kpberry@google.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 28 Apr 2026 15:41:37 -0700
X-Gm-Features: AVHnY4K5R_1OF1J9AqBkmwa_pdOm3r18CBCteEumdceRA5aZMXMUVn7Bgs4tixc
Message-ID: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Kevin Berry <kpberry@google.com>
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 921A048CAD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:dkim,asu.edu:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241788-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[asu.edu:+];
	NEURAL_SPAM(0.00)[0.462];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,asu.edu:dkim,asu.edu:email]

Thanks Kevin for picking this up for 6.12.y.
We can't backport the upstream patch since the upstream rewrite that
introduced the bond_up_slave snapshot array isn't in this tree.
Confirmed it fixes the double-free without introducing concerning side effe=
cts.

Acked-by: Xiang Mei <xmei5@asu.edu>

On Tue, Apr 28, 2026 at 9:32=E2=80=AFAM Kevin Berry <kpberry@google.com> wr=
ote:
>
> From: Xiang Mei <xmei5@asu.edu>
>
> bond_xmit_broadcast() reuses the original skb for the last slave
> (determined by bond_is_last_slave()) and clones it for others.
> Concurrent slave enslave/release can mutate the slave list during
> RCU-protected iteration, changing which slave is "last" mid-loop.
> This causes the original skb to be double-consumed (double-freed).
>
> Replace the racy bond_is_last_slave() check with a simple index
> comparison (i + 1 =3D=3D slaves_count) against the pre-snapshot slave
> count taken via READ_ONCE() before the loop.  This preserves the
> zero-copy optimization for the last slave while making the "last"
> determination stable against concurrent list mutations.
>
> The UAF can trigger the following crash:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in skb_clone
> Read of size 8 at addr ffff888100ef8d40 by task exploit/147
>
> CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZ=
Y
> Call Trace:
>  <TASK>
>  dump_stack_lvl (lib/dump_stack.c:123)
>  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
>  kasan_report (mm/kasan/report.c:597)
>  skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 inclu=
de/linux/skbuff.h:3396 net/core/skbuff.c:2108)
>  bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
>  bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bondin=
g/bond_main.c:5593)
>  dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdev=
ice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
>  __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
>  ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:=
554 net/ipv6/ip6_output.c:136)
>  ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
>  ip6_output (net/ipv6/ip6_output.c:250)
>  ip6_send_skb (net/ipv6/ip6_output.c:1985)
>  udp_v6_send_skb (net/ipv6/udp.c:1442)
>  udpv6_sendmsg (net/ipv6/udp.c:1733)
>  __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
>  __x64_sys_sendto (net/socket.c:2209)
>  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.=
c:94)
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>  </TASK>
>
> Allocated by task 147:
>
> Freed by task 147:
>
> The buggy address belongs to the object at ffff888100ef8c80
>  which belongs to the cache skbuff_head_cache of size 224
> The buggy address is located 192 bytes inside of
>  freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)
>
> Memory state around the buggy address:
>  ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                                     ^
>  ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>  ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value =
error bug")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
> Signed-off-by: Kevin Berry <kpberry@google.com>
> ---
>  drivers/net/bonding/bond_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 5035cfa74f1a..9f1a189d46f1 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5326,14 +5326,21 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_=
buff *skb,
>         struct list_head *iter;
>         bool xmit_suc =3D false;
>         bool skb_used =3D false;
> +       int slaves_count, i =3D 0;
>
> +       slaves_count =3D READ_ONCE(bond->slave_cnt);
>         bond_for_each_slave_rcu(bond, slave, iter) {
>                 struct sk_buff *skb2;
> +               bool is_last;
> +
> +               if (++i > slaves_count)
> +                       break;
> +               is_last =3D (i =3D=3D slaves_count);
>
>                 if (!(bond_slave_is_up(slave) && slave->link =3D=3D BOND_=
LINK_UP))
>                         continue;
>
> -               if (bond_is_last_slave(bond, slave)) {
> +               if (is_last) {
>                         skb2 =3D skb;
>                         skb_used =3D true;
>                 } else {
>
> base-commit: c286ea5e62389897291fa742d2bb909ecc9ef2d0
> --
> 2.54.0.545.g6539524ca2-goog
>

