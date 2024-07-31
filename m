Return-Path: <stable+bounces-64726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD027942966
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AB1B21ACC
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92041A8C02;
	Wed, 31 Jul 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfJyoowh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D271A8BF0;
	Wed, 31 Jul 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415488; cv=none; b=VXcdN5abHMYRp9Wk42G71Q6zFVxEgFojRCn4/JPosRh8ziIKsmgxXrqgxMNbwQxvqoF3tmLgZc3byi4gF8DeRYLIYQtelmH8S9miVvD8bhdV7VN7EiLigbWYgwiE/KkI+z6bmOmv9iFDcpIgg9lRzhhZX/Xd4C+mpyXn6GSPPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415488; c=relaxed/simple;
	bh=WzC80hl1AW1tiBkiKAI6/dELkDarMZZqpTulR3LSY6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U89ni27yMu2PochwQj+Q1t231hJOXdzUt7qojZADo0H12tX/2cBz4+jKi3X/1vi7ryPhk0yr+fFajgmycgTfXQLyFrNvQBvLRnMXGri4Ur+P0JOOtq7hIo76wCyH6+am+0ep1837n3jUWUVIutLbb/5wPKnpjEcHDTI5WVTh5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfJyoowh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5647C116B1;
	Wed, 31 Jul 2024 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722415488;
	bh=WzC80hl1AW1tiBkiKAI6/dELkDarMZZqpTulR3LSY6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfJyoowhJ0sxAIFJP8EH8/5EeNk5XFa+k/rD9fPPqt89+baW6O46DfPVbZHwu06z4
	 vUYjpNjYSV+X976z7l28rQZ5LswYHGqZ+GERZq076T5w3mHwLSfZQtYNyD7txtZU+6
	 lyVixwyfS4Qzu6d0QtITvrqZ7CjxFVYoFz/I/KpXaopCd1xUNdHvtyRTZfU5rogwud
	 sQzATIetOuPz2X7ltmYAL0zW1qY6wBeHFAMnLzBFWQgTwtOrpSaEr3WCjtyCZTu+M9
	 YX5QW8mtHcV8yjGjccDem99PPL5YUzsAXOi6bOz5H13AQHfJhFSOTuGLrriW6NXNoX
	 1YQf5cUB3m49Q==
Date: Wed, 31 Jul 2024 09:44:43 +0100
From: Simon Horman <horms@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v1] net: wan: fsl_qmc_hdlc: Discard received CRC
Message-ID: <20240731084443.GL1967603@kernel.org>
References: <20240730063133.179598-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730063133.179598-1-herve.codina@bootlin.com>

On Tue, Jul 30, 2024 at 08:31:33AM +0200, Herve Codina wrote:
> Received frame from QMC contains the CRC.
> Upper layers don't need this CRC and tcpdump mentioned trailing junk
> data due to this CRC presence.
> 
> As some other HDLC driver, simply discard this CRC.

It might be nice to specifically site an example.
But yes, I see this pattern in hdlc_rx_done().

> 
> Fixes: d0f2258e79fd ("net: wan: Add support for QMC HDLC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/net/wan/fsl_qmc_hdlc.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

The above notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

