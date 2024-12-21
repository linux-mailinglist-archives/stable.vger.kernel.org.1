Return-Path: <stable+bounces-105525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2A99F9F4A
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4084A188BE43
	for <lists+stable@lfdr.de>; Sat, 21 Dec 2024 08:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AAA1EC4F1;
	Sat, 21 Dec 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S+tp3DpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319ED1DF269;
	Sat, 21 Dec 2024 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734769061; cv=none; b=CPiRfDAR6P/nJtTbQNQSbaLD46xVSBjjjqS/B1nDDCRQ5dXrI9V/vQoOB5uiQbeC14BTcTolYeCpwxR1y1T3li1a10RHYTtT1zwwrRdzCXMASuZCOZ2Non+mPHU4dLlJGSm5yRnR1Z4hQjjXy8ga5NoXp0wfcDHZ6/1X/lnjxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734769061; c=relaxed/simple;
	bh=ZfCo1bskYbhtwN12RIG2EQFQ0aAZfTnGZ5Ya543AloQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlDpSAdrMvlbzvqBCbNr3zM90OJg0ALu+4Y+EkuxbNWb89URAHlAd/eHAObAgOzMPI+U8bryI8/fCGi+zTKMCh7bejgXssv+2LVK4yLDPkzhcElLCpoIU4QLQ0gKH6v6HBc/WxSfhnIZC3kDxOkab31kPeK7E5uMzxu1IRzdVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S+tp3DpF; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734769060; x=1766305060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B3pUGK886agq7GOCKwKEUH1qlETW5QxolobcuW4Z5mk=;
  b=S+tp3DpFOOthWqJC3VEQnzqdM3Ok4zwrcP49nDwSD9BdhTfwpvnnpY2d
   oXyIzaMjOFCgjYiq91LrZPUs0q6W49ubd9qzhjaQBc2yLZww4v9p2/VRD
   +as1qvE35K3dham50ZtgH0E6M/o4PIx8hdWKRhGD4AtgaZWPbsCpxLKfL
   U=;
X-IronPort-AV: E=Sophos;i="6.12,253,1728950400"; 
   d="scan'208";a="157705105"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 08:17:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:21727]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.219:2525] with esmtp (Farcaster)
 id d0764f2f-112f-4a2f-b34d-80eccdab9453; Sat, 21 Dec 2024 08:17:38 +0000 (UTC)
X-Farcaster-Flow-ID: d0764f2f-112f-4a2f-b34d-80eccdab9453
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 21 Dec 2024 08:17:38 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.154) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 21 Dec 2024 08:17:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pchelkin@ispras.ru>
CC: <edumazet@google.com>, <ignat@cloudflare.com>, <johan.hedberg@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luiz.dentz@gmail.com>,
	<lvc-project@linuxtesting.org>, <marcel@holtmann.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
Date: Sat, 21 Dec 2024 17:17:18 +0900
Message-ID: <20241221081718.98353-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241217211959.279881-1-pchelkin@ispras.ru>
References: <20241217211959.279881-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Fedor Pchelkin <pchelkin@ispras.ru>
Date: Wed, 18 Dec 2024 00:19:59 +0300
> A NULL sock pointer is passed into l2cap_sock_alloc() when it is called
> from l2cap_sock_new_connection_cb() and the error handling paths should
> also be aware of it.
> 
> Seemingly a more elegant solution would be to swap bt_sock_alloc() and
> l2cap_chan_create() calls since they are not interdependent to that moment
> but then l2cap_chan_create() adds the soon to be deallocated and still
> dummy-initialized channel to the global list accessible by many L2CAP
> paths. The channel would be removed from the list in short period of time
> but be a bit more straight-forward here and just check for NULL instead of
> changing the order of function calls.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE static
> analysis tool.
> 
> Fixes: 7c4f78cdb8e7 ("Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/bluetooth/l2cap_sock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 3d2553dcdb1b..49f97d4138ea 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1888,7 +1888,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
>  	chan = l2cap_chan_create();
>  	if (!chan) {
>  		sk_free(sk);
> -		sock->sk = NULL;
> +		if (sock)
> +			sock->sk = NULL;
>  		return NULL;
>  	}
>  
> -- 
> 2.39.5

