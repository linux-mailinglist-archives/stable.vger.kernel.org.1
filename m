Return-Path: <stable+bounces-111785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9E6A23AF0
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52E03A550C
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD0215E5C2;
	Fri, 31 Jan 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ml2ASgZn"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F914D6EB;
	Fri, 31 Jan 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738314090; cv=none; b=kDHygLAUmUdp8Tkt44gCdj0aEi2NJ1SaoinFvqi+UF6EpF6/3oOWsIUBfHpXKC5MJGDYRWyY30GL6VCnXg4va35/EUhissdlwB05gTkk1IU6OA01gzqSdXZIM2Ei5WzlOiZ1M6/YJdddPFz6+OwoxGf4EawykmNmC7GLrD8PU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738314090; c=relaxed/simple;
	bh=kItDpugYx6gRCn88QbwT9UzP15ysFUO0qUNXJ/SQQQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apMGeKz9pq2Chyx3Rl61fzWMN9dV2q6sSymGMOaOSnJcDG8rGnjdiVmTkiRnh+ELoX37zjAW4as9qMvNcEwuVdP2AUfk54kxLKeKQU1Gy4rPVRv75ccgZseP2ahtbtMAFxlin4YdGktLRll8zWF4nG2wgroL2e9yGzhsUiWMasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ml2ASgZn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gPuQ7FFoVv+Rl4WcP5s1FugzEtXKc7tx/WmMwger708=; b=ml2ASgZnV+EgGke7bor0cOJ8qu
	nqvaRXgLmq+NWJ+3UgdCWZ/Wcq12PLZ4yCJTfDaSyYe0B5UPisuBZzvRy+KEo2uYDOhkyqfAF2waw
	WyqKvqYlqt1+oWRTIcqGNXSaEoU0ES/VbanxMfXOiaLDOFWGOM12CDK16nzeBcw9SWYF6PeRzWX49
	41DVqTH3rS0IlGHVtauego7qtw7kwAzug/XlouEIvKD16oY4F9bHuCc8XfOUkOQ9FhNtFWKyNYA92
	Tju2Bj71WYzenxJFQTnDbBF0MCYSTGGlpexHOPgWC46jUXCeHksozwny1XpBGs7th0b6LGHWWRGyR
	7IS8WEMA==;
Received: from [212.111.254.164] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tdmtp-00069z-RW; Fri, 31 Jan 2025 10:01:17 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Tianling Shen <cnsztl@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject:
 Re: [PATCH] arm64: dts: rockchip: change eth phy mode to rgmii-id for
 orangepi r1 plus lts
Date: Fri, 31 Jan 2025 10:01:15 +0100
Message-ID: <2910311.mvXUDI8C0e@phil>
In-Reply-To: <59e46b34e1c8f9197565fea917335d3f@manjaro.org>
References:
 <20250119091154.1110762-1-cnsztl@gmail.com>
 <98387508-10de-4c2e-80ad-05d0d86b7006@gmail.com>
 <59e46b34e1c8f9197565fea917335d3f@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hey,

Am Freitag, 24. Januar 2025, 07:35:50 MEZ schrieb Dragan Simic:
> Hello Tianling,
> 
> On 2025-01-24 07:28, Tianling Shen wrote:
> > On 2025/1/19 23:48, Tianling Shen wrote:
> >> On 2025/1/19 19:36, Dragan Simic wrote:
> >>> On 2025-01-19 12:15, Tianling Shen wrote:
> >>>> On 2025/1/19 17:54, Dragan Simic wrote:
> >>>>> Thanks for the patch.  Please, see a comment below.
> >>>>> 
> >>>>> On 2025-01-19 10:11, Tianling Shen wrote:
> >>>>>> In general the delay should be added by the PHY instead of the 
> >>>>>> MAC,
> >>>>>> and this improves network stability on some boards which seem to
> >>>>>> need different delay.
> >>>>>> 
> >>>>>> Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi 
> >>>>>> R1 Plus LTS")
> >>>>>> Cc: stable@vger.kernel.org # 6.6+
> >>>>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> >>>>>> ---
> >>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 3 
> >>>>>> +--
> >>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts     | 1 
> >>>>>> +
> >>>>>>  arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtsi    | 1 
> >>>>>> -
> >>>>>>  3 files changed, 2 insertions(+), 3 deletions(-)
> >>>>>> 
> >>>>>> diff --git
> >>>>>> a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
> >>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
> >>>>>> index 67c246ad8b8c..ec2ce894da1f 100644
> >>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
> >>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
> >>>>>> @@ -17,8 +17,7 @@ / {
> >>>>>> 
> >>>>>>  &gmac2io {
> >>>>>>      phy-handle = <&yt8531c>;
> >>>>>> -    tx_delay = <0x19>;
> >>>>>> -    rx_delay = <0x05>;
> >>>>>> +    phy-mode = "rgmii-id";
> >>>>> 
> >>>>> Shouldn't the "tx_delay" and "rx_delay" DT parameters be converted
> >>>>> into the "tx-internal-delay-ps" and "rx-internal-delay-ps" 
> >>>>> parameters,
> >>>>> respectively, so the Motorcomm PHY driver can pick them up and
> >>>>> actually configure the internal PHY delays?
> >>>> 
> >>>> The documentation[1] says "{t,r}x-internal-delay-ps" default to 1950
> >>>> and that value already works fine on my board.
> >>>> 
> >>>> 1. https://www.kernel.org/doc/Documentation/devicetree/bindings/net/ 
> >>>> motorcomm%2Cyt8xxx.yaml
> >>> 
> >>> I see, but those values differ from the values found in the
> >>> "tx_delay" and "rx_delay" DT parameters, so I think this patch
> >>> should be tested with at least one more Orange Pi R1 Plus LTS
> >>> board, to make sure it's all still fine.
> >> 
> >> This patch has been tested on 2 boards, and we will do more tests in 
> >> next week.
> >> 
> > 
> > Managed to test on another board and looks so far so good.
> > (Working network connection, no packet drop)
> 
> Sounds good to me, thanks for the additional testing.

I assume that means there are no more open issues, right?
At least I got that impression from glancing at the thread :-)

Heiko



