Return-Path: <stable+bounces-144278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7B8AB5FF0
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 01:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD71B444AA
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 23:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E120D4FF;
	Tue, 13 May 2025 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQCFoXMM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5B3FBA7;
	Tue, 13 May 2025 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747179486; cv=none; b=Qw04KoGCpTJKjj/0crPDRB+z5F98iVWRDC7wI+LKpBA+NNiLfZ6TD7aE6CjhyLSj9p/bsmknXHzRGdRwthDIGtzbNVzBCuEf4OKZ96R86NyoW2aXwFvKCnPb853W7/rDNLQk5ETfA42lVySOIZmHjbqRTVe71dQYQXGIzRyYxOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747179486; c=relaxed/simple;
	bh=NjAKmuVrJ0UmQ2g6RUai7g83BbLQmuzfNTCwf9/RQ0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX9xxJmLcdJwIszZSh4RqW824PNY6q+MLE77W3RZigzSYHSYBF6U2nBgZ9RgzNUKOGuhymbcFLjPJsN3jrYFc3Db84/CSQMJtyCfNyL+kqMRFMeEE5CvhalurlKnui9G/DmNojoeRTzupVD+LlEIBpKVDICxq2JdCX7/2ow/rXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQCFoXMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3BAC4CEE4;
	Tue, 13 May 2025 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747179486;
	bh=NjAKmuVrJ0UmQ2g6RUai7g83BbLQmuzfNTCwf9/RQ0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQCFoXMM7ratZbqEVwkZ8PqwkCqg95MKZPEd277nMmV7CFA5o56XJlCB/AY2LYtaM
	 aYkLzGIdIv6PxJAdKIcRvki29CxPskK8ASIrqxafqmxE6j6V2BFTApk8VYXP+qx8RP
	 kKqdL99bvBippeFXWkvYgA80xmWD2UDhViVLtF65tqr5s6RhLog8LCP4lQ+KQX7NwE
	 B8SHck0tvCMudFtH2rh52J09CTIileAnUDYHB86F0bCAXgLtVEaiC1gAWtgXaKceMF
	 i9Sp+03LvB1p94VcCsG412e2XSrcG3UfHrDPaT7vnL2MlV8qe3+UfEmfkAVhoQitFb
	 nBNs8xN6VcF6A==
Date: Tue, 13 May 2025 16:38:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Marek Vasut
 <marex@denx.de>, Tristram Ha <Tristram.Ha@microchip.com>, Florian Fainelli
 <f.fainelli@gmail.com>, jakob.unterwurzacher@cherry.de,
 stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: microchip: linearize skb for
 tail-tagging switches
Message-ID: <20250513163805.2d278369@kernel.org>
In-Reply-To: <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>
References: <20250512144416.3697054-1-jakob.unterwurzacher@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 16:44:18 +0200 Jakob Unterwurzacher wrote:
> Fixes: 8b8010fb7876 ("dsa: add support for Microchip KSZ tail tagging)

ps. also missing closing quotation marks on this tag

