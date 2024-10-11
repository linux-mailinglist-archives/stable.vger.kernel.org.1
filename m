Return-Path: <stable+bounces-83481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4B299A8F5
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 18:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D313C285DAB
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31541993B1;
	Fri, 11 Oct 2024 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="IKiP8E9a"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7B198840;
	Fri, 11 Oct 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664517; cv=none; b=tslAdcO1u2OjzCRNCjuOkPOq9Ya0jyKjoTenyGRvp1CBOWQ3HhlFDYfA9Y9mqLGoC1mhWe9MhemhZGmBpE2mc0DJRml6UCwJcShUUTyL2D2R39YeoVx8boQPe0kUnHFNk/qJl68zU9GmmXxq0hVc4NJC3cxlqd3hdlcSwiqRDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664517; c=relaxed/simple;
	bh=eAHxM/0RfvsWGDdMjPNChPQgNfkEu5q8bkdLnbGmxoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIE0hZsse+l44L8qvvK+KZjQe4WCXmdZMuHshLUYI+IJ05mWXfPddxE51m/To9WoAoDPScRo1cyk3D3cTrBkzOLd+xnbc64fDR0sg2Oj82QHAtFDmUqsIURqV13/xzeq8NfV+2INjAI3lL0RKGgdJB3q6gWnkMJxXs+txtAV4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=IKiP8E9a; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bUYpKd1S8uep3qSusAJs52M2QZgjsVJCe2Klh66jzFE=; b=IKiP8E9aWJBg3G2HiMKZOaudPc
	VFPo4QEkc1RSMj9/vpLobPl7uIq+2oBrltwqcARRR6m4w6D6DqUdTzNITDofNozwJ8duuef80IOjK
	d9M+duanqyqU1AZ52xkTqEAHZB+yfHxUeO1V9AzLXU75uA0JC3Xok0RlLKbdpgAxDbITeFJLZ3ro1
	nCdveq5mg3mqW7u2DdXL2Em7xyMrvZxvb7hAL0dHxCXM28z3bmskwx+qYe9ugDyE2GvpXsu7vlhte
	lGsAzinkBiV86h+ezE4RGFmepyx71SCLyS/nZmsuz9ORWZTjQ/8fpqT+UfieQc9WVE/m/l9RJPzUg
	BsJh86hw==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1szIbg-0008Aq-34; Fri, 11 Oct 2024 18:35:12 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Prevent thermal runaways in RK3308 SoC dtsi
Date: Fri, 11 Oct 2024 18:35:11 +0200
Message-ID: <3125164.CbtlEUcBR6@diego>
In-Reply-To: <172859192266.2746127.3378168630215627036.b4-ty@sntech.de>
References:
 <d3e9dc4201d38894b09f3198368428153a3af1a4.1728555461.git.dsimic@manjaro.org>
 <172859192266.2746127.3378168630215627036.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 10. Oktober 2024, 22:27:44 CEST schrieb Heiko Stuebner:
> On Thu, 10 Oct 2024 12:19:41 +0200, Dragan Simic wrote:
> > Until the TSADC, thermal zones, thermal trips and cooling maps are defined
> > in the RK3308 SoC dtsi, none of the CPU OPPs except the slowest one may be
> > enabled under any circumstances.  Allowing the DVFS to scale the CPU cores
> > up without even just the critical CPU thermal trip in place can rather easily
> > result in thermal runaways and damaged SoCs, which is bad.
> > 
> > Thus, leave only the lowest available CPU OPP enabled for now.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: rockchip: Prevent thermal runaways in RK3308 SoC dtsi
>       commit: 864f1a5b390278a4a8d4a6d7425c7022477c6c9f

as discussed in the other replies, I've dropped the patch again


Heiko



