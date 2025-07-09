Return-Path: <stable+bounces-161421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70414AFE5FC
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F341C412A6
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9EA28DB45;
	Wed,  9 Jul 2025 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNlrtuRE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6462749F1
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057581; cv=none; b=hCwQZvewoybtf6Y/ZsJO2OJCrTNCkzGy6s1zAnyph7FvO0Gt95R3vmeD0236Q63wEz/0pv1ygCG294P/dvGUbUrwrYU6ZzLLs2WIA83ZFuWQ/XAZngfsozVUAyUVuqBbKtCtJKGGzgyGRLHmM1ZzdbweZ4115fOQEfiqQoYaCFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057581; c=relaxed/simple;
	bh=TWPjjVwTDG9DdNR/Pmi7LJCmkQWeeFslBLY28yXv2IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOiLwoVrmbCcERb8OfC1aj0Q09Gdi3GC6BZ9OfMjXEx9SY5AvcpLI1DLiUUuX49eiw7hdvLPT2M+tT83KUok80GG04zqSU5hTUM5i0G9p/uNJtER8toGv24vrPuFkMqo+YNkUhUP0kJpKIqqJyThAaHaSXkDwK6aZnr5VKWd0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNlrtuRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FBEC4CEF4;
	Wed,  9 Jul 2025 10:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752057580;
	bh=TWPjjVwTDG9DdNR/Pmi7LJCmkQWeeFslBLY28yXv2IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNlrtuRE88ljlLi5o+hwt5uPknw19y0s+cVelaibA2LOcKYkli+DGtQEZOF4CTQ0G
	 4xv2F32zm5CfuiVkIOtrjG9twvpmA+BUDwLI2yz/T9BenbcHacIDFMKPqlZ46xII10
	 tUINw/CtCgigLUBbFYfS3Y4UPKsHI5BXpo8/PVYw=
Date: Wed, 9 Jul 2025 12:39:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: stable@vger.kernel.org, luca.ceresoli@bootlin.com,
	olivier.benjamin@bootlin.com, thomas.petazzoni@bootlin.com
Subject: Re: Backport perf makefile fix to linux-6.6.y
Message-ID: <2025070906-john-uncouple-3760@gregkh>
References: <DB7G4ZS920XB.1I7M44B53YY6Y@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7G4ZS920XB.1I7M44B53YY6Y@bootlin.com>

On Wed, Jul 09, 2025 at 12:19:01PM +0200, Alexis Lothoré wrote:
> Hello stable team,
> 
> could you please backport commit 440cf77625e3 ("perf: build: Setup
> PKG_CONFIG_LIBDIR for cross compilation") to linux-6.6.y ?
> 
> Its absence prevents some people from building the perf tool in cross-compile
> environment with this kernel. The patch applies cleanly on linux-6.6.y

Is this a regression from older kernels that was broken in 6.6.y, or is
this a new feature?  If a new feature, why not just use perf from a
newer kernel version instead?

thanks,

greg k-h

