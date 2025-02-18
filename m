Return-Path: <stable+bounces-116661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6EA3930B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 06:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EB117249A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A601B0439;
	Tue, 18 Feb 2025 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDO97Bn+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E641A8404;
	Tue, 18 Feb 2025 05:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857730; cv=none; b=bb4qMICyQ5wYm2Liq7X+RO6MmX697WYJgF1HY+JkN4uCYxlqqRKwk7yEJ9W0szZ6J1vqeg9aBEiTtIN3YwJDmVGYKMjNVy0V9h1ddiPoXY7oM7MsRkUv5hZYCxz7EKCKSGXCCd2tkXoFZ4VueQOiN0nP8p14ZGwRBz9PxvaV56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857730; c=relaxed/simple;
	bh=EhfoyfiV3/TQJjfLSsDlj14YQBGN85M2TkPc7w3M1ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vC7Ip+ABM9+panIcFtCO4F8mM05JVGbS8j8GEFol/Txp1E0oS8jiuInKVMKyqxJWKYptpQq1byxhKIqS0cOD7P0sDruYUhaA162hg6DSOEuyt0G2nnkCtF7f7hp0T3voaeMJRm1gJt36fWS8iBCNzyZE7NgJL3EVYzY7is+s/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDO97Bn+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739857728; x=1771393728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EhfoyfiV3/TQJjfLSsDlj14YQBGN85M2TkPc7w3M1ms=;
  b=CDO97Bn+ERJ/ZxhD8/CV5IDtIOhRzocdshPnQZkdC4DOKDnFl3u7I9uN
   KeGQ0Ji6yeGPEPmKaVQER0IHTb4tZMV+ijsoyotZCpoICbPQXiA6eF+Ep
   8U8HkHMjZ2Msa9RIuyWuIa2N1eSi9BhrvqzGoqwdaHNSEvDUkVdy8Dfut
   hErCTxCSh502Uc8igbjWuIfWMrahlrSOCYi6wcz1LvbJCKQgJyapGiM/X
   wFN+9yqPaPS96y0+L7576PLKXPD5wz6EGAzcrFlq+2/g2z2Pd0wxIWV++
   s5qkWmz28yg/08p4F+ZtaIfcG1nNIdAOADJ6L5MqKVHDVpPdBug41BXtV
   g==;
X-CSE-ConnectionGUID: z5tyUbxuRdqy1/UQrS8Shw==
X-CSE-MsgGUID: 8zdWfL/jRb6Wfcj13c+hHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="65896414"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="65896414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:48:47 -0800
X-CSE-ConnectionGUID: OP7CRnalRXSD+cNsV3OJ6Q==
X-CSE-MsgGUID: hUD85pdNRkms9PlrASST4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="119392439"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 21:48:43 -0800
Date: Tue, 18 Feb 2025 06:45:02 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Y.B. Lu" <yangbo.lu@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 1/8] net: enetc: fix the off-by-one issue in
 enetc_map_tx_buffs()
Message-ID: <Z7QeXnBE0iBNFQYL@mev-dev.igk.intel.com>
References: <20250217093906.506214-1-wei.fang@nxp.com>
 <20250217093906.506214-2-wei.fang@nxp.com>
 <Z7M1hQIYZGWAZsOT@mev-dev.igk.intel.com>
 <PAXPR04MB8510AA1D5B596B4382873A9F88FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510AA1D5B596B4382873A9F88FA2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Tue, Feb 18, 2025 at 02:11:12AM +0000, Wei Fang wrote:
> > > Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet
> > drivers")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > >  drivers/net/ethernet/freescale/enetc/enetc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > index 6a6fc819dfde..f7bc2fc33a76 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > @@ -372,13 +372,13 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > *tx_ring, struct sk_buff *skb)
> > >  dma_err:
> > >  	dev_err(tx_ring->dev, "DMA map error");
> > >
> > > -	do {
> > > +	while (count--) {
> > >  		tx_swbd = &tx_ring->tx_swbd[i];
> > >  		enetc_free_tx_frame(tx_ring, tx_swbd);
> > >  		if (i == 0)
> > >  			i = tx_ring->bd_count;
> > >  		i--;
> > > -	} while (count--);
> > > +	};
> > 
> > In enetc_lso_hw_offload() this is fixed by --count instead of changing
> > to while and count--, maybe follow this scheme, or event better call
> > helper function to fix in one place.
> 
> The situation is slightly different in enetc_map_tx_buffs(), the count
> may be 0 when the error occurs. But in enetc_lso_hw_offload(), the
> count will not be 0 when the error occurs.

Right, didn't see that, sorry.

> 
> > 
> > The same problem is probably in enetc_map_tx_tso_buffs().
> > 
> 
> I think there is no such problem in enetc_map_tx_tso_buffs(),
> because the index 'i' has been increased before the error occurs,
> but the count is not increased, so the actual 'count' is count + 1.
>

But you can reach the error code jumping to label "err_chained_bd" where
both i and count is increased. Isn't it a problem?

BTW, not increasing i and count in one place looks like unnecessary
complication ;) .

Thanks,
Michal

