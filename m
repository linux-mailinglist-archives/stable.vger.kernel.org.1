Return-Path: <stable+bounces-159126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A40ACAEF370
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 11:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9081BC3358
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3812367C0;
	Tue,  1 Jul 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VAZglClL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26B2253F2
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362490; cv=none; b=oYp/mu96vr0SwHCEfvfPKe01hKrO3LbXSWhLJN+DzRWdvaZdymIcQYLCZBQsOm0tPMRbrHuCH0u74+95MtC+TlXCj+8Lr8iSeo//Tf+Eghjad28DFBYNP5mP8nKtqx2ZYAiglg/9Qejt5aBsy9DPKn5Yx6UF5FeOXA4z/tp/XGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362490; c=relaxed/simple;
	bh=eIKmxvJehCoPJLB7HMzSbjj3kOjSFInGsc90YL+duD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3gvdMXrEtUYTNUu6UA0W+eWJZEkuVrGpz1TrG9y9Wno2nlVIrDcvDRxmfm8+Zfx6zFYasgWaGl50krzlRvCopNa18+Q3jUgjcKtdv4RP69ZLT7ZhZWz6MwdEnxbYo1EABT5yqzorJHPGPxfMVlUM2MjqUa606BYbAXtXewVztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VAZglClL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5AAC4CEEB;
	Tue,  1 Jul 2025 09:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751362489;
	bh=eIKmxvJehCoPJLB7HMzSbjj3kOjSFInGsc90YL+duD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAZglClLUa2f50vQztVobCxedyeEkUTFcsvKDiGSWanbJqD4eMbXtO9NRJphxibWT
	 uGhhtZDR7trchjOGIcc81h9YWD/kGY8qGGtYFMyjA8HGN2meybfOP+rBVdhIvPFvmk
	 VuwZQewCXKgmPWg39QtZioymt+bmQkUWFWjy5t5E=
Date: Tue, 1 Jul 2025 11:34:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: fugang.duan@cixtech.com, cix-kernel-upstream@cixtech.com,
	stable@vger.kernel.org, Hongliang Yang <hongliang.yang@cixtech.com>
Subject: Re: [PATCH 1/1] usb: cdnsp: do not disable slot for disabled slot
Message-ID: <2025070123-macaroni-gag-6dd0@gregkh>
References: <20250618095321.34213-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618095321.34213-1-peter.chen@cixtech.com>

On Wed, Jun 18, 2025 at 05:53:21PM +0800, Peter Chen wrote:
> It doesn't need to do it, and the related command event returns
> 'Slot Not Enabled Error' status.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: stable@vger.kernel.org
> Suggested-by: Hongliang Yang <hongliang.yang@cixtech.com>
> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> ---
>  drivers/usb/cdns3/cdnsp-ring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Any reason this wasn't cc:ed the proper mailing lists?

Or is this a stable-kernel-only patch?

confused,

greg k-h

