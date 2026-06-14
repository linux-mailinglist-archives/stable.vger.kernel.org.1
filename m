Return-Path: <stable+bounces-263093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JJdaCy8pL2qQ8QQAu9opvQ
	(envelope-from <stable+bounces-263093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 00:20:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B41F368265C
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 00:20:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Pk+PbvAQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263093-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263093-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14F183001FEF
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC84E37CD2F;
	Sun, 14 Jun 2026 22:20:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF6292B54;
	Sun, 14 Jun 2026 22:20:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475627; cv=none; b=n2hzQDf0w5FH23aq+rqYtbTzOKZIPLCY0F85T8xlGAedBGxflsVCB1wz4GodMtSHDI+Ru1FeMREIqV3ASFRrd+ldG3G4zsUSQxRzvtm3EI5XA/6udCAsO41ixKnJ/ekffSLF0T67b3Vx32pogX65O5PIKgWu2qsksSb4n54Nd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475627; c=relaxed/simple;
	bh=AolzJ5fBKCYhdZoy8bTLrjEDJd4XB/zbqN6ZB63xKyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpPtA0nlyGckXCDD+JVm0f1BjqQzr1W7H4xWzYKxuJkVpEnGBr/xZyJMzh9TA+CXTMiOK4DQGWfskl3GEKKzvPM5o6ph/ZpKhEhJeIDKwOGVWZF7AR8twUyPc9VfrHllyIxpoePaesiF4AG1ucuEQjCj0pNoscmvWEZq+jY124Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk+PbvAQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2474C1F000E9;
	Sun, 14 Jun 2026 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781475626;
	bh=7RDOpRHXsto/ZnZ2BpjuO3i0UoV7uNmp1csBtkTg2I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pk+PbvAQog32lrbAeLhyfFZRdotgRwJRA1rtRd9LNXuh1UGqwuW6tP6p5vMmdWJ05
	 nAAKVx2vh77PZThJWidRzxlpmog9S3x/hpE3pRiZWSg5IYrdmMnqVuEud1HKr1xzei
	 186KjRZjhSXxiSm05dgb1CLShHW1x/u47FAOkISaFjRjzKqGQbWND3jBADRVPwFobl
	 my+NJDRgFV/r01dr6QLOXteOs/yDysxqNkFAqK830UUymDlUoQQVK2vtgxnefmQlBG
	 NRrj6/Kddf4Ace8BhzhxyqeOZBooxM23swbnVklJPRA6qbpmcO9QtYTcq8g0q1icz9
	 NJb9eKmlGjWnQ==
Date: Mon, 15 Jun 2026 00:20:21 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
Message-ID: <ai8o9vxUX6rbZNV4@zenone.zhora.eu>
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
 <20260608024533.32419-3-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608024533.32419-3-wanghongliang@loongson.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263093-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:wanghongliang@loongson.cn,m:zhoubinbin@loongson.cn,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wsa+renesas@sang-engineering.com,m:linux-i2c@vger.kernel.org,m:devicetree@vger.kernel.org,m:loongarch@lists.linux.dev,m:chenhuacai@loongson.cn,m:stable@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable,dt,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B41F368265C

Hi Hongliang,

On Mon, Jun 08, 2026 at 10:45:33AM +0800, Hongliang Wang wrote:
> The i2c-ls2x driver supports dts and acpi parameter passing.
> 
> In dts, uses clock framework, by parsing clocks property to
> get i2c bus reference clock, and define the div of reference
> clock by device data.
> 
> In acpi, by passing clocks property to describe i2c bus reference
> clock and clock-div property to describe the div of reference clock.
> 
> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> and div, calculate the prcescale of i2c divider register. The
> calculation formula is
> 
> prcescale = (clock_a*10)/(div*clock_s)-1
> 
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

I think Huacai has not reviewed this patch, his review was only
for patch 1. Am I right?

Andi

