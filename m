Return-Path: <stable+bounces-80662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E698F336
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4ED1F21D88
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E131A2C06;
	Thu,  3 Oct 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnTXO42F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B845713B280;
	Thu,  3 Oct 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970727; cv=none; b=Phwtunhyvhbqsl6IwttZ3Qpbf3Ecn1DccOO93ILjYz7hc9/jIWL7sBVAeLEtv+4+bZo4CoQ1deV8Tddx0qqCFdUDJ8b4T8KZRQ/TDPVxk4lNMPm4iytS180ERBcm8Lj0/6fu605B/9g3pqzVGRvXeEfUke2zx2gS4fbuhkC0p9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970727; c=relaxed/simple;
	bh=M9Oz75M4chQxxMkZ4li5kMs02D59pE5QYJmHwEsc1rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHG0mqkNAJPpZmPSsKtPyUDPFxL3Jfrxsv9qx0dlZm5hhQljaZrg9F1hiI4p4WIE9XeHPBJln3QPVx9BQX7OMr67p8Q7PMml0UpqJy5r8P3XkUqfDU8oSe6c04K3PBLcgyq+FwUKAGpKzZK1TaYuw8vqbHfrHdETd96teryhrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnTXO42F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F90DC4CEC5;
	Thu,  3 Oct 2024 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727970727;
	bh=M9Oz75M4chQxxMkZ4li5kMs02D59pE5QYJmHwEsc1rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnTXO42FbCft7Jo8Oud/6G8+I2anVX96jWC9rMlOGAwq30iqdsXI/elN4ZfpY51YG
	 mhKdR3E0MmevNh/tqHTCEfdhiZCF0bdnQyHhlcm0G794YBhWVHb2VJTRKhh9KBfO0Q
	 YdBX6n7kwUpbPAI0FDjOQ/fuJBTklM+bBna7qqbZEDK6v5ISWkHeMOqnRLJrNiDbAb
	 9s7yOqj9Vos69octThtjJHEvnzCs/U2tjhVc93SvMv12ClqvwfIaM1V2dYHYuL7f61
	 G7csTIR6/x2Oey6CPp/zqiTa6mI2G7KjVklleerE9/kdZtaKPnAHYwQfsW1ubROOZI
	 EguVBYjZbk5/g==
Date: Thu, 3 Oct 2024 16:52:02 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Vaganov <p.vaganov@ideco.ru>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stephan Mueller <smueller@chronox.de>,
	Antony Antony <antony.antony@secunet.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org, Boris Tonofa <b.tonofa@ideco.ru>
Subject: Re: [PATCH net] xfrm: fix one more kernel-infoleak in algo dumping
Message-ID: <20241003155202.GT1310185@kernel.org>
References: <20241002061726.69114-1-p.vaganov@ideco.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002061726.69114-1-p.vaganov@ideco.ru>

On Wed, Oct 02, 2024 at 11:17:24AM +0500, Petr Vaganov wrote:
> During fuzz testing, the following issue was discovered:
> 
> BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x598/0x2a30

...

> Fixes copying of xfrm algorithms where some random
> data of the structure fields can end up in userspace.
> Padding in structures may be filled with random (possibly sensitve)
> data and should never be given directly to user-space.
> 
> A similar issue was resolved in the commit
> 8222d5910dae ("xfrm: Zero padding when dumping algos and encap")
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: c7a5899eb26e ("xfrm: redact SA secret with lockdown confidentiality")
> Cc: stable@vger.kernel.org
> Co-developed-by: Boris Tonofa <b.tonofa@ideco.ru>
> Signed-off-by: Boris Tonofa <b.tonofa@ideco.ru>
> Signed-off-by: Petr Vaganov <p.vaganov@ideco.ru>
> ---
>  net/xfrm/xfrm_user.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 55f039ec3d59..97faeb3574ea 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -1098,7 +1098,9 @@ static int copy_to_user_auth(struct xfrm_algo_auth *auth, struct sk_buff *skb)
>  	if (!nla)
>  		return -EMSGSIZE;
>  	ap = nla_data(nla);
> -	memcpy(ap, auth, sizeof(struct xfrm_algo_auth));
> +	strscpy_pad(ap->alg_name, auth->alg_name, sizeof(sizeof(ap->alg_name)));

Hi Petr and Boris,

The nested sizeof doesn't look right to me.
I expect the length of the destination is simply sizeof(ap->alg_name).

And given that ap->alg_name is an array (which is why using sizeof is
correct here), I believe the two-argument variant of strscpy_pad() can be
used:

	strscpy_pad(ap->alg_name, auth->alg_name);

As an aside, and not for this patch, there is a usage of strncpy() just
above this hunk which looks like it could be converted to the two-argument
variant of strscpy() or strncpy_pad() if it ought to be zero-padded.


> +	ap->alg_key_len = auth->alg_key_len;
> +	ap->alg_trunc_len = auth->alg_trunc_len;
>  	if (redact_secret && auth->alg_key_len)
>  		memset(ap->alg_key, 0, (auth->alg_key_len + 7) / 8);
>  	else
> -- 
> 2.46.1
> 
> 

