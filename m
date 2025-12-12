Return-Path: <stable+bounces-200894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C61CB886C
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 10:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 926C7301765B
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEAF315D25;
	Fri, 12 Dec 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEVM6K9/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBA315786;
	Fri, 12 Dec 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532756; cv=none; b=EMJG9TCC2pxo0VhQPRlEX1HIUIt0Xd0oBgf9k9eFXubfXKJDysb7a+P44ggnDr4w4m2Q2HqrHCaBcjhIM44fVfA4wtUBzA3LT4G5PIZaR+5dNUxNEEhY+auvVUzihzWVeyQ1/uw9K7iVxNEZL/GiEc66npWGqqNCPNnoV8ybq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532756; c=relaxed/simple;
	bh=OJwZMxD1xuFpaiDZD9bZZSlslngJQdfqp12dqASxJRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsr1xUF2P1g66I71h4JuQs0Ez8vG7l9bzN5G0Yp/NXiNa+oi5eF9IGxHS3zwUf8jIFau80XjF7CRvMvBVPaSQ4m0LC5y4zn4oYpLmgNvKD7352mj0gkMM4pYnA9xZGpTh1rRVxNDC/NQD17iFqggmI1xrE+GrslKn3zg/kN1eDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEVM6K9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFCBC4CEF1;
	Fri, 12 Dec 2025 09:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765532756;
	bh=OJwZMxD1xuFpaiDZD9bZZSlslngJQdfqp12dqASxJRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dEVM6K9/j5i6iNYV/xHSRzht35wI0smoeQZDq2tQTGDhNRD19/NsLfaBYU5AGLQzv
	 V8aWcCoIhF3SkABxoGPpmIwH86PZP1610FXAxa0UMTbTNKuriKsACbGTdmLO7t9o3R
	 SUUGK7RrTTmYa1XqZFeDoVVp9DoafSddYggc3fAIyvWYyk+Qp9HwgSdK0UIZC+ENaU
	 Q7L0/DWhVKiq/+5CgYj5eA7xRGK6qzh6V2G9PY9mnKzLlH4FSBnrJrH93iFl+siwyv
	 eUM/gOOMp4brI2+qMwe9cyglfB5lA3D/fUfBAwjbF7BK5JlaUmRTZpUR0InMZnlNMV
	 Y/nfNh5ukIjuQ==
Date: Fri, 12 Dec 2025 09:45:51 +0000
From: Simon Horman <horms@kernel.org>
To: Ilya Krutskih <devsec@tpz.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow
 in
Message-ID: <aTvkTwsIsZmPOSnl@horms.kernel.org>
References: <20251211173035.852756-1-devsec@tpz.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211173035.852756-1-devsec@tpz.ru>

On Thu, Dec 11, 2025 at 05:30:33PM +0000, Ilya Krutskih wrote:
> 'card_idx' can be overflowed when fealnx_init_one() will be called more than
> INT_MAX times. Check before incremention is required.
> 
> Fixes: 15c037d6423e ("fealnx: Move the Myson driver")

I believe that the commit cited moved rather than added the code
which seems to have been present since the beginning of git history.
In that case the convention is to use this tag:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
> ---
>  drivers/net/ethernet/fealnx.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Please allow 24h to pass, to allow review, before posting an
updated patch.

Link: https://docs.kernel.org/process/maintainer-netdev.html

