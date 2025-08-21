Return-Path: <stable+bounces-172220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49DB30233
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4813D1887A55
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C21531F9;
	Thu, 21 Aug 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmDJFU9Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DE2E2829
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755801357; cv=none; b=mHmGXtcl+HIQ3zrOAb7qNoxn4/mTgq1Xp349ek8F48NDMnKMUAlb0RMfRIg3sUcntXptv9Lc475oiqNJW8hVq1BLc4sHeN7WpfMKQzD9snMO1JZhQwN+XkFD6fZB0QZtRMJUODW6jWO3S9eUraA8+nsZluxEb8Chp4bQVTCz9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755801357; c=relaxed/simple;
	bh=4M0la3ztP0+nQkxCBoMClOk87Z8IUf/9DnqFFTFav9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDQD0m+cXtf/7ZSg/2peDtf0w9o9VS7J2kUOpd4f8I1i6tyZzXDOJq+AA1IjFPYM7wFQkONNQirednBC6RSDqnoc28Q4Yprl6m3mf9Ey2x5POu/Yryav1Trnd9L2t7izGJYM0XX5EieXtV4o8B2TCCxNnpx89gL9wdpM4Xrzkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmDJFU9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A540C4CEEB;
	Thu, 21 Aug 2025 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755801357;
	bh=4M0la3ztP0+nQkxCBoMClOk87Z8IUf/9DnqFFTFav9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmDJFU9ZUSEVi6ZnDk2qCUYmdrQ44XbReiUtsPWCc+qmpkBFxhQYmThf9cjQpN328
	 wPIAcZQSGc0kU3f7HgVR8IzcA7IraxmiJy4PP10HDmjP9wEERhprBpENqefBJHlbV5
	 QzwQ5vemfR8WUcIrR68rEO1ETZXR4V8E/Id77MZ+qH5VIrSEtL5FQwZiQponQE8yTR
	 hYTiiAxUuc5h2Rd6yqf9E3feZW6Od5XqUNl7oNeutiyoudz+G/oefTniq4SOhEhX77
	 GRlFhXqiZYrYkhvCkcaFiI7B8FArdL9wXLtQsSeoaLvoJOJGCB+2ygbFk0Kxc/TwND
	 3mamm4rVnULvg==
Date: Thu, 21 Aug 2025 11:35:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: thomas.weissschuh@linutronix.de, masahiroy@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] kbuild: userprogs: use correct linker
 when mixing clang and" failed to apply to 5.4-stable tree
Message-ID: <20250821183553.GA1697222@ax162>
References: <2025082106-cheer-train-f1fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082106-cheer-train-f1fd@gregkh>

On Thu, Aug 21, 2025 at 03:31:06PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
...
> ------------------ original commit in Linus's tree ------------------
> 
> >From 936599ca514973d44a766b7376c6bbdc96b6a8cc Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
> Date: Mon, 28 Jul 2025 15:47:37 +0200
> Subject: [PATCH] kbuild: userprogs: use correct linker when mixing clang and
>  GNU ld
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The userprogs infrastructure does not expect clang being used with GNU ld
> and in that case uses /usr/bin/ld for linking, not the configured $(LD).
> This fallback is problematic as it will break when cross-compiling.
> Mixing clang and GNU ld is used for example when building for SPARC64,
> as ld.lld is not sufficient; see Documentation/kbuild/llvm.rst.
> 
> Relax the check around --ld-path so it gets used for all linkers.
> 
> Fixes: dfc1b168a8c4 ("kbuild: userprogs: use correct lld when linking through clang")

While this commit is in 5.4, it does not actually do anything because
the userprogs infrastructure was not merged until 5.8 in commit
7f3a59db274c ("kbuild: add infrastructure to build userspace programs").
So I don't think it is worth applying this.

Cheers,
Nathan

