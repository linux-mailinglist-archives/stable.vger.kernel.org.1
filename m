Return-Path: <stable+bounces-107988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4DEA05C10
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 13:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C60165535
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B321F9A80;
	Wed,  8 Jan 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx2hSaH8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4E1F7589;
	Wed,  8 Jan 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340604; cv=none; b=DaRoYDyi7/k2IQo4kro16PQrCbbBRqqK66ps2TIGVNtv+XVxYSWWX9QBIha3QuumU1dsR/ScbYHf8Eiy+jaqSCYLu4T+VXOfoVQ6cU1e/DgD6GBz9vc4QLCGMR8BZFHSj1UuCEpxNC6BleofyxaxHb5zKxO+Qtn3g6/MKIRATho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340604; c=relaxed/simple;
	bh=Agh85AcU34sO5Z/y1T57IDqim/xqjFjzZrX9iq/AWhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz1g0D2/w9DHhgnUEhXgUL/202RxaHVq5G9qwkAQBuQW2mymRbaBA1SyjBF5rKhcnqqd63LN5E7tG5N40J7PBZvCvGYMRvMlz2+RUohJcUuhbyKkHQ6h/r+hkRttV9NMd5NMVtAoBp0D1M8i/C6nJmjCbrhAe37yUSj89IQMTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx2hSaH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E134C4CEDD;
	Wed,  8 Jan 2025 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736340603;
	bh=Agh85AcU34sO5Z/y1T57IDqim/xqjFjzZrX9iq/AWhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hx2hSaH8HClaYe8b0UKDF7yhn/t4kh2V2ZgANmR/EvoSSuGq4m2xLp0FrXDqC8U1W
	 gQjHw8fAfndfAdL4jxlWTgMvkDSnU3taWa1jeHHv++wOjKMnGI6/VojxaVBw0UnLEl
	 TbGy5/gLlgbYvhEjajj35fyYWMf8cOQ8YctAePKMwVjm0SSK1Oaxm5RKj2Ab5oQNz4
	 UGen/QjuIMVfB3Su/8vGNC0uw3gn4vwHr50C+Kxhr3K/4YWjDnfdZRyz2uQWolwXXI
	 CruYELhEwl/F2L7QrKsxAAZrxIsA2+NMOzFty4bKKO3cw7o8VY7TE/cGCjOvaITZfs
	 aqJN7GxmeHtdQ==
Date: Wed, 8 Jan 2025 12:49:58 +0000
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64/sme: Collected SME fixes
Message-ID: <20250108124957.GA9312@willie-the-truck>
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Dec 04, 2024 at 03:20:48PM +0000, Mark Brown wrote:
> This series collects the various SME related fixes that were previously
> posted separately.  These should address all the issues I am aware of so
> a patch which reenables the SME configuration option is also included.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Pull simplification of the signal restore code after the SME
>   reenablement, it's not a fix but there's some code overlap.
> - Comment updates.
> - Link to v1: https://lore.kernel.org/r/20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org

Mark (R), are you happy with this? I know you were digging into some
other issues in this area but I'm not sure whether they invalidate the
fixes here or not.

Cheers,

Will

