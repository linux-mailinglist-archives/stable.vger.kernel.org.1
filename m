Return-Path: <stable+bounces-40333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F24F8ABB85
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 14:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1165281D8B
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 12:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7227F376FE;
	Sat, 20 Apr 2024 12:27:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD572563;
	Sat, 20 Apr 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713616050; cv=none; b=LFy1PmLHTk3nseQvbsZd477ly41vNJ7OnTL2k205PGSUEtOe8cw5Oy50hPpprBbIefvGRr3zYF4dciyMeCgT9VcVzXOBPGLtyXla52/nVyxxhskwOjpZywpxqQM79B0BgBgft+O+P+bKgMkMPYKVoJyo29DoArrLPf5Z4sVixRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713616050; c=relaxed/simple;
	bh=DUh40Uht4oyFq7XVb+Uzeh3zDYZFen1WhM2fMtWNaTc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CaA6+b5TXjCW0jP+yJ9Hy8LmYq2hVDdCzRja4FaBJ7tz749YxSMnRTVJDuWMlQTOSEAOIOBzv0jGvDopyBqJQVm/gJnPIb/IXO3GCiX4Ry4hkS8JhQ/oLIumrnBpYsAon/VTwnxB21V/WXESEwEjjxTmox0wLDjxHA7Q1p24M+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.80.200) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 20 Apr
 2024 15:27:16 +0300
Subject: Re: Patch "ravb: Group descriptor types used in Rx ring" has been
 added to the 6.8-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>,
	<niklas.soderlund+renesas@ragnatech.se>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20240419114711.977309-1-sashal@kernel.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <344fc08f-2f4b-17db-2b53-784e5744aa2f@omp.ru>
Date: Sat, 20 Apr 2024 15:27:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240419114711.977309-1-sashal@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/20/2024 12:11:02
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184817 [Apr 19 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 18 0.3.18
 b9d6ada76958f07c6a68617a7ac8df800bc4166c
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.200 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;www.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.200
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/20/2024 12:16:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/20/2024 10:19:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 4/19/24 2:47 PM, Sasha Levin wrote:

> This is a note to let you know that I've just added the patch titled
> 
>     ravb: Group descriptor types used in Rx ring
> 
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ravb-group-descriptor-types-used-in-rx-ring.patch
> and it can be found in the queue-6.8 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit fb17fd565be203e2aa62544a586a72430c457751
> Author: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Date:   Mon Mar 4 12:08:53 2024 +0100
> 
>     ravb: Group descriptor types used in Rx ring
>     
>     [ Upstream commit 4123c3fbf8632e5c553222bf1c10b3a3e0a8dc06 ]
>     
>     The Rx ring can either be made up of normal or extended descriptors, not
>     a mix of the two at the same time. Make this explicit by grouping the
>     two variables in a rx_ring union.
>     
>     The extension of the storage for more than one queue of normal
>     descriptors from a single to NUM_RX_QUEUE queues have no practical
>     effect. But aids in making the code readable as the code that uses it
>     already piggyback on other members of struct ravb_private that are
>     arrays of max length NUM_RX_QUEUE, e.g. rx_desc_dma. This will also make
>     further refactoring easier.
>     
>     While at it, rename the normal descriptor Rx ring to make it clear it's
>     not strictly related to the GbEthernet E-MAC IP found in RZ/G2L, normal
>     descriptors could be used on R-Car SoCs too.
>     
>     Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>     Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>     Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>     Stable-dep-of: def52db470df ("net: ravb: Count packets instead of descriptors in R-Car RX path")

   Hm, I doubt this patch is actually necessary here...

>     Signed-off-by: Sasha Levin <sashal@kernel.org>

[...]

MBR, Sergey

