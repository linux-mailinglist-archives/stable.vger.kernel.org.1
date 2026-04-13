Return-Path: <stable+bounces-237664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMnVMBtm3WmydgkAu9opvQ
	(envelope-from <stable+bounces-237664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:54:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA033F3A3E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79211300E49F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C0F358379;
	Mon, 13 Apr 2026 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="G+BzScSm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCEB34DCF3
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117270; cv=pass; b=KwV3J3CQ8J0wnBBNVkZV9ZrxQJzEpJ7vPS9HX/79GCmlZnLqgfqN+PsR7S47IBeQSO8tClP3iHn6+jnEHvb+X+uJaotiU193Cp6rR3BjWQ2gsxZh50QU3wGmx8aiXUS8QHrfxs+TF9EwSdh4Ls+P+fZA9IworO4SpfnILPg1MIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117270; c=relaxed/simple;
	bh=noehSjOwfAzfoE84j/s2X+Fq5Zffca+uEe6PpBHWbDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZdx0S10qzvqMsPI5I+hxvLk41zqYMwUZNgFAe5y7GFp3FbGddij4gDYwFz/ex26/YmyepAi4jq76QJeR2u0oEeek9p8BXLe6LAtV4By/ZKPAtG9SSAOnT8gtOMTRRhRkFmH3G6o3NgLmLYfd7kqdrIgk09c2aAARmaa9pPkxJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=G+BzScSm; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2494440f3so16657525ad.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776117268; cv=none;
        d=google.com; s=arc-20240605;
        b=dSI10YzfajLW6Dk38FEmD5M3FZjEHsI8CJPFV6n3hLKpxuPo6SI/O8xyWv94EvXdie
         NM2i0oxYoCvZh3mpSM9HeCon55kxuBFQlAjEw98gNtCXEqMNQkfX+MTHoIf+isiUbAUz
         G0K3PzD1W9o+UsWGU/RoMHgBiIRH7MzEk/2saIPNSmq0dG3wXJRRz/yMPiHrDtVViBaH
         UOXflglcQGroecKF806TLIjVSyCk1D9VZzPGzarkV/lz19B895HqLYP87VLVOyohRT+J
         aUXHxL1W9KUdhr0k5/gOJca942XHxkxr6zxR7ztNrtaKl558gQohbyRg80ISUL6ocwDf
         HmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4A5q/u2GjROt5G8izZLI1rLeYlVXEM5J4xMMGpVR/Y=;
        fh=i4a/3Eii7pPhJZy1dQT5hmZ7IUTuMLnDBeBfalwzZR0=;
        b=YErtt+/VtUdPbxtqjwsWgjuftY6P/5on5ZFpY610c60oKxaLOGRYtEDF9EMJU6UAvM
         C+Y1OIjMu0se7XmaP1ioSEmXi5ccJ9Lj3jRFbu/1oc0eJp+kNZjKmUCTMDBjEEjajYdy
         46R2TniuULfkKCF0l9A4CsYFrWQWY/4t+zFg5WZa5N+7i4GOWyC9g0WBclRHlqkGTEIq
         pFWRB3mmGeW61ewDmj2OZrGaNTZZr/KDwtIOd3e4BWPKKNSR2dBX6yxTSMWu3vtALNPj
         2LjXlGpg0zg3dOhfkwupqcYO7MVAUXup8g7QlPSfJwRgF/CtSW87SsZnmTScrg0wKOvz
         IRnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1776117268; x=1776722068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4A5q/u2GjROt5G8izZLI1rLeYlVXEM5J4xMMGpVR/Y=;
        b=G+BzScSmezZCwgxAXlVvCkR7J09PQWUDf3tSe2wqKUQ57jFBCSqhywDio39eek/OQJ
         IwsxUQjpMzGh56oucizOuYr0r38pD0rHted4iNsVTJb8qighGunor8aFhgGdCj5EMpOU
         DNBM54psMw4BOfsltS6+rNChd2s2n+0QJXk2uHE9UEy8zBZQb01S7MOIepSiFlJ0+edV
         BAIFhVN3t9Z54O173DCGSvTAlS/gEmmNfx88QsgljFnng6RDIfIJTsuw1nz9ilRywHKZ
         bsUk7iKpa/Y9YEjsm2Z+VUQUIQL/Q7mpG1Rz08tTo+8zLVhWkIDtOy7nPGd5LaqlI1LY
         izsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776117268; x=1776722068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+4A5q/u2GjROt5G8izZLI1rLeYlVXEM5J4xMMGpVR/Y=;
        b=UsgzDuq84GTFoJNLl8uA46ILIpJ1LRkXA5tR7xZKa2nEnq+MdSZWo/UL90IQeGSB4I
         VOGaXLiqB+By40cIeFNgAwYRsClqmjUBJ5ccr1yZZoXQsg7R5mGUXOVoWVesEFzCOlDD
         10eomzZxC0n7YmCxD1Bd4ZKNGnadQtt5XRXysW4tb7gwO0TBLjv4AhER/d3uUO7SrmSI
         A2duFsF35c2maZT77LrUcY4su3WgvVH1MBv8Z+QJAtvsXu7q3dE6PHGpPouxiR2WQxKt
         W0U66sNRjdYod80SfvWRHZ6YsQtfQMVlxFqXZJfd9D8n4R6jtEu43EGIKjMLM2UcWf2F
         U6Mw==
X-Gm-Message-State: AOJu0Yz5oca3Y/hNuTlsqP+cLzXaoKJwIzao8ZkZ3ImNk0ehqMWAkHHu
	uGGlmZfjDU4CTVbx+TupKQwpbFj+3y7iPePSEfpzN0oE38xfX+QHc//IB5Soul0BxWeWZqDw0M9
	DBHgYCsfDZ6cA9XQxM1VbVPBOyyhIlseAB5MbZMKt
X-Gm-Gg: AeBDietXfzV8Gb4g/Z9IAohJpmKTkxzuuTFWARXgHU6yJSjPke85VmvzcvQeu+lpV+Y
	h1eRsXfs/+Me8sxmtjx+R0sytikZzYKQhAYLSbopyyGGCzgYKzLkG1nkfvKctcjlAJstP5UOKZp
	RTmvpd1SaYsHM+hXiHYN2ov7lfmnaDN02rXYRGASXD0f5b79ZnMYrgwgD9PTN9c9YRiyo/tFzqq
	jSowUg7VPJAqD7WWG5b8Hxk6dSbjBJT9ynVbj27QAILv3v7ZT5OgBhOeLNCHQA23wTUL2Y1RggK
	ft9m89WH
X-Received: by 2002:a17:903:1b46:b0:2b0:4a57:e480 with SMTP id
 d9443c01a7336-2b2d5a831a5mr142902005ad.45.1776117267768; Mon, 13 Apr 2026
 14:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413213409.1674678-1-chenglongtang@google.com>
In-Reply-To: <20260413213409.1674678-1-chenglongtang@google.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 13 Apr 2026 14:54:16 -0700
X-Gm-Features: AQROBzDLg53T6vqwWc5M6A32W_A6ZhlcYCxndHb4hdimSz_IA9ZmCWzfhsRGp4k
Message-ID: <CAPpSM+SbRsFUd9jcP81K1VmhANhT7uzPqOPmy8i0gZ28ctjQKw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Chenglong Tang <chenglongtang@google.com>
Cc: stable@vger.kernel.org, kpberry@google.com, rnj@google.com, 
	joneslee@google.com, Weiming Shi <bestswngs@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-237664-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,mail.gmail.com:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBA033F3A3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chenglong,

I=E2=80=99m not entirely clear on how PATCH 6.12.y works and had a question
regarding this patch.
Could you please clarify the need for the parameter bool all_slaves?
As this feature (was introduced in ce7a381697cb) is not introduced in
v6.12, I was wondering if it might be sufficient to apply my original
patch instead. I=E2=80=99ve also checked against 6.12.81 and didn=E2=80=99t=
 encounter
any conflicts.

Thanks,
Xiang

On Mon, Apr 13, 2026 at 2:35=E2=80=AFPM Chenglong Tang <chenglongtang@googl=
e.com> wrote:
>
> commit 2884bf72fb8f03409e423397319205de48adca16 upstream.
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
> Change-Id: I2349f4953b5760b7f4a12da583aa779c19c4b59c
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [Kevin Berry <kpberry@google.com>: fixed merge conflicts and adapted
> to 6.12 struct]
> Signed-off-by: Chenglong Tang <chenglongtang@google.com>
> ---
>  drivers/net/bonding/bond_main.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 2ac455a9d1bb..fb8d7fec27ee 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5346,23 +5346,33 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_bu=
ff *skb,
>         return bond_tx_drop(dev, skb);
>  }
>
> -/* in broadcast mode, we send everything to all usable interfaces. */
> +/* in broadcast mode, we send everything to all or usable slave interfac=
es.
> + * under rcu_read_lock when this function is called.
> + */
>  static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
> -                                      struct net_device *bond_dev)
> +                                      struct net_device *bond_dev,
> +                                      bool all_slaves)
>  {
>         struct bonding *bond =3D netdev_priv(bond_dev);
> -       struct slave *slave =3D NULL;
> -       struct list_head *iter;
> +       struct bond_up_slave *slaves;
>         bool xmit_suc =3D false;
>         bool skb_used =3D false;
> +       int slaves_count, i;
>
> -       bond_for_each_slave_rcu(bond, slave, iter) {
> +       if (all_slaves)
> +               slaves =3D rcu_dereference(bond->all_slaves);
> +       else
> +               slaves =3D rcu_dereference(bond->usable_slaves);
> +
> +       slaves_count =3D slaves ? READ_ONCE(slaves->count) : 0;
> +       for (i =3D 0; i < slaves_count; i++) {
> +               struct slave *slave =3D slaves->arr[i];
>                 struct sk_buff *skb2;
>
>                 if (!(bond_slave_is_up(slave) && slave->link =3D=3D BOND_=
LINK_UP))
>                         continue;
>
> -               if (bond_is_last_slave(bond, slave)) {
> +               if (i + 1 =3D=3D slaves_count) {
>                         skb2 =3D skb;
>                         skb_used =3D true;
>                 } else {
> @@ -5597,7 +5607,7 @@ static netdev_tx_t __bond_start_xmit(struct sk_buff=
 *skb, struct net_device *dev
>         case BOND_MODE_XOR:
>                 return bond_3ad_xor_xmit(skb, dev);
>         case BOND_MODE_BROADCAST:
> -               return bond_xmit_broadcast(skb, dev);
> +               return bond_xmit_broadcast(skb, dev, true);
>         case BOND_MODE_ALB:
>                 return bond_alb_xmit(skb, dev);
>         case BOND_MODE_TLB:
> --
> 2.54.0.rc0.605.g598a273b03-goog
>

