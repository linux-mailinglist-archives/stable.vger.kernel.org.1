Return-Path: <stable+bounces-241436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFhjFGLC72mLFQEAu9opvQ
	(envelope-from <stable+bounces-241436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:09:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E240F479B6A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 22:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD67330523D5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF632E974D;
	Mon, 27 Apr 2026 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="srHKdepd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C742D3733
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320470; cv=pass; b=QOIcQW6KX3yD1ZHHP/JG9jiWlYOIM7PxxoRskw/Yk38H5DID7CGnUaFkmTnGQphd78G3l8CGxyKTQdikZcusB93Dkn9CBplELirxfUrfPSGz5fSA75hgeYWwnBFA/33oYu4pvv1kU6ZAj9v2jScW9eIq50TAO+qaA8EDwfyWJt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320470; c=relaxed/simple;
	bh=NrO5SSSV3z7xxVtDNapD85+jYDNEUcw8U1gMPtN48Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBvuoJ9ig3AFfL7z8qLBM9PubvXW93NDQhB0OVU2HiJYQll1zFaNmh1av+ySi4TLk47hma1kMrisgorAaHXho7kfcZQmTPbSvu8tpAzXjfXLA1Bv1hjdNoh7LKOj6S6U8GlEnmiqauQQljI91mc5ViZaz7azBvw0ji+NNOYZxBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=srHKdepd; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-356337f058aso6692218a91.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777320469; cv=none;
        d=google.com; s=arc-20240605;
        b=LnqfzcFsEFWvtCOj1qe2TnQI5O5PlR3kno3oMh12Tzw9YCwmTXzTczDyKMVNEYD1op
         7MwzfXxMsp4kG1G4RB3mh98UWmFYXCP0xNehGz27wOxXb6Wa0C2XmuXJNrRcxUJ4wECF
         4gg8InY79GGRKU9buPOBnBxwKYC1n31L3uzV+xrFfqQn7ySZ7FmqVQDxn3iFCmGnuWBS
         R3kHyuq1N0GJJK5x76v/Rhosp4W2c2Aj2GF/ilyhmsDTVBILlmc9rvKgc9QnfyGHB80S
         OFpadlqvyXdP7bWSRFy3mgQBxbl4jym/SzD7YNF3Uf0S60+0behi1BTDPbHshHebClNt
         UaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y9Z5uSrkulVOs/Fdzpbp0C16pW9teDfKsfKcObvrzJg=;
        fh=oymPqypl1LVYTWKW9wzLJbNIw/Tfff+80dsJolKYW6Q=;
        b=lLVlQEij7fGobKlDXXJNJOB3rU31bHST09NIjq5267+FIWatbOicE8kd5LCg0+s84x
         Hol64gwStRDeN+F0JO9Hh8OhUbdCtjKOj4JU3370LUImEIr4A8Yk4p0mrmHJ35xXKb5E
         uGDCSGVWz4/icOD4f5bsaxuziVmC3W0YqrBvoKuQ+hChckL0tVdSJzzCYGNl88ihRZM0
         e4OZRkaj+i5LxmNeOJB6XdwmZ4DaVybn7fvEBrjhnXrQ3qwGUzVSph9gXJoluV6NjUEH
         5Nsc5d0s13Cc6JEpx/1W25H4ImSXuaJVMkwEpDixSbu2oeVEhjHq1O/Q6uGbpoql0J1Y
         SynA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1777320469; x=1777925269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Z5uSrkulVOs/Fdzpbp0C16pW9teDfKsfKcObvrzJg=;
        b=srHKdepdioznMxsDGnZvqDpdl+xZn42/bWgdji5W6m9/c03IGAS+XhmbE4FN6plzmy
         BnyEwQtldjhZ5FQ3KuSojso7GYOBZcif9ESV3HE0aM43ev+m31DGndRBrOWZfp3IHZot
         6MqMCPX6/TgYAuf1jc6Z+9LZuC1MvBss282Os1ohRPX/Sts8Fi2udLg8vN+98s3NLyDM
         qrnUrkfWa7qvR2Z1R75DWxDUc1cyB7qupbWx+9BmIGtrW/aGkCi6xRf+1W74Bz4bNz5x
         CH1ik3HjY9qImjnpIPlzdzbCQbwNu3VcGCtY+ev6GC4A6vVYKZAQZ8A6CpWC6jWhQkST
         07uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320469; x=1777925269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9Z5uSrkulVOs/Fdzpbp0C16pW9teDfKsfKcObvrzJg=;
        b=INhvM7XH65aWOVBgiVZpkuYRSttEuZYNkqmgGS5aZsGoLesx/Z7NUfPBRsGv1ky09d
         bTBMuLZiFd6DX4SLWJMLxzxS1kBcoiNZYFN5IGKApfTogGRfUtkup/eGkRX9O+dghwkE
         aOwxasbpPfvPOjD2YZD+gPdXB0tFqjC1h6iy+/w4nkDqSKg4TjjOtVi2jXzbQI3Y830c
         nw9uLIxUqJkfwB3XYSkOxod7LZebEe3Mj1TEg5aM+t/tqndboyKqJuSBTbYi6oltCKBG
         bRPyow00JuoMw1+VVr+ZxctpZSI2si6elxwoaCW7OxtUUZ3sqf1AiRVIkydRMxwJtErW
         eHhA==
X-Forwarded-Encrypted: i=1; AFNElJ8KRza85HmpBTaZL/quWotgqLhuKaOTGaE2s5PhdnwhKQCbHAzpP1WasXBxTDdiL4RjwB1JmtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydg86JJoL5b4tIOlDofdeMWuFe7/gFh9+M0CBfHmDsqwdSeSYG
	3DJzWaC/IA/irHN8FSqCu3UpT8N0rLA+Se6UClJO5q1s10h6yN3ypNPO3KRtfUNNefO/5Z09pjC
	tZDbAzK8DEV8MYDOFa+wsB8ADnyYevkK0oQzz82Hy
X-Gm-Gg: AeBDietv8oulVZDfmXGgN3dR5VZifOSJnok3FtfyzZmy3JvlhM3Re7HRbjJstqI++iC
	VSThZwzJIyocBWEBhnxjg8dnGil3YxKAdcy5ZwsVZardaS7uqSueRRmrtr6k9dGJx0KtITnAfXx
	+Wz6507TxUFMQM6SxSAlZomdA7mLZBRns0yv8SyOD9FvVB2jC2iN0LiW40+VTtrD4PA38MwRBqt
	82crVctAi44GArOIU4b2Uitnuh/+z1e2DB3Wph7+S/iFu//RM6uMbwc6bCPJjUmoVrtAD2q8pif
	sE+En5uD1NX11J/bWS4=
X-Received: by 2002:a17:90b:2885:b0:35f:b647:d98a with SMTP id
 98e67ed59e1d1-36491fa7a71mr89273a91.5.1777320468603; Mon, 27 Apr 2026
 13:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+SbRsFUd9jcP81K1VmhANhT7uzPqOPmy8i0gZ28ctjQKw@mail.gmail.com>
 <20260427184208.161981-1-kpberry@google.com> <20260427184208.161981-2-kpberry@google.com>
In-Reply-To: <20260427184208.161981-2-kpberry@google.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 27 Apr 2026 13:07:37 -0700
X-Gm-Features: AVHnY4JDNMwwdZjuOJWgoBA8jNJTSSmK2lL-r6vGLuG6kHPonoz5MfQMBTBvPuA
Message-ID: <CAPpSM+QVaLKspnh+fdLC8wtxqqMHbu+E81A-NzpbqVvN=vp1Xg@mail.gmail.com>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Kevin Berry <kpberry@google.com>
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E240F479B6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:dkim,asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241436-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[asu.edu:+];
	NEURAL_SPAM(0.00)[0.690];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email]

Hi Kevin,

Thanks for the explanation. I now understand that we are backporting
the patch to 6.12 (I didn't realize it couldn't be backported).

I have one concern about your patch. On 6.12, bond->all_slaves is only
set by bond_update_slave_arr(), which is gated by
bond_mode_can_use_xmit_hash() (i.e., 802.3ad, XOR, TLB, ALB). This
does not include BOND_MODE_BROADCAST, and nothing else initializes it.
As a result, in bond_xmit_broadcast() on 6.12,
rcu_dereference(bond->all_slaves) is NULL, slaves_count is 0, the loop
never executes, the skb is freed, and NET_XMIT_DROP is returned, so it
drops every packet.

This works in mainline because the array-based iteration was
introduced alongside additional changes that ensure all_slaves is
valid in broadcast mode. Those supporting changes are not present in
6.12.

To resolve this, we can either backport the prerequisite series or
apply a smaller, self-contained fix like the one below:
```
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5326,14 +5326,21 @@ static netdev_tx_t bond_xmit_broadcast(struct
sk_buff *skb,
  struct list_head *iter;
  bool xmit_suc =3D false;
  bool skb_used =3D false;
+ int slaves_count, i =3D 0;

+ slaves_count =3D READ_ONCE(bond->slave_cnt);
  bond_for_each_slave_rcu(bond, slave, iter) {
  struct sk_buff *skb2;
+ bool is_last;
+
+ if (++i > slaves_count)
+ break;
+ is_last =3D (i =3D=3D slaves_count);

  if (!(bond_slave_is_up(slave) && slave->link =3D=3D BOND_LINK_UP))
  continue;

- if (bond_is_last_slave(bond, slave)) {
+ if (is_last) {
  skb2 =3D skb;
  skb_used =3D true;
  } else {
```

Please let me know your thoughts.

Thanks,
Xiang

On Mon, Apr 27, 2026 at 11:42=E2=80=AFAM Kevin Berry <kpberry@google.com> w=
rote:
>
> From: Xiang Mei <xmei5@asu.edu>
>
> [ Upstream commit 2884bf72fb8f03409e423397319205de48adca16 ]
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
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Kevin Berry <kpberry@google.com>
> ---
>  drivers/net/bonding/bond_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 5035cfa74f1a..20043f1094df 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5322,18 +5322,22 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_=
buff *skb,
>                                        struct net_device *bond_dev)
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
> +       slaves =3D rcu_dereference(bond->all_slaves);
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
>
> base-commit: eefc95626b5cb02ea6268d1ae58237768004a60d
> --
> 2.54.0.545.g6539524ca2-goog
>

