Return-Path: <stable+bounces-58926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398792C33D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 20:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D377A28503A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D4180024;
	Tue,  9 Jul 2024 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLpZMgSd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118B17B020;
	Tue,  9 Jul 2024 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549333; cv=none; b=gmOs4tGwRMhicQ4mqGKVtvx7e61JAIlwQ1C0ijaSHbAfqsoMw+D+UHWzXQvj7btDBeJOg/aa2W0p1VeK3M7LIF5KXk03/oqPnZhvQ1VqHmmyHa179pBRWmO3gWR51y657OC4uVzXHpxPieS4wMU+GksFCS1QDLZIrIAfW+9QSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549333; c=relaxed/simple;
	bh=wM59GLV9xAXEl0zKRazQLCWwzgAPxvRC3pkgUZT2BrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5fxg00bEr5N2bL9db7pusOPqQr8YBBQ8hbxtC6F74c4yfoDy/wTrqbTe3lfzKSaXF2MbnNiRdGxFYO5lOwU4yfn9eltPiQT/M08QT9zxx7JvGKpk+C+iLmD3a/1tt5jg2tqRZhFSjXIDxl+Q860KbUYaFbpjYMRn3W7oGnUzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLpZMgSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B8CC3277B;
	Tue,  9 Jul 2024 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720549332;
	bh=wM59GLV9xAXEl0zKRazQLCWwzgAPxvRC3pkgUZT2BrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iLpZMgSdfhul7ttC0QnHJx5sFtuih3jt29Z6zJITYudJfpovZs5MNlpIRFr9lLIlV
	 kq0+pk/l8x5rpT5wYRoJ0cZnNxdnwWZVdV5hEOmUC8aEE6T24cRzqgNnktlL6h+E7F
	 oMVNd0WiIEn+PoOqzS6tWntpri1aZIuIlfA9f4BM8pon5MLKOFRK7ClDpN/KBjvPeF
	 2GSJpjBCXFTrZ2h/f2GFtKXt0Xo3ITg1hdab6XJ5hjc6KeX5329SFDRQvEALGz/Kh1
	 USCEpaG6H/YS9zu2yaOsnZebULrdxMm/OoR7I2OO6XMi+yxTW+96G7QRL8yPlC+kH/
	 bgk4tcdK7iNcg==
Date: Tue, 9 Jul 2024 11:22:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] net: ks8851: Fix deadlock with the SPI chip variant
Message-ID: <20240709112211.36119956@kernel.org>
In-Reply-To: <20240706101337.854474-1-rwahl@gmx.de>
References: <20240706101337.854474-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jul 2024 12:13:37 +0200 Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> When SMP is enabled and spinlocks are actually functional then there is
> a deadlock with the 'statelock' spinlock between ks8851_start_xmit_spi
> and ks8851_irq:

Applied, thanks!

