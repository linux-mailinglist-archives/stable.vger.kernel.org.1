Return-Path: <stable+bounces-99058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D869E6E90
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003AD281AD1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6E200130;
	Fri,  6 Dec 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hh6GHUlS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07910E6
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489520; cv=none; b=sI53kflBCqcq71Khhv6dI13KNooOTyxvl1JbV/TUc6BX7xaVAw/EnVUWsrVE3ED/NtHH1dZfId4gAj3g41cUPWWgSsx+jX1aZgby5XJ3f0OzCAMJKTK++0pxHvn8CxwFpYFGORL+WnD4oGEdDPw+/dcNlSFEhpLOsc+0KcvuTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489520; c=relaxed/simple;
	bh=Fr+eN7Mbfm4/7eG+xDqlT6vJxZkaQ2nGUghEYEfaUUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHPcRc7F2KxAMmQJupXl/hJH8J98w6fLH8lVS1QpXJf1H4vENSPxTTQ1DaUkgnGlYXHMefNRnaYaF1hmKFehw4V7UpNvxMpAbP0XCG5z3CVcCY7eeuKtO7nXlroONo3clTZ57QI42py87Nj+Y6GnYVL9UaZ1+nTLORKgzb8a79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hh6GHUlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E66C4CED1;
	Fri,  6 Dec 2024 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733489520;
	bh=Fr+eN7Mbfm4/7eG+xDqlT6vJxZkaQ2nGUghEYEfaUUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hh6GHUlSe/rXym/pH9AQ4oGhj6GWxU68X+zb2uD4wIfqDQG7shyzmUFjN82wTvO8S
	 ICI6mDx8Idk/QW8kitydHdKQLBNlEDu0SlSrcHDZu5m59WePIOqh6KLito+x4L9ZZD
	 MKuDeMjEaPnnH12U+X2OQJ7rmMuhr9UqbHup9P2Q=
Date: Fri, 6 Dec 2024 13:51:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-stable <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: stable-rc-queue-6.6: Error:
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts:114.1-5 Label or path bsc not
 found
Message-ID: <2024120640-charbroil-viral-075e@gregkh>
References: <CA+G9fYuMnDvMK-4PRmyOk+KKFONrPPwRtFpnAVtUPrmQhcbOfw@mail.gmail.com>
 <CAMuHMdW7RwVCbubxw_-=4-zHvGjip0oZED_DLmY=C9BNAmoyRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW7RwVCbubxw_-=4-zHvGjip0oZED_DLmY=C9BNAmoyRg@mail.gmail.com>

On Fri, Dec 06, 2024 at 10:53:14AM +0100, Geert Uytterhoeven wrote:
> Hi Naresh,
> 
> On Mon, Dec 2, 2024 at 2:04 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > The arm build failed with gcc-13 on the Linux stable-rc queue 6.6 due to
> > following build warning / errors.
> >
> > arm
> > * arm, build
> >   - build/gcc-13-defconfig-lkftconfig
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build errors:
> > ------
> > Error: arch/arm/boot/dts/renesas/r7s72100-genmai.dts:114.1-5 Label or
> > path bsc not found
> > FATAL ERROR: Syntax error parsing input tree
> 
> I guess this is due to
> 
>     commit a670e8540da2de723c0eae14ef8234b0ada6b542
>     Author: Geert Uytterhoeven <geert+renesas@glider.be>
>     Date:   Thu Aug 31 13:52:32 2023 +0200
> 
>         ARM: dts: renesas: genmai: Add FLASH nodes
> 
>         [ Upstream commit 30e0a8cf886cb459dc8a895ba9a4fb5132b41499 ]
> 
> which depends on commit 175f1971164a6f8f ("ARM: dts: renesas:
> r7s72100: Add BSC node") in v6.7.

Now dropped (this was a dependancy for another fix, which I've also now
dropped.)

thanks,

greg k-h

