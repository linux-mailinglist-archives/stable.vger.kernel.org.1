Return-Path: <stable+bounces-96215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A09E16C1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4AF284DA3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF251DE3BA;
	Tue,  3 Dec 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPK0D+QH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE981DD0F9
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216961; cv=none; b=mwp/BqZJ7rFA+ydkso/6D4moY1T3KbZiOB1lqM7fBNSB/W16fUNVsSeyRekU6wVW5CnECnU9TEC876YUbsEEMPSTFZhJaOeE5sU+c2PAeKJ7kqZ2VKm//LrBEfsV6uUiEllyQHb91nPSmrzA+7Cs9fa8Y0QVQ1roD4zZ+jmGem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216961; c=relaxed/simple;
	bh=oGgQyep4szuI4vrqS60PqHHHTV3+vmDvrDubbA29uoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUREywkv0Z+7JataLgd3rX5m+BTMUk+jhdTyEhF7ViOf2ag+HeLNpmF8Me314UhI2IRKs+N8IX2ndBkXxM4m2flVGGZunZBjUAsrohnFa2MbZ2IeRp0mFMfWiYw/P4sZz4o8u7DRjptVQu2bpZ7YOoylliaRm8+OT/NfT8BrkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPK0D+QH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B626AC4CECF;
	Tue,  3 Dec 2024 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733216961;
	bh=oGgQyep4szuI4vrqS60PqHHHTV3+vmDvrDubbA29uoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPK0D+QHVQ+H3wOHT7q/hviqMvDGdSBBH6DE8laTtaBYmyhiHFzlV0eSmgPzoYpfE
	 Q785jzdt2vxwgXl9pIlFiu0dz2JeNT1JlfPnWEqSum990zLC0tUbY0IB/v7d0fRh4j
	 IOOsjLe1uf3KHWccAQhNrxoElCVr9/u9CQvNHF08=
Date: Tue, 3 Dec 2024 10:09:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Sasha Levin <sashal@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.12 v3 1/3] dt-bindings: net: fec: add pps channel
 property
Message-ID: <2024120307-cobweb-bring-0bcb@gregkh>
References: <20241202155800.3564611-1-csokas.bence@prolan.hu>
 <20241202155800.3564611-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202155800.3564611-2-csokas.bence@prolan.hu>

On Mon, Dec 02, 2024 at 04:57:58PM +0100, Csókás, Bence wrote:
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

No signed-off-by from you :(

