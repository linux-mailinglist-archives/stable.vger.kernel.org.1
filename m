Return-Path: <stable+bounces-62898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2476D941620
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE7011F2526A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33191B583E;
	Tue, 30 Jul 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjqtR9qv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60F29A2;
	Tue, 30 Jul 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354994; cv=none; b=Fu9DrOw3nniJV7nO/e4sGIlpsspPC3viTcXLtguuXkcNsJ8YQjKdCEZhSvuehyVFeFima8ML03CT9nlnG5TjOrz64ZH2X8l24mpGJZ+nNXXUpnpQHpTpI022j9kCgAJO+lvH+2EX/eVkln+STMqKsdmDIxJy6NJyEAivNPvo1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354994; c=relaxed/simple;
	bh=8CuFTMoQBnrtRBkUggxshUDoWUpQGu2HjJyh4gH80Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghodh3vASlQwFzURXq8Rnxz9Ts4dpw/EfPH7K50evjxlSQ+Ki6oHVtp+brtHWHB2R9D+yWzyjOfM/T3wyIQeYFdjhV1A/fI8iu3coZQKRdg6uhdw06hA07tVapVkMajKOofL4M8CNyckuQZR5BExZppt0PoHsl44Uwjgu6H5go8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjqtR9qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C743BC32782;
	Tue, 30 Jul 2024 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722354994;
	bh=8CuFTMoQBnrtRBkUggxshUDoWUpQGu2HjJyh4gH80Mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KjqtR9qv5UM8+ljLItAIdwvv9zglpbdEDAbUJFlBDhczu7WZ6DgjptPvtuSCpgSU2
	 /79F3CwhyJjC7eZ8e0rFF0j8xBaHZ8ohimE0aFnU/btHPgphNjysHQICXPoEhV64zd
	 ujX/Ei1qebabKrfxGHH3WdcfZhAl5aeLJgRuDr6cjEfS82sf3CGAXE0TYHRlMlighD
	 KALwCyoZsZhNjRTdfLUP8ZpFA5HnvewhWvclubuMMaj8Dyv4Z4jXn3yWDq09X8ndXB
	 vVc09H2fcqBuIJJylREg8qVt/GjGZk8My2f0PJ8Y7whd8z2CHmlBgyaFjUiD6fSTtz
	 yRfvVsyVTwFUQ==
Date: Tue, 30 Jul 2024 08:56:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horatiu.vultur@microchip.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net V1] net: phy: micrel: Fix the KSZ9131 MDI-X status
 issue
Message-ID: <20240730085632.1934ae5f@kernel.org>
In-Reply-To: <20240725071125.13960-1-Raju.Lakkaraju@microchip.com>
References: <20240725071125.13960-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 12:41:25 +0530 Raju Lakkaraju wrote:
> The MDIX status is not accurately reflecting the current state after the link
> partner has manually altered its MDIX configuration while operating in forced
> mode.
> 
> Access information about Auto mdix completion and pair selection from the
> KSZ9131's Auto/MDI/MDI-X status register
> 
> Fixes: b64e6a8794d9 ("net: phy: micrel: Add PHY Auto/MDI/MDI-X set driver for KSZ9131")
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>

LGTM, can we get an ack from PHY maintainers?

