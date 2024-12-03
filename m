Return-Path: <stable+bounces-96220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDC19E18D0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CEBB2AEA7
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BFB1DE3A7;
	Tue,  3 Dec 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9k9Z3QO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856CD16EBE9
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217070; cv=none; b=VFYMn2OarGJRU+aC3ORw0i7m8q9bYglmjW/lZxNGml/BzCk2U6SEDfIjvBF5RTFHVJ0C94chYSWRf7DHSonJ7S8xvwaSOZJ5FvOllIWonTAJZjHP7/kz3oLTUhT/idcuAsXy1+MCxTf+Ie09s4PQUMGyCRnL5e2AZk9tjIgb2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217070; c=relaxed/simple;
	bh=rRVF4h2gsRpUCs4y153rMNNlRAfwgDlBWdEo9cpBaq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgPpKRezIKd0ZQEelQvveZWyZoB3FkMvzm4TVUPJYuVrF8Jxs+oIdzZ2j75ut+Guv2FJ0DvdxVm+GNjSZClem0/sIaH0A16bt8phYSU1nkt5NuytcjJECD+nZPW/1mXeE/7t50xYnABaCJl76qTH1vDs78CZALNIR8RTn7IgXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9k9Z3QO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E853EC4CECF;
	Tue,  3 Dec 2024 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217070;
	bh=rRVF4h2gsRpUCs4y153rMNNlRAfwgDlBWdEo9cpBaq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9k9Z3QO8mA9oFgLqHKvJzEGwLe4xMn98ZKX3SKDiEgsoAyVvuxWXi46MQvHL5xtC
	 /dtTmgjHSWEEj/xW/0lQFYdtjf+mxCEd4mUjrR7rlFc5MWK8QIrDRN89r1x1GJc/Bl
	 0XV+ztVOoiOR8yKwz1Z6uuq1Ks7PtL5HoKZti7Ww=
Date: Tue, 3 Dec 2024 10:11:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Sasha Levin <sashal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Rafael Beims <rafael.beims@toradex.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.11 v3 3/3] net: fec: make PPS channel configurable
Message-ID: <2024120358-saloon-diligent-2647@gregkh>
References: <20241202155713.3564460-1-csokas.bence@prolan.hu>
 <20241202155713.3564460-4-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202155713.3564460-4-csokas.bence@prolan.hu>

On Mon, Dec 02, 2024 at 04:57:13PM +0100, Csókás, Bence wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Depending on the SoC where the FEC is integrated into the PPS channel
> might be routed to different timer instances. Make this configurable
> from the devicetree.
> 
> When the related DT property is not present fallback to the previous
> default and use channel 0.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Rafael Beims <rafael.beims@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> (cherry picked from commit 566c2d83887f0570056833102adc5b88e681b0c7)
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Again, no blank lines.

thanks,

greg k-h

