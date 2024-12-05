Return-Path: <stable+bounces-98750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD039E4F33
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8829E1881E06
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E71CEE9B;
	Thu,  5 Dec 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cCM/WL7A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2C1B4138;
	Thu,  5 Dec 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385847; cv=none; b=SkOaqXbGoR0uwck+1zWRTDBOflb6eM3h8vD4K7cRIXxr7mU+QOsPafYoE9EjdOjoe/QiQOO0eTQgI0NOZlxXiqTzi530W/N41vkDBPzUnVGC5TdRFWYGCaOPej2h0kTidzmpdZ+NptTNcPCXXtBW1s72WCAGt1Shxw3VVJ59OZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385847; c=relaxed/simple;
	bh=FIozSi8SgpqkY9ZdwR7YpI65MxDaseGvlnzWbKVg2nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCuiYNoFWnSpkFlonY2EEKXcoVHcHe3ebAc1weutnC0kzh8iDFAFsU1qj1KVdw4owxzfcgTe+t20XPjLSZM4RjVFE8qDXK+vgPQn/T4n0zK/nJUpVZyrhNRjFpjfGRiECgOOh8V3e8WbQ8wqmIDl9Jws8DlCcew82qXVqOnYqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cCM/WL7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F234C4CED6;
	Thu,  5 Dec 2024 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733385846;
	bh=FIozSi8SgpqkY9ZdwR7YpI65MxDaseGvlnzWbKVg2nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCM/WL7AcmSti272C/8pmCDv4/kLRfmjlVaxX6jKtkohw9FU+pWVbFqN4btG9sx1u
	 XLqWNZjvXB3yI3t6NUvjR32zdTUc0z9+CF/hZQ58QjaxQ/+2VfMyW6NYoqvAb1t2L6
	 67Q9FWFCiKGW3ZiwO2xNke6z1SrKKCgiK/Rdd9t0=
Date: Thu, 5 Dec 2024 09:04:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Roy Luo <royluo@google.com>, kernel-team@android.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 5/8] phy: exynos5-usbdrd: gs101: ensure power is gated
 to SS phy in phy_exit()
Message-ID: <2024120528-poker-thinness-6cfb@gregkh>
References: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
 <20241205-gs101-phy-lanes-orientation-phy-v3-5-32f721bed219@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205-gs101-phy-lanes-orientation-phy-v3-5-32f721bed219@linaro.org>

On Thu, Dec 05, 2024 at 07:33:16AM +0000, André Draszik wrote:
> We currently don't gate the power to the SS phy in phy_exit().
> 
> Shuffle the code slightly to ensure the power is gated to the SS phy as
> well.
> 
> Fixes: 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo phy (HS & SS)")
> CC: stable@vger.kernel.org # 6.11+

Why is a patch 5/8 a stable thing?  If this is such an important bugfix,
it should be sent separately as a 1/1 patch, right?

thanks,

greg k-h

