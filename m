Return-Path: <stable+bounces-263407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lNwOG1YtMGoRPgUAu9opvQ
	(envelope-from <stable+bounces-263407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:50:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C06968889E
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:50:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="PLydyh/4";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263407-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263407-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D5FA3011376
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B94183B7;
	Mon, 15 Jun 2026 16:49:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCE41167A;
	Mon, 15 Jun 2026 16:49:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542156; cv=none; b=KLkIdQOoPXkL6mmCbUleMaXx1VnZGbmXKOV8LGs3Mn5FoEPYsqtyLUkc7N5a8pxKh9nKvzZB16BbfRsfE3HHi+F/C8H4OB7V5+V7KkgFSvUf8xjde782Cx2Ua3b1qIWK4zuzz4XDpkOy7EUc42Yf4ZsVRGWiUzPYDDneySjNTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542156; c=relaxed/simple;
	bh=edfUnc6xtOg8nreVx1l9GgQ7LRTcijUWggT9VmGlqD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP66svqIHF3uKarCyBz0QWRMqgfobPjLkAmVu+bPcZeG8BSOGQ8kmMOEidfUSjmpQehCj4fLGl2z05iRtz2yPw0rH52jVHSTWWLIFYTA/TgjwgxXq/7kkwsrX6sCIEyHARG/eVhdYfRfHTQm2pl56jW8rOYBM4RbIwVZ+Ukn2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLydyh/4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F471F00A3A;
	Mon, 15 Jun 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542155;
	bh=9KMHFkvWVjJq8wV6DOPhDqXx0riaGku/JWu2rovsXjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PLydyh/4ZZqAIT+BGQeJHTT3byFU9h9KaswEQyUWLRMCm8aUEZzsGYCz1nEV+QP1c
	 OoNSNfVAh4tOludtFQuvxJVcUgBB8zA1JTUpgbsLkt9xjeLV91qpDXQS/3c1Bzzqdq
	 /d1IBcdO4pRpbM6bpWQY6eTzUIRKZRdvBmwmAXj1kUJqOklS/wheOk3ZIAAE6SrwDL
	 UzF80dFL2WwvhBsb0VcHMeyULSCQ9356PgLZT/YE3ngYPg344T5mMzaWbHlaV8fbAk
	 H6Dh9BE2K9k3zWPzKQgjip8Q33jJGgyYbgmOiZ85W6D5qvSNh4yJn/cYKOBNOQAp9B
	 JmT08kiAt0V7Q==
From: Simon Horman <horms@kernel.org>
To: zhaoyz24@mails.tsinghua.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	veritas501@foxmail.com,
	linux-kernel@vger.kernel.org,
	yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn,
	fengxw06@126.com,
	qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH net] appletalk: Hold socket reference in atalk_rcv()
Date: Mon, 15 Jun 2026 17:48:58 +0100
Message-ID: <20260615164858.783714-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
References: <20260614095226.1210-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263407-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:horms@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kees@kernel.org,m:veritas501@foxmail.com,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,foxmail.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C06968889E

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
appletalk: Hold socket reference in atalk_rcv()

This commit addresses a use-after-free race by holding a reference to the
socket found by atalk_search_socket() until after the packet is queued in
atalk_rcv().

> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index 30a6dc06291c3..61ec5c569dc3c 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c

[ ... ]

> @@ -1474,9 +1476,12 @@ static int atalk_rcv(struct sk_buff *skb, struct net_device *dev,
>  		goto drop;
>  
>  	/* Queue packet (standard) */
> -	if (sock_queue_rcv_skb(sock, skb) < 0)
> +	if (sock_queue_rcv_skb(sock, skb) < 0) {
> +		sock_put(sock);
>  		goto drop;
> +	}

[Severity: High]
Does this code introduce a memory leak or an infinite timer loop?

By holding a socket reference in atalk_rcv(), the socket memory is kept alive,
but atalk_rcv() does not hold the socket lock. A concurrent atalk_release()
could lock the socket, mark it SOCK_DEAD, and call atalk_destroy_socket(),
which logically purges the receive queue:

net/appletalk/ddp.c:atalk_destroy_socket() {
    ...
    skb_queue_purge(&sk->sk_receive_queue);
    ...
}

After this purge, atalk_rcv() might call sock_queue_rcv_skb(). The core
function __sock_queue_rcv_skb() does not reject packets for SOCK_DEAD sockets.
It will successfully enqueue the skb and increment sk->sk_rmem_alloc.

Since AppleTalk uses the empty sock_def_destruct() instead of a custom
sk_destruct callback, is the receive queue ever purged upon final sk_free(),
or does this permanently leak the skb?

Furthermore, if atalk_destroy_socket() finds other pending allocations and
arms the destruction timer, will the timer endlessly re-arm itself?

net/appletalk/ddp.c:atalk_destroy_timer() {
    ...
    if (sk_has_allocations(sk)) {
        sk->sk_timer.expires = jiffies + SOCK_DESTROY_TIME;
        add_timer(&sk->sk_timer);
    }
    ...
}

The timer checks sk_has_allocations(sk), which will remain true indefinitely
due to the uncleared sk_rmem_alloc from the leaked skb.

>  
> +	sock_put(sock);
>  	return NET_RX_SUCCESS;

