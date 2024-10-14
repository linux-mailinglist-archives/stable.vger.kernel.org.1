Return-Path: <stable+bounces-85068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490599D692
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 20:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3639E1C245A9
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BBB14F115;
	Mon, 14 Oct 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gjwq0Amk"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07D1AA79A
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930804; cv=none; b=m5MuJfknqg8QL/d//vxFl2b/b1+TVqBDDBq6e6idMPSFD3eZdyrkO/MHF1oIxt0u2TUAXoM87wQZkJIWEnGzcLC0ngVdATbIDJBf6TL2d8SsjlXW+w/HW7m3MTmZjjjL+TAzB2K7yuoGafP/iiDpJNmrYATJRp7ZARLXBD6YQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930804; c=relaxed/simple;
	bh=Rdkqqh4lbkPiK8/q/ODQZwdQUVY+h6mD9+k5XfV94VY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5XaLFSX/Q1tizymZF0w45PvSOfMZZvKd2k60t7Rf+k5oqpE6pb8hMgYqZYVOxK7U1k2/3tzan7KXj69vcDA09d6/l5xEG6+XrZpQZ6zFR/AFlZ+9O/mVRkb93BvtVjf123Iz996GqH1+6ZJyewZjGSi4OLfDixn85iM2ao2dqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gjwq0Amk; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728930802; x=1760466802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rKCt2telM6maTWPe4XsSoL13DYZlMIXBfBNw+s3BbIc=;
  b=gjwq0AmkWJWjuPgVIRUmSA7/9DOvdYc2cXI08UL0BtiwigN2fv1Awm2c
   c5vU8eU3KlrQROmmbamHDGF6iJThzSBr6P0GBc1QYH7vZU0StvUMebDEu
   ighgFQ0cBMfjL9gUL3x1vZn2VEbXSY6xkbx6Wk1DnlyrXXQ1HonoJXXVP
   I=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="138529332"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 18:33:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:37617]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id c59301f7-cddd-4ef0-8f6d-3e40482868f7; Mon, 14 Oct 2024 18:33:20 +0000 (UTC)
X-Farcaster-Flow-ID: c59301f7-cddd-4ef0-8f6d-3e40482868f7
Received: from EX19D018UWB001.ant.amazon.com (10.13.138.56) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 18:33:17 +0000
Received: from c889f3bcf8d1.amazon.com (10.187.171.41) by
 EX19D018UWB001.ant.amazon.com (10.13.138.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 18:33:17 +0000
From: Matthew Yeazel <yeazelm@amazon.com>
To: <yeazelm@amazon.com>
CC: <daniel@iogearbox.net>, <gregkh@linuxfoundation.org>,
	<martin.lau@kernel.org>, <peilin.ye@bytedance.com>, <razor@blackwall.org>,
	<sashal@kernel.org>, <stable@vger.kernel.org>, <zhangyoulun@bytedance.com>
Subject: Re: [PATCH 6.1.y] bpf: Fix dev's rx stats for bpf_redirect_peer traffic
Date: Mon, 14 Oct 2024 11:33:15 -0700
Message-ID: <20241014183315.39532-1-yeazelm@amazon.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014182130.37592-1-yeazelm@amazon.com>
References: <20241014182130.37592-1-yeazelm@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D018UWB001.ant.amazon.com (10.13.138.56)

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 20d8b9195ef6..9f5109a15e4c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9983,6 +9983,54 @@ void netif_tx_stop_all_queues(struct net_device *dev)
>  }
>  EXPORT_SYMBOL(netif_tx_stop_all_queues);
>  
> +static int netdev_do_alloc_pcpu_stats(struct net_device *dev)
> +{

I submitted this prematurely, this needs a few more changes that this commit depends upon. I'll work on getting the full patchset ready for backporting to 6.1.y.

