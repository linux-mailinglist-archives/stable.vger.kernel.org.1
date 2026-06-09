Return-Path: <stable+bounces-262298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0UvqBNEmKGqQ/AIAu9opvQ
	(envelope-from <stable+bounces-262298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 16:44:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA6661486
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 16:44:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=nTknKs6T;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262298-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262298-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A7A930FE689
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BA234389A;
	Tue,  9 Jun 2026 14:27:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177B342C93;
	Tue,  9 Jun 2026 14:27:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015248; cv=none; b=q2y11hwKlgLFDo3Z1JK9KLYT0AFqNodnJ7gCqRisV8HO2AIQ9e53QrvwU7ytt5gsQynv1OA2WvAP7bJ+i8umNvlKCtHhrI///XWo4tLbL/i/oYFuWFApHosu66+fhD33W5W/x13yzMb9CEQCYoVyGErKlbC4ImPRlL1MWp+odUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015248; c=relaxed/simple;
	bh=Hc73zFAvz2tICSssvWylf3xw9PZh/KwFdXDcFohR1PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0hoVtVC4rc0twtd8a5d8IcUNWvMRVS2Yx7379dgHPEgdPvA+jT1BJsizJB/wWHnFhr1X3GbXA40rUTr7W9Jq8A/5kXMbJSgTIop7QS9ZqkBRZhVKRkDeJdHzSRBplpAPBx4DmzCPJYgr6x4GlMky20J56mPOgL1QJxazX1fVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTknKs6T; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781015247; x=1812551247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hc73zFAvz2tICSssvWylf3xw9PZh/KwFdXDcFohR1PI=;
  b=nTknKs6TUjP+KoOqcGkwtfB5+/0feRSakSxxSgnswPL+HseUN8J84+90
   eYNv973Y4vywY00lTwrjueGZSFt26vF1520hyH3f5vK0hApojQdM4dEwc
   JHBuQTFptrKUT2Z+24ciOfKHU3hlZgTi47VequI+NbVY5XmceA254tWrW
   R5SmbRUSLn/td0PpbY+UZd/KXVgEikqq79MD/679Mwa/WgARULyUQ4JIl
   Xc4dZZ+KkgE5yLX0Ib1xDZhW4/OcrslihXp28ZGazG+iE5ws7P/UDlhDL
   4NthKEUNDRyxwqsEpU1DFB1QBncWEKQTmDcTyumIzoTQkJxYUtXkxn/AV
   g==;
X-CSE-ConnectionGUID: jvX5HfXVST25M2PIoo5FUA==
X-CSE-MsgGUID: Zch/MPRJQSW5ieHXi/+isA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="107213033"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="107213033"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:27:26 -0700
X-CSE-ConnectionGUID: 6tqw48DKRHCJg2OyMoYNvQ==
X-CSE-MsgGUID: csqgTnwCSRSXu9Qqitz4fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="239537131"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.94.249.113]) ([10.94.249.113])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 07:27:23 -0700
Message-ID: <ea66e44e-c9b0-4942-af6f-0b76e3f065a1@linux.intel.com>
Date: Tue, 9 Jun 2026 16:27:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix memory leak in
 ice_lbtest_prepare_rings()
To: Dawei Feng <dawei.feng@seu.edu.cn>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>
References: <20260609125021.3873270-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260609125021.3873270-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262298-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[marcin.szycik@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime,seu.edu.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBDA6661486



On 09.06.2026 14:50, Dawei Feng wrote:
> While ice_lbtest_prepare_rings() correctly frees Rx rings if
> ice_vsi_start_all_rx_rings() fails, the earlier error paths for
> ice_vsi_setup_rx_rings() and ice_vsi_cfg_lan() jump past this cleanup.
> If Rx ring setup or LAN configuration fails, the function leaks the
> initialized Rx resources.
> 
> Fix this by routing these earlier failures to the existing
> err_start_rx_ring label. This ensures the Rx rings are properly freed
> before tearing down the Tx state.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc5.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> Intel E800 Series adapter available to run the ethtool offline loopback
> selftest, no runtime testing was able to be performed.

IMO last two paragraphs should not be included in commit message,
rather after ---.

> Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index f28416a707d7..7c81ca313645 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1065,11 +1065,11 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
>  
>  	status = ice_vsi_setup_rx_rings(vsi);
>  	if (status)
> -		goto err_setup_rx_ring;
> +		goto err_start_rx_ring;
>  
>  	status = ice_vsi_cfg_lan(vsi);
>  	if (status)
> -		goto err_setup_rx_ring;
> +		goto err_start_rx_ring;
>  
>  	status = ice_vsi_start_all_rx_rings(vsi);
>  	if (status)
> @@ -1079,7 +1079,6 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
>  
>  err_start_rx_ring:
>  	ice_vsi_free_rx_rings(vsi);
> -err_setup_rx_ring:
>  	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);

Correct me if I'm wrong, but looks like unroll order is reversed:
ice_vsi_stop_lan_tx_rings() unrolls ice_vsi_cfg_lan()
ice_vsi_free_rx_rings() unrolls ice_vsi_setup_rx_rings()
(was reversed before this patch too, but since we're fixing it, might as well)

>  err_setup_tx_ring:
>  	ice_vsi_free_tx_rings(vsi);

Thanks,
Marcin

