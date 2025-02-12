Return-Path: <stable+bounces-115023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1443A32120
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB4D27A27B7
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792872046BC;
	Wed, 12 Feb 2025 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XgtwYrfm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81F2B9BC;
	Wed, 12 Feb 2025 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349101; cv=none; b=qISjaU7ZwU7K9HQY+v7kg19nBroeWAnLlq444zSQKjDozANG7OTjCF0JiIkyMUvcqoX2gPHjwbMAn1z+dLzc0WHy61hNc6KD9Kq68LZya4S2g4e6/hqYvq9gPL2clI6IDddA5RZ9ikov5DlpBD8e1HgpDhcDJWI3P0IEq8F73no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349101; c=relaxed/simple;
	bh=U5LkOsBYQBC9HF+Xost4UKjDT+A/Ur3sNHrHaVpD6CE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gk3vdqYbSb5BeMyr0BKUiAAj0N+YjRwPlsjkyqG46aCxwY2U9iq+SB4phxRoR4vR3Tcuk8OOKzKCvV2hQJ2ui0Qf4fkGQoktVsqQB6S8kPtJKCtGvtEFgxThRW4b8c9A2qGXsFRV9GR8ZQU13dzmwXTEtMl9PYUac7jbXTyof5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XgtwYrfm; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739349099; x=1770885099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PzCZADhAvJ2WREamw5Y550pTth+/8wJ75CW4RSfQBOs=;
  b=XgtwYrfmivhPv0meDnfSrSG7igy/0Lvcn3C3I1mu1Gn4wdtJwCElM8IB
   MyDdzNZVDcQuS/OW1DRSQm5AkhEmme07HMiiBJGLt1XqWsxZ8LWVjbbg3
   qD+8+YE92A9kqarxIzNuuuMGAMwxNd8WODGH2pCDbi+RIP46Xr6PsQ7+f
   k=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="270480792"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:31:33 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:8635]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id 444b47fe-285e-4859-b4f9-d0036cc2cdc3; Wed, 12 Feb 2025 08:31:32 +0000 (UTC)
X-Farcaster-Flow-ID: 444b47fe-285e-4859-b4f9-d0036cc2cdc3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 08:31:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.86) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Feb 2025 08:31:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <bastien.curutchet@bootlin.com>
CC: <alexis.lothore@bootlin.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>,
	<stable@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net 2/2] rtnetlink: Release nets when leaving rtnl_setlink()
Date: Wed, 12 Feb 2025 17:31:17 +0900
Message-ID: <20250212083117.32671-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212-rtnetlink_leak-v1-2-27bce9a3ac9a@bootlin.com>
References: <20250212-rtnetlink_leak-v1-2-27bce9a3ac9a@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 12 Feb 2025 09:23:48 +0100
> rtnl_setlink() uses the rtnl_nets_* helpers but never calls the
> rtnl_nets_destroy(). It leads to small memory leaks.
> 
> Call rtnl_nets_destroy() before exiting to properly decrement the nets'
> reference counters.
> 
> Fixes: 636af13f213b ("rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

It's fixed in 1438f5d07b9a ("rtnetlink: fix netns leak with
rtnl_setlink()").

Thanks!

