Return-Path: <stable+bounces-236006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFpeOoza3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-236006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:59:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF0A3EBA20
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B97EC30090BB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614F3BE17F;
	Mon, 13 Apr 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WMvY3/JZ"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16F33BED17;
	Mon, 13 Apr 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081546; cv=none; b=ApwoRRjgxcrOgLEtBM8stN2BzFGgn104slLl9EpR76a28r1V/xJ5FqqmrMl3iCy4p0Fd0/+x0D/2ZCmpyZSNlIFoQsBrljqGet6WyfW1zLxXv8X61BuyYvApm3eWdJrXmumgabTrh0m6I5OfU6D5E4XYfEIkXLsUx1FfHZy0Sj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081546; c=relaxed/simple;
	bh=kdwtsZTX8JHWxSQI096jyZiy3Z+yb1EqPFicOLsBJlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2E+hBKjD04PZWXz7VBiQty9KO0Kr2rUqGNnEvP1pGhqLQkTNFS52qS5TpoiCLUoOmAsb3IcubQMAx7Zf50MslfEm+RrzaY1icGTiNUb9Lo4+RIdK2QTvLvzcn/XYPcagipkoxgAkGOWnoz/I4JSX+0tK4lh6Tg4KwVaGpoDsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WMvY3/JZ; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fvQtH3RpRz8B2w;
	Mon, 13 Apr 2026 13:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776081543;
	bh=kdwtsZTX8JHWxSQI096jyZiy3Z+yb1EqPFicOLsBJlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WMvY3/JZ/P+wYNeMbryJ+mrWYJU0HrVBhpxIZVGfjif+Lr5MHBrCOV1H1vmawJBao
	 vJEYsvB0eg1vimmPk35YpYJJArtC4W0+hWeNMidQLeth6ZgZeaCuEpkerBHiRT1n4v
	 GLF57i9wjJubmnH0M3ZAFKM5jjOXXXWAUKRAmp8Km2l9gre0sbsOcZ3+DDruIiKJgc
	 /+X+rO6EIV9Tnvmmm73N1cJ6cl1sgACePbzWngpim+vx2qLiJy0GIz66iq5gr2N9bc
	 JSdjH2mOUA/56x7SXoB7xx925+nHShPIElF7lZcFDBXUn798FqJtiMjKcubkKVfIW8
	 z4hw9Zcjcfxxg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fvQtH2kMMz89r8;
	Mon, 13 Apr 2026 13:59:03 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fvQtB13N3z8scg;
	Mon, 13 Apr 2026 13:58:57 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E463D635CE;
	Mon, 13 Apr 2026 13:58:56 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <58f6e74d-480e-4e0c-aa66-68dfc1de7421@leemhuis.info>
Date: Mon, 13 Apr 2026 13:58:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>,
 "Berg, Johannes" <johannes.berg@intel.com>, Friend <netdev@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: 
 <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <2026040331-evasion-walk-f572@gregkh>
 <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <2026040349-chowtime-freeload-5ca4@gregkh>
 <DM3PPF63A6024A9E931C940F849C60FAF9EA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <DM3PPF63A6024A9E931C940F849C60FAF9EA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177608153730.182129.13646758274842136762@mxe9fb.netcup.net>
X-NC-CID: lTUSuUsXUuObicN+PqyvLtbNuSKpQVeUo6LeMeMx+NC/Kv4gwkA=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,leemhuis.info:dkim,leemhuis.info:mid];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TAGGED_FROM(0.00)[bounces-236006-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AAF0A3EBA20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 15:00, Korenblit, Miriam Rachel wrote:
>> From: Greg KH <gregkh@linuxfoundation.org>
>> On Fri, Apr 03, 2026 at 12:44:48PM +0000, Korenblit, Miriam Rachel wrote:
>>>> -----Original Message-----
>>>> From: Greg KH <gregkh@linuxfoundation.org>
>>>> On Fri, Apr 03, 2026 at 11:08:46AM +0000, He, Guocai (CN) wrote:
>>>>> No, The mainline have no this issue.
>>>>> The changes of 0c4f1c02d27a880b is not in mainline.
>>>>
>>>> That does not make sense, that commit is really commit e1696c8bd005
>>>> ("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") which is in
>>>> all of the following releases:
>>>> 	5.10.252 5.15.202 6.1.165 6.6.128 6.12.75 6.18.14 6.19.4 7.0-rc1
>>>> confused,
>>> The change is indeed in mainline, but the locking situation in
>>> mainline is totally different (that mutex does not even exist there)
>>> Therefore, the issue is not supposed to happen in mainline.
>>
>> Ok, does that commit now need to be reverted from some of the stable branches?
>> If so, which ones?
> 
> From every version which is < 6.7.

Greg, do you still have this in your todo mail queue somewhere? Just
wondering, as last weeks 6.6.y released afics lacked a revert of
e1696c8bd0056b ("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") --
and I cannot spot one in your public stable queue either.

These are the commits that according to Miri need to be reverted if I
understood things right:

v6.6.128 (4d7a05da767e5c), v6.1.165 (0c4f1c02d27a88), v5.15.202
(31344ffecd7a34), v5.10.252 (d91240f24e831d)

Caio, Thorsten

