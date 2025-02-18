Return-Path: <stable+bounces-116792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F0A3A079
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57EB7A291A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31E426A0D2;
	Tue, 18 Feb 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDo2F8eN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9A2309B5
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890352; cv=none; b=sFJ6j7UedH2HXXTqj7skkF8Yiw8wUFYmVKEzfh0BmiKtBvBSKVXdGZURc2dipUr0yG6Jg10wJuH2RuaC1M5mts94VzdZ9PWeTZ4m9amkt55yf9lM+yotPkjTjQJRAsk0NJ9XY0sZN80fVhxbAyPDnu0OHhHwD2Jt3LtOpZHCmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890352; c=relaxed/simple;
	bh=O4JM2RTl3GhRfmA/F9MrWZ+AVrc+uu3kFC0l28qw7Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5na2uMhmvjWTttAQft5oSe85Y03oUwvYXmHiQpdpdxqoPMyn4pdjRY9gKON7OJz1mN4LebRjZf8GvjfLp65fcCOtjfR8zLWZhoRmW7aDfst/M0MVXXvbdllD4BucwL5CEd+WWCMgMj4iaqfmXe6RGOhr7bNxZhUY+/s7ghT7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDo2F8eN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D36C4CEE2;
	Tue, 18 Feb 2025 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739890352;
	bh=O4JM2RTl3GhRfmA/F9MrWZ+AVrc+uu3kFC0l28qw7Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eDo2F8eNAOQUmi3FXX1O3bL1wr9+YrrmhK96Pb1FQ05gzA7JdxOnUSmY7QzaP7wXL
	 QpMeIJnU2UP37sGrAC7G7e8sCJF/OOUFEpbNWqLlcYtRFu/6pfC96lnf2ykgWJUpH4
	 0WxoEJ+kSB1LSZNSG8EBagBQZLjhAlj/WIkCKnDg=
Date: Tue, 18 Feb 2025 15:52:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Brian Norris <briannorris@chromium.org>
Cc: stable@vger.kernel.org
Subject: Re: Request to apply 6d3e0d8cc632 to stable kernels
Message-ID: <2025021822-stung-sitcom-f0c6@gregkh>
References: <Z6P-BnP_nZRz_H00@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6P-BnP_nZRz_H00@google.com>

On Wed, Feb 05, 2025 at 04:10:46PM -0800, Brian Norris wrote:
> Hi,
> 
> May I request this be ported to stable kernels?
> 
>   6d3e0d8cc632 ("kdb: Do not assume write() callback available")
> 
> It landed in v6.6, and I've tested the trivial cherry-pick to v6.1.y.
> AFAICT, it makes sense and applies cleanly to at least v5.15.y and
> v5.10.y (and possibly more), although I didn't test those.
> 
> It's a bit of an older (but trivial) fix, and I assume not many folks
> actually test out KDB/KGDB that often, but I wasted my time
> re-discovering it.

Now queued up,t hanks

greg k-h

