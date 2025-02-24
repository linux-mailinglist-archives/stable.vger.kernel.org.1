Return-Path: <stable+bounces-119422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91699A430D1
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E017CC66
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E354020B213;
	Mon, 24 Feb 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blgBdzQ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1117578;
	Mon, 24 Feb 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439607; cv=none; b=pMPtQrLFMBQMn128kvPZwZSGLihf5TQI6c8L0GGpbuLjpj6Rk+orZ75zrawUnHXv8w9iE8gER5KwE38FxE8fHWHDRoPez/9YMUuko3OiukBWgcLfvEIswAW/dKmwfdqUUgSxsxX1RICJDBClSFB6KI206dwvlcflrnx1ZddAGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439607; c=relaxed/simple;
	bh=FN+pC9T5AWPvaPTFjiXFC+7rLGANFb8eaEwM3ubi9po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkBGqEs88MHM6KdVMlpaAyD0fdhT1QCR696iWmyFxZPTk8I0Ajxbg6CpOfZGq1/LZdfQ0ZL2fLtEEr75icEIbMMRemyAZ354JOJepHMiyxdyuljg44lYa2PCBqdoBcetRj1et9s/U2K9Hqk0qEDtdDqATpDUSL2Xqulomz0tR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blgBdzQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D153FC4CED6;
	Mon, 24 Feb 2025 23:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740439607;
	bh=FN+pC9T5AWPvaPTFjiXFC+7rLGANFb8eaEwM3ubi9po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blgBdzQ5skUoctzXhTlZpUdmnH9wYsT6JKpdS570RRscpxAWk/Sik06N9S1boY3rF
	 l462UV/j+Sdq3jiUKB3aDyWt8XyETf1LFVOm0cElARkvio8YO5uRBIYJP64Pn2ZVdj
	 M6FDYcQ7CVJCCh0c570isc43KAhjAciHiWpkl7dFNDAcOZ6GYnOHk+LfaXTg+ryMCZ
	 mytPquk60LevrEFpP1OxnisCO0clXDWlWH6985yVXW5uOLAZWZQLz+LnoI07TKklN4
	 sO2N0oaF8sS9o23Hsd612Pon9vtL7c91+WPVTRghNjB9L/1KTXgMLaxWg4sVfBzf89
	 0IfQhL2oauNMg==
Date: Mon, 24 Feb 2025 17:26:45 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Stefan Wiehler <stefan.wiehler@nokia.com>,
	Tony Lindgren <tony@atomide.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Julia Lawall <Julia.Lawall@lip6.fr>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/9] of: fix bugs about refcount
Message-ID: <20250224232645.GA117818-robh@kernel.org>
References: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>

On Sun, Feb 09, 2025 at 08:58:53PM +0800, Zijun Hu wrote:
> This patch series is to fix of bugs about refcount.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Add 2 unittest patches + 1 refcount bug fix + 1 refcount comments patch
> - Correct titles and commit messages
> - Link to v1: https://lore.kernel.org/r/20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com
> 
> ---
> Zijun Hu (9):
>       of: unittest: Add a case to test if API of_irq_parse_one() leaks refcount
>       of/irq: Fix device node refcount leakage in API of_irq_parse_one()
>       of: unittest: Add a case to test if API of_irq_parse_raw() leaks refcount
>       of/irq: Fix device node refcount leakage in API of_irq_parse_raw()
>       of/irq: Fix device node refcount leakages in of_irq_count()
>       of/irq: Fix device node refcount leakage in API irq_of_parse_and_map()
>       of/irq: Fix device node refcount leakages in of_irq_init()
>       of/irq: Add comments about refcount for API of_irq_find_parent()
>       of: resolver: Fix device node refcount leakage in of_resolve_phandles()
> 
>  drivers/of/irq.c                               | 34 ++++++++++---
>  drivers/of/resolver.c                          |  2 +
>  drivers/of/unittest-data/tests-interrupts.dtsi | 13 +++++
>  drivers/of/unittest.c                          | 67 ++++++++++++++++++++++++++
>  4 files changed, 110 insertions(+), 6 deletions(-)

I've applied the series. I made a few adjustments to use __free() 
cleanup and simplify things.

Rob

