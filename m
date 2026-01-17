Return-Path: <stable+bounces-210149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FD7D38E95
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 13:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E449301BEA3
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554E31AA81;
	Sat, 17 Jan 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DKCa2bjh"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC4153BE9;
	Sat, 17 Jan 2026 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768654681; cv=none; b=f9ggp6KwRFlEZFu7qfneD9D/qy/Vx52Vlzhanhev1A0DSWdBrrbhlqmOBbAi7DSgqVkKIbfndKi3KxoKAO8poTKZcpAjGmfPxN1qLezHoShps5DAz1VOvo3jh7bqyfId4QhFJkWELBUwLrw1p1c8NZ3/dLaodfCpVKa3WLwm/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768654681; c=relaxed/simple;
	bh=6ctmFzGc9uAw0XJwRwZZfDdX3usU2MzQhRothFe2tQc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=k2QxcSAdbZ0+ElW6ynDTIpCbcUs31N1k7QZjrbCu0a9fdcoIZnqpbEsRCQV34sCQdEle5Nj5ENuNe+RLnz+fV6a7eO1CSsZpemZh8pTaZrYTXI8RLq/FGJ137aWzjXZEfA9y7bISajZXkg2tzl7YPbU14vfeDQKP2d1TB2v2ytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DKCa2bjh; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768654670; x=1769259470; i=markus.elfring@web.de;
	bh=rPkr+qZWZ3VT+JUIg93ayi8cfnY2TOCQ7rFusewqjjI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DKCa2bjhutzaXffxhWZeHZ2gvNBTO0ni03xVfCwbcGB9k2BtnwLdbsUJjJaNCRHy
	 jhgxhKgiFmF9fGgkcyox/KQXCmhX33VHcjNpLYhvFrBm+ZwiK9aEmIAOdPH9WC6fl
	 ry9/3ZzhdF1ZvrM8ClDfl4BK1li1ruLGlXGiK+y5glsK4WKWgNBGfL+vhvLLxFB0L
	 v58KNhcONlDNiT5Jsp2WSAFLmRmQJnsfZTNpmvlduWjAjV4sGMuEw6jAp6ckaKjkz
	 GHkiSZp3c+fF6ZR72BC1ViitnRpvhT4n7gMACzEBqBYUMTJw2RgNCZo9SVrjDZfK4
	 wf0y+k7eQ9j3KijwTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.177]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1w7enZ0D5z-00k7Ll; Sat, 17
 Jan 2026 13:57:50 +0100
Message-ID: <9b522c00-f403-4eac-a2dc-ed140cd3568c@web.de>
Date: Sat, 17 Jan 2026 13:57:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, linux-clk@vger.kernel.org,
 Brian Masney <bmasney@redhat.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20260116113847.1827694-5-lihaoxiang@isrc.iscas.ac.cn>
Subject: Re: [PATCH 4/7] clk: st: clkgen-pll: Add iounmap() in
 clkgen_c32_pll_setup()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260116113847.1827694-5-lihaoxiang@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/AcjH/b8ItPqnRybN+esVv33Fk12/CvakOAOBdMLPsbDv38lgRf
 pAvZTIPPgfdKlkocZ8xV9ZH0FxdSh1mzS89g/hB8pCs+RL4LxJPdEhFrvRTCEI3o+QMb1r5
 n6X4SqbCnPZwR+6euCt3wuBegnKdxc1jL8A5PqwRu29Io53h10gPqn/aWuWzJRXs334qiCe
 8CEjYVuwu3RqrKPqz3U8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WZJFmjbGdzs=;8G6Y3kwYv1RaI9JAd02bGHrS4CK
 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
 dP67GquA=

> Add a iounmap() to release the memory allocated by

      an          call?


> clkgen_get_register_base() in error path.

Was such an improvable implementation detail detected by any known source =
code
analysis approaches?


=E2=80=A6
> +++ b/drivers/clk/st/clkgen-pll.c
=E2=80=A6
> @@ -829,7 +829,11 @@ static void __init clkgen_c32_pll_setup(struct devi=
ce_node *np,
>  	kfree(pll_name);
>  	kfree(clk_data->clks);
>  	kfree(clk_data);
> +err_unmap:
> +	if (pll_base)
> +		iounmap(pll_base);

* I find this pointer check redundant because of a previous variable check=
.
  https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/clk/st/clkgen-=
pll.c#L771-L773

* I suggest to refine the goto chain a bit more.


>  }
> +
>  static void __init clkgen_c32_pll0_setup(struct device_node *np)
=E2=80=A6

Regards,
Markus

