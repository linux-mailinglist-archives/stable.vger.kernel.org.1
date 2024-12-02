Return-Path: <stable+bounces-96039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85E9E07B9
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61438B2620E
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF23C203711;
	Mon,  2 Dec 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sUbKxlo2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FF202F7B
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149304; cv=none; b=ZFkHuiQ9Ak6JI5bQHB5A0ol9poTA43vr5KOQUsxgx5ZL89BWIDK8qs2cdo3uKcdX1wpbRjC7OPQoMdD3LCKbso+gjBQ8ywD0CyxEWTTqy3OChzEn0ayOpiDgdX0VjZQnws5T3S5KHoeVtbvMnY15FB6BOu/Xi+hZMPfn279utS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149304; c=relaxed/simple;
	bh=gHUAW6NocCSkoZat0qV1AvtdstB7BwLfvlS/FYA0xxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1QMvADatEC29Ll3r47TTCvEA025plEf20qUa9v1lgJK92qDj/Xfcm81HRPwasXsEWRbZtk0C0yXJADXmfpgbYgOntbwLn99zAkC7n8GecN+IoUZ/nYZyIsD2fkhP2Bg4FF+MyVK/SsKJFUDwC+krLhLUMrESKOp6SvI7RkHSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sUbKxlo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0B2C4CED1;
	Mon,  2 Dec 2024 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733149304;
	bh=gHUAW6NocCSkoZat0qV1AvtdstB7BwLfvlS/FYA0xxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUbKxlo2GOAFT8EDuHF+bVbNZZvcD0SCp0Fa8YWCqXLRwWLiTUd+pRZDDSooTcU0k
	 q/bbdVnI/zwSsDKCFGfO9XuPTdequd57q6+mbAJPdLRwiosjfzeXWH8gcZQSoLWWr0
	 aOaYcHpZAE8fCHrtdLUU4wmDkfCglfxkRxoJ+TV8=
Date: Mon, 2 Dec 2024 15:21:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Sasha Levin <sashal@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.12 v2 1/3] dt-bindings: net: fec: add pps channel
 property
Message-ID: <2024120215-oblong-patient-779d@gregkh>
References: <20241202130733.3464870-1-csokas.bence@prolan.hu>
 <20241202130733.3464870-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202130733.3464870-2-csokas.bence@prolan.hu>

On Mon, Dec 02, 2024 at 02:07:33PM +0100, Csókás, Bence wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add fsl,pps-channel property to select where to connect the PPS signal.
> This depends on the internal SoC routing and on the board, for example
> on the i.MX8 SoC it can be connected to an external pin (using channel 1)
> or to internal eDMA as DMA request (channel 0).
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
> ---
>  Documentation/devicetree/bindings/net/fsl,fec.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

You can't forward patches on without signing off on them :(

Please read the kernel documentation for what signed-off-by means and
then redo these patch series.

thanks,

greg k-h

