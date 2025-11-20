Return-Path: <stable+bounces-195224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 165A1C722E0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 05:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2AF435307D
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 04:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19B2C0F73;
	Thu, 20 Nov 2025 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOD8j1Pk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D582135CE;
	Thu, 20 Nov 2025 04:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612531; cv=none; b=JsDuyjCqU5AedNv1WQAAmttfmgsV71mFEB/u3ESrVRHGnL/JvyZ//GV9SUo79lQw2Ee0Fdu8o8JV9xFkkZCpAjKebpk1oWQ8uH/Ho/8CSmJ6RFutwiAW8GjRe8lJJRCEIQUTsGQxO0yuPyve3OBskRk3UZpjsALG0KkyIvEpa34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612531; c=relaxed/simple;
	bh=bHoA5YIj8f9goOT8x55+QH3KcEvt0Aw7nd4f8ohSWh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOiXrFbUyKtdrDcwSkQfy1IRUnBZDB9wGw9PnVUy5xbj/WLoQSelb/G2tF4pj9SZHf9zcCGauil84cX7qTIyZGzfQx+EpM2QiqBFTgmDpiCc4w5w44CFv5vjS2AhpuOfncM5U5/pAx75E2XAfWLSOiZ+E4u5psXXzhYXhCztjqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOD8j1Pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89AAC4CEF1;
	Thu, 20 Nov 2025 04:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763612530;
	bh=bHoA5YIj8f9goOT8x55+QH3KcEvt0Aw7nd4f8ohSWh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOD8j1PkS8DZ1TBDONiAouELH6FJYLNOciUm0jBbEz9FAlv0lDup/VMPszLHfvpnm
	 KKczo6ZDlen8eEFkwdCbgg5PN/VUYG2l1hnKB9BukJfhbmYJJiMy0UiFA6Mvd1PZKK
	 5CUryRCbAumEhUBGH7ZRDtATyExuVAWSfmQ+ivOuOwwTOOqbKgcvAfaDbG9cJSomUC
	 LdRQ75SPMBvnOepV2C2MVJE2smWWozW9FA5obWV25utUzK/4UuNazEWmLg93B/89WZ
	 HripqdmXbJXfwSfBN+T8xqxJrjoaqzmVIYispRr1uHAM8ZATtQdQmdITHNmf4Ngiv2
	 MZPu3datVgTjA==
Date: Wed, 19 Nov 2025 20:22:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Arun
 Ramadoss <arun.ramadoss@microchip.com>, Pascal Eberhard
 <pascal.eberhard@se.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 4/5] net: dsa: microchip: Free previously
 initialized ports on init failures
Message-ID: <20251119202208.1b0f5a3a@kernel.org>
In-Reply-To: <20251118-ksz-fix-v5-4-8e9c7f56618d@bootlin.com>
References: <20251118-ksz-fix-v5-0-8e9c7f56618d@bootlin.com>
	<20251118-ksz-fix-v5-4-8e9c7f56618d@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 17:13:25 +0100 Bastien Curutchet (Schneider
Electric) wrote:
>  			if (dev->info->ptp_capable) {
>  				ret = ksz_ptp_irq_setup(ds, dp->index);
> -				if (ret)
> -					goto out_pirq;
> +				if (ret) {
> +					ksz_irq_free(&dev->ports[dp->index].pirq);
> +					goto port_release;

please jump to the correct location in the unwind loop
it's perfectly normal for kernel code

> +				}
>  			}

