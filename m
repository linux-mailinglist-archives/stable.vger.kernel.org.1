Return-Path: <stable+bounces-223065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JqpFjE1qGm+pQAAu9opvQ
	(envelope-from <stable+bounces-223065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:35:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C75200817
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD0D43130FF5
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494C3373C1E;
	Wed,  4 Mar 2026 13:30:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4EE372673;
	Wed,  4 Mar 2026 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631014; cv=none; b=e7LjQaw51Acts+muNQIaRIlNGmfz8jopthuA73lIDS0+rkKUC7Y1oBSw9QvNWryjZoDn+fTaTmv+fsCaPoBJb/WrvGquTgkxBYK9aH7ctgbkW3uOCMj1482GdvZywFf8FVpZRZ2raXXxQ1VZmrifZMmhy1G8ED2YDon+o0rNwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631014; c=relaxed/simple;
	bh=OA7sY5Gukki1t+dkD73vfKDLROh7QEw2JN22fFOoXto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvmdBvRlgoy1YDELQLKiQvxGkmPn/kaf0r54DaBJbnGVQQWNK6ggt+FSdP9wZo0S0K+m0ASiYLLQTMpD41XaoG8ngQi/rN/LlyDSEv5NFjd1X3mxNu23QPLs7HI78H+moASeGpUxoOwAeSvOUjUZBTG/k8hEaHY0gm4gHFFPTHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Wed, 4 Mar 2026 14:29:56 +0100
From: Brett A C Sheffield <bacs@librecast.net>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/684] 6.6.128-rc2 review
Message-ID: <aagz1A1WCj2qBb4x@karahi.librecast.net>
References: <20260302160934.2521545-1-sashal@kernel.org>
 <20260302193559.3432-1-bacs@librecast.net>
 <aafiF3Mtc17i7Y72@auntie>
 <aagiQjT1eBGEHV--@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aagiQjT1eBGEHV--@laps>
X-Rspamd-Queue-Id: A7C75200817
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223065-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[librecast.net];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bacs@librecast.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,librecast.net:url]
X-Rspamd-Action: no action

On 2026-03-04 07:14, Sasha Levin wrote:
> On Wed, Mar 04, 2026 at 07:41:11AM +0000, Brett A C Sheffield wrote:
> >On 2026-03-02 19:35, Brett A C Sheffield wrote:
> >> # Librecast Test Results (FAIL)
> >>
> >> 020/020 [ OK ] liblcrq
> >> 010/010 [ OK ] libmld
> >> 120/120 [ OK ] liblibrecast
> >>
> >> CPU/kernel: Linux auntie 6.6.128-rc2-ge6906aa7f5ea #1 SMP PREEMPT_DYNAMIC Mon Mar  2 17:31:27 -00 2026 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux
> >>
> >> Builds, boots and passes network tests.  Fails to poweroff.
> >>
> >> Bisects to commit 3ba77c48498f0fa29456e2435d7d49eafc0a279c (upstream 4589712e0111352973131bad975023b25569287c) and affects 6.6.y and 6.12.y. Other kernels are unaffected, including mainline.
> >
> >Are we dropping the offending commit from 6.6.y and 6.12.y and retesting?
> 
> Yup, I'm going to drop it from both trees.

Thanks.

-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

