Return-Path: <stable+bounces-127955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B5A7AD96
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2ECE1896A21
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9AC28EA51;
	Thu,  3 Apr 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WwDPGAVS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527C28EA50;
	Thu,  3 Apr 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707516; cv=none; b=YBmag2dOkGBCDKEvWqKt9rvVmd0fJVRQkChHDFKo0B/NXYVbiqil7va5obx+LS5G6NocIrDEFVGv+Bmr+Ui/xxgS4nKfplo80yHObFDvxDmjTKggadnRaNbaYc4lFfeebZqFmvN4Und0xU27o8/U4eTjiDDeRLkRYQvNhfCGt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707516; c=relaxed/simple;
	bh=SUF+FEvZ0V/1XiQErPBCBUZApPbnbBjViybnTHmlfjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiXZN3yQ1Biu/+G4zyewhOuWTSa/Xrrt2YxFYbS4BRMYL4Y0NPqLHV9Ru9EnbL5LHGKmZN9t0tsEHcauY67BX1IxclEUwOXC9E+aj2UrjzRqUQ7LtmjxiOmL2qU9Z5Akr7rF8VczAKKr/SMUn1CM2y+KP6+JFnKdFIWbrqrk7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WwDPGAVS; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743707515; x=1775243515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vovxfpKJgf6ol6D0CSE6J0UKWexkXXL6DC9c0tr1dr0=;
  b=WwDPGAVSB3MUCW6lnXIDj8kNyDEF6eugvbSr4l+ct9GqgxC0NqQBtYP7
   cUi8+Ub+8f3gnMOcFunXRFs5tdMKeZ85Ns1ksav5zFycpq8BKMbR+Z7YC
   o5MuB2NMQkOE1d4+UhuvykKslm2yWnW038yChLDZGXPjY6alweRdhVLAI
   M=;
X-IronPort-AV: E=Sophos;i="6.15,186,1739836800"; 
   d="scan'208";a="392813403"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 19:11:53 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:32116]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id 724021ac-06b5-4828-8460-c9fe5bea7dc1; Thu, 3 Apr 2025 19:11:52 +0000 (UTC)
X-Farcaster-Flow-ID: 724021ac-06b5-4828-8460-c9fe5bea7dc1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 19:11:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 19:11:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jirislaby@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <ematsumiya@suse.de>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<peterz@infradead.org>, <sfrench@samba.org>, <stable@vger.kernel.org>,
	<wangzhaolong1@huawei.com>, <willemb@google.com>
Subject: Re: [PATCH v1 net] net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
Date: Thu, 3 Apr 2025 12:11:28 -0700
Message-ID: <20250403191138.20479-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <568f7245-05c9-4061-b2f4-5d9d38b5c212@kernel.org>
References: <568f7245-05c9-4061-b2f4-5d9d38b5c212@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jiri Slaby <jirislaby@kernel.org>
Date: Thu, 3 Apr 2025 12:46:43 +0200
> On 03. 04. 25, 4:07, Kuniyuki Iwashima wrote:
> ...
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2324,6 +2324,12 @@ static void __sk_destruct(struct rcu_head *head)
> >   		__netns_tracker_free(net, &sk->ns_tracker, false);
> >   		net_passive_dec(net);
> >   	}
> > +
> > +#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> 
> I don't know if this is the right approach at all (it appears not to 
> me), but:
> 
> Having this check in random files looks error prone. Perhaps you want to 
> introduce some macro like SOCK_NEEDS_OWNER? Or you introduce sk_put_owner().

include/net/sock.h and net/core/sock.c are not random files.

Also, __sk_destruct() is the other single user where all sockets
are destroyed, so we have no reason to make sk_put_owner() available
for modules.

But, I'll define sk_put_owner() with sk_set_owner() under the same
config guard because I noticed I need to clear sk_owner in
sk_clone_lock() for MPTCP, which needs sk_clear_owner() or another
ifdef.


> 
> > +	if (sk->sk_owner)
> 
> The if is not needed.

Exactly, will remove it.

Thanks!

---
pw-bot: cr

