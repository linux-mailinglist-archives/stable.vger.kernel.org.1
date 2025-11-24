Return-Path: <stable+bounces-196813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C4EC829EA
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 23:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637993AD5EB
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF0334C36;
	Mon, 24 Nov 2025 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4GPNWlQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E92D6E66;
	Mon, 24 Nov 2025 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764021851; cv=none; b=XxShjOnKX+GLL1AbanrLyXoZHdhih4lloAyzCmKArAStpMGs5fcGaUJbWHP+kkhckdOKCoiM/4Wt45iPG0UlDjV5IOFntpENFeWUIrWwuJceY8UtKIORU4f/0aQcIzXMClkCvHttVLrCiqmRr10kXN/whuqEXAGzUPsOzhhklZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764021851; c=relaxed/simple;
	bh=wceX8zBzs3TQ32cO+3gxNzC/X5/pmJ/YVHXZ4xod3NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpGY7y+w9xrIuWcsUrqR3Kyy0xLGY6zxdxe/SimDZg6mrY4oNX66ZGXnz0u/CnAC2QbOy5OnQokvN89R/9gHJyX7RS/eOpT5DGpRLZG5FN1fPB3A1C9X0vq6BBfijsHg7wY4WnmpCPiRJnrUBmFch/Q7Eb9qVWBJx/I+CqxerlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4GPNWlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098C9C4CEF1;
	Mon, 24 Nov 2025 22:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764021848;
	bh=wceX8zBzs3TQ32cO+3gxNzC/X5/pmJ/YVHXZ4xod3NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4GPNWlQcUb5ZNl8052dlx40gyVXArwJsylp2aOr4zu3JmjsLEF2agqtAlEZenNbY
	 HA4pWvkpzTfz1ZOsjxwcNtPoGunft0qb8qNsbUbvXHii2wJD9mfvminw9TneZSD15b
	 oJMbnvDJhmt5tGlNILoGJyOLe1BfcxXGnGfLLHXeG/ZBQpIu2jlfg1zsw+gVv4kKpj
	 6ArqqenmyYm+v24p6ZNQkqIzFULsyDOEzmqwGqwMg7ENCbb6BwF9/N17h3HqQOdQO7
	 X7wFGWlDLEWsgdFCalcxcq+qEl5kcbjIUCLiKZMhA/DouO/bez7aTmM+6sytzoz+Zr
	 4S8lX5dfsMp/w==
Date: Mon, 24 Nov 2025 15:04:04 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, gus@collabora.com, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build) variable 'val' is
 uninitialized when passed as a const pointer arg...
Message-ID: <20251124220404.GA2853001@ax162>
References: <176398914850.89.13888454130518102455@f771fd7c9232>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176398914850.89.13888454130518102455@f771fd7c9232>

On Mon, Nov 24, 2025 at 12:59:08PM -0000, KernelCI bot wrote:
> Hello,
> 
> New build issue found on stable-rc/linux-6.12.y:
> 
> ---
>  variable 'val' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer] in drivers/staging/rtl8712/rtl8712_cmd.o (drivers/staging/rtl8712/rtl8712_cmd.c) [logspec:kbuild,kbuild.compiler.error]
> ---
> 
> - dashboard: https://d.kernelci.org/i/maestro:5b83acc62508c670164c5fceb3079a2d7d74e154
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> - commit HEAD:  d5dc97879a97b328a89ec092271faa3db9f2bff3
> - tags: v6.12.59
> 
> 
> Log excerpt:
> =====================================================
> drivers/staging/rtl8712/rtl8712_cmd.c:148:28: error: variable 'val' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
>   148 |                 memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
>       |                                          ^~~
> 1 error generated.

This comes from a new subwarning of -Wuninitialized introduced in
clang-21:

  https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e

This driver was removed upstream in commit 41e883c137eb ("staging:
rtl8712: Remove driver using deprecated API wext") in 6.13 so this only
impacts stable.

This certainly does look broken...

  static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
  {
      u32 val;
      void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
      struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;

      if (pcmd->rsp && pcmd->rspsz > 0)
          memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);

Presumably this is never actually hit? It is rather hard to follow the
indirection in this driver but it does not seem like _Read_RFREG is ever
set as a cmdcode? Unfortunately, the only maintainer I see listed for
this file is Florian Schilhabel but a glance at lore shows no recent
activity so that probably won't be too much help. At the very least, we
could just zero initialize val, it cannot be any worse than what it is
currently doing and copying stack garbage?

Cheers,
Nathan

