Return-Path: <stable+bounces-207873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279AED0AC15
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 15:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECBE3015ECC
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 14:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295430BBB6;
	Fri,  9 Jan 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K156FxdM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B2289811;
	Fri,  9 Jan 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970473; cv=none; b=UuwwUrUo6dNDbFXlzHeeZ1+Pzgj+j4/byWuitKzp9S/aXfsdZCwqjN2jR/dBkDdTciQ9fmsZZ0tG69sMD7FQ9Yp3SqpA2yu2f+hL3OXRmHdidBkotPskA5Mve9mfZdIQAjD/WJLNJmVzLItPZr/i+xl8FnQuLzdpHYqwzfg3M04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970473; c=relaxed/simple;
	bh=rNKz89ursx0gV3ChF3se4ynmcQUZoXNuL8DKwVafaEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0r+7DhkSVP/tQBVCVvCkWhXEwQ1mNveAPaB8n12GFqdx8sHS/fCAXN2aGBqR+B7WLKFOJQ5jregyBOVouEw5iqiHnG3cUYr8gSWzQ6/IR4lRp9wdy9wEeA7wP1PVwXvr3hEU2u2pYivy4nDXDFpDkksgWFdFcitvy/NRUrzg4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K156FxdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466EFC4CEF1;
	Fri,  9 Jan 2026 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767970472;
	bh=rNKz89ursx0gV3ChF3se4ynmcQUZoXNuL8DKwVafaEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K156FxdMn32TdyO3PuIBVoIwwSUemqZanc+7u39d508EgPBMCm8P6qkM3mB9jz4E7
	 oIAWv2i+oNWWRkDfPu3FaUIC9n7nDIb3pg3KOQUKNsn/h7OPbFp+t/pvercPT+L3qy
	 ePbRY9APDHSanFlb4Yvz7jlTFA8yFomVAmwsBoU6DjoSjJXNzc5Azu8/r8qX3IOsdi
	 jViC7yaZQt4OeI2w8zgYJHkR3GueLGt5FEtk8jlxTBASN/Uv8OL3MC+jRwvWzDcVGS
	 Xwh8qO/gTeaDSqKT7zMwvI9xDLV/ykuXWgHMDfpC41jHxc33+2Wc09O4HI2Sno+8x1
	 fyyH7pG/3tUKQ==
Date: Fri, 9 Jan 2026 07:54:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Arnd Bergmann <arnd@arndb.de>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-apple: Add "apple,t8103-nvme-ans2" as compatible
Message-ID: <aWEWph1LT5Cd_HAV@kbusch-mbp>
References: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-nvme-apple-t8103-base-compat-v1-1-dc11727dc930@jannau.net>

On Wed, Dec 31, 2025 at 11:10:57AM +0100, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
> "apple,t8103-nvme-ans2" as fallback compatible as it is the SoC the
> driver and bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Thanks, applied.

