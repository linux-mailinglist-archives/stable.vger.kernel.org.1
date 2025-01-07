Return-Path: <stable+bounces-107907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8969FA04BD5
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 22:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8105F161B8A
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2451F3D23;
	Tue,  7 Jan 2025 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRyAIU1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CB1E1A39;
	Tue,  7 Jan 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285770; cv=none; b=oFgfBz9JcfPDXgltL8ksONWVPqLsIpsSX1fAqbGshj010fC3wjKieovOsINuvXP42fy2AjLiBp/vU7cOk9uyNIMsLMJUl1YlZnv220kYNhIZd8GMWEkYh6up4YpNYKxDVbMf3oeDhXQM0ohlWF5F1G1Hl8aLwRoZoNuqaYLT+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285770; c=relaxed/simple;
	bh=0ujhkjhchtTCvOCmjzqwYnjJMvC2IEBKnobRKzabDFE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pFLX6eMLkszYcog3gIUpKu3DR8uwV52yrwnUCE6S5TZrVRp2PjVLtpBjtDYCusskTWBRCBX1IWIUgpOZoWutmjP7U/3XwrrYJ2I4Q9O8bnvR8r9jkl1ylDxuxodWss5BjCzsx9Dvq2fJnK3ChhIbruZYtXrbzuDOsE1zt/7nvZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRyAIU1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D9BC4CED6;
	Tue,  7 Jan 2025 21:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736285769;
	bh=0ujhkjhchtTCvOCmjzqwYnjJMvC2IEBKnobRKzabDFE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gRyAIU1ShsZrWDxCOA5hBiA7TeWd1YAmySfquf7F9MkO7EwXs031rZfBttQrZfCrR
	 hwKMbC4Z/lFzxiP4TGp9zrvlNmMxLhBQdgXtvBgQLAVnG9gL4ZPQTDTJXFG0i8Yzqm
	 O+B0OMXGBwRcUJmIOrZa9ewmsfaK2zOP9bFT1WgOdy+RdgKqHLK4DmHWSfsXq8MYu7
	 8II2uiuwS0HbJGebhv0mdqWEEz07FgB2yAsZRmpDEKumXLjqqicU73s247LhQxfZsb
	 W9l1fDMToQENLFInvANW4xKhlUHzYpr6DjWLlWwPx8NbJH0/eWPiQtWGoTeeoy78Tc
	 /gDHDYtFn6OwQ==
Message-ID: <ca72b67f879b7fdbb5e717cdf97fbb0d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241231190336.423172-1-lkundrak@v3.sk>
References: <20241231190336.423172-1-lkundrak@v3.sk>
Subject: Re: [PATCH] clk: mmp2: call pm_genpd_init() only after genpd.name is set
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Lubomir Rintel <lkundrak@v3.sk>, stable@vger.kernel.org
To: Lubomir Rintel <lrintel@redhat.com>, linux-clk@vger.kernel.org
Date: Tue, 07 Jan 2025 13:36:07 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Lubomir Rintel (2024-12-31 11:03:35)
> Setting the genpd's struct device's name with dev_set_name() is
> happening within pm_genpd_init(). If it remains NULL, things can blow up
> later, such as when crafting the devfs hierarchy for the power domain:
>=20
>   8<--- cut here --- [please do not actually cut, you'll ruin your displa=
y]

Applied to clk-fixes

