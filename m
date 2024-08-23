Return-Path: <stable+bounces-69921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3495C2BC
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 03:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59DBB2392E
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 01:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648F314A8F;
	Fri, 23 Aug 2024 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vvsl/gRe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9CE17721;
	Fri, 23 Aug 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724375657; cv=none; b=Zy/o2LVIIKBtmm/0/frF5XL3xzDP03zS20G+Galhj13e5S3/28J95Gfn9G9dcmPng3XRnRk2YuVAyw64CQRsD1aZaXZUV8DZNOcrVMgS2X32tuwD1yKlTnqSLVe9SODqykTiCUofwQ0jzT0AvTFwcna/NusmyYeK3YxQ9oqC1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724375657; c=relaxed/simple;
	bh=8BcFo4tyhAWSn29kdpWnpAMfcnfwtBYAU2NcUbOZJG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIoyVUt140wDh5GzQ2E+d67OcCvDIvwHyswJjswYdxsCOeQTNlqwC8b3Q+b4+wfsGXm3MShNjke/f7cxDSYflxtVxHG7NQPd1G3NDN1jdNd3XolrNKVkaFGBTJXbDzeZJ6b2PL2o7gy2BB/SezlGmbDCi640zC3SuF9Usml5zMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vvsl/gRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84D2C32782;
	Fri, 23 Aug 2024 01:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724375656;
	bh=8BcFo4tyhAWSn29kdpWnpAMfcnfwtBYAU2NcUbOZJG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vvsl/gReDOfVy+9aYq5CPDS4C3VBkLpP2gwbBBt0EBspAzUfFuvxpfdvJ674o/Exa
	 TaWoje27YZzkK8yQHApvEZ65oAul7S4CsIsKVMWbuT/3WhldhyriujLK5mdDcCl6rB
	 jFMxm6k9skrSH4FHWHN1fEkJC57UlyFmpBbwhaTc=
Date: Fri, 23 Aug 2024 09:14:12 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
Message-ID: <2024082318-labored-blunderer-a897@gregkh>
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
 <ZsfRqT9d6Qp_Pva5@google.com>
 <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>

On Fri, Aug 23, 2024 at 08:46:12AM +0800, Zijun Hu wrote:
> On 2024/8/23 08:02, Dmitry Torokhov wrote:
> > Hi,
> > 
> > On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> An uninitialized variable @data.have_async may be used as analyzed
> >> by the following inline comments:
> >>
> >> static int __device_attach(struct device *dev, bool allow_async)
> >> {
> >> 	// if @allow_async is true.
> >>
> >> 	...
> >> 	struct device_attach_data data = {
> >> 		.dev = dev,
> >> 		.check_async = allow_async,
> >> 		.want_async = false,
> >> 	};
> >> 	// @data.have_async is not initialized.
> > 
> > No, in the presence of a structure initializer fields not explicitly
> > initialized will be set to 0 by the compiler.
> > 
> really?
> do all C compilers have such behavior ?

Oh wait, if this were static, then yes, it would all be set to 0, sorry,
I misread this.

This is on the stack so it needs to be zeroed out explicitly.  We should
set the whole thing to 0 and then set only the fields we want to
override to ensure it's all correct.

thanks,

greg k-h

