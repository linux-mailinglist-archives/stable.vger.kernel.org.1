Return-Path: <stable+bounces-100308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAE99EAA6B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EF316533C
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD3822F3AE;
	Tue, 10 Dec 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Dm62ua+2"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95D221DB9;
	Tue, 10 Dec 2024 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818659; cv=none; b=MjzD4kB2r+ypdG6fboagPidd3n6ukLu4yzjMva/TGc60/hOwkiH4/z0je3yhLrkU11OVuJ07/A9A8MZStBhlNrSmapIUhDQHBqOwEoP5LFZL6r+NtFR2SPvMTyfG9gjknrSU6muOU3apcYbiGDZVrJPZFVZX+bbHmEZdmYusHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818659; c=relaxed/simple;
	bh=G+NhmUEtVI87NVZZ2QM51ZkZCn/PR5HBsg8fSYVN1PE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKBv1Zt8S2h5NpfOsM23nsJrUK/eTz935Q0USx7JuUh3hjymW1inatFF6OL8rGTmmfCMH3thUCvQPTClpWL8h4sL8FFQZKjpOjLyN9m4JFq7+vR5vs6R6WCpzKVH5IyAFaTHeH4ShY7ouIEjzK71Yvjo42CXhYf2FAvhXafKjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Dm62ua+2; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733818657; x=1765354657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=omllbvkEJ50T7Yk5NDW1o33t4otvLM5puMTYc11F07w=;
  b=Dm62ua+2rkVFbIQZCTfOcCSH37YCEuOQrMrYUIgoJNMAvZp8RjqHBEc/
   MSjgh0QBMk2LQ/OG5fcagHn+7YxDuJPGqjU9q9FiXPN0ZLWc8WJ+UZXAR
   TEpiQMwxltYBNUV9iyF433XClgWOflZSnvWrYW6rxFgRY2NieV9ANXtWW
   g=;
X-IronPort-AV: E=Sophos;i="6.12,221,1728950400"; 
   d="scan'208";a="359416197"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 08:17:35 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:28081]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.98:2525] with esmtp (Farcaster)
 id 81da2a32-e1e6-4daa-a015-eb68e9e457da; Tue, 10 Dec 2024 08:17:35 +0000 (UTC)
X-Farcaster-Flow-ID: 81da2a32-e1e6-4daa-a015-eb68e9e457da
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 10 Dec 2024 08:17:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.88.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 10 Dec 2024 08:17:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <deweerdt.lkml@gmail.com>
CC: <David.Laight@ACULAB.COM>, <davem@davemloft.net>, <dhowells@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <jdamato@fastly.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<mhal@rbox.co>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<stable@vger.kernel.org>, <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
Date: Tue, 10 Dec 2024 17:17:21 +0900
Message-ID: <20241210081721.66479-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <Z1fMaHkRf8cfubuE@xiberoa>
References: <Z1fMaHkRf8cfubuE@xiberoa>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Date: Mon, 9 Dec 2024 21:06:48 -0800
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, for example when using sendfile over unix sockets.
> 
> Using the test code in [1] in my test setup (2G single core qemu),
> the client receives a 1000M file in:
> - without the patch: 1482ms (+/- 36ms)
> - with the patch: 652.5ms (+/- 22.9ms)
> 
> This commit addresses the issue by marking checksumming as unnecessary in
> `unix_stream_sendmsg`
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederik Deweerdt <deweerdt.lkml@gmail.com>
> Fixes: 2e910b95329c ("net: Add a function to splice pages into an skbuff for MSG_SPLICE_PAGES")
> ---

For the future submission, it would be nice to explain changes
between versions and add the old patch link under '---' here.

The patch itself looks good to me.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


>  net/unix/af_unix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 001ccc55ef0f..6b1762300443 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2313,6 +2313,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  		fds_sent = true;
>  
>  		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
>  			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
>  						   sk->sk_allocation);
>  			if (err < 0) {
> -- 
> 2.44.1

