Return-Path: <stable+bounces-106192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE19FD238
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 09:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AFB1883962
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0BA15383A;
	Fri, 27 Dec 2024 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="NDNJRDDn"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7F1876
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735289214; cv=none; b=I+BKyteolbXRmbT1domJjbu+OjU64VctwyDb6ZQ5gdVtDitmmEeMoXAFmM1XP9mdTyyY2/2OapWNdAeHfO9oeM/cDVEsd6D8qOaqvr9B1Shc6Gqg2q7n18oIEelVutCTr+GkLPtA8gPZaW0GY9GXmoNjnqV7ylGccmkZdLTOSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735289214; c=relaxed/simple;
	bh=CLaRTwNrBEuvYmMR2ZHeWDlLDsqiojHM+Zpk2bGtvqI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gY7+9tKvRcn0VRAdJniy+HNnrFfNH3/+ROPfevPQOu1uHp0z3EkuyAwHZeutAT9bfM34JJLl7RqrYeBrqSHW2dyiejkubvlupcAexeNztUjpwcO5yzJoUCyMg/7xM9B9BYruQF53NUskcjbFc8pzSHUlx3rtQYcCgANFmTDJ+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=NDNJRDDn; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id R0UZtaiuanNFGR5y7tWgU0; Fri, 27 Dec 2024 08:45:15 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id R5y5tHcbNcEKuR5y6t2kuO; Fri, 27 Dec 2024 08:45:15 +0000
X-Authority-Analysis: v=2.4 cv=Z7YnH2RA c=1 sm=1 tr=0 ts=676e691b
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=-pn6D5nKLtMA:10 a=NEAV23lmAAAA:8
 a=oIXfh7CG2JD6673A1wUA:9 a=QEXdDO2ut3YA:10 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CbHybnIOXmlSwaXNoaXYOUqH0/mYuZ8kkjuKjW87omQ=; b=NDNJRDDnw/y2q/XpMHCG2FL1sK
	oITjouXaGaiFTHEqjQ1JABwZmQ0zzYnzoflffHMbU1Pjkj15KTHaR7OyQNyL4t7Ldkku8gntKicsO
	nFBwg3skiPmnF+9QeKVeYfiIZjA+tjRroZ/t8+gAlEqXfTdHol7mNAYzGekP6uIRKCy7HdIfVFqgg
	nnm+VYrMucoVSeE+0O388Pz3oumqegJkOKSsrN/SP8rkh7MgdPwt86JlP2uH5MgmOvAAYhmVWmWEZ
	0y7OPy/Uj+4Z58HzetcOlpOv9tfweAhraj0p/KWJkKCX5dSIAHFhLZYOLEn0CGAUaoJdk1pbK5LvK
	zh0wxk8Q==;
Received: from [122.165.245.213] (port=48506 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tR5xx-003AmV-0N;
	Fri, 27 Dec 2024 14:15:05 +0530
Message-ID: <9415ca9c-f303-4507-8cd6-cb08ee09e988@linumiz.com>
Date: Fri, 27 Dec 2024 14:14:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: a100: enable MMC clock reparenting
To: Chen-Yu Tsai <wens@csie.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yangtao Li <frank@allwinnertech.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Cody Eksal <masterr3c0rd@epochal.quest>
References: <20241109003739.3440904-1-masterr3c0rd@epochal.quest>
 <173124139852.3585539.10704015898700065278.b4-ty@csie.org>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <173124139852.3585539.10704015898700065278.b4-ty@csie.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tR5xx-003AmV-0N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:48506
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 1
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCANQwNbMd9PDTR5LxbA+nsbBPBdSk9uKWhsBxt+PkAQvm1riRDZtpOmSONVD8QbDixQk/gbU6obKVYW283rzFmYTw7y/CyjI0kJHFTieclKbLSdKl3W
 /arRDXiQMylHqwPjfm4jaCFZzycuYyxcfRS+IDFw6PB5/PhMg2fhUam5J76uiMXdlH3cLWxlHD4Ul7NFowzdJebtVUu55KzdgeA=

On 11/10/24 5:53 PM, Chen-Yu Tsai wrote:
> On Fri, 08 Nov 2024 20:37:37 -0400, Cody Eksal wrote:
>> While testing the MMC nodes proposed in [1], it was noted that mmc0/1
>> would fail to initialize, with "mmc: fatal err update clk timeout" in
>> the kernel logs. A closer look at the clock definitions showed that the MMC
>> MPs had the "CLK_SET_RATE_NO_REPARENT" flag set. No reason was given for
>> adding this flag in the first place, and its original purpose is unknown,
>> but it doesn't seem to make sense and results in severe limitations to MMC
>> speeds. Thus, remove this flag from the 3 MMC MPs.
>>
>> [...]
> 
> Applied to clk-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!
> 
> [1/1] clk: sunxi-ng: a100: enable MMC clock reparenting
>       commit: 3fd8177f0015c32fdb0af0feab0bcf344aa74832
This commit is missing in 6.13-rc4. Will it be merged in the next rcX?

Thanks,
Parthiban
> 
> Best regards,


