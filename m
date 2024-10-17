Return-Path: <stable+bounces-86639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832CE9A260F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 17:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E375B28B06
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481901DEFCC;
	Thu, 17 Oct 2024 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlIgq/Eh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF31DBB2C;
	Thu, 17 Oct 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177499; cv=none; b=UU4PFG7bK45okpsSx9xcvP+SKD8any01NyFG72BozoeiwNe5DD4UtuDYVJzWzWXKjOKRgMVuhDzx8/Ntt75RHoPCd2jE7SaCFKhN7ao0IFb9jPekiaawHIqF5Sfn0Tjp2jCcFgLHYWnj7hN7dm8Nc7shDFVxUC+qihOx+yvD1N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177499; c=relaxed/simple;
	bh=/iUFQ/0rM9C2X/U7ch5ZgY6xRHDxFImBc3ZRlD2x5nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZAIZhTxAi+b2iqa5wO/P4a0Klp/eccLxu/cuuVoOyKiUQrZL7TrWyd2AJMwHqrULnUrrxQ64dQHGt1MnRSN6ciqn+Q71WAMfaZVWVwUKQni3MWvCy4VJ/a84qAcLtfQZpfU3KkdDiZv/u3nKEF/HCrgYVNNiy+CvjfeqUw36rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlIgq/Eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9B2C4CEC3;
	Thu, 17 Oct 2024 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177498;
	bh=/iUFQ/0rM9C2X/U7ch5ZgY6xRHDxFImBc3ZRlD2x5nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlIgq/EhaOF6MeriKt0Alr74nqLElWpi7SUCS4995WT2g2jWvlb+Q/48edxfR35Kd
	 tUxGEj7ZYXCSCbgFTIrtcnIDFSaE/WQs2TBFLqQp2LnNsMVPRrpcKMZRNFVQifLywC
	 eSAYg3hsFk3LYx8Glm8EekiONP9grdbvtcNYodStd8SSFjltLabBq68S35SXTiz2fu
	 P5LY3ZeeLlc7S1Tj+cJYb6QI0Ur018QsRnsD7bZrY9SyqJ7E1THr9PmGMl0PYGVnd9
	 iV93PgIwV+OYB10EqqJEdegIR4f0TWq7xHYy1QlEZ/vBHggRjUmCbrlH/nLO3lx/rb
	 wyitPFVa0W8yA==
Date: Thu, 17 Oct 2024 20:34:55 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: kishon@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, Frank.Li@nxp.com, marcel.ziswiler@toradex.com,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	kernel@pengutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH] phy: freescale: imx8m-pcie: Do CMN_RST just before PHY
 PLL lock check
Message-ID: <ZxEnlx8n4rojC779@vaman>
References: <1728444303-32416-1-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728444303-32416-1-git-send-email-hongxing.zhu@nxp.com>

On 09-10-24, 11:25, Richard Zhu wrote:
> When enable initcall_debug together with higher debug level below.
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=9
> CONFIG_CONSOLE_LOGLEVEL_QUIET=9
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
> 
> The initialization of i.MX8MP PCIe PHY might be timeout failed randomly.
> To fix this issue, adjust the sequence of the resets refer to the power
> up sequence listed below.

This fails to apply on the phy/fixes, can you please rebase and send

-- 
~Vinod

