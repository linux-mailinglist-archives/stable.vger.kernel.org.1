Return-Path: <stable+bounces-249901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNW0MgGlDWqh0wUAu9opvQ
	(envelope-from <stable+bounces-249901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:11:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B751558D613
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C22AE30C0B87
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF73E0C46;
	Wed, 20 May 2026 12:03:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B133DFC81;
	Wed, 20 May 2026 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278613; cv=none; b=OfLTUmJHi4GjvnUwmb0cFgkTn9XnKXjQV8ML8Siuf5N6X7D7dPxqpYAMZdKBPuIzvE9A20lKoCJxShoc5dcxbQxMG5D8k2OUKevKphjtiRlmaDa9audZh040yCeACAsBrJR1qpzSn9Z0+hao1eXgOiD8oCIfvGi5TOb4bBjg8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278613; c=relaxed/simple;
	bh=GCzSfJkkUYiRuQC4PVO+LOVhzE7ba9iIZBYzDzMUzY4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sJN/bu+4EEuv8lfeOKXeK0+QWp9sjt5hzwoqGlyEbWGRMJr7EgI5XZRcP/d6t6ss/R9keZQXr/iXbs/v06LyEFBzVQEy0qO6glDt5Gvm4iONmWUuBEelBbUetq0C3I91K5Hj9wxbS4k2a1NTk7sURlFCPWkeihe2SWv4fii7iRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from ursule.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id BE5FAC0140;
	Wed, 20 May 2026 14:53:31 +0300 (EEST)
Received: from ehlo.thunderbird.net ([2001:14bb:cd:39b0::67a5:201])
	by ursule.remlab.net with ESMTPSA
	id VY98G7ugDWrBEgIAwZXkwQ
	(envelope-from <remi@remlab.net>); Wed, 20 May 2026 14:53:31 +0300
Date: Wed, 20 May 2026 14:53:31 +0300
From: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To: Zijing Yin <yzjaurora@gmail.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net=5D_phonet/pep=3A_disable_?=
 =?US-ASCII?Q?BH_around_forwarded_sk=5Freceive=5Fskb=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260519172635.86304-1-yzjaurora@gmail.com>
References: <20260519172635.86304-1-yzjaurora@gmail.com>
Message-ID: <4172DA29-330F-42FE-91FE-C247D67F852A@remlab.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.26 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249901-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[remlab.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[remi@remlab.net,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,remlab.net:mid,remlab.net:email]
X-Rspamd-Queue-Id: B751558D613
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 19 mai 2026 20:26:33 GMT+03:00, Zijing Yin <yzjaurora@gmail=2Ecom> a =
=C3=A9crit=C2=A0:
>The networking receive path is usually run from softirq context, but
>protocols that take the socket lock may have packets stored in the
>backlog and processed later from process context=2E In that case
>release_sock() -> __release_sock() drops the slock with spin_unlock_bh()
>and then calls sk->sk_backlog_rcv() with bottom halves enabled=2E
>
>Typical sk_backlog_rcv handlers process the socket whose backlog is
>being drained, so the BH state at entry is irrelevant for the slocks
>they touch=2E pep_do_rcv() is different: when the inbound skb targets an
>existing PEP pipe, it forwards the skb to a different *child* socket
>via sk_receive_skb()=2E That helper takes the child slock with
>bh_lock_sock_nested(), which is just spin_lock_nested() and assumes BH
>is already off=2E The same child slock therefore ends up acquired with
>BH on (process path) and with BH off (softirq path):
>
>  process context                   softirq context
>  ---------------                   ---------------
>  release_sock(listener)            __netif_receive_skb()
>   __release_sock()                  phonet_rcv()
>    spin_unlock_bh()                  __sk_receive_skb(listener)
>    [BH now ENABLED]                  [BH already disabled]
>    sk_backlog_rcv:                   sk_backlog_rcv:
>     pep_do_rcv()                      pep_do_rcv()
>      sk_receive_skb(child)             sk_receive_skb(child)
>       bh_lock_sock_nested(child)        bh_lock_sock_nested(child)
>       =3D> SOFTIRQ-ON-W                   =3D> IN-SOFTIRQ-W
>
>Lockdep flags this as inconsistent lock state, and it can become a real
>self-deadlock if a softirq on the same CPU tries to receive to the same
>child socket while its slock is held in the BH-enabled path:
>
>  WARNING: inconsistent lock state
>  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage=2E
>   (slock-AF_PHONET/1){+=2E?=2E}-{3:3}, at: __sk_receive_skb+0x1cf/0x900
>    __sk_receive_skb              net/core/sock=2Ec:563
>    sk_receive_skb                include/net/sock=2Eh:2022 [inline]
>    pep_do_rcv                    net/phonet/pep=2Ec:675
>    sk_backlog_rcv                include/net/sock=2Eh:1190
>    __release_sock                net/core/sock=2Ec:3216
>    release_sock                  net/core/sock=2Ec:3815
>    pep_sock_accept               net/phonet/pep=2Ec:879
>
>Wrap the forwarded sk_receive_skb() in local_bh_disable() /
>local_bh_enable() so the child slock is always acquired with BH off=2E
>local_bh_disable() nests safely on the softirq path=2E
>
>Discovered via in-house syzkaller fuzzing; the same root cause also
>on the linux-6=2E1=2Ey syzbot dashboard as extid 44f0626dd6284f02663c=2E
>Reproduced under KASAN + LOCKDEP + PROVE_LOCKING, reproducer:
>https://pastebin=2Ecom/A3t8xzCR
>
>Fixes: 9641458d3ec4 ("Phonet: Pipe End Point for Phonet Pipes protocol")
>Link: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D44f0626dd6284f02663c
>Cc: stable@vger=2Ekernel=2Eorg
>Signed-off-by: Zijing Yin <yzjaurora@gmail=2Ecom>

Acked-by: R=C3=A9mi Denis-Courmont <remi@remlab=2Enet>

