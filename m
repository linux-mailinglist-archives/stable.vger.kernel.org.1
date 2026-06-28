Return-Path: <stable+bounces-269577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h6EJB3ByQWpZqwkAu9opvQ
	(envelope-from <stable+bounces-269577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 21:13:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4FC6D4B69
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 21:13:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=o8vyMWwP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269577-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269577-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121E23013A9C
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CE3126AD;
	Sun, 28 Jun 2026 19:13:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB002262D0B;
	Sun, 28 Jun 2026 19:13:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674019; cv=none; b=G7+Sa+D7UBrNCT1MSun4zm8wAK8GA7QlWhjVpmIG91ZO5Zn6z4Ee82T8PuqOF1DMGQE3geZbyI8K/f0txFM1cQq+ug3yhKLzr8mHpf3qRAQLclzhzbEiR0s2JSiq3h7PMQPnVZIuhYL56uWOHCn5SChjKQYJphtAQvuIl6jjOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674019; c=relaxed/simple;
	bh=f0zvPyYrWMaHQwMn7JRTbhUeKXMcrorNRIVcPJcfaZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1MkutWZ9CIukqafud3rYvBwQkFZFPJx7jXAmbGaSH3aex2yLshuNkQcDLLYwSLxb5D6OBvj0GfxXatjRAwwhUY8d98MGyP5rli3ibfh9sLiSMOI3Y62+TDs1N+Vdj7gn5VMoZZwILROGKIXoj9n6ChdaQEMRdZ+r6cA/qTteP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=o8vyMWwP; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ZdaTmsRuUwlAr3UAk7TqOg1bWsvPp5lljQQumQI6/0A=; b=o8vyMWwPbG74igvWIsnM00asfz
	WD+MMBbFUyATcL8lGW3uE5VnB9CrP4qqkDPyFvXL1wdi3v08JifaWOEMCEN5VVLKSEgY+hCGloJqs
	8Of91hPQFGhzBqbgqOJZ38mepZ9Av9D7Pz3C0zN8jbqsRqeUDf4FgVSvIfmL9OrB3tMWWocPfi/zO
	1ezD960yhDJ7Nx3sBiejGpEDVA3QVpU60rWUzzx32X/Rm5QuTznbfS8RMfJfTdqs26AB2cBpEV5b6
	M528rX6lP1tRWSVhjIR0voiJ8He81MuzzZWgcnZk1p9+JOnhxY+Gz85JyGV7vD+k5BIjzyZTuBdU5
	vAObhV7w==;
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	stable@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix emmc reset polarity on px30-cobra
Date: Sun, 28 Jun 2026 21:13:25 +0200
Message-ID: <178267399837.3089434.7647542691250454782.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609081728.30616-2-jakobunt@gmail.com>
References: <20260609081728.30616-2-jakobunt@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:jakob.unterwurzacher@cherry.de,m:quentin.schulz@cherry.de,m:jakobunt@gmail.com,m:heiko@sntech.de,m:stable@vger.kernel.org,m:heiko.stuebner@cherry.de,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cherry.de,gmail.com];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269577-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[sntech.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:dkim,sntech.de:email,sntech.de:mid,sntech.de:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B4FC6D4B69


On Tue, 09 Jun 2026 10:17:25 +0200, Jakob Unterwurzacher wrote:
> Technically, the reset signal is active low - it's called RST_n after all.
> 
> But it is ignored completely unless RST_n_FUNCTION=1 (byte 162 in extcsd)
> is set in the emmc. It is 0 per default.
> 
> For emmcs that have RST_n_FUNCTION=1 we failed like this:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix emmc reset polarity on px30-cobra
      commit: 85babf47515e2adf266dcc3be9804e31f752083e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

