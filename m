Return-Path: <stable+bounces-61433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D401193C3BA
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C25280F6A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213E16DEA8;
	Thu, 25 Jul 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="aXma48aL"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC74219B3D7
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916500; cv=none; b=rlSz0T4BzHwmxYIAd/KpYmRGRPX+HFd4nWGUd3h8ANInkQ32DdaLkJKfiq6Chdj4IB22SnECcI4Z1F9NQg72jBFKuyLgP442J3aVpB/iPZISb4HwBd6vnvnfoJdCPzR8dkHKLxypMAyWJ9YCHfb6yQgix2XKpI8wbxmX1uLOZkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916500; c=relaxed/simple;
	bh=SADbPCxd17HIrLkpJURAjijzrsQZxo+Zf0YZKJ7WTR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3l4BxEj13oGQc+uqs+AmX52l+xj1K7Ua3uXvb3AN3RaebvQcGVKnG33HdINy6V9wqOqu0EgMvWXRmrj+p3O3Vj60QLyGTe3tqTkCeeV32GqKvU6fSDYMBelGdXcBpgGXqa9Zzrib1pM3UoPnJOoQcXYz5mp8UHhAJ/mBhZpIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=aXma48aL; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id Wkxhsm72ovH7lWz8ksSpuM; Thu, 25 Jul 2024 14:08:18 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Wz8isTzc3bFeFWz8is5iVn; Thu, 25 Jul 2024 14:08:16 +0000
X-Authority-Analysis: v=2.4 cv=dJKgmvZb c=1 sm=1 tr=0 ts=66a25c51
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=fdGasvwXBZ8LG8062yEA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UNSukhC8/XJWiqFsl1PRoBN34Cj/n6wZBImH+0eEHqg=; b=aXma48aLrxjiLwn6vTTMuFEmdc
	VZqW3FeBIBqN2H24BwRFhyL1zKgndA2E2oNQs8awmsSEYrKOIKdZ9bzgmyBgECW+FMtk4GKxyFfMl
	uwK9vz0tzxJEJCa+eRSNpo8ssslXoKnqUAdDApkmU7OwJN1FfecOyiQeqi1guAa3KYgMVxe7fp8IG
	vIPijEZ4L1HNBsFL/xWnlsKLYCVA0FeCIsA0gbnyKBNnrdS7lRt5AoZQgMuU/baYzeaXiLFAVgE/x
	zOQgMZ8NpZjx1xNnHEtKeeSCArnBfri2tnYthD2bDGsv/N2jEVgtCm520Lhth38dr3259CSkoyrPf
	m2fqJGDw==;
Received: from [201.172.173.139] (port=54024 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sWz8h-0019bE-2f;
	Thu, 25 Jul 2024 09:08:15 -0500
Message-ID: <906edca8-a357-4fc2-913d-be447a86963c@embeddedor.com>
Date: Thu, 25 Jul 2024 08:08:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ALSA: firewire-lib: heavy digital distortion with
 Fireface 800
To: Takashi Iwai <tiwai@suse.de>, "edmund.raile" <edmund.raile@proton.me>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org,
 regressions@lists.linux.dev, o-takashi@sakamocchi.jp, gustavoars@kernel.org,
 clemens@ladisch.de, linux-sound@vger.kernel.org
References: <rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2>
 <87r0bhipr7.wl-tiwai@suse.de>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <87r0bhipr7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sWz8h-0019bE-2f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.139]:54024
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGLnE2vUERgbAg/ASY0wiTbAS6m6SRA8x+AZP970/kwIdYFr3p4p0s0f2coJueWfvKYK6/7y5nYgMdA4HmZzmb34QopBxxvlddWOOh17G0uu8F3rjI5n
 3OZeehMjtCl1U6e1FwTJ5+a4+FfgpA/NAZFN67n00wVjLWMmDyiDtZDZgvftZJWu7q3FDdndH/Baxd/nIw68rRe3j7ghUSmPypk=

Hi!

On 25/07/24 07:07, Takashi Iwai wrote:
> On Thu, 25 Jul 2024 00:24:29 +0200,
> edmund.raile wrote:
>>
>> Bisection revealed that the bitcrushing distortion with RME FireFace 800
>> was caused by 1d717123bb1a7555
>> ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning").
>>
>> Reverting this commit yields restoration of clear audio output.
>> I will send in a patch reverting this commit for now, soonTM.
>>
>> #regzbot introduced: 1d717123bb1a7555
> 
> While it's OK to have a quick revert, it'd be worth to investigate
> further what broke there; the change is rather trivial, so it might be
> something in the macro expansion or a use of flex array stuff.
> 

I wonder is there is any log that I can take a look at. That'd be really
helpful.

Thanks!
--
Gustavo

