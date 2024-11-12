Return-Path: <stable+bounces-92843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056AB9C62EB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 21:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD73281A33
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3345219E46;
	Tue, 12 Nov 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWmIOhfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2E18BBA2
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444798; cv=none; b=OmEonXCnoPb/thlGZtBg/8gziqrg4UD8VlIFcnGhjPeVCB08MZha9O6bWPGw78MU+oJmtxRfgKk8fvZ5mHeaGwOgsD9XSjnzolvxNTXF2lUCQo0CNHI17g0FuANbJb5T0F7/hn5x/0KvA//oRWJiyaRqBl3t5dZIGJWAE4DoBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444798; c=relaxed/simple;
	bh=b9nh8b0iL/UODzLeCSVY4WsOgjRikaVGumQJxkWK+7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYyE+uVYB4g/M5nV6QmFVCFoAe0KWVVNfapdG9gx0SvmP9oyYdz3sP4qYd2KCwXzxo/BzvhpzWrVILNNJQGN4U1Kua5NQUtnW/EFqjJ/2fAQvL8jnA0b/2AVCwpV51uYA5bSuX0F+ukwXgZKOJ4xprlfE6N7ZR8AfaB9CRKekoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWmIOhfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10478C4CECD;
	Tue, 12 Nov 2024 20:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731444797;
	bh=b9nh8b0iL/UODzLeCSVY4WsOgjRikaVGumQJxkWK+7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWmIOhfO16xwytGgbEstKtub5WRi5poUlN3Z9U/L0St7eGXVJyiG/2OIxHnpWVgu3
	 O/JN8+oKXwIFdao5irGuvEWEnQNh14IPcAKZHgg86bdLwJf6A3e5zyYcnWOykj4eao
	 YYIhtHka6AujJGIcGhxBoBby8gVMyWyhj57dDH2c6GXoM4ERmugPIZLdLJTn+NGUE3
	 Q8xOBc2sjTZPYI1rN2NZwhEUlVPcYGaDTa1oe7v+KFjgsRqXQRjAr2voqoAP/qWhtc
	 tHHFXS+h8hka3tn/dyiL4Cmu2e/DIuaFm2RsTr4Tofubl1AAUIPFMVVizoEhZQoY8K
	 cRp0DmPxQZX5A==
From: SeongJae Park <sj@kernel.org>
To: =?UTF-8?q?Motiejus=20Jak=C5=A1tys?= <motiejus@jakstys.lt>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tools/mm: fix compile error
Date: Tue, 12 Nov 2024 12:53:14 -0800
Message-Id: <20241112205314.43962-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112171655.1662670-1-motiejus@jakstys.lt>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 12 Nov 2024 19:16:55 +0200 Motiejus Jakštys <motiejus@jakstys.lt> wrote:

> Not much to be said here, add a missing semicolon.
> 
> Fixes: ece5897e5a10 ("tools/mm: -Werror fixes in page-types/slabinfo")
> Closes: https://github.com/NixOS/nixpkgs/issues/355369
> Signed-off-by: Motiejus Jak\u0161tys <motiejus@jakstys.lt>
> Cc: <stable@vger.kernel.org>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  tools/mm/page-types.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/mm/page-types.c b/tools/mm/page-types.c
> index 6eb17cc1a06c..bcac7ebfb51f 100644
> --- a/tools/mm/page-types.c
> +++ b/tools/mm/page-types.c
> @@ -420,7 +420,7 @@ static void show_page(unsigned long voffset, unsigned long offset,
>  	if (opt_file)
>  		printf("%lx\t", voffset);
>  	if (opt_list_cgroup)
> -		printf("@%" PRIu64 "\t", cgroup)
> +		printf("@%" PRIu64 "\t", cgroup);
>  	if (opt_list_mapcnt)
>  		printf("%" PRIu64 "\t", mapcnt);
>  
> 
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> -- 
> 2.44.2


Thanks,
SJ

