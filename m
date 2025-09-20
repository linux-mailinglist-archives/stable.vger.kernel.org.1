Return-Path: <stable+bounces-180719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B6B8BB6C
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 02:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97B07B3CC0
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 00:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371C9189;
	Sat, 20 Sep 2025 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwyrkjP5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D01D6BB;
	Sat, 20 Sep 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329737; cv=none; b=BfsOFDgyyTYyM+3TDzup9IGUv1vyibkTxvyiBuSaWMDrAESelD75PBAgeBSEUBr/xOwRdKfjsmWlEABRbwyVhNSQ+R4ApztR5PwbmHn9fpJBhirv4DlhsDCqp4tp8DjgfDwz7g21A66mlwcGafXio5avI30BWNSnoVoWkwHpscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329737; c=relaxed/simple;
	bh=xHhgtD9N0YYd+VEikxxpv6izJ9J1H9+FhgVzBmIlsCs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q1H+Q3aV11DZV2oc1R3O+nvsn/YeyK+vaaH4ZDJuOzceTa6Eu7hGlWpQGLCNlH1VcsjkRfT2VZytDYftJeDzY7SXo3nTDbYbVj+SxSqS5p+t0tZuq4OtXl2Nq11exYr+zFdwwsSsFOdj7V8EGQwxkRchttX8WDeFKlWd2n5tf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwyrkjP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2FAC4CEF0;
	Sat, 20 Sep 2025 00:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329736;
	bh=xHhgtD9N0YYd+VEikxxpv6izJ9J1H9+FhgVzBmIlsCs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OwyrkjP5Egxyz8TzAQyFy+05DLVpjvhb6wqgoc6Vj1KkCNBEi/uM6v75Bh09rPZ9P
	 PBTZm8hUe6EblRW1NsxY8T0YevPZdtA4Se31+jk9khlV2ITF+t1eoYK8dMTfMUYTpz
	 JQZ6AJgpO/Gh7JAH2A/ceIGg4IqvQzRiZebaPnaqefp4SSDEqvQe/Y4CGVM7sG3GeN
	 XZ8EdXYPZWQt9JrdyK+11ntDEudHuUlKn5vTcXj0cQ5Y6bd0pL6r8pFEeO+sYhX8vL
	 W0l2AN1ZInpeo+U3n6vAYlnQsLX6rQcmKh+BZac17eCtLVdb1b6quyOuM3pAfCX13s
	 PiK/HM4jCiSHA==
Date: Fri, 19 Sep 2025 18:55:28 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
cc: kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>, 
    Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Fix sparse warning in __get_user_error()
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Message-ID: <c7f5a944-0abf-8696-217b-4fee650ca96a@kernel.org>
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com> <20250903-dev-alex-sparse_warnings_v1-v1-1-7e6350beb700@rivosinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Sep 2025, Alexandre Ghiti wrote:

> We used to assign 0 to x without an appropriate cast which results in
> sparse complaining when x is a pointer:
> 
> >> block/ioctl.c:72:39: sparse: sparse: Using plain integer as NULL pointer
> 
> So fix this by casting 0 to the correct type of x.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508062321.gHv4kvuY-lkp@intel.com/
> Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, this one was sent upstream as part of the last fixes PR.

- Paul

