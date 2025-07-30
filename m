Return-Path: <stable+bounces-165528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7687CB162B6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B576A170F73
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512CA2D9797;
	Wed, 30 Jul 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ax415/bk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5F2BD582;
	Wed, 30 Jul 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885608; cv=none; b=kWDrhBgmXwmG1uptKpFsLmovUV/F4UvqcYysSUzsCLZY6ngCHr/yj+KlBauksgaLgNcItVP1Hfo2adDVz4N4/Fksiyag0bzXR5rGx7mI+LadCOPGFZQtGFDSr/5LW0FH5Q2inCa4QTY+A4cjc7uuUV0Y5fgHGosypa+g4j9y1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885608; c=relaxed/simple;
	bh=NzNLnN8gkgPqDzoHuFxVWpIUGLGJD3DT7IFgIBIS9g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONqvnMtdh2HOFyy8kBeT0znEzdtJ+n6Uo/xdlzcPO/4vK84259mY8ce/tiC/B1g89IjeT2jMuLNqcsjwqwnYl3R66BfIJLzOetxJZ8PFwg40OlBIYZKfLyctOxhCFo8GObngXqs4iPDh7HHwLeDJuABkgSscRa6ocgs3tuHhxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ax415/bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87A8C4CEE3;
	Wed, 30 Jul 2025 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753885607;
	bh=NzNLnN8gkgPqDzoHuFxVWpIUGLGJD3DT7IFgIBIS9g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax415/bk24Tzgeq1G/8ojgjMZ9l4aOhSrbgBipGN/WHjGqJ9XbB6s5ML3cPEXE36a
	 lStSND8JC/ZBTua/JbEymvfLm5FGiSN5yoNjxoRXymTzlLsqTyzkGwV5j5gk320SIc
	 oKRkSmA2J2fnYhNe2k2qwdRIZ/7jrS2fSCWUvkUY=
Date: Wed, 30 Jul 2025 16:26:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: Yi Yang <yiyang13@huawei.com>, GONG Ruiqi <gongruiqi1@huawei.com>,
	Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Text mode VGA-console scrolling is broken in upstream & stable
 trees
Message-ID: <2025073054-stipend-duller-9622@gregkh>
References: <C4_ogGo3eSdgo3wcbkdIXQDoGk2CShDfiQEjnwmgLUvd1cVp5kKguDC4M7KlWO4Tg9Ny3joveq7vH9K_zpBGvIA8-UkU2ogSE1T9Y6782js=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C4_ogGo3eSdgo3wcbkdIXQDoGk2CShDfiQEjnwmgLUvd1cVp5kKguDC4M7KlWO4Tg9Ny3joveq7vH9K_zpBGvIA8-UkU2ogSE1T9Y6782js=@protonmail.com>

On Wed, Jul 30, 2025 at 02:06:27PM +0000, Jari Ruusu wrote:
> The patch that broke text mode VGA-console scrolling is this one:
> "vgacon: Add check for vc_origin address range in vgacon_scroll()"
> commit 864f9963ec6b4b76d104d595ba28110b87158003 upstream.
> 
> How to preproduce:
> (1) boot a kernel that is configured to use text mode VGA-console
> (2) type commands:  ls -l /usr/bin | less -S
> (3) scroll up/down with cursor-down/up keys
> 
> Above mentioned patch seems to have landed in upstream and all
> kernel.org stable trees with zero testing. Even minimal testing
> would have shown that it breaks text mode VGA-console scrolling.
> 
> Greg, Sasha, Linus,
> Please consider reverting that buggy patch from all affected trees.

Please work to fix it in Linus's tree first and then we will be glad to
backport the needed fix.

thanks,

greg k-h

