Return-Path: <stable+bounces-73057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5806696BFDA
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32720B226A6
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959451CFECB;
	Wed,  4 Sep 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HsONAqvT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52648441D;
	Wed,  4 Sep 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459403; cv=none; b=Rt3Jafh+yCZ7UZQ8sGOgWxD1av9+rA0US6d4bEcRsonsSGkXgIORSrObEW3CACSYBGqDb7+THheSMx8tqQlo1QQbpuIuF9INtf3UzuuReJ2rGLnKasiBWi7+aRcV6ML0ZsWaoFfhH214ReDKepuzP5ZXqV5R2eG5FqVgYZWwqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459403; c=relaxed/simple;
	bh=+XqebrZoKyaredrRcegCEDFcx02aoHVTTevjI+CEAvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCkIwBpw9nekcM+d2BknDBRkuWuNmYaR8ClvaKP4mxKzsHrOS1StJifDZq3UaHBVomZzh6QPLXtYdEtxnicclR5lgxMIrC0eKoDyLsYaoqDPdiHLlAru6GLqdlaaRQhQf/9JpCVyayvoSpnJHYEv4G6M1UiWvS1y1gy2tsPnGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HsONAqvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29A8C4CEC2;
	Wed,  4 Sep 2024 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459402;
	bh=+XqebrZoKyaredrRcegCEDFcx02aoHVTTevjI+CEAvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsONAqvTKsePkjBVc8zcBscH3gt62Bjk+heKpxGQeLhRRAxY2i3n+atbcnTElGx1q
	 TWQJRLiLqBl3/FNJwOjYJInWmkNReZLUyNMJEAmQIdneHKa9WiUdZwJuQ6wlL6zvkT
	 kMqdl+mn1Omx2JXirL+5nxok6Uf/X9gxdxo0bOe4=
Date: Wed, 4 Sep 2024 16:16:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	mptcp@lists.linux.dev, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.10.y 2/6] selftests: mptcp: join: test for flush/re-add
 endpoints
Message-ID: <2024090432-vanilla-earthly-9671@gregkh>
References: <2024082617-malt-arbitrary-2f17@gregkh>
 <20240902172516.3021978-10-matttbe@kernel.org>
 <1311d6a3-2007-4b26-aade-6c181ff67372@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311d6a3-2007-4b26-aade-6c181ff67372@kernel.org>

On Wed, Sep 04, 2024 at 02:40:52PM +0200, Matthieu Baerts wrote:
> Hi Greg, Sasha,
> 
> On 02/09/2024 19:25, Matthieu Baerts (NGI0) wrote:
> > commit e06959e9eebdfea4654390f53b65cff57691872e upstream.
> > 
> > After having flushed endpoints that didn't cause the creation of new
> > subflows, it is important to check endpoints can be re-created, re-using
> > previously used IDs.
> > 
> > Before the previous commit, the client would not have been able to
> > re-create the subflow that was previously rejected.
> > 
> > The 'Fixes' tag here below is the same as the one from the previous
> > commit: this patch here is not fixing anything wrong in the selftests,
> > but it validates the previous fix for an issue introduced by this commit
> > ID.
> 
> FYI, Sasha has applied all the patches from this series, except this
> one, the backport of e06959e9eebd ("selftests: mptcp: join: test for
> flush/re-add endpoints").
> 
> In theory, this commit can be applied without any conflicts now that
> commit b5e2fb832f48 ("selftests: mptcp: add explicit test case for
> remove/readd") has been queued in v6.10.

Thanks, I've done that right now.

greg k-h

