Return-Path: <stable+bounces-80693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5998F9BA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76484B217CD
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DADE1CC14F;
	Thu,  3 Oct 2024 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XEHY3a6R"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1D1BFDFF;
	Thu,  3 Oct 2024 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993788; cv=none; b=on5bZkgmSSengzlHTbhIBq+qfGRqWsDrNGV7xX6x8sc+j9NS0RNCFQNA8MyJZpAhKsKRCO1maAvgb3zxo01c39d7lNhD/4pexrcRH/ubyj85VDxxBe6bIal1kM0EOOErMZ5LVvjTCUFBQltzeMFQVzUfe+A+Bcefdot40PLUSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993788; c=relaxed/simple;
	bh=J/rkdBOnFENzr/Ao83muSATxMMgLCURc4fzHWx3WNr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iq5YUneVDeQywC6bdF0YhI5eMeQR3nUn8bFdf9qAAbsj4kKPtCLnNtSX87BfbyPwXlXn6UJy7CS73CcY1/p82jGhEtVHA3tW3VwlzkrRjyz+FiRwdrLxvQ2oV+y4vBMkA7Kd2YfFG1kJWUMK8git7Bp9StPiNtcg+SiXXguMTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XEHY3a6R; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727993786; x=1759529786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7S5TLf0uNeKxKynG+d6zNMxgJ7TApjOSq9+bG8QoKE=;
  b=XEHY3a6R9mI+m9uNFF3osvfJmCpl8HmZddVK9Fe2uDPWeUmSmsXvIGaY
   OZESwTUuG36/7JLvGrwRQEEFF0a5Q+Mpn4LnRjqFA7UmSRbptmBq0Ab7s
   fBRIgeZQQv2DHHoDdFCsLtUjhuKjBjO0GpP6CQiF6vXKQB405E46KOhTk
   E=;
X-IronPort-AV: E=Sophos;i="6.11,175,1725321600"; 
   d="scan'208";a="663541638"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 22:16:22 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:54321]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.239:2525] with esmtp (Farcaster)
 id 2b21fd1b-19d3-4b7c-a31b-14397a46a683; Thu, 3 Oct 2024 22:16:21 +0000 (UTC)
X-Farcaster-Flow-ID: 2b21fd1b-19d3-4b7c-a31b-14397a46a683
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 3 Oct 2024 22:16:21 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 3 Oct 2024 22:16:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <a.kovaleva@yadro.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <johannes@sipsolutions.net>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux@yadro.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <stable@vger.kernel.org>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH v3 net] net: Fix an unsafe loop on the list
Date: Thu, 3 Oct 2024 15:16:07 -0700
Message-ID: <20241003221607.13408-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241003104431.12391-1-a.kovaleva@yadro.com>
References: <20241003104431.12391-1-a.kovaleva@yadro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Anastasia Kovaleva <a.kovaleva@yadro.com>
Date: Thu, 3 Oct 2024 13:44:31 +0300
> The kernel may crash when deleting a genetlink family if there are still
> listeners for that family:
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
>   ...
>   NIP [c000000000c080bc] netlink_update_socket_mc+0x3c/0xc0
>   LR [c000000000c0f764] __netlink_clear_multicast_users+0x74/0xc0
>   Call Trace:
> __netlink_clear_multicast_users+0x74/0xc0
> genl_unregister_family+0xd4/0x2d0
> 
> Change the unsafe loop on the list to a safe one, because inside the
> loop there is an element removal from this list.
> 
> Fixes: b8273570f802 ("genetlink: fix netns vs. netlink table locking (2)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
> Reviewed-by: Dmitry Bogdanov <d.bogdanov@yadro.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
> v3: remove trailing "\", change spaces to tab
> v2: add CC tag for stable
> ---
>  include/net/sock.h       | 2 ++
>  net/netlink/af_netlink.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index c58ca8dd561b..db29c39e19a7 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -894,6 +894,8 @@ static inline void sk_add_bind_node(struct sock *sk,
>  	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
>  #define sk_for_each_bound(__sk, list) \
>  	hlist_for_each_entry(__sk, list, sk_bind_node)
> +#define sk_for_each_bound_safe(__sk, tmp, list) \
> +	hlist_for_each_entry_safe(__sk, tmp, list, sk_bind_node)
>  
>  /**
>   * sk_for_each_entry_offset_rcu - iterate over a list at a given struct offset
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 0b7a89db3ab7..0a9287fadb47 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2136,8 +2136,9 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
>  {
>  	struct sock *sk;
>  	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
> +	struct hlist_node *tmp;
>  
> -	sk_for_each_bound(sk, &tbl->mc_list)
> +	sk_for_each_bound_safe(sk, tmp, &tbl->mc_list)
>  		netlink_update_socket_mc(nlk_sk(sk), group, 0);
>  }
>  
> -- 
> 2.40.1

