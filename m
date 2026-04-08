Return-Path: <stable+bounces-233760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ae+IeHr1Wkd/QcAu9opvQ
	(envelope-from <stable+bounces-233760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:47:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 019323B75BB
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 07:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C21B3018BDE
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 05:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD57355F2B;
	Wed,  8 Apr 2026 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgMLcpqg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FE1EB5C2;
	Wed,  8 Apr 2026 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627207; cv=none; b=ZgEwBsBbL377pHRGByUIZVCmef9V7I5b5jiR//yFXlC2WCj5OnY7owAX6maWaB7IGkDoaej1FSJxvic745MWTgEVoT9tZJxsr/j6cStiMSJPnTrB7Jil0ze/NhIDZ4QlNPq7S0LIk0lLCd9Rs43V6N09yeSWETCmMsJaZwXeljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627207; c=relaxed/simple;
	bh=E4uU7VhDySTu/ApRmmn1LxcYG6u2WBIH8FMFN4v/WNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJvI1prMBG7zEFj8iqea90hx40N4DsU5VpchugXBDS0oGfSNyTZckujHY8Iyv/5Ccswrfgh10wsgNQVGZS97bnEdmPtM7bWohHU2G1yQzOdVULZU8oXymcw0eoQBqzgTHE2en2C9Btt8XlSnodkcRcFKU/tYW0JbInh77vx4o40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgMLcpqg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775627206; x=1807163206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4uU7VhDySTu/ApRmmn1LxcYG6u2WBIH8FMFN4v/WNk=;
  b=CgMLcpqgrBeBYi9c4Y1ke0grFwJtpyEPC/ehwl3Umv9cpQQ1L3WvTCGS
   88JN8EZEz+t4NKh93/6RaqfaXSSXZMsl087DpSwgysQuD7jBdpYzpOB1c
   WqwQpRVLvolz6+TSdEpwx9z+RL2tXvqV6GHvWXngpmTeqm+VZ+bbi0UqF
   fE4ebifdcn/HTnPKxjiiv+ut/msT7h2n2GpE/UrHTAWyLRhRa+N14aMiR
   5wNqGorU5w6zyl5TnxU3HJpmfHJgvgn2OOcvlCK0Jo13QKt/kIOfDUbsz
   2uKGCMk35fNRpY6Y1N/NSoFrMSJILSwpEK3HfCZ5vHFD8WVDvBtL0f1Er
   A==;
X-CSE-ConnectionGUID: gimGjHv/Q0+ywOWf4dSZYQ==
X-CSE-MsgGUID: ZMTASo19T9eow4lvQVfGQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76494671"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76494671"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:46:45 -0700
X-CSE-ConnectionGUID: cEu5HsZmT4eMX7SgNLPhug==
X-CSE-MsgGUID: lrYWmM22Q2qrL8itfzuw+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="232745623"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 22:46:41 -0700
Date: Wed, 8 Apr 2026 07:42:52 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>, stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix VF queue configuration
 with low MTU values
Message-ID: <adXq3Nq15B1kIvdZ@mev-dev.igk.intel.com>
References: <20260406145641.1020623-1-jtornosm@redhat.com>
 <88c37486-70aa-4109-a5b1-ee74cce23bc5@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c37486-70aa-4109-a5b1-ee74cce23bc5@intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233760-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,mev-dev.igk.intel.com:mid]
X-Rspamd-Queue-Id: 019323B75BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 03:50:32PM -0700, Jacob Keller wrote:
> On 4/6/2026 7:56 AM, Jose Ignacio Tornos Martinez wrote:
> > The ice driver's VF queue configuration validation rejects
> > databuffer_size values below 1024 bytes, which prevents VFs from
> > using MTU values below 871 bytes.
> > 
> > The iavf driver calculates databuffer_size based on the MTU using:
> >   databuffer_size = ALIGN(MTU + LIBETH_RX_LL_LEN, 128)
> > 
> > where LIBETH_RX_LL_LEN = 26 (ETH_HLEN + 2*VLAN_HLEN + ETH_FCS_LEN).
> > 
> > For MTU values below 871:
> >   MTU 870: 870 + 26 = 896, aligned to 128 = 896 (< 1024, rejected)
> >   MTU 871: 871 + 26 = 897, aligned to 128 = 1024 (>= 1024, accepted)
> > 
> > The 1024-byte minimum seems unnecessarily restrictive, because the hardware
> > supports databuffer_size as low as 128 bytes (the alignment boundary),
> > which should allow MTU values down to the standard minimum of 68 bytes.
> > 
> > I haven't found the reason why the limit was configured in the commit
> > 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message"), so
> > with no more information and since it is working, change the minimum
> > databuffer_size validation from 1024 to 128 bytes to allow standard low
> > MTU values while still preventing invalid configurations.
> > 
> 
> I dug through some of our internal history and found that there was no
> justification on why 1024 was chosen.

I can't remember why I choose 1024 and didn't mention it in commit
message. I agree that it is unnecessarily restrictive.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> 
> I agree with your assessment that the value of 128 makes the most sense
> as it is the actual hardware minimum. I wonder if we used to always use
> data buffer sizes of 1024 before the conversion to libeth. Either way, I
> think it makes sense to allow smaller buffers since the modern iAVF will
> request them.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> > Fixes: 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message")
> > cc: stable@vger.kernel.org
> > Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/virt/queues.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
> > index f73d5a3e83d4..31be2f76181c 100644
> > --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> > +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
> > @@ -840,7 +840,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
> >  
> >  			if (qpi->rxq.databuffer_size != 0 &&
> >  			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
> > -			     qpi->rxq.databuffer_size < 1024))
> > +			     qpi->rxq.databuffer_size < 128))
> >  				goto error_param;
> >  
> >  			ring->rx_buf_len = qpi->rxq.databuffer_size;

