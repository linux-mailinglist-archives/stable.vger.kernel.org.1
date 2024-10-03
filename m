Return-Path: <stable+bounces-80690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4398F936
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE21C21983
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 21:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFFE1BF81B;
	Thu,  3 Oct 2024 21:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dZZWbDak"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056F6F06A;
	Thu,  3 Oct 2024 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992259; cv=none; b=WxgZbRI8eolK999ZZ2X53pZGncrCdsSr3UJVGUYU+1T3UivknBpNHTCVKq5Tmt+OMI5O497nV4gwwHnBEC142pykIcKg+MF62oRxhtzC0zJnkGPa0HXweowHor8TVUNI3iPxoTOeQSOupUDl2Ook4NH8+IH5Q0PtX9MIoD7GVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992259; c=relaxed/simple;
	bh=xDvuuU0Ny5bptRzf1f6XMRSEy3QqAXdPpCjIwoLn+yQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxCHHWEeoIek1CKkptv73ReFxO4GY5Q2XlryKaGo3PyhMhNeMvmMBNcX/D22SR0u15rB8fgWTHrMgmIWeAnrWaIYhAGBXR5/EKngi+RznBbOiLE5AyJVaDqYMjegFskJT4fL8V1Ab0nmAYjzeyZiny4bsdfw3cvQsh48E5CcdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dZZWbDak; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727992256; x=1759528256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6rpJeqVSzaRKWSkf7f1FmSyfDmQ9YVfHM+Tdpkcb4O4=;
  b=dZZWbDakDgEL59R7siHPjCQ7Mf5YgV8x/z67xWS2Ko49nawNxBNrIIVk
   WqDx9fV8GtxkYvtJJhmUmbuytyYWRJOGJNW3vg8iEYKg8rl/SuqH6pvBB
   ZHJ3xsGO90nnyd6o36hT12bDL5Y3jcFIZLH0rZE/+VQrkHU97JTbB0n47
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,175,1725321600"; 
   d="scan'208";a="438116422"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 21:50:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:22494]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id d6bf4c58-0a1d-4336-a2a1-3bd93f1d09d4; Thu, 3 Oct 2024 21:50:49 +0000 (UTC)
X-Farcaster-Flow-ID: d6bf4c58-0a1d-4336-a2a1-3bd93f1d09d4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 3 Oct 2024 21:50:49 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 3 Oct 2024 21:50:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ignat@cloudflare.com>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kernel-team@cloudflare.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
Date: Thu, 3 Oct 2024 14:50:38 -0700
Message-ID: <20241003215038.11611-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241003170151.69445-1-ignat@cloudflare.com>
References: <20241003170151.69445-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu,  3 Oct 2024 18:01:51 +0100
> We have recently noticed the exact same KASAN splat as in commit
> 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
> creation fails"). The problem is that commit did not fully address the
> problem, as some pf->create implementations do not use sk_common_release
> in their error paths.
> 
> For example, we can use the same reproducer as in the above commit, but
> changing ping to arping. arping uses AF_PACKET socket and if packet_create
> fails, it will just sk_free the allocated sk object.
> 
> While we could chase all the pf->create implementations and make sure they
> NULL the freed sk object on error from the socket, we can't guarantee
> future protocols will not make the same mistake.
> 
> So it is easier to just explicitly NULL the sk pointer upon return from
> pf->create in __sock_create. We do know that pf->create always releases the
> allocated sk object on error, so if the pointer is not NULL, it is
> definitely dangling.

Sounds good to me.

Let's remove the change by 6cd4a78d962b that should be unnecessary
with this patch.


> 
> Fixes: 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket creation fails")
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Cc: stable@vger.kernel.org
> ---
>  net/socket.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 7b046dd3e9a7..19afac3c2de9 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1575,8 +1575,13 @@ int __sock_create(struct net *net, int family, int type, int protocol,
>  	rcu_read_unlock();
>  
>  	err = pf->create(net, sock, protocol, kern);
> -	if (err < 0)
> +	if (err < 0) {
> +		/* ->create should release the allocated sock->sk object on error
> +		 * but it may leave the dangling pointer
> +		 */
> +		sock->sk = NULL;
>  		goto out_module_put;
> +	}
>  
>  	/*
>  	 * Now to bump the refcnt of the [loadable] module that owns this
> -- 
> 2.39.5
> 

