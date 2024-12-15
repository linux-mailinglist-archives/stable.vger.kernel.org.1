Return-Path: <stable+bounces-104286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191DC9F24E8
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 18:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC8218852BD
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1518C932;
	Sun, 15 Dec 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="bPK+BqmU"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016264C80
	for <stable@vger.kernel.org>; Sun, 15 Dec 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734282954; cv=none; b=BeYv67ucCHblIXOY0ut8Pf+Iq6iizq5UMbObjPk0MTa94J0z/YOsdLBRYrnfQq08TgQ+4gIOv3czAJDhmJkWinWg2qj2zex1tpl+7+8gLnznFZad38rgo1/QYFH0ivJG9yX/GIeiIJJnkhuh0rUwIkiGApUqXcMxK3aP30frn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734282954; c=relaxed/simple;
	bh=BIp8K3LQ7XeLatmB+Bd5r8i9k/5JAT5zwke9OwyPMRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hlyz3EK3m3Z+gvUvREmNKbcLUnnsl9TuSlAjD2rixNBmDn67XRA6/Ox6ISQvTEKSD9woD2ur46ZttXZXPGRsQ19bTUyMEWG9yl3vx2uWIb10daF4efmoFq07HEu/ZovYfZGI10CeSq5EwTTLzeTtbODQeg860TR5og59R3yRaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=bPK+BqmU; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 716BBA03FB;
	Sun, 15 Dec 2024 18:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=eu6nlrH6IOW72gWT8OiP
	DnPPjEDIaaBcidASdgNbLGI=; b=bPK+BqmUtXn5cL3/D+m5btKMYR9pysz06u7k
	NMpsPgbgebUPsGIG2zbq2ddx20+avtoliG/d7ef7xCSOr83qXezsbXIozKgUzM8O
	1SRemm7zn3p4YW+myJkZtm9gV3Zf/fu6EE7Svph3QC5z/Qla36fkeGF+ThAgJL6S
	2r9ppDl3Fg6nfnCP7IeU/28kmxK2mZD8c13taO6Jaz4h3nS+ReoEtumI3ZGvdJ4w
	cA6INy+A2li2x0pr3W9BSLSH8RwF9PjxQCcJCQJcg++iXxdSgJBYxqIWkarMvq7t
	51Bf5EZ0ElqrvmeiLPCWGCM4+cqvmvQMy/N5W7ZLmJZAjOQZhfLPKyTotSua91HJ
	RHMmU2xi7joy1LOAdRkaY4XZlnjz++PrfbesjaLluXr06laOaw/mIHwbgAV05BVK
	tuamDtidOhINSdbh8HlE3dLkyjMS2JkcR0D9idaJVVUpE7mu+soUdtn7zRGPmg9I
	Yy6HUEgqeJ9iCHal6PFwS/aJ78q4O/F4cFlAIL+jzF7xmBBSQsschHIb/wGHZ6zr
	zR3g1OHHuNfM5m7Y3jsc8bbGmjBQsTBoGJudri3njt8gcRCIDgYhiOX2Mzy9Kyly
	/+IHgFHNp6T2KbDt8wRAaQggxwJ52VGzP0gxkw9bDufwEsF69BKxxwjOV6j60s4K
	oli7JMg=
Message-ID: <6d794b77-77ea-4da3-8ca3-1510dd492e2e@prolan.hu>
Date: Sun, 15 Dec 2024 18:15:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 resubmit 0/3] Fix PPS channel routing
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>
References: <20241213112926.44468-1-csokas.bence@prolan.hu>
 <2024121346-omission-regulate-89c3@gregkh>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <2024121346-omission-regulate-89c3@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948556D7465

Hi,

On 2024. 12. 13. 12:41, Greg Kroah-Hartman wrote:
> This series is really totally confusing.  Here's what it looks like in
> my mbox:
> 
>     1   C Dec 13 Csókás, Bence   (0.8K) [PATCH 6.6 resubmit 0/3] Fix PPS channel routing
>     2   C Dec 13 Csókás, Bence   (1.9K) ├─>[PATCH 6.11 v4 2/3] net: fec: refactor PPS channel configuration
>     3   C Dec 13 Csókás, Bence   (1.8K) ├─>[PATCH 6.11 v4 3/3] net: fec: make PPS channel configurable
>     4   C Dec 13 Csókás, Bence   (1.4K) ├─>[PATCH 6.11 v4 1/3] dt-bindings: net: fec: add pps channel property
>     5   C Dec 13 Csókás, Bence   (1.9K) ├─>[PATCH 6.6 resubmit 2/3] net: fec: refactor PPS channel configuration
>     6   C Dec 13 Csókás, Bence   (1.8K) ├─>[PATCH 6.6 resubmit 3/3] net: fec: make PPS channel configurable
>     7   C Dec 13 Csókás, Bence   (0.9K) ├─>[PATCH 6.11 v4 0/3] Fix PPS channel routing
>     8   C Dec 13 Csókás, Bence   (1.4K) └─>[PATCH 6.6 resubmit 1/3] dt-bindings: net: fec: add pps channel property
> 
> I see some 6.11 patches (which make no sense as 6.11 is long
> end-of-life)

Ah, sorry, it seems those were left in my maildir from a previous 
format-patch as I invoked send-email ./* ...

> and a "resubmit?" for 6.6, but no explaination as to _why_
> this is being resubmitted here, or in the patches themselves.

I submitted it to 6.6 once here, but it got rejected because it wasn't 
in 6.11.y and 6.12.y:
Link: https://lore.kernel.org/netdev/2024120204-footer-riverbed-0daa@gregkh/

Since then, it got into 6.12.y, and - as you said - 6.11 got EOL, before 
it could ever get this patch. So I thought to resubmit it for 6.6, as 
that's the version that is of interest to us.

> Two different branches in the same series is also really really hard for
> any type of tooling to tease apart, making this a manual effort on our
> side if we want to deal with them.
> 
> What would you do if you got a series that looked like this and had to
> handle it?  Would you do what I'm doing now and ask, "What in the world
> is going on?"   :)
> 
> Please be kind to those on the other side of your emails, make it
> blindingly obvious, as to what they need to do with them, AND make it
> simple for them to handle the patches.
> 
> Series is now deleted from my review queue, sorry.
> 
> greg k-h

Sorry for the confusion. So, should I submit the series yet again, 
without "resubmit" (and, obviously, without the left-over 6.11 patches)?

Bence


