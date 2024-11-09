Return-Path: <stable+bounces-92029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072279C2EB2
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 18:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361A91C20C07
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A959CECF;
	Sat,  9 Nov 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="bTOFOFM+"
X-Original-To: stable@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E919D082;
	Sat,  9 Nov 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731172657; cv=none; b=B0LjnIZ6a4YCpubQmiXbv4To6vIz2z2xPfdozlt4BK4jDwdg/LXGad5MRkJwXfsOGaWUyL1CadqiDL7XOL+403ZgM8QVlnavpIVN8GSmHtHWbZ/XTUeTUQY+ar7Obx1AnZhMl4+0U5zLu8zD4p4lu6f9sKQSqBrl9NYQQ/lFsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731172657; c=relaxed/simple;
	bh=TMDsyqDQ0pHvp2k1/uQnLMixLG+oX5cPjrDKtufuaPE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XomFbIPV/QUVlTqy6tb2Xm9JubTWLjnA0/RsCUNWXCIzjrzahqIOBR1s84Niq4Ilq0Ys465iX9YtlHczfgIUMdW4OqgvKMd+pOo1cM0/RI7WUvj3JoNlPiwIDfF9huJ3N2z3ibGhF7o227QqjpInU/SOxwCLykJiVrZICGGDKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=bTOFOFM+; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1731172654;
	bh=TMDsyqDQ0pHvp2k1/uQnLMixLG+oX5cPjrDKtufuaPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bTOFOFM+V+Vjnfh6JFW/4AI7emhyGc9yKxXwgL9v2C0SAPbobCZRpCWvbK8jAh0CG
	 JgnaQDy0f7JnKDvq6owZa9n5GlgsmwAzliEyWdIdYyLSjf3gO4WNWq8F+Fcckpr7Em
	 i58rutDcD6To0pOmyWxVyOwb2wb7E7QyziVBOUlYhV6OG2z7JBoAscQV/0Br2bJTRt
	 +ajvY6ebHAU1/Ir+cl1zFhAhBI1JRdcTTPiSPBI+gXyYQc15Eu5+t4/+jW0E/M4/C6
	 ZitB/n6phl+HjeGfBtUB/9O7nAWF4r+3KDVB0rOxfXtnM0KaQE++9+ZMh2qevj8A01
	 vYouC3PadruzQ==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 09 Nov 2024 13:17:32 -0400
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: wens@csie.org
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Rob
 Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Parthiban <parthiban@linumiz.com>, Andre
 Przywara <andre.przywara@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: a100: enable MMC clock reparenting
In-Reply-To: <CAGb2v663xMyiEx4BpPkuRew9t8fAgbz6EENEj--8Y57E87Lgcg@mail.gmail.com>
References: <20241109003739.3440904-1-masterr3c0rd@epochal.quest>
 <CAGb2v663xMyiEx4BpPkuRew9t8fAgbz6EENEj--8Y57E87Lgcg@mail.gmail.com>
Message-ID: <ad31f44044d56dda935698012c0dd595@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024/11/09 12:02 pm, Chen-Yu Tsai wrote:
> You should still keep the version number from the original series if
> resending or increment it if changes were made.
Noted, sorry; still getting used to LKML norms. Since I was resubmitting just
this patch for stable, I wasn't sure what the norms were.

The contents of the patch are unchanged from my series; the only modifications
made were modifying the commit message and adding stable tags.

Thanks!
- Cody
>
> ChenYu

