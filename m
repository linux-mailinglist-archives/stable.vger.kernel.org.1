Return-Path: <stable+bounces-75927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE94975EFA
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 04:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39F34B2175B
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F196D41C89;
	Thu, 12 Sep 2024 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XTczgsIE"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45547250EC;
	Thu, 12 Sep 2024 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108712; cv=none; b=FwI9kNDPgvcrmjnCS5LyHuyap5FU6yX3ejbeuzYUXzM0pu9GqojSm4STy1r1CUTyhcw8k5/UA/hCjvmoJg6yNLKiWYkbmr7SxHuh87oIWZ7y+9Fm4EV5hpIckmfPy3XH1sT9mrGjsVyBMNHO+xdS3PJG7Hz0AnQQhjvJ4gtC9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108712; c=relaxed/simple;
	bh=U1oQ8yV2876PbJ1l87fAYYB5li3P/vajQPSAI368Zec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sO1i7bdNWvUD/u4pYDJ7G/MMohQpRUjn/eh4xEmLdcVBsBBTQAmRWe86IJWWsknZ1B9FzeLF7nD+YNbKA8c8IAtntnWsp1OzkcRZQLDrHtYcsWBvP+vRsRBAFikaxq/JQp+3BzJnoiLobWdCwk36K53DBhoDiLos42xM1m4ETCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XTczgsIE; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726108706;
	bh=+pRg9X4n7TVLk4pJltxMi594tN+w+P/Lvm16g3XG4LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XTczgsIESkLqCDl6+PXig9KDrrVBh6568anOox/JcvGJ74DOi97qJDxuxSZ71ELtG
	 GwNZpvqgAaBadgn2EkFRnvBo0z6+0ySbrfUvJlLBrm+iZYKfP7M9Stw3TtSYo4/jOf
	 RDlG4Ji3lbwIDHybKtptTaM/TKq8CxSg+/toLZQE=
X-QQ-mid: bizesmtp90t1726108703t4wrs7qk
X-QQ-Originating-IP: WA3jwlK+hZurhA4Tg3wzuZx/vI63xq+b6Mf+xnbk/es=
Received: from [10.20.53.89] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:38:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15563347605386470238
Message-ID: <DBEFAD22C49AAFC6+58debc20-5281-4ae7-a418-a4b232be9458@uniontech.com>
Date: Thu, 12 Sep 2024 10:38:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 1/4] riscv: dts: starfive: add assigned-clock* to
 limit frquency
To: Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org,
 william.qiu@starfivetech.com, emil.renner.berthing@canonical.com,
 xingyu.wu@starfivetech.com, walker.chen@starfivetech.com, robh@kernel.org,
 hal.feng@starfivetech.com, kernel@esmil.dk, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 netdev@vger.kernel.org
References: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>
 <20240909-fidgeting-baggage-e9ef9fab9ca4@wendy>
 <ac72665f-0138-4951-aa90-d1defebac9ca@linaro.org>
 <20240909-wrath-sway-0fe29ff06a22@wendy>
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <20240909-wrath-sway-0fe29ff06a22@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1


On 2024/9/9 19:17, Conor Dooley wrote:
> [6.6] in the subject and Sasha/Greg/stable list on CC, so I figure it is
> for stable, yeah. Only one of these patches is a "fix", and not really a
> functional one, so I would like to know why this stuff is being
> backported. I think under some definition of "new device IDs and quirks"
> it could be suitable, but it'd be a looser definition than I personally
> agree with!
These submissions will help to ensure a more stable behavior for the 
RISC-V devices involved on the Linux-6.6.y kernel,and as far as I can 
tell,they won't introduce any new issues (please correct me if I'm wrong).
> Oh, and also, the 4 patches aren't threaded - you should fix that

I apologize for my ignorance about the correct procedure...

For instance,for these four commits,I first used 'git format-patch -4' 
to create four consecutive .patch files,and then used 'git send-email 
--annotate --cover-letter --thread ./*.patch' to send them,but the 
result wasn't as expected...

I'm not sure where the problem lies...

> WangYuli.
QAQ
-- 
WangYuli

