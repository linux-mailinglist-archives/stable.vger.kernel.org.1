Return-Path: <stable+bounces-154593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91312ADDF90
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 01:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54345178867
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 23:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5F29C33D;
	Tue, 17 Jun 2025 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZo0v4e6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DB2EFDA5
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202411; cv=none; b=hVJv2oqc4j65ebgaKvlISP2tBCdIykomrX/7zrcyteMoIH/Mk+JqQzn+LprQaAXQXAWWxd06bvjh7YJA5jPXs2gN9ueH69Yhrw4/y3syio+W6WIaSkB09aqW5TuKm74UXfAHJHbyXYXZNQZEoioGF/MzLG9evElBgtSgmzG7+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202411; c=relaxed/simple;
	bh=FeGgz/4aR1dQDapybZYPllqTCHa5HdoQu2OqqRhwWnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc0JQ5l9z5pSESPZheIjx0H98YhOhT9E93lo/SxSqmUMF2EQ0AtUkPYfzPX+Thh5W4QjrVoFSIDsbloYKJ726MRdUqAcVj00W1hOghJo54OJJAuwY93CHA888CJgj6bYikiDGIWa4Zpz81C/IaC3vl6yhWx2V+Gl5czvufrNuWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZo0v4e6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AFFC4CEE3;
	Tue, 17 Jun 2025 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202410;
	bh=FeGgz/4aR1dQDapybZYPllqTCHa5HdoQu2OqqRhwWnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZo0v4e6UsNWNHzteDALxU7EXVrIXtQGVkavqE1S+wCVZPsdN9E9BNE8raAlE8GtJ
	 1mzo4wAOwiMo6Qu1rwCt5yMxlmezel32/2gUzRIJVYq8qAXjOC3xI1iabFdPxrUh2c
	 eBL9VtCm/KOfdhGOMB2bBDGpbcnZ/I+UyCxAGCzcraRUoiHTJnR/O3Ni6v2yWqpc6G
	 QhcVkYyaAeINZbG3S2XGnj5vlXcKL4Ji3sGNK4vaWU5c7p19/87IznBci/ieoASRJ1
	 bsvkwiSw4S83d5PmzdDw8x1CKQVEpIuHpoflqcrEBLfKt7431+pap3uLEftR26heH2
	 e7II0ksZQ2SPA==
Date: Tue, 17 Jun 2025 16:20:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: thomas.weissschuh@linutronix.de, masahiroy@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] kbuild: userprogs: fix bitsize and target
 detection on clang" failed to apply to 5.4-stable tree
Message-ID: <20250617232006.GB3356351@ax162>
References: <2025061733-fineness-scale-bebf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025061733-fineness-scale-bebf@gregkh>

On Tue, Jun 17, 2025 at 05:08:33PM +0200, gregkh@linuxfoundation.org wrote:
> From 1b71c2fb04e7a713abc6edde4a412416ff3158f2 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
> Date: Thu, 13 Feb 2025 15:55:17 +0100
> Subject: [PATCH] kbuild: userprogs: fix bitsize and target detection on clang
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> scripts/Makefile.clang was changed in the linked commit to move --target from
> KBUILD_CFLAGS to KBUILD_CPPFLAGS, as that generally has a broader scope.
> However that variable is not inspected by the userprogs logic,
> breaking cross compilation on clang.
> 
> Use both variables to detect bitsize and target arguments for userprogs.
> 
> Fixes: feb843a469fb ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for figuring out that I missed picking this up in my backports.
This is not needed in 5.4 because the userprogs infrastructure was added
in 5.8 with commit 7f3a59db274c ("kbuild: add infrastructure to build
userspace programs").

Cheers,
Nathan

