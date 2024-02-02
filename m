Return-Path: <stable+bounces-17663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AE0846A58
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B56B2821D8
	for <lists+stable@lfdr.de>; Fri,  2 Feb 2024 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE11803D;
	Fri,  2 Feb 2024 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="f+yKyOju";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s2Y/Hvgm"
X-Original-To: stable@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7C52F7C;
	Fri,  2 Feb 2024 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861437; cv=none; b=ehGDHKs39MXA3KmszpSBXfEngkjupJwQf9VXweabFZICqSsqcJryFYwFygQQAYi5Rq+yDwIxk69qFTqnJ+zR3nGcNBIUeFAM6+5+P1gTsHSVRp1mP9Jt02oxHW4qtRDBU3oZmSRptl9GknD4sBBgtwwk7TI73Tgs5R3+T76k8YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861437; c=relaxed/simple;
	bh=WDuGYjGSBU+A1zPDCQ5qkTNzoUWTvvU46Mto0rbQ9NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJx2+l0D78pSqC3nkbHggHa/rIooeaIa9/S5W4iB5wbYI9Ikmm9OIGgAuyVNyZe49k2puKlYXCrzKpD4dGo3sISeogaq/1dFws0bXHmozWc0TVAVJtFiTDmvY8woiVEttotP+xcVNf0SD/aJgBVRlBT0nqJe2Hgh6RqXnqe+dyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=f+yKyOju; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s2Y/Hvgm; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9FD041C00093;
	Fri,  2 Feb 2024 03:10:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 02 Feb 2024 03:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1706861434; x=1706947834; bh=EumVd0yJ3syM67+PD28lPoMRV25ljbZ9
	/nQH4iIdHl0=; b=f+yKyOjuoAVsJGvOJppSPR1UXxz/qRamqUQGUEA3u0qXCYqs
	wgzhulE6nzQQmuo3Y1nFi+2s9soSMTeMjNJV/+ztP2YrHYYmxAY9D/9Sl2mWI7Lz
	2Aomj8Gu1PO37POj45Reejg9uH0HrNHdZP5pM46D8MX/3DKP7pHjtyv1GaxPlK2U
	VsqpklVJvflftFeYa4HOgF3BfI+jOZFIkT5m5AmFtt0UaghioZB/3z1q1Hhax+xr
	OpEDyJkxV8VN1JSE3UpG1IFjh11zhPmg7jplatvlyWeVTasr8H+uQJltB0TVTVn7
	P3wswUGTjKDvkRuujlhymNOl6gW1lY70eT9kaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706861434; x=
	1706947834; bh=EumVd0yJ3syM67+PD28lPoMRV25ljbZ9/nQH4iIdHl0=; b=s
	2Y/Hvgmg6SOXFW5PGUgAv6oRjHUW4pZxd2N3q0e6uyIs3Bp/FNsSRI8NLpVvL8w2
	WWtfEKv22Qyy6eh4mhq5yRj/Ink79wGzDb3PjaTXXQFZK+T73fcof/L9j9e+CQ+l
	lbL5WEuly6TMun6/krjaeYSoxh4fr6EAR41e1JxEd+Uuyy/L+NJ2zhK7X8k8FFiL
	Rd1YuuuLj5nA8EE8SWcoT18SPFJAoKLS9WcyZZ0VbZ3TibkqJvBF5ySvMklIreVR
	gPrHGMF30KR482iGRvngX+MtpT8noq//Zf+2mKON/huUM7o7JKzAxjPde1+RyAhB
	QsOtmOEajn2xZdMoTwWOQ==
X-ME-Sender: <xms:eaO8ZZJ-yVwzql0k1sukeiO7135bIhBKy_k8jMup5IRECdLeVbCUJQ>
    <xme:eaO8ZVIsEBzj5rohbKIf2NhQTeIxRqYvhlw_hQj0bzLM2S7pxGx_4fc29RoKDL6K8
    ekSKfmQjw>
X-ME-Received: <xmr:eaO8ZRvjrGnVzLO4J8AsJN--WbjzJIF3ne3pumbI-Lnz8k8EgwxcMv-E-4g8laG4LIf1wT7ELG0a0vTzQAW3y7idrpF1e9KfpD33oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepteejteffudfggfeifeevhedvfeekhfejhfdtteejueetieehueduleetjeeuueet
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:eaO8ZaZgbl5dyQ1i9sqIXKUZ4ncd0ZKndWADehSM3yy0IcaBBtwqvg>
    <xmx:eaO8ZQYPIKkybCE4Yn_bB9Q07QYXkhZMhlTDySDONOPre0aUxu1igg>
    <xmx:eaO8ZeBllF69zgF_lb77CP6f6zddXsdE1yWDMeKMIz-IOEoobjW7YQ>
    <xmx:eqO8ZfzQji92CktMMzbMp7rtm1rSdQxG238cld6NOSm9H30_igEzowZGnnM>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 03:10:31 -0500 (EST)
Message-ID: <1698d0d4-8637-4723-b2b2-5e06d5410e5f@feathertop.org>
Date: Fri, 2 Feb 2024 19:10:29 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "i2c: rk3x: Adjust mask/value offset for i2c2 on rv1126"
 has been added to the 6.1-stable tree
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
 stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>, Andi Shyti <andi.shyti@kernel.org>
References: <20240201172757.95049-1-sashal@kernel.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240201172757.95049-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,
   This patch should not be added to 6.1 stable since support for the 
Rockchip rv1126 SoC was only added later around 6.3.

Regards
    Tim

On 2/2/24 04:27, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>      i2c: rk3x: Adjust mask/value offset for i2c2 on rv1126
>
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       i2c-rk3x-adjust-mask-value-offset-for-i2c2-on-rv1126.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 415eb64a74fe97dc85bcad99deaecfe57dce6b6a
> Author: Tim Lunn <tim@feathertop.org>
> Date:   Sun Dec 3 23:39:59 2023 +1100
>
>      i2c: rk3x: Adjust mask/value offset for i2c2 on rv1126
>      
>      [ Upstream commit 92a85b7c6262f19c65a1c115cf15f411ba65a57c ]
>      
>      Rockchip RV1126 is using old style i2c controller, the i2c2
>      bus uses a non-sequential offset in the grf register for the
>      mask/value bits for this bus.
>      
>      This patch fixes i2c2 bus on rv1126 SoCs.
>      
>      Signed-off-by: Tim Lunn <tim@feathertop.org>
>      Acked-by: Heiko Stuebner <heiko@sntech.de>
>      Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>      Signed-off-by: Wolfram Sang <wsa@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index 6aa4f1f06240..c8cd5cadcf56 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -1295,8 +1295,12 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
>   			return -EINVAL;
>   		}
>   
> -		/* 27+i: write mask, 11+i: value */
> -		value = BIT(27 + bus_nr) | BIT(11 + bus_nr);
> +		/* rv1126 i2c2 uses non-sequential write mask 20, value 4 */
> +		if (i2c->soc_data == &rv1126_soc_data && bus_nr == 2)
> +			value = BIT(20) | BIT(4);
> +		else
> +			/* 27+i: write mask, 11+i: value */
> +			value = BIT(27 + bus_nr) | BIT(11 + bus_nr);
>   
>   		ret = regmap_write(grf, i2c->soc_data->grf_offset, value);
>   		if (ret != 0) {

