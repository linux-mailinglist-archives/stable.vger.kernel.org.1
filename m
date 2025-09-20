Return-Path: <stable+bounces-180721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6F9B8BCBE
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 03:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F8C567892
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 01:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAA718DB02;
	Sat, 20 Sep 2025 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLmvgmYl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870B262A6;
	Sat, 20 Sep 2025 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332388; cv=none; b=h+LcXhAygyGe6zKY9+G4aAygxY3qAphEKtKyoE8ALFVr1DrCo+QNktN4jsumQYRLze0H8RJwH5sjRlhTAaA5Nm3oATtthK0RjaS+SkamJ0L804yZs5/TomB4I7mZ0FglTJa7WPE5dVuH4fLDvjiZxE1X/NTOXYL7SN9hfK9UymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332388; c=relaxed/simple;
	bh=rh7cwBrAE1IG7NHihASXimQd9HV1rWtmQL+DvATx5iQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QmtWlZIbGO30w6p92a9hLNh9jMvWEqos9/prJSA67ncSYCd2oy5CNQo59ZlUSDGFkOCLcBBYQvaHZIMl0AygaAB4gCm9V40HMLdsHXpjFy1xj2CoYGkHx3heUJVrvdMOTqxto96Bn4VUuiQYioHNQnpK/W+l+dL8v1LpVzS1g8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLmvgmYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D1DC4CEF0;
	Sat, 20 Sep 2025 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758332388;
	bh=rh7cwBrAE1IG7NHihASXimQd9HV1rWtmQL+DvATx5iQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DLmvgmYl20zs0XsXJmVoKH7ct1cO0poq4n+qzHjVZyMJOTwzmbLOOYDN0veqfzk8T
	 mLRSKhgy3gsEpA4PGbqUqoJTat8bECCvSKzFItR4zwhXJlPnPK+maNHj9u7MqwsLnE
	 7ze8DAuHMf6D4kQIgUEs+TatOE/yd2fV/m3v6b9/jXcPzo+h3WKTNFbywv6uvSRcjv
	 vpYqfJS9qmklrWSgDgY/bChTR5eP68eCM1gKpDXqe9NDBSNv6hFRdRc1tVdRHNO3Nu
	 crOJ7y4mGp/Nso/AV0+5r0fQuBV2DpsBl/J//2rbYejlQRNeRLlcjiMFDTlK1jEx/E
	 MapIpHyZSiDDw==
Date: Fri, 19 Sep 2025 19:39:43 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
cc: Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Use an atomic xchg in pudp_huge_get_and_clear()
In-Reply-To: <20250814-dev-alex-thp_pud_xchg-v1-1-b4704dfae206@rivosinc.com>
Message-ID: <c8afb3b4-e5d5-628b-6bce-0b1b3137a667@kernel.org>
References: <20250814-dev-alex-thp_pud_xchg-v1-1-b4704dfae206@rivosinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Alex,

On Thu, 14 Aug 2025, Alexandre Ghiti wrote:

> Make sure we return the right pud value and not a value that could
> have been overwritten in between by a different core.
> 
> Fixes: c3cc2a4a3a23 ("riscv: Add support for PUD THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> Note that this will conflict with
> https://lore.kernel.org/linux-riscv/20250625063753.77511-1-ajd@linux.ibm.com/
> if applied after 6.17.

Two quick questions on this one:

- I see that you're using atomic_long_xchg() here and in some similar 
functions in pgtable.h, rather than xchg().  Was curious about the 
rationale for that?

- x86 avoids the xchg() for !CONFIG_SMP.  Should we do the same?

thanks,

- Paul


