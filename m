Return-Path: <stable+bounces-268065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0LM0G25xO2rAXwgAu9opvQ
	(envelope-from <stable+bounces-268065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 07:55:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C608B6BB9E8
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 07:55:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=XZ0b9xiU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268065-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268065-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9F4C30E69F0
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F62329E5D;
	Wed, 24 Jun 2026 05:52:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6A32570D;
	Wed, 24 Jun 2026 05:52:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280375; cv=none; b=qKiSjEvx+tCmmxaAXZJrCU039xVeB2duSwX4nyQqP8z1INMK4CyDR1EtUyxuwWE2ixHLRV8Brr+dhGT4Xdj/XzeYf/vySuDDC/ChvIt1DzIl4SDr7fcoJiQaoE5NF/rE41XTyCzFYtQn0Eh6rIByWc1Fi1K+t2Gii+X658lySbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280375; c=relaxed/simple;
	bh=Nh+d4vtceR7RsqEGXzwi+eBs6Z8NNz7JZu8G5XaM21I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me5Qo3Aoa8/306cZGWpJcMZYg16npBEgz8rhSsGkJGP6pPjVBNBAq3gQm3SmKAW+ezGQjtq1Ti48TdpPbRTGg4Wo+LxLZZYB1uY9lAWlOYlXRE5waDsaowTJzqGDH+lzI6yRJb5N7Z7v+D1nuBzVf2pZmFdfKdeP6MNeXNkSIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XZ0b9xiU; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782280374; x=1813816374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nh+d4vtceR7RsqEGXzwi+eBs6Z8NNz7JZu8G5XaM21I=;
  b=XZ0b9xiUXJ7eFfu/iVx3VIIYosvyquZZ9Px1Gv6biwr8hNmBTnfvI62d
   jnDNOcBi4odTDQ+K63kAfSQBfpY4jlmFnE9wddCtdxB7vgx9rvm4MpMAn
   wOdHyWVrad1+5tpgBqeLU1r4JMKuRSCyJU1VPvWXKhIyPiUdGsPqQfvzw
   2nmsmng19mupPxdmjNgmBhIsJCslUME7mfr9oHoaNXgpCei4wpQDKZEDS
   bolAGf0yFyIQbUpBSiyaflGtusOL8ZuK6b+1HN80t1tDUFfR22hPHzycU
   tKo3fvs0SevY1z+a/RjsfWY9MhmPTeSFszFry9Q0QFWnIoPVNYhN4LB5h
   Q==;
X-CSE-ConnectionGUID: WTTu3NOyRIacTOD4iyppWg==
X-CSE-MsgGUID: EUWGE7zORMy6aDCCz1j1+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="86876878"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="86876878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 22:52:52 -0700
X-CSE-ConnectionGUID: fnc09IOhQJysumEr5vR28g==
X-CSE-MsgGUID: 7nztfX23TDmc8kXgVckctA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="249755440"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2026 22:52:51 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 45A7495; Wed, 24 Jun 2026 07:52:49 +0200 (CEST)
Date: Wed, 24 Jun 2026 07:52:49 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: raoxu <raoxu@uniontech.com>
Cc: andreas.noever@gmail.com, westeri@kernel.org, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] thunderbolt: fix bandwidth group reservation indexing
Message-ID: <20260624055249.GH3066@black.igk.intel.com>
References: <BF910BF87AF1F9F7+20260624050719.4113548-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BF910BF87AF1F9F7+20260624050719.4113548-1-raoxu@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268065-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mika.westerberg@linux.intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:raoxu@uniontech.com,m:andreas.noever@gmail.com,m:westeri@kernel.org,m:YehezkelShB@gmail.com,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andreasnoever@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C608B6BB9E8

Hi,

On Wed, Jun 24, 2026 at 01:07:19PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> Group ID 0 is reserved, while valid bandwidth groups use IDs 1 through
> 7. tb_consumed_dp_bandwidth() uses the Group ID directly to index
> its group_reserved[] array.
> 
> Currently group_reserved[] has only seven entries, covering indices 0
> through 6. A tunnel in Group ID 7 therefore reads and may write one
> entry past the end of the array, and that group's reserved bandwidth is
> not included in the consumed bandwidth total.
> 
> Include the reserved Group ID 0 in MAX_GROUPS and map tb_cm::groups[]
> directly by Group ID. Initialize every entry with its array index, but
> skip index 0 when allocating a free group or restoring a group reported
> by the hardware. This keeps Group ID 0 reserved while making IDs 1
> through 7 valid indices in both arrays.

I looked at this again and realized that your v1 was almost okay but
instead of the -1 we should do this and just this:

tb_consumed_dp_bandwidth()
{
	 int group_reserved[MAX_GROUPS + 1] = {};
	 ...

keep everything else as is. This should solve the issue, right?

