Return-Path: <stable+bounces-179278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79AB53663
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A2B7B8A90
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 14:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6D343205;
	Thu, 11 Sep 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liTJD3JT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ABA314A70;
	Thu, 11 Sep 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602517; cv=none; b=u7LiNyKpRXY+1zn5ZOC+DPNgPDotZfNv7QAtlkmVsNz3ohDwjKO8zoP3i5c0z/au3DLNBgOPL7U7Uf5rYD8nABncXWs1IkiTfbKNMkhffqdpaSFyxSe0YDa4wAiEEYRIvZp7omGQ4dpILHDiofGzeKihHaPknEz0hF3ZRQ6s+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602517; c=relaxed/simple;
	bh=U/J1oy0yLzD+5vHPtcYAKVk7rNrPHlE6BjC7Eb+5HLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUhiq61Dq1cGk3FAlVil0rhFAGF9T+tC1UXxndYsScBEJIidnbxyEm0VmoAQwwsxXBPJ8osjij/hEM600mYuC3K1pEkTr5DvYN8D/HOSZCtpKFQ9I2vVwJHgmGcdounNNB4RUEDbhdNekH/+PvY5QItgSD/HwKLxbDWhxb01Zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liTJD3JT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5727C4CEF5;
	Thu, 11 Sep 2025 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602514;
	bh=U/J1oy0yLzD+5vHPtcYAKVk7rNrPHlE6BjC7Eb+5HLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=liTJD3JTrjya52KE9p4+dsxrdr5hf97KI0Y6+KFqH+EoXBZxPjkpAV3NdwNRhKO2E
	 MkHiynaX0qvy7FWqo0DTvY/L7mxzygfPx1Q3wsFNgiEHBFCYh6YQkZoanzVKlPGnOl
	 X8ZXW9yOGHOcNMHbUbOIM4/fdhvF6PI53CX19BidQPJugFDtQr1LSwvDlXPk1Cc4nj
	 f9c+43B8StFT4NC+4v4Lt770ALmUw40Iw9pXAPAHb/gVGKzjdcRaqEJGwuY/hEkNZ2
	 pwluOeCoPqYAF2fJso0gk0fsI9u+451NZ0G7Cq6Pc2/HuoBKm0KnZBJYbBpKwiCaG4
	 3S+sUgP/1VcIg==
Date: Thu, 11 Sep 2025 07:55:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Hubert =?UTF-8?B?V2nFm25pZXdza2k=?=
 <hubert.wisniewski.25632@gmail.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Xu Yang
 <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <20250911075513.1d90f8b0@kernel.org>
In-Reply-To: <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
	<CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
	<b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
	<aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 15:39:20 +0100 Russell King (Oracle) wrote:
> I'm not surprised. I'm guessing phylib is using polled mode, and
> removing the suspend/resume handling likely means that it's at the
> mercy of the timings of the phylib state machine running (which is
> what is complaining here) vs the MDIO bus being available for use.
> 
> Given that this happens, I'm convinced that the original patch is
> the wrong approach. The driver needs the phylink suspend/resume
> calls to shutdown and restart phylib polling, and the resume call
> needs to be placed in such a location that the MDIO bus is already
> accessible.

We keep having issues with rtnl_lock taken from resume.
Honestly, I'm not sure anyone has found a good solution, yet.
Mostly people just don't implement runtime PM.

If we were able to pass optional context to suspend/resume
we could implement conditional locking. We'd lose a lot of
self-respect but it'd make fixing such bugs easier..

