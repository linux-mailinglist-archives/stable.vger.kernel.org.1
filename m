Return-Path: <stable+bounces-98140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6F79E2C36
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE6DB2C963
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F201F8921;
	Tue,  3 Dec 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVEBAqTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F81304BA;
	Tue,  3 Dec 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247057; cv=none; b=DW2cJeV4q+mNjMl38HLxK5ed5fuwKL3YidPgZy93XaYzOXZknXL/kxLVqT0tCZSfW4C6uKWCGdj624E2y75UdZIAtRKX6HWSDvlcAkabEiOyarpFkzWUszt2ADJgECA+dJ6pSDWEXB4IgNH6ddk35HTImdBCGXJBZcKuxK0E8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247057; c=relaxed/simple;
	bh=L2tR04wzRfMcaL3qtYw3Nw0O8MARMU2Q2Ip13H2mrIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQNxsC3l1LHeWoEH3Wn4IOhUjCZl/651vcfrNm0BeMhpxpp0GFpmRFuW344zQc8DeaZzD496ad4B9SnwAs0/EMymhN3reRDA1vFWeCzrL6GYhPfJuTsLqwDQbeceyb/8DIbIbv/tOT0p/CAgkMeoiVlF67gYPHmGuFbRlKZ5Iyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVEBAqTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97FBC4CED6;
	Tue,  3 Dec 2024 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733247057;
	bh=L2tR04wzRfMcaL3qtYw3Nw0O8MARMU2Q2Ip13H2mrIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVEBAqTIs6rDoy8KJsDjf6f4vMVJ9VPJHSd1vZI1PtsaNQVx26uJu4JHEYnRFT5FU
	 HgsThivcrhiMKnUg/m4ThFCyyumkkb/wT3kPmgfko4KS9GsJcmcdZsMY5RqyYWPsor
	 S39qfrF6v4vEs9y97VbotDjaEdiw7HSvjMw2VnaNdCC93jCCDFoCBxCn+lr+UNyf74
	 xmfWS0iLqJ/55772FAvNmnjEVT97jZ4UIH19kdr6a4MSQhumJ2e4cNNudKQDFJZQkU
	 CQHmzbprdC/fLuupOVLltxQ4uCs9Dm/f29Rp+ukl/vvTXYKtgkaeunROyjWvbl80/k
	 NT/njVO3YmNbQ==
Date: Tue, 3 Dec 2024 11:30:55 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	stable@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Fix error path in of_parse_phandle_with_args_map()
Message-ID: <173324705366.2006936.5456851909385472212.robh@kernel.org>
References: <20241202165819.158681-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202165819.158681-1-herve.codina@bootlin.com>


On Mon, 02 Dec 2024 17:58:19 +0100, Herve Codina wrote:
> The current code uses some 'goto put;' to cancel the parsing operation
> and can lead to a return code value of 0 even on error cases.
> 
> Indeed, some goto calls are done from a loop without setting the ret
> value explicitly before the goto call and so the ret value can be set to
> 0 due to operation done in previous loop iteration. For instance match
> can be set to 0 in the previous loop iteration (leading to a new
> iteration) but ret can also be set to 0 it the of_property_read_u32()
> call succeed. In that case if no match are found or if an error is
> detected the new iteration, the return value can be wrongly 0.
> 
> Avoid those cases setting the ret value explicitly before the goto
> calls.
> 
> Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/base.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Applied, thanks!


