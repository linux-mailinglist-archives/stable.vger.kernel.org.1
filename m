Return-Path: <stable+bounces-204575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C706CF12E6
	for <lists+stable@lfdr.de>; Sun, 04 Jan 2026 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD7E300D141
	for <lists+stable@lfdr.de>; Sun,  4 Jan 2026 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB86256C8B;
	Sun,  4 Jan 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVGjuvKX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291D3A1E70;
	Sun,  4 Jan 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767550405; cv=none; b=lwgeVOCIZyRy1KrMA0a9Ghe5ROsnoFOStBM1+pCNgV/U1mYZ+kBqpTv8Gsv5bskuQXqLHE7toZ/9zbzsemg0Np9Z1KgqpGExSxSrn1H84FBmDsCa+5KaMuAKiFsy+bk4s6Qm4X5zAl4jA/wTPqDEO0XixCAuiFyeU4hp93gM2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767550405; c=relaxed/simple;
	bh=7aLUiot2SfuGwMnLVofiZQScB17Z0NLov7dmrjYkKj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPJtZAzu1GTqwsVw6+v66GBYcy2uGwgEln1OMDXYIOrmUzyNn0Z1rKwzyCy+WrdtR8t74QDg5vKmoL6iv3HgVSDhgC8SHNXDv3ZgEUc39Z650DBKYmUr372dmWf7JgP7YethCRTZdq5SWduGStldyNTR39JlR3ZUXo9AdGnqfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVGjuvKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99084C4CEF7;
	Sun,  4 Jan 2026 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767550405;
	bh=7aLUiot2SfuGwMnLVofiZQScB17Z0NLov7dmrjYkKj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rVGjuvKXaV8PbensfG4lQRQXlB5xjTFbHGDiPC0QvCI2etwW4y4iVjH0cwivp33HT
	 LyViESXin1u4ySEGbeDZV3xfg8fa3MsBo4KYTqsl3ey8EU++1BNvQXdfeF+ly47iuV
	 FBawWKsh8xXg+z14cclTGltbwu61GI0t9HYIvkkvcr2TdXLDIp6Ccabsj2Dj/l1ngW
	 qxs8ajFB1AulpmllylfPzTxkScysFZX4TDvGc4tPprXhUbdLZ8dN1D3I8y2b0JyKmA
	 typfIFdaOBVHdF4nche0c01OX6+MhmR9DaaNiys/sLa2L3FQIduj4q9+vrP4JL5NuH
	 EgzVdJvF5nt1g==
Date: Sun, 4 Jan 2026 10:13:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon
 Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Michael Thalmeier
 <michael@thalmeier.at>, stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: nfc: nci: Fix parameter validation for
 packet data
Message-ID: <20260104101323.1ac8b478@kernel.org>
In-Reply-To: <20251223072552.297922-1-michael.thalmeier@hale.at>
References: <20251223072552.297922-1-michael.thalmeier@hale.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 08:25:52 +0100 Michael Thalmeier wrote:
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index 418b84e2b260..a5cafcd10cc3 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c

> @@ -380,6 +384,10 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
>  	pr_debug("rf_tech_specific_params_len %d\n",
>  		 ntf.rf_tech_specific_params_len);
>  
> +	if (skb->len < (data - skb->data) +
> +			ntf.rf_tech_specific_params_len + sizeof(ntf.ntf_type))
> +		return -EINVAL;

Are we validating ntf.rf_tech_specific_params_len against the
extraction logic in nci_extract_rf_params_nfca_passive_poll()
and friends?

