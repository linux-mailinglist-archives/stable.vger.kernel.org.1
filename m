Return-Path: <stable+bounces-164845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A2B12C67
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 22:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECF43B9BA4
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 20:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920A288C8C;
	Sat, 26 Jul 2025 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4eLVdoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C61EBA07;
	Sat, 26 Jul 2025 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562978; cv=none; b=u0JFepTIFHZQ0zBV8vhYYe8j3B25EpF39n4W2JBGFIENxuK2BgCaYwbUAh30at7bpXu8EvltKgXdlPanulJVLaAreviWUusxLqalxlkTFbXUGVog/OKaQ2IHgtQ8KbhyIInyMXlsQqIa5GHoT4+3pdrE4iX3VPe9kEug7u+2+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562978; c=relaxed/simple;
	bh=8RQSyduisEjaFCXXGjc4tFGELVGdjHec542mvpUvWWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWokEHWjs50+wGu9wkjvMEZoYTPJ/Db+8NxvY2U77DQMi7SSJAtRSQ0Ir/K7jN1rWy+6RUnTEDOnWxHC96vuh0t5S+3UE7yVDbn7+ug5dMElASB6rCZ5m4ho1UxgVPkdYxzS3G0kFQJWTcdyqzBh8ImH44VSm5vfm1YrobvPmkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4eLVdoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E07C4CEED;
	Sat, 26 Jul 2025 20:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753562977;
	bh=8RQSyduisEjaFCXXGjc4tFGELVGdjHec542mvpUvWWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I4eLVdoYqH2yrUtW/0s/rIIthbUAuelWVtKLp6SZ6K4OPZTFY2wgbyR0fsY2yhc/k
	 IwmHn8lge+pQlELZN+QDSBrHvQE86caxHx0R8L8mw8/DLvxqr9Kj7moLfGS2IZUHZh
	 vJpR2cnZHUmPQYgJJnCoPvMJ/wRXG4uAn5S7WMlTyjTW01/FqiicJR1BuOrmx15gU2
	 S1wlpzyrLcvUULbIkKR6v3gAiTPJM1V88yFzXCY6oEZ9N9Y7J016LswvlufqZfcJ24
	 20hhbhs2u1GLdskOf1JE5qAfdRWaAJiiDzVzFCnLl6k7sykLwn2JPrh3EpiU0U4Sh3
	 M5Kolo9vR0cbw==
Date: Sat, 26 Jul 2025 21:49:31 +0100
From: Simon Horman <horms@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH 3/5] net: gianfar: fix device leak when querying time
 stamp info
Message-ID: <20250726204931.GS1367887@horms.kernel.org>
References: <20250725171213.880-1-johan@kernel.org>
 <20250725171213.880-4-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725171213.880-4-johan@kernel.org>

On Fri, Jul 25, 2025 at 07:12:11PM +0200, Johan Hovold wrote:
> Make sure to drop the reference to the ptp device taken by
> of_find_device_by_node() when querying the time stamping capabilities.
> 
> Note that holding a reference to the ptp device does not prevent its
> driver data from going away.
> 
> Fixes: 7349a74ea75c ("net: ethernet: gianfar_ethtool: get phc index through drvdata")
> Cc: stable@vger.kernel.org	# 4.18
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


