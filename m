Return-Path: <stable+bounces-154594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B45ADDFB1
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 01:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA346175AAA
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170A215077;
	Tue, 17 Jun 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL9QAfqq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5700136A
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203125; cv=none; b=L9SOGCSSuAAifoCvt5nyzQaarx878W29jWK8cUjde4Egt8uUtQPFvCXF7bNlZAx/rLK2HacEJnsDbAlz29QknqiUfKHeOZ16raFH3zpe2rkcjB8grCQbOmULdzw1CcNp3IOAckqtl1ORXz00oQN3ks7LFxYlYyTS6FMytLlr4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203125; c=relaxed/simple;
	bh=tAxOC8hGXylSReQAjCj7wSlZDVQYhreRK9e5b7fn2YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0KOnl40pWr7b6Hh3gWufqUO/5B0+gYqE4gjSVvPLUxCvpHlaTnUC9OBxAnSaTSwYPGjEr7nYzZL7pePtDCg6taUcq+tn+Hdew12ZT8xpHVP7hhOE+j+JAkbkcMfCVU2IjNBBDCcq0Z5sOoJQimRHy+SuFVAmv/BdqDvPi7Dmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL9QAfqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C15C4CEE3;
	Tue, 17 Jun 2025 23:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750203124;
	bh=tAxOC8hGXylSReQAjCj7wSlZDVQYhreRK9e5b7fn2YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fL9QAfqqJgWBKFOeM75S8CQPGrCJo9t9vVpUjAc8TeNtY6BUm4AsYP3ayRuNEuDRh
	 3HsekLHPJUZ5xCm4bgdyZKIBG0ZBDF6hpJDmawIIdyR8bxDYbTMBS4QS7SFw9Ghlrs
	 dFSoiRYo06gwGDop9wm4tBc3KQnxo6rduLRJJaPVkmHQPTqwldkx+5v/XLsj4q3aBS
	 yc6PAmZiSMSt2aHTXzmNJR3XajKPVEEMJ0BcWXu0onsrKer0SSKqWA7Ww6VzdZwvha
	 l36NqH9UM8xdFxV2NnW6lPpXQcSBHRMgypSZRNbMUjra9I/iKf9curh8GP+ic673xr
	 LqV9147qb10dQ==
Date: Tue, 17 Jun 2025 16:32:00 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] kbuild: hdrcheck: fix cross build with
 clang" failed to apply to 5.4-stable tree
Message-ID: <20250617233200.GC3356351@ax162>
References: <2025061706-stylishly-ravioli-ffa1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025061706-stylishly-ravioli-ffa1@gregkh>

On Tue, Jun 17, 2025 at 05:10:06PM +0200, gregkh@linuxfoundation.org wrote:
> From 02e9a22ceef0227175e391902d8760425fa072c6 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 25 Feb 2025 11:00:31 +0100
> Subject: [PATCH] kbuild: hdrcheck: fix cross build with clang
> 
> The headercheck tries to call clang with a mix of compiler arguments
> that don't include the target architecture. When building e.g. x86
> headers on arm64, this produces a warning like
> 
>    clang: warning: unknown platform, assuming -mfloat-abi=soft
> 
> Add in the KBUILD_CPPFLAGS, which contain the target, in order to make it
> build properly.
> 
> See also 1b71c2fb04e7 ("kbuild: userprogs: fix bitsize and target
> detection on clang").
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Fixes: feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 6c6de1b1622b..e3d6b03527fe 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -10,7 +10,7 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
>  
>  # In theory, we do not care -m32 or -m64 for header compile tests.
>  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
> -UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
> +UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
>  
>  # USERCFLAGS might contain sysroot location for CC.
>  UAPI_CFLAGS += $(USERCFLAGS)
> 

Commit 9fbed27a7a11 ("kbuild: add --target to correctly cross-compile
UAPI headers with Clang") in 5.18 introduced '--target=' here; prior to
that change, feb843a469fb would have no effect, so this change is
unnecessary for 5.15, 5.10, and 5.4 (the current 5.10 and 5.15 backports
are not harmful but they do not do anything as far as I can tell).

Cheers,
Nathan

