Return-Path: <stable+bounces-114010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A9A29DAB
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 00:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B21E167E7C
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A80F21D002;
	Wed,  5 Feb 2025 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EFzUOuY5"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6821B19F;
	Wed,  5 Feb 2025 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799165; cv=none; b=q2jEHL9tyQoT/rLUJJVMVrA2NzUDWXi9CW9amg8VIEbHtHiw39JlfkOwZY9PnNL7+cxGKeISklnG94FDlnI35/640Qo0iujcPj05QLDt6R6F2cDoLrfRcw0P+VrlgDFfr2TjWSf9bT2vzXlchzXMLe8JH0EDYcqifwE1ax41pnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799165; c=relaxed/simple;
	bh=g09ZCqXnNJJVNUAm2aaH4LByKmRn9oc/DAVX0yAT7Ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf4/33DLZ5H3VsQR7Pq+x6IZTrcByg75MHuz5otPE11DrMamW/ZSKojzCACM8u8ycWebSYYByVvE8aRrUDCR7hF07NyFanr+vKFSq+HuudjUMtTiE3rATp7/mFY2v04Mun8FPMbw+/F/NrGUmXkBvbW/KejdiAyMBmapNxhYx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EFzUOuY5; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738799164; x=1770335164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LVoyEb4eO8E2i2Vxvj92QtiYB4cbewa0hWoTfpwNUdc=;
  b=EFzUOuY5kwvg5DBvBYRlWZKoABO+tVbLsiz8yUWkyZVmKrz3U8X5bwBH
   MEelcNC7ytddRDCYOoll2bwygjvjMht55zp0y9KYpmdsJ3hL64gaRGeia
   bwPYKosYTjPK9fiTOPW7+gCEVnd82ioefmtD8j2qfx4g4Ii4takP0nCGu
   0=;
X-IronPort-AV: E=Sophos;i="6.13,262,1732579200"; 
   d="scan'208";a="796459408"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 23:45:58 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:15949]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id c8515f7e-9835-464e-9b44-6453fd1c087c; Wed, 5 Feb 2025 23:45:57 +0000 (UTC)
X-Farcaster-Flow-ID: c8515f7e-9835-464e-9b44-6453fd1c087c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 5 Feb 2025 23:45:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 5 Feb 2025 23:45:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.dichtel@6wind.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <razor@blackwall.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] rtnetlink: fix netns leak with rtnl_setlink()
Date: Thu, 6 Feb 2025 08:45:39 +0900
Message-ID: <20250205234539.52299-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205221037.2474426-1-nicolas.dichtel@6wind.com>
References: <20250205221037.2474426-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Wed,  5 Feb 2025 23:10:37 +0100
> A call to rtnl_nets_destroy() is needed to release references taken on
> netns put in rtnl_nets.
> 
> CC: stable@vger.kernel.org
> Fixes: 636af13f213b ("rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!


> ---
>  net/core/rtnetlink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 1f4d4b5570ab..d1e559fce918 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3432,6 +3432,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		err = -ENODEV;
>  
>  	rtnl_nets_unlock(&rtnl_nets);
> +	rtnl_nets_destroy(&rtnl_nets);
>  errout:
>  	return err;
>  }
> -- 
> 2.47.1
> 

