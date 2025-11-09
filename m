Return-Path: <stable+bounces-192861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (unknown [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB7C44880
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 22:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA960188B614
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA326CE05;
	Sun,  9 Nov 2025 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="jbwX5XIg"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AEB246BA8
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762725156; cv=none; b=G5NlOKmA1JAZ6bw6nir6xY+4pmIef2KinlUNG73KvQd5n9p+4G9IEkBkHqbenAwU8xjH2zSTRiklEhHaU9BH4gMMdXIThcOTPK2byMwW4KxAUy9u6EAn7K6SkKStmKvYVuWYJJFmgz7cyQrl6zu9kUdB/kjI/kz4XT6vXfDc5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762725156; c=relaxed/simple;
	bh=7BCLaP1uWoZlFc9CkCV6gqewDs9HCBo9HgDWPuflkVQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cb7P3oqyaac2DvsHhcp9jfaMzG4MJLCGUe2cA3kMvIteq8U17is2ksrJsxexIaRP0mm/IF8NQKh07BHO9DR1Yo0YWu1StVJriCNfSghw4liwh6ouH2JXMLsB8dnAG5sX6XpUJRfdMQf1cN45O4D5da2Zq6MPb++bQ8V4sWZbwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=jbwX5XIg; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762725142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVKL4KOVVv4PCmD5ezWsnIkKKizZfKpAXP3Rk6TFCXo=;
	b=jbwX5XIgZ8KOC3TVlB//6JQ/2kAXWBJGhA0dKdSFOqj/VDG/CeKyypetqde568lvHcMXH7
	IXVm4g5KN9LfH/87jG7giUY7IogeDCjHJyEnzmRt6+FhC6Nb5q9EDgZndFRmrQBUNlPAsz
	GexmkfW3kuSNiP+KbyGpt29nil3281My5V9ibaknzsttsbrjrEo1umJ7PC5F8s8hlh2fra
	ldeIsCdy9VsBdtjXT0Kpnmd8RpJ0R5yNW9VOElzkyTjH56yRnDFAuoLgCfkpwcq6oVdV+S
	kfWeW3TYhVTeUPwwOOtb/7nliT3Nk0VfYBy8Y+MJ51YO6E6Uo66oShq1sqHRsQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Nov 2025 22:52:13 +0100
Message-Id: <DE4HWR95IFVW.1GG1O5GO9GKKV@cknow-tech.com>
Cc: "hrdl" <git@hrdl.eu>, "phantomas" <phantomas@phantomas.xyz>, "Dragan
 Simic" <dsimic@manjaro.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fixes for PineNote DT validation issues
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "Samuel Holland" <samuel@sholland.org>
References: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-0-ed38d200cc04@cknow-tech.com>
In-Reply-To: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-0-ed38d200cc04@cknow-tech.com>
X-Migadu-Flow: FLOW_OUT

On Sun Nov 9, 2025 at 6:05 PM CET, Diederik de Haas wrote:
> These patches fix the following DeviceTree validation issues on the
> PineNote dtb files:

Please ignore this patch set. Sorry about the noise.

Cheers,
  Diederik

>     Warning (graph_child_address): /i2c@fe5c0000/tcpc@60/connector/ports:
>       graph node has single child node 'port@0', #address-cells/#size-cel=
ls
>       are not necessary
>
>     usb2phy@fe8a0000 (rockchip,rk3568-usb2phy): otg-port: 'port' does not
>       match any of the regexes: '^pinctrl-[0-9]+$'
>
> And with these 2 fixes, there are no more DT validation issues :-)
>
> The fix for the 2nd issue also fix these kernel errors:
>
>   rockchip-usb2phy fe8a0000.usb2phy: Failed to create device link (0x180)=
 with supplier port0 for /usb2phy@fe8a0000/otg-port
>   rockchip-usb2phy fe8a0000.usb2phy: Failed to create device link (0x180)=
 with supplier 3-0060 for /usb2phy@fe8a0000/otg-port
>
> Cheers,
>   Diederik
>
> Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
> ---
> Diederik de Haas (2):
>       arm64: dts: rockchip: Simplify usb-c-connector port on rk3566-pinen=
ote
>       arm64: dts: rockchip: Move otg-port to controller on rk3566-pinenot=
e
>
>  arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi | 27 +++++++++--------=
------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> ---
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
> change-id: 20251109-rk3566-pinenote-dt-fixes-upstream-1fb32eff43ea
>
> Best regards,


