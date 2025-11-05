Return-Path: <stable+bounces-192482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B040C3465D
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 09:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2390634AC0F
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183B2C0292;
	Wed,  5 Nov 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGWDOmX0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBB24A074;
	Wed,  5 Nov 2025 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330107; cv=none; b=bXmZxy6FVEnDrGmmvNIRvxhLnLdkpDMV3YU+sHfeFXRvLlq+U0Z22taCnWSDFBsmfNrLvgPurICWzZMOp6c0sszPsZTzvyFtpJy5dGvhyK2koqoNotgaWCAFaqm17cDbfFTiBUAQEqNWCer63ohpWAGibdIFQklrNPkTR/5ghog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330107; c=relaxed/simple;
	bh=L5zrmAxPeveYGnuIp1/AiWAZ8zt9K0PY9Rlag7HPinE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcR6tVPnUBKVoGajq5yVZCRJwr4Hl1Ac0w5XU1U8ngqLB6KVzTOmTUB7Y74OXMy567iXZEM5vuKJXb9qOHCPtwxgOJkdDbQFUrQ4cKSVjCuGkX3X14GfWA/+LCE4dEyuR2mN2rCAk4HHKGxK3EO3JTEeMq7Z3kwqCj+gh6/3HiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGWDOmX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B4FC4CEF8;
	Wed,  5 Nov 2025 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762330106;
	bh=L5zrmAxPeveYGnuIp1/AiWAZ8zt9K0PY9Rlag7HPinE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGWDOmX0CakgQs4HV/4xN47w2KF99fYDsBwTWKHaGn+LplXtdBi3EqGmZwcdvldV2
	 4tvwevzX2f23FxvOcas4hgbddIAJOM4UpuhmXXD0iOoYGDgtsxo04ab9d9scxldiyj
	 iXFkplVgJMi+cF9sTXT8+HXxa+oUsKQLqFkq3e1sH3gOda9Dl/vuo6qlT1n6wAZ2pq
	 FbACXxroSSl84dgbE3b1CeHTXYf+ChBSGOxePLLkiBJfmDlunQlh2R0xwH5/CzPA+g
	 LOxsMeZaEVZ9RBsvdBiIPRpvFkLKYZILVzYH3KVZfw91Th92bKnplLiNOP9TRHcE5o
	 fxUvs2o9dksnw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vGYZA-000000004uV-2SAC;
	Wed, 05 Nov 2025 09:08:28 +0100
Date: Wed, 5 Nov 2025 09:08:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] amba: tegra-ahb: fix device leak on smmu enable
Message-ID: <aQsF_OJF3eaJt7YP@hovoldconsulting.com>
References: <20250925150007.24173-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925150007.24173-1-johan@kernel.org>

On Thu, Sep 25, 2025 at 05:00:07PM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the ahb platform device when
> looking up its driver data while enabling the smmu.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away.
> 
> Fixes: 89c788bab1f0 ("ARM: tegra: Add SMMU enabler in AHB")
> Cc: stable@vger.kernel.org	# 3.5
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up for 6.19?

Johan

