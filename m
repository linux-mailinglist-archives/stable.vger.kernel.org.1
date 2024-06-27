Return-Path: <stable+bounces-55954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A3791A599
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736CB288C13
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBC214B083;
	Thu, 27 Jun 2024 11:45:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300C13AA4C;
	Thu, 27 Jun 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.72.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488718; cv=none; b=LWlMjP5rwOnzEUkAe9qPZefcX0cNR7kfStL93sNMLaF5eup10WDMMvbeJgztRRQdb9PTvZAFYqEDkHCK8Krj/TnwmryHHhpBs9gx6q2Ce0Na0vCk1wL4EC2TCdUGENHMobYjt8TM36jNWcmzDs12edUOh6zHmZG9KaOv8moOiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488718; c=relaxed/simple;
	bh=evSv+YzWBzT/rL+Ef3bDS+9leq4NZMD9hE/fznsNY7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WvlFmcuH7rXMxZUg1fgWOjox0nqSdImpfUyCcFTq+S+b47pRESJxNJP7SrQta1MQe7K6m1ge0avzEEjJGnd/n4U3lIUjx8xHew5I/owMBEyKpyGDWP3pftQsE6EgMSNqqoSuns+6rzPiNEh9bn0RxAFQVIgfSUAIxwRIGSmKBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com; spf=pass smtp.mailfrom=mansr.com; arc=none smtp.client-ip=81.2.72.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mansr.com
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
	by unicorn.mansr.com (Postfix) with ESMTPS id F14E015360;
	Thu, 27 Jun 2024 12:39:26 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
	id DE143210C01; Thu, 27 Jun 2024 12:39:26 +0100 (BST)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maxime
 Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Robert J. Pafford"
 <pafford.9@buckeyemail.osu.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: common: Don't call hw_to_ccu_common on
 hw without common
In-Reply-To: <20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32824a1@oltmanns.dev>
	(Frank Oltmanns's message of "Sun, 23 Jun 2024 10:45:58 +0200")
References: <20240623-sunxi-ng_fix_common_probe-v1-1-7c97e32824a1@oltmanns.dev>
Date: Thu, 27 Jun 2024 12:39:26 +0100
Message-ID: <yw1x4j9e62dt.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Frank Oltmanns <frank@oltmanns.dev> writes:

> In order to set the rate range of a hw sunxi_ccu_probe calls
> hw_to_ccu_common() assuming all entries in desc->ccu_clks are contained
> in a ccu_common struct. This assumption is incorrect and, in
> consequence, causes invalid pointer de-references.
>
> Remove the faulty call. Instead, add one more loop that iterates over
> the ccu_clks and sets the rate range, if required.
>
> Fixes: b914ec33b391 ("clk: sunxi-ng: common: Support minimum and maximum =
rate")
> Reported-by: Robert J. Pafford <pafford.9@buckeyemail.osu.edu>
> Closes: https://lore.kernel.org/lkml/DM6PR01MB58047C810DDD5D0AE397CADFF7C=
22@DM6PR01MB5804.prod.exchangelabs.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
> Robert, could you please test if this fixes the issue you reported.
>
> I'm CC'ing M=E5ns here, because he observed some strange behavior [1] with
> the original patch. Is it possible for you to look into if this patch
> fixes your issue without the need for the following (seemingly
> unrelated) patches:
>       cedb7dd193f6 "drm/sun4i: hdmi: Convert encoder to atomic"
>       9ca6bc246035 "drm/sun4i: hdmi: Move mode_set into enable"

This does indeed fix it.  6.9 is still broken, though, but that's
probably for other reasons.

> Thanks,
>   Frank
>
> [1]: https://lore.kernel.org/lkml/yw1xo78z8ez0.fsf@mansr.com/
> ---
>  drivers/clk/sunxi-ng/ccu_common.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu=
_common.c
> index ac0091b4ce24..be375ce0149c 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.c
> +++ b/drivers/clk/sunxi-ng/ccu_common.c
> @@ -132,7 +132,6 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, str=
uct device *dev,
>
>  	for (i =3D 0; i < desc->hw_clks->num ; i++) {
>  		struct clk_hw *hw =3D desc->hw_clks->hws[i];
> -		struct ccu_common *common =3D hw_to_ccu_common(hw);
>  		const char *name;
>
>  		if (!hw)
> @@ -147,14 +146,21 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, s=
truct device *dev,
>  			pr_err("Couldn't register clock %d - %s\n", i, name);
>  			goto err_clk_unreg;
>  		}
> +	}
> +
> +	for (i =3D 0; i < desc->num_ccu_clks; i++) {
> +		struct ccu_common *cclk =3D desc->ccu_clks[i];
> +
> +		if (!cclk)
> +			continue;
>
> -		if (common->max_rate)
> -			clk_hw_set_rate_range(hw, common->min_rate,
> -					      common->max_rate);
> +		if (cclk->max_rate)
> +			clk_hw_set_rate_range(&cclk->hw, cclk->min_rate,
> +					      cclk->max_rate);
>  		else
> -			WARN(common->min_rate,
> +			WARN(cclk->min_rate,
>  			     "No max_rate, ignoring min_rate of clock %d - %s\n",
> -			     i, name);
> +			     i, clk_hw_get_name(&cclk->hw));
>  	}
>
>  	ret =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
>
> ---
> base-commit: 2607133196c35f31892ee199ce7ffa717bea4ad1
> change-id: 20240622-sunxi-ng_fix_common_probe-5677c3e487fc
>
> Best regards,
> --=20
>
> Frank Oltmanns <frank@oltmanns.dev>
>

--=20
M=E5ns Rullg=E5rd

