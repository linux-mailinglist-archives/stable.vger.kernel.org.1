Return-Path: <stable+bounces-81518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3983993E99
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790421F22497
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 06:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D9314AD0A;
	Tue,  8 Oct 2024 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smHd6lvL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441D714D6E6
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367628; cv=none; b=C8ywfqpmcpFH7iH4UMmMTDfZamakXnaZo6i2f/xDtVVzfilFApI+OfzV8Y+kQ5ZtW5fvoyMGt2slFajFwYfix+dxy8VBE8EuvYOYHx98a5FbPBw824M2Dp/AR7St6e7dpkAS/BHAwEx+L4HlDUvrYjsm+cakEkQHggQAIirtVUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367628; c=relaxed/simple;
	bh=xPQHxjtOvBXWIsVgwFrisQdbiDmG9OLRpxaF7O0xx3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx/UpFty6KEknJaJYaznOiWJIKpKMjY6b6Uvj0RtePgejFZ15lieLkIEb9lHKoVxzNmjrpodtHIAonXKLYu8vIPxlfGN5Ts2HtoG3tYF9zIVNAbTvPVce34OKiAsc3kZfPY2prxvXJDFTDR93YvARuBBj9IQSqC5de4tbU1gAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smHd6lvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9EDC4CED0;
	Tue,  8 Oct 2024 06:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728367628;
	bh=xPQHxjtOvBXWIsVgwFrisQdbiDmG9OLRpxaF7O0xx3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smHd6lvLku2tWiy12O8GlTMzCIjHd0/FUgbghy8t1Xl4hf3AHpNc3wWKoNnPg+/7l
	 USgWGSAd2w+XdsuyhxD4Njtxw0781J+HHcfsVdW+dT1P2Zc6r5yrDuHttrV2qMjAem
	 gBC0YBRzmu8t1lN1rBlieYyKpaOa6Wy+CBTSQmN82i8A1PqMpsPdCPwHg8RgBt0q3/
	 LlDDsSz3jlfETCaop4Hhb8YN3ypwQ2wWA8LZPGCiyvlcylTX0S+389prlIFIqL2Cgl
	 7FJoyDs1LbvDmaI2czNxZBZGqaJwB22VdhZIXNsTCKqhvd4JI7Dfai0GlzGLkhWflz
	 DsyCw1vdY/bwg==
Date: Tue, 8 Oct 2024 02:07:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] r8169: add tally counter fields added with RTL8125
Message-ID: <ZwTMCp1d5bC31tET@sashalap>
References: <39dc7755-5c2b-4f97-9c4b-f4548ca08cfa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <39dc7755-5c2b-4f97-9c4b-f4548ca08cfa@gmail.com>

On Tue, Oct 08, 2024 at 07:40:17AM +0200, Heiner Kallweit wrote:
>RTL8125 added fields to the tally counter, what may result in the chip
>dma'ing these new fields to unallocated memory. Therefore make sure
>that the allocated memory area is big enough to hold all of the
>tally counter values, even if we use only parts of it.
>
>Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
>Cc: stable@vger.kernel.org # up to 6.11
>Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>---
>Original commit: ced8e8b8f40accfcce4a2bbd8b150aa76d5eff9a

I've fixed it up by taking 8df9439389a4 ("r8169: Fix spelling mistake:
"tx_underun" -> "tx_underrun"") as a dependency instead. Thanks!

-- 
Thanks,
Sasha

