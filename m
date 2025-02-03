Return-Path: <stable+bounces-112038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB1A25F04
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD13161508
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89093209F58;
	Mon,  3 Feb 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r3XnTynn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38091209F4A;
	Mon,  3 Feb 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738597267; cv=none; b=kIVz1A5mKnqvtw99x85KpVx6ylm2lc/HKbJY+cgxtuvEe7L5QwkE35uJ2wnwmIC6AcNtGxMbZwdAlQQ8ntBidmjkI9Ax3diAvQtHihVklJ7oAGoKsrVSLYl/C0y0Y5r0SicbEqBdeQ1PuFkTJRdOFuzhclZpEkrzmVmdVfvFJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738597267; c=relaxed/simple;
	bh=t+e9M1T7gZCHqn15b4A9fYXOSiUPiS6xvK01k5AQCmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZZkl5krBndcERWwFLIQwb0wNCBih4vtGfh/lsrimX/bOJEkOjnLckpjm/YCpkT/YokX9H25vj2qCwk0PMYbhi3QGJQLydsxhmsSKXapcWmR/ThAzHPeCTbG5KnAaEinVBYFd0TfSL6lzsILLLXsJAjfmPf7i9TgIJ4XcvaLu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r3XnTynn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0F4C4CED2;
	Mon,  3 Feb 2025 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738597266;
	bh=t+e9M1T7gZCHqn15b4A9fYXOSiUPiS6xvK01k5AQCmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3XnTynnOTgsMtTNZO+Y1s25XmD2mIHCFryVo7nwyZI3zyudiqt6et+qxVlGT1B3r
	 pLYigZcxI3ih+eNjJ8EpjVzU1RPmO/yjtmjv1XJcDcwKrbHtRWX9ZZcA8Bc0LZhyeO
	 WZUUX39QMbBMfXqpEs6rdmznsK9cTbI85PX26Ma0=
Date: Mon, 3 Feb 2025 16:41:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guoren@kernel.org
Cc: palmer@dabbelt.com, conor@kernel.org, geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] usb: gadget: udc: renesas_usb3: Fix compiler warning
Message-ID: <2025020324-siding-custodian-b21d@gregkh>
References: <20250122081231.47594-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122081231.47594-1-guoren@kernel.org>

On Wed, Jan 22, 2025 at 03:12:31AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> drivers/usb/gadget/udc/renesas_usb3.c: In function 'renesas_usb3_probe':
> drivers/usb/gadget/udc/renesas_usb3.c:2638:73: warning: '%d'
> directive output may be truncated writing between 1 and 11 bytes into a
> region of size 6 [-Wformat-truncation=]
> 2638 |   snprintf(usb3_ep->ep_name, sizeof(usb3_ep->ep_name), "ep%d", i);
>                                     ^~~~~~~~~~~~~~~~~~~~~~~~     ^~   ^
> 
> Fixes: 746bfe63bba3 ("usb: gadget: renesas_usb3: add support for Renesas
> USB3.0 peripheral controller")

Please don't wrap lines here.

> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501201409.BIQPtkeB-lkp@intel.com/
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

No need to sign off twice on a commit, I'll just drop the last one as
that doesn't match the From: line here.

thanks,

greg k-h

