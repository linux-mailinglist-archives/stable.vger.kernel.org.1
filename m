Return-Path: <stable+bounces-62808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C5941377
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951541C23598
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFAE1A00ED;
	Tue, 30 Jul 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1eAbqWa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01F19E7E3
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347117; cv=none; b=RtOnXh4y3wRbR1sum/tQIjMPhHBumM1AzNHIssO/Rg6lMrcdxxwUGr/vC6SAlPwjcZCKR8953ZJKeStpG9hIK33KO1iziuIMIYlCJBPpjCJmCVokiclpMaUru4SIptKNFv41PCW9cU50U+DabtnTgumCfXEiTcU7CS60/RxIowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347117; c=relaxed/simple;
	bh=+zsI6u1pamv4zfSkp3vIYVQE6SGk1QRtdxKnss1H2KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlgBnEzU94/21O+ciYECN7JaelfbeMBKQLGQ1g8d25hWmp0pngrzp+oQ8FX0fPuW50fXtRXnBF/YRlykBqAeXPxTwNhpdOKJm19jGfHqAp58ejkpnO/rwpL4SsTlTGqHuZcYSD5muZ3VsmaKAMgOynIqB3FPwLTMJiHtKuJTUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1eAbqWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAB4C32782;
	Tue, 30 Jul 2024 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347116;
	bh=+zsI6u1pamv4zfSkp3vIYVQE6SGk1QRtdxKnss1H2KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1eAbqWaTCNi4HjS6ht+5LIEMeSda2Q44FNoaj2IVjPTwxh77b4QFgTpeRouPd6tB
	 4AdP3N5Nl7Bt3nUF3C3CkI0nBhw5K9Jw20NJoXxD04e5KkKqjz2qLjCIHYzs981zB8
	 CjJIAnm941DX97s2Ck4fM7b3BlAR8bD9CycB7DaA=
Date: Tue, 30 Jul 2024 15:45:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: stable <stable@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
	Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: stable-6.6: Reproducibility fixes
Message-ID: <2024073004-puppet-amiable-bab9@gregkh>
References: <CAOMZO5DymKk1oJM-Q+a_7hKSSLcxSs8D+EM=jUbT+Bj2g_nXnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DymKk1oJM-Q+a_7hKSSLcxSs8D+EM=jUbT+Bj2g_nXnQ@mail.gmail.com>

On Fri, Jul 26, 2024 at 11:22:43AM -0300, Fabio Estevam wrote:
> Hi,
> 
> Please consider applying the two commits below to the linux-stable 6.6
> tree as they fix reproducibility errors reported by OpenEmbedded:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/lib/build_OID_registry?h=v6.10.1&id=5ef6dc08cfde240b8c748733759185646e654570
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/video/logo/pnmtologo.c?h=v6.10&id=fb3b9c2d217f1f51fffe19fc0f4eaf55e2d4ea4f

Both now queued up, thanks.

greg k-h

