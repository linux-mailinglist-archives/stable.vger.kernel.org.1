Return-Path: <stable+bounces-77763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F5E986F3D
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 10:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92442B2131B
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAE41A4E9A;
	Thu, 26 Sep 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="s1kD5Zj9"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0B22318;
	Thu, 26 Sep 2024 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340491; cv=none; b=ZWWLmo21krWZktHJVu9de9ZqMD+trpeY95vrtJiQJ5d/ANAj4Wxu/5pg2MH4PwgfF1exhNMOrH7er6EAhJaojuoSW+pkumPMOHnCGITJxfsJX76DYQ8/AlrwEpm1nwSsNlYUKHg5SY32+wPtX/BXIiPfYfad5FWjgSuD9DoA/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340491; c=relaxed/simple;
	bh=IlvTv+4FiylnLOkPfoXKqabv+lAAaCMaWT2hbw/wMf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Saj2BpXBeYzFn/7n+lXSLgdw2+I6sMY1VUyWrf4HcvLupR3f+Dqqryt4278xFxfsIGF8/PEygm7I75Ptjp1e0JueaRZWLwNshA+NGYzctpMvypBbJsfDLOiJjWrmQKqYYuiU0ltHrLxXYsw6zR8+4CjZTq9s1dGr+0lTgVKCN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=s1kD5Zj9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r7Psuo5wLjW5qDjj4cW4p0k9wjcIcrFjFZh9XT4IWKc=; b=s1kD5Zj9ZV+D6q3RCSz0reepXW
	AAjinTmt/yMIiUfKOvfGGDWWz8aP5rjx6emWa1xsQWx5prhKCvTsDYuyqLcTOj70uQq2OeWRM1kS4
	apv1TFrDlp3jnEM+9XBQkFqqQUKBl1tiN5N0eK4drmVtEuXPnJQi+n36PltVfz7kZ/KImQISzEzyC
	I2DwxfkbgV6mmqs1RQxskhphC/mLGYRPX9tUy1Qrs7yJ1i6PTfiza42h35drXL2oUJSYY1ZfQOEdR
	FORCpayp5FBT1lYBHsBU44I6JcQB0mZ94iIuYACLFiNqibHOuhB2wPBNV519nMGp2jRkkR3mYmUOe
	zFYpBgmA==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1stkAO-0001nb-Hi; Thu, 26 Sep 2024 10:48:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Move L3 cache under CPUs in RK356x SoC dtsi
Date: Thu, 26 Sep 2024 10:48:03 +0200
Message-ID: <2007608.CrzyxZ31qj@phil>
In-Reply-To: <57d360d73054d1bad8566e3fe0ee1921@manjaro.org>
References:
 <da07c30302cdb032dbda434438f89692a6cb0a2d.1727336728.git.dsimic@manjaro.org>
 <3938446.fW5hKsROvD@phil> <57d360d73054d1bad8566e3fe0ee1921@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 26. September 2024, 10:32:17 CEST schrieb Dragan Simic:
> Hello Heiko,
> 
> On 2024-09-26 10:24, Heiko Stuebner wrote:
> > Am Donnerstag, 26. September 2024, 09:49:18 CEST schrieb Dragan Simic:
> >> Move the "l3_cache" node under the "cpus" node in the dtsi file for 
> >> Rockchip
> >> RK356x SoCs.  There's no need for this cache node to be at the higher 
> >> level.
> >> 
> >> Fixes: 8612169a05c5 ("arm64: dts: rockchip: Add cache information to 
> >> the SoC dtsi for RK356x")
> >> Cc: stable@vger.kernel.org
> > 
> > I think the commit message needs a bit more rationale on why this is a
> > stable-worthy fix. Because from the move and commit message it reads
> > like a styling choice ;-) .
> > 
> > I do agree that it makes more sense as child of cpus, but the commit
> > message should also elaborate on why that would matter for stable.
> 
> Thanks for your feedback!  Perhaps it would be the best to simply drop 
> the
> submission to stable kernels...  Believe it or not, :) I spent a fair 
> amount
> of time deliberating over the submission to stable, but now I think it's
> simply better to omit that and not increase the amount of patches that 
> go
> into stable unnecessary.
> 
> Would you like me to send the v2 with no Cc to stable, or would you 
> prefer
> to drop that line yourself?

I'm hopeful that I'll remember to drop it :-), so I guess no need
to resend for that.

Heiko



