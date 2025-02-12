Return-Path: <stable+bounces-115025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0336AA32168
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA642163D0E
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079C20551D;
	Wed, 12 Feb 2025 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uwUw8sPa"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14AB271828;
	Wed, 12 Feb 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349961; cv=none; b=tQEtkKlYNbG2Hxju5q9bkszC2jTMnWo03JESaHH8XzlP3MVO2wlfohfA1Y2yHZt1ykePNIer+mNeaV2xdmAolf0WyDNKVo6dHDOijLAa7T7sbHVpHMZXTCIcyfM+ibsoLQLuwBtHjTDk8O+u4F0gxlPDgEFoNV090p1JA34CugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349961; c=relaxed/simple;
	bh=SP/+UeGY2ctHk9D8AJWeItEVLVTLyVkEN8JUn948NJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5etVZAe0nVjMvifCwz1Bm1QWqmVSMAKBN1Y6BRSm9Okx6dJeztWNYP/kFjjEH2Uh7m+u2j0QRGOJp5y8kSieDG5xf2Lw4BJisuZc1lvF2GeQs3XeGVvfJliseWtPoo76Hfv0oW2AATyoIOM1xtAqPD3svrzkfGw4zG1N/lxzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uwUw8sPa; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739349959; x=1770885959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SP/+UeGY2ctHk9D8AJWeItEVLVTLyVkEN8JUn948NJ8=;
  b=uwUw8sPaXh9R+l4zIFLY2XwPH1oh9l88fV9C2yR23b2SX8HBL85geYB3
   du85wktevt6tvz3WLPlgUmzcgIrgc3/DL+Pabwqoe9hybAPOhplsTLWDA
   IdDN6pXi0f/3epVFTMWlX14HO0yWB1gt5PKup23XiPloCTIKpYWQajVsA
   I=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="798132496"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:45:34 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:45084]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id b0720d08-eebd-4a10-9586-a1e26bdbbb8e; Wed, 12 Feb 2025 08:45:34 +0000 (UTC)
X-Farcaster-Flow-ID: b0720d08-eebd-4a10-9586-a1e26bdbbb8e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 08:45:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.86) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Feb 2025 08:45:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <bastien.curutchet@bootlin.com>
CC: <alexis.lothore@bootlin.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>,
	<stable@vger.kernel.org>, <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net 1/2] rtnetlink: Fix rtnl_net_cmp_locks() when DEBUG is off
Date: Wed, 12 Feb 2025 17:45:19 +0900
Message-ID: <20250212084519.38648-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212-rtnetlink_leak-v1-1-27bce9a3ac9a@bootlin.com>
References: <20250212-rtnetlink_leak-v1-1-27bce9a3ac9a@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 12 Feb 2025 09:23:47 +0100
> rtnl_net_cmp_locks() always returns -1 if CONFIG_DEBUG_NET_SMALL_RTNL is
> disabled. However, if CONFIG_DEBUG_NET_SMALL_RTNL is enabled, it returns 0
> when both inputs are equal. It is then used by rtnl_nets_add() to call
> put_net() if the net to be added is already present in the struct
> rtnl_nets. As a result, when rtnl_nets_add() is called on an already
> present net, put_net() is called only if DEBUG is on.

If CONFIG_DEBUG_NET_SMALL_RTNL is disabled, every duplicate net is
added to rtnl_nets, so put_net() is expected to be called for each
in rtnl_nets_destroy().

