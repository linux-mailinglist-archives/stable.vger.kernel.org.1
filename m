Return-Path: <stable+bounces-179370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6B9B54FDC
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B841D60B63
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C430E82A;
	Fri, 12 Sep 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xG5w1Vt/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594530DED0;
	Fri, 12 Sep 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684526; cv=none; b=SpQB5NVJv8IB/ZsPS4PfcOIZOBQ5DSWx0CiVIpB2w5hSCW0vA367TOLSVTSsuB0UhT6QkulvX9hq4B9jtKFKYBP2AG23XaNUrIeHRz5+V/uOzqT/7hrfy9sxDDHSIDpw64fLL5uqyQsRCfJ/CmBLYwynhFdBES+OXJid52HzZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684526; c=relaxed/simple;
	bh=U3uobCozwnx9lizz7F34LM6MEhZG08cfp1FJAGkl8iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBP58D0Se6AN1zX/zi/6oo+SJtk9EdAQrtjE866xhFix2pB5TXkSYo4EbL+2GKQMewm5+JWAY5xwBIjdaGHiVANvWftI+kSjldlnKgobOuf2VRtRLgHAor39YNKDSoDzJTW8Mmv0OfSYSgm8LMZsJLSeI9ucJ5tw+vePLSfb+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xG5w1Vt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E26C4CEF1;
	Fri, 12 Sep 2025 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757684526;
	bh=U3uobCozwnx9lizz7F34LM6MEhZG08cfp1FJAGkl8iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xG5w1Vt/GJO/gYqey6tkPgbjcIM20+TXU2ps3C8R+lyK538s5yT/9RtejXlPs+JyD
	 M7dk0LBWhlEEkGMfs2Bwgncsc99/r7ip+tt3MD3Wp0XkW1tDqxdRe3mDSbiosSOsOt
	 2h0RyPLlHd9I1sFdvhoJR7j4m4ipLoNY0RqnKyXQ=
Date: Fri, 12 Sep 2025 15:42:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: luc.vanoostenryck@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
	natechancellor@gmail.com, ndesaulniers@google.com,
	keescook@chromium.org, sashal@kernel.org, akpm@linux-foundation.org,
	ojeda@kernel.org, elver@google.com, kbusch@kernel.org,
	sj@kernel.org, bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	clang-built-linux@googlegroups.com, stable@vger.kernel.org,
	jonnyc@amazon.com
Subject: Re: [PATCH 0/4 5.10.y] overflow: Allow mixed type arguments in
 overflow macros
Message-ID: <2025091237-frugally-ultra-b3a5@gregkh>
References: <20250912125606.13262-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912125606.13262-1-farbere@amazon.com>

On Fri, Sep 12, 2025 at 12:56:01PM +0000, Eliav Farber wrote:
> This series backports four commits to bring include/linux/overflow.h in
> line with v5.15.193:
>  - 2541be80b1a2 ("overflow: Correct check_shl_overflow() comment")
>  - 564e84663d25 ("compiler.h: drop fallback overflow checkers")
>  - 1d1ac8244c22 ("overflow: Allow mixed type arguments")
>  - f96cfe3e05b0 ("tracing: Define the is_signed_type() macro once")

You forgot to sign-off on these backports :(

Other than that, they look good to me, thanks!  Can you resend with that
added?

thanks,

greg k-h

