Return-Path: <stable+bounces-240294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEMJKTyJ6Gk6LgIAu9opvQ
	(envelope-from <stable+bounces-240294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:39:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78444390F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D08DA3007B1B
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6B3BF677;
	Wed, 22 Apr 2026 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzpvqIxL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFA1A9FA7;
	Wed, 22 Apr 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847152; cv=none; b=IPZNzh7Nrcph3jLaX7cBnSAsQjl+eRzVDnm+V4ARuOwys1g1orp60yHw0O/tsIBTo2piuf4zIFiP1umGdRAdFROfbn8d51CZS0pq+GO5qMZ4yRW+9mov83KmxBLnlZ8oj9CV2eIY4KcY9ZrvSED8gbvc97/ATxsCrgiKv08aPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847152; c=relaxed/simple;
	bh=w73KMIQlHjPb+N1olkaiecVh/4Mf9dDmU8qVJtpkvSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rl1qkC219TtzJIrL1Z+p/zsYRn22m234LeWCP/xKGodyKVLcTyZilijVv8e6AhnqRsJ0zRK7ynQYj87pXg4zk0vORZ6PCB2hb8U0yMc/MTh3FHTGEx+Gh5WbbEbZw1aX0ZCTA3XSneKif2sswtreHeeuCOJGjvMqe1P+fFngZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzpvqIxL; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776847151; x=1808383151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w73KMIQlHjPb+N1olkaiecVh/4Mf9dDmU8qVJtpkvSg=;
  b=OzpvqIxLaUY1Fy7FWxl/HVigYMNS+yQcluFXNbQhYyimXfI1UBqG/a7e
   EjrJjW89Eo/+5ebs5KNr6z9r5EKU7ERYjphG1MKSealICzFoYStRlV6pe
   4vv6XNhK3key+ojfVIoRJvmqrOdyhLvCZ51/iphQd5RUy+xtqU2SQKtvT
   nVyBSaWSnfXpxt3210QesP2Tqk36yW4JA24hMj8/V/TPiUv94ERfpgKt/
   UMwA1vwlo0h9ftjrllIAw7BixvUW9QFFL9UocfsXNE5oOhtYPVzERCyLG
   pQg6acuXRVEFtZ3ss0k/LDD4aZQT8vjDAoESgtfKI3+XPt2doKMPjQIWK
   g==;
X-CSE-ConnectionGUID: dhDUlPErTBeLX9L2bdWh1Q==
X-CSE-MsgGUID: P9jqPVRqQzGsLyxw/A27CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="76827701"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="76827701"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:39:10 -0700
X-CSE-ConnectionGUID: bgQrZQfHQaazekliRtVgvg==
X-CSE-MsgGUID: TjLeu755Si6KxtFXz56UZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227957981"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.20.189]) ([10.247.20.189])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:39:08 -0700
Message-ID: <dfdf4a8c-41cd-482f-baf6-64fe82698453@linux.intel.com>
Date: Wed, 22 Apr 2026 16:38:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] igc: fix potential skb leak in
 igc_fpe_xmit_smd_frame()
To: Kohei Enju <kohei@enjuk.jp>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kohei.enju@gmail.com, stable@vger.kernel.org
References: <20260415025226.114115-1-kohei@enjuk.jp>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20260415025226.114115-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240294-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faizal.abdul.rahim@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F78444390F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 15/4/2026 10:52 am, Kohei Enju wrote:
> When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> allocated skb, leaking it. [1]
> Use dev_kfree_skb_any() on failure.
> 
> Tested on an I226 adapter with the following command, while injecting
> faults in igc_fpe_init_tx_descriptor() to trigger the error path.
>   # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on
> 
> [1]
> unreferenced object 0xffff888113c6cdc0 (size 224):
> ...
>    backtrace (crc be3d3fda):
>      kmem_cache_alloc_node_noprof+0x3b1/0x410
>      __alloc_skb+0xde/0x830
>      igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
>      igc_fpe_send_mpacket+0x37/0x90
>      ethtool_mmsv_verify_timer+0x15e/0x300
> 
> Cc: stable@vger.kernel.org
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> Changes:
>    v2:
>      - change to idiomatic style with goto (Simon)
>      - add Cc to stable (Alex)
>      - add reprodunction steps (Alex)
>    v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/
> ---
>   drivers/net/ethernet/intel/igc/igc_tsn.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 8a110145bfee..02dd9f0290a3 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -109,10 +109,16 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
>   	__netif_tx_lock(nq, cpu);
>   
>   	err = igc_fpe_init_tx_descriptor(ring, skb, type);
> -	igc_flush_tx_descriptors(ring);
> +	if (err)
> +		goto err_free_skb_any;
>   
> +	igc_flush_tx_descriptors(ring);
>   	__netif_tx_unlock(nq);
> +	return 0;
>   
> +err_free_skb_any:
> +	__netif_tx_unlock(nq);
> +	dev_kfree_skb_any(skb);
>   	return err;
>   }
>   

Thanks for helping to fix this.

Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>



