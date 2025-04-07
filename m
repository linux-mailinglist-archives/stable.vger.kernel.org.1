Return-Path: <stable+bounces-128580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D43A7E51A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AF57A352C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B74E2045B2;
	Mon,  7 Apr 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S800ReA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9A2040B7;
	Mon,  7 Apr 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040799; cv=none; b=sT2T6fZU91Y3xTCeNOlOMtz04TS51sQNwjfvwHnrFdzqrGncV2d7YNLHSqcjrhXdanZ0hF14Rp/+Pdvm7W9zXPOuiYVKVrGEw4YxZkEwvDEi40C3Xh9idc0xpXa6fNDyXtWCp8vldduW2rTkLqkaoIQo4BTFCel7kTQr0aD+BYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040799; c=relaxed/simple;
	bh=3JKH4GIY/au3jWTb2aoF3BWfc2VHv9ob16gBCK3dN4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoU1Sf5jG/xRZhXYFbiFchVjumr3JgPgFrtQ5nQNmULqdiK/1ShgOVsJcnavf34/hfZvPaGq8KfcSfkzG/KDrFaZT2DCILyeOfl45upDSWg97Cg6D3ZBg1KaOQuzW/e9lh+RUdrFofHfhoBPjDX1HC9FEAGAr6X7TlzHSjdSuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S800ReA+; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744040798; x=1775576798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b8pk2WO7U7PSqWMxtkBKS4UJqO0G3TRNoE2CrucpvhE=;
  b=S800ReA+/sKQb21IHwxHjs0mzBTeWHgDb124fMpcZNIXjc0H+Ycbf36z
   tM9Ff54K5+R0hJpEXNLN8aWkhbFt5hRMkQRUcPlCjaq+/WUPtBU2GCWLH
   actII9aS4GBomC985ZcvclposSc82tBZyU2Z4Ig3iFD+0k896fiNr1QTv
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="38490008"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 15:46:37 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:25784]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id c281f309-001c-49d5-88e9-1b8d465fd87f; Mon, 7 Apr 2025 15:46:35 +0000 (UTC)
X-Farcaster-Flow-ID: c281f309-001c-49d5-88e9-1b8d465fd87f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 15:46:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 15:46:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <ematsumiya@suse.de>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <peterz@infradead.org>,
	<sfrench@samba.org>, <stable@vger.kernel.org>, <wangzhaolong1@huawei.com>,
	<willemb@google.com>
Subject: Re: [PATCH v2 net] net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
Date: Mon, 7 Apr 2025 08:46:18 -0700
Message-ID: <20250407154623.15542-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407104559.GB395307@horms.kernel.org>
References: <20250407104559.GB395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Mon, 7 Apr 2025 11:45:59 +0100
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 8daf1b3b12c6..4216d7d86150 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -547,6 +547,10 @@ struct sock {
> >  	struct rcu_head		sk_rcu;
> >  	netns_tracker		ns_tracker;
> >  	struct xarray		sk_user_frags;
> > +
> > +#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> > +	struct module		*sk_owner;
> > +#endif
> 
> Not a proper review, but FWIIW, sk_owner should be added to the Kernel doc
> for struct sock.

Thanks for catching!
Will add kdoc in v3.

