Return-Path: <stable+bounces-144067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E651AB4880
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3350A3AB8C6
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 00:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47FA54763;
	Tue, 13 May 2025 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msb6F8Id"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD391BC2A;
	Tue, 13 May 2025 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096728; cv=none; b=EisaXC7un3aUdZ+bRg5Ympq6DmmTdo2CpQFn7gZc1bKsZPfboShp+dhwV4C92VJNU/4aRvae933vReTmNu5EcX7Ue5EbpzZqrLhkk7aWXBKZrWwRas9WY/a2vytt+C3nJFPSPHsnKUCQcqXhfX5pYv22eNVv5rpSFTXgcwFOP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096728; c=relaxed/simple;
	bh=flBB8DjvsauKMmFKOOZ3kglblEROS9qMRYYhOuXJGuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hk/h1g5VGET1+jh7rshW10K8mNzeNXSou2FA8EkBDsm8yMGw0oHUDu1seX1jP1snRsOTvp2JCoRGNTH0w4vMTGMh2P3Hr93HmmKVvgEcCIGivX7F6APw9UjnpcG6XxKLzgxSfv8kcKzpv2u29kNJInDGZkpPFIcNI5dn9/vUUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msb6F8Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA38C4CEE7;
	Tue, 13 May 2025 00:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096728;
	bh=flBB8DjvsauKMmFKOOZ3kglblEROS9qMRYYhOuXJGuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=msb6F8IdO+YfS7WclIgqjRBOasou2kc/kwcfHMFRQAxFgwjfnhRE4e/EhCimbMerm
	 G2in5f3v0WIgcXRFAPvBV5/+gGaty9roH/IabkZHvgHlo0gz/aKFeQalc8K6Gkvmrc
	 3sWonqoSxSP+vb3TZoMFtgor7YdlNeeCIp+2YHt8y2fUTgUKugH3JUO2hjqvFTQbn1
	 7HD8pEIviDmSDf+h2scKBZwFiFwBmKSd1OTzmRioxxOYGy1IGgwTfj9r3qYvyPO05f
	 1d8k+fnxbzalVDjWSbnqm1Ms6op4GILNO37vutw3M/Atv+7BQ8gtLmswb1Rti7rtsW
	 41ZtD6hsGFfbw==
Date: Mon, 12 May 2025 17:38:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Christian Marangi
 <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Daniel
 Golle <daniel@makrotopia.org>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [net PATCH] net: phy: aquantia: fix wrong GENMASK define for
 LED_PROV_ACT_STRETCH
Message-ID: <20250512173846.511a2303@kernel.org>
In-Reply-To: <e5a4fc33-4fe2-4078-83e5-596dff96bef9@wanadoo.fr>
References: <20250511090619.3453606-1-ansuelsmth@gmail.com>
	<aCB0dkhiO49NJhyX@shell.armlinux.org.uk>
	<e5a4fc33-4fe2-4078-83e5-596dff96bef9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 May 2025 12:06:38 +0200 Christophe JAILLET wrote:
> There is a compile time check, but in this case
> VEND1_GLOBAL_LED_PROV_ACT_STRETCH looks unused. So it is never expanded 
> and compiled.

Thanks!

Given this the patch is obviously not a fix.

