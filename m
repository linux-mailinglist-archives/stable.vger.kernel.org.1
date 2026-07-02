Return-Path: <stable+bounces-271544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AaTJOmW4Rmr7cAsAu9opvQ
	(envelope-from <stable+bounces-271544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 21:13:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F79A6FC71C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 21:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=fJWXkvhs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271544-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271544-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B26630C3C4B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 19:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B23845A2;
	Thu,  2 Jul 2026 19:05:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F8384CF0;
	Thu,  2 Jul 2026 19:05:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019112; cv=none; b=AZCyZWGOsJRK00Y4IS2Y0lh6YttmzWeYu2KrLHC+zXCDdgOHcgOi8Gv4QHTI5AkSfm0eBBOdJjQNi9auY6qGvrcmrAptv4Fa601fAjrIMGHeMGbT7AWp/89VU6Ds0p6jtHaW04AII3qmV1qkYvxVmFBwHp0d4zzZJMOg0Zbj5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019112; c=relaxed/simple;
	bh=PBvGKxSN3lubbQ6xO3qbDw3P1qiZKcB0tHw/YPSl8n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9d7EplyOed1nAhq+aQnqJi/e3LjuV+ebpgrmCTV+CLOsnm49/z+4980eW/RsavjQndH4acJzgLvJW3LmzUqevgfTdFFMMAybC6bRrSV5Qyf55koARD7eDZwGPp6+NdBtFE+Zmzxh0K3HAUH4PJq4mf+QM10Xw35d1Y737wAhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=fJWXkvhs; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=qi+og8zzAWmwxBq5244UzdXz2emj9itakwbhrlFY2Rg=; b=fJWXkvhsrFUM/UOKyZLZFZfBVg
	zCVaQzvT3DI3HJVrg6GGZloSryXaOGLJwnEwzR/J9CjtWNO2Lz2Iihjx+ZgsoI41Ifrd3aIXGHGTV
	+3+1tqy4VF5cGHS9WJ6w1cLfggdYqUE+8kXJ9TrxixjEx4JU51AHayan0fTn4Jj3mz9pLvNZj4aja
	i1VxQuT+y76p/zq7ncejlP4w8A7ARadsR1Xi5nRFugBOGXj8guRKVBxg1Qr5Karz3Ve/6+TtmsvFq
	vQdBB+85KKLuOUubSvkIQC7ZOat9kgZR7azHzl0E+pzPMfdgOdEj5tF9dRs3sBSThqYrr8YNLOH+x
	7fU+z35w==;
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC reset polarity on PX30 Ringneck
Date: Thu,  2 Jul 2026 21:04:52 +0200
Message-ID: <178301901902.3838694.15610180855070263903.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626-ringneck-emmc-polarity-v1-1-90cefe57b316@cherry.de>
References: <20260626-ringneck-emmc-polarity-v1-1-90cefe57b316@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271544-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:quentin.schulz@theobroma-systems.com,m:foss+kernel@0leil.net,m:heiko@sntech.de,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:quentin.schulz@cherry.de,m:stable@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:foss@0leil.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sntech.de:dkim,sntech.de:email,sntech.de:mid,sntech.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F79A6FC71C


On Fri, 26 Jun 2026 16:40:38 +0200, Quentin Schulz wrote:
> According to the Jedec 5.1 specification, the device is held in reset
> when RST_n is low, therefore the polarity of the line must be that, as
> specified in the Device Tree binding (mmc/mmc-pwrseq-emmc.yaml).
> 
> Due to the wrong polarity, eMMC devices with RST_n_FUNCTION[162]
> bitfield [1:0] set to 0x1 (the default is 0x0) will be held in reset
> forever.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix eMMC reset polarity on PX30 Ringneck
      commit: 549081d9af61cf046cac15281e9a6ceb9b2592e9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

