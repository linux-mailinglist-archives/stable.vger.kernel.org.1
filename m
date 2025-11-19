Return-Path: <stable+bounces-195155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B0C6D43F
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 08:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69BA03503AA
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00553280339;
	Wed, 19 Nov 2025 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m/kp9gv6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67526FA4E
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538657; cv=none; b=N6+imjGmNoGGbkbizw5zqsKTMF+w/VB+arbsqFUwkzJEV1EB74hDAAX233/k5KQ3D+PnVtc3W3DjssNDseupN1HQm77nXh1drcRFJY3DuI2ANfAdF6SvakczfL5QtU+dJyA5c4A80RUXwCP3+GY9TJaZhgx5A9mNskv5k8Bpo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538657; c=relaxed/simple;
	bh=aMI4twBDreFpk4asqoCI3C4Mkn+cZ7imr7aeWxqxB0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj+kGMTQjX2+ca5GK+77/pOSEd7UVq+PDkzGZsOCYPVAZC4yhsRoToasiKOeinRX/DoOnsv2e5N9p7eJhW6w3goIX7hppXCANstniEKB2nWREnvrp5dw/xYYdn488M3cHF921UvRuEIJInmvBlfVdMc1JF5Sdj5VC2Sz1/13dSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m/kp9gv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B910BC19424;
	Wed, 19 Nov 2025 07:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763538657;
	bh=aMI4twBDreFpk4asqoCI3C4Mkn+cZ7imr7aeWxqxB0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/kp9gv6uJigqRl2MALQLvtCJG19X7xkrgNwjyHEQbNS2PPAudgh2iahg0snLl4jv
	 yfOI3lp+ykTDyLKIH8N42VDup0EW7N8cWmq43OHHeiaTeR7yyxVHpExYNx9oFaEb7G
	 Bw6sPtFhamuPj/Tzwxw9ZV1qm/S1OTuFyhxX6S0E=
Date: Wed, 19 Nov 2025 02:50:53 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: MUHAMMAD AMIRUL ASYRAF MOHAMAD JAMIAN <muhammad.amirul.asyraf.mohamad.jamian@intel.com>
Cc: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: intel: agilex5: Add fallback compatible for
 XGMAC
Message-ID: <2025111926-rebirth-drank-1810@gregkh>
References: <c75a1061c0ef016406f73c05f1254b3c7dea79e4.1763520303.git.muhammad.amirul.asyraf.mohamad.jamian@altera.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75a1061c0ef016406f73c05f1254b3c7dea79e4.1763520303.git.muhammad.amirul.asyraf.mohamad.jamian@altera.com>

On Tue, Nov 18, 2025 at 07:24:13PM -0800, MUHAMMAD AMIRUL ASYRAF MOHAMAD JAMIAN wrote:
> From: muhamm120 <muhammad.amirul.asyraf.mohamad.jamian@intel.com>

Does not match the signed-off-by line :(

> 
> Add "snps,dwxgmac" as fallback compatible string to all three gmac
> nodes (gmac0, gmac1, gmac2) in Agilex5 DTSI.
> 
> With the fallback present, the generic dwmac driver can properly
> initialize the XGMAC2 hardware, allowing ethernet to function correctly.
> 
> This fixes ethernet regression test failures on Agilex3/Agilex5 SOCDK
> platforms.
> 
> Fixes: 343ea11a2fe3 ("arm64: dts: Agilex5 Add gmac nodes to DTSI
> for Agilex5")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Muhammad Amirul Asyraf Mohamad Jamian <muhammad.amirul.
> asyraf.mohamad.jamian@altera.com>

Line wrapped :(

Also not sent to the proper developers :(

