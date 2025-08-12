Return-Path: <stable+bounces-169289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45367B23A64
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 23:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C2C1893CEF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B960284B25;
	Tue, 12 Aug 2025 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2C2Zyf0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E82512F5
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 21:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755033109; cv=none; b=oJ4bJBUubJbJjozHqeT8CucNxBog4JrwHAs5jHzaInHr6hi0ppkWGLnhXyaMBbDoSmm4Hm6oOefvj8wAuMQlXFnS2u34RnUomQmRkWFMgTppakuP2NIb1vJolG0gMT0qPfsebxkucxsyXXa1R9KuEXk1xmyDEfnr7mG8fOkbOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755033109; c=relaxed/simple;
	bh=h1nWrNjyG3Oh+sW7y7sXS4dWVAb8+MQwbubSt6C0hJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYWCnIPnXejPy0uQVACJ02ChtW9gzS/Wmmj1Bm7Ta9+JxZpjYoRbmEs04mjNNG0DeHGO5HJUdQoFaPCrgsYjSofDbdT4RLEMHz877uQkBkEn/TisYBAt2cQiT8Km1T+CwwkaTXJKVE3P/XMlwzE/xsN/9UWZTOmu+wx+C2JY01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2C2Zyf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17365C4CEF0;
	Tue, 12 Aug 2025 21:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755033108;
	bh=h1nWrNjyG3Oh+sW7y7sXS4dWVAb8+MQwbubSt6C0hJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2C2Zyf0yCvIYG5/soJuTxp2SwIsJBJMNwY1N7mHlUR6l6d9iV6f+xA9UdGVIzPo8
	 WL/hep7WYBdfKC36jCJ4XUZkDYdHoX3zxRXK+Hd3uKqIU/EzLHgE60IJlKSSGJRbGp
	 nNxwmrNk07o9NE1X6/9zBKbAGsFAmLYrudMtFly9U2oj3SN0jIh9j/BFY+8W4F047o
	 LHubp9TpyAmiyNaWgJXFbTmjOCmqRE0bDbvcypbGuTthT10AAcaZl2DTyJHuzVNo4r
	 GAabe5iAf2GrXLN4R6MG603Gkuwl72sqUTmuJe3J0A20xSkLLqmdDbaocmWbzhyOJn
	 kdYUis2m9Zx1w==
Date: Tue, 12 Aug 2025 14:11:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.4 5/6] kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS
Message-ID: <20250812211145.GB532342@ax162>
References: <20250811235151.1108688-6-nathan@kernel.org>
 <1754967622-c52851ba@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1754967622-c52851ba@stable.kernel.org>

Hi,

On Tue, Aug 12, 2025 at 12:12:25AM -0400, Sasha Levin wrote:
> > The upstream commit SHA1 provided is correct: feb843a469fb0ab00d2d23cfb9bcc379791011bb
> 
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Nathan Chancellor <nathan@kernel.org>
> Commit author: Masahiro Yamada <masahiroy@kernel.org>

Hmmm, the patch has a "From:" header that has Masahiro as the author, is
that not sufficient for authorship?

> Status in newer kernel trees:
...
> 6.1.y | Not found
> 5.15.y | Not found
> 5.10.y | Not found

Odd, it appears to be there to me?

6.1.142:  8d21861f91a1 ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
5.15.186: 0690824cc325 ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")
5.10.239: 951dfb0bdcd6 ("kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS")

> Found fixes commits:
> 02e9a22ceef0 kbuild: hdrcheck: fix cross build with clang

Unnecessary in 5.4: https://lore.kernel.org/20250617233200.GC3356351@ax162/

> 1b71c2fb04e7 kbuild: userprogs: fix bitsize and target detection on clang

Uncessary in 5.4: https://lore.kernel.org/20250617232006.GB3356351@ax162/

> 43fc0a99906e kbuild: Add KBUILD_CPPFLAGS to as-option invocation

43fc0a99906e is present in this series after feb843a469fb0a because that
is how it happened upstream but 43fc0a99906e could be applied before
feb843a469fb0a in stable.

Cheers,
Nathan

