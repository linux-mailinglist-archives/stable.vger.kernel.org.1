Return-Path: <stable+bounces-78593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925598CBF1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 06:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41761B21BDB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 04:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7828E179A8;
	Wed,  2 Oct 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hAy0cv1o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673312E4D;
	Wed,  2 Oct 2024 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727842431; cv=none; b=G8I5SuoG/ZV46C/x5p5QXiBAX7Mg4u4NiRYFThSAcT9tP4MLw135I27mGgKglMpsGx83O8HagD9p2vum/NMLhnK5L1AW1WHa9XoMk/dKZUE6w3dFQdQIHeCXpSWg4tdUpYYON3+ps4rUJ6qWsUs8iTMmvxpHsqorbx8Gy1KZtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727842431; c=relaxed/simple;
	bh=JbDzwPlLGBcCtenQQlWCMXDqaB0XwCcXMo+h3ZF+zkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqpCQXFF0PWZ1Vkt/fdUeWKr2ylVltIWX9LeCjYBOVu+x0gAT0MaBGeWqEOpKbwkEHKY9/eVKDiGOPsodJeDOxmx2rRrdPcn2Ufa5MpZOMWW4UjBgbvX9yQLats97b7cUMXSjDLcNXoUpNRQzE+DjqAY4ba4GONBCV6apQb6Z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hAy0cv1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6818C4CEC5;
	Wed,  2 Oct 2024 04:13:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hAy0cv1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727842427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1yRMQcqyG54p0Nk1PXs3aHdgydglzJzi1V5Bm/TxEM=;
	b=hAy0cv1oposMo0di+EcmB9u6LJnix8TuweCd6vsSK1ewGMCoA7srgEfC3vqhAKQt9tGp09
	Gn3s0KngE9ByFFvFtED1HHCmD16HS1O6EmxOQxYz2uw7cU3m7uTpul9U0uG1vMN64G7foD
	h4zy6hFQdI1ZV4AMG+9l3vLPu76y4DE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cec7646a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 04:13:47 +0000 (UTC)
Date: Wed, 2 Oct 2024 06:13:45 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
Message-ID: <ZvzIeenvKYaG_B1y@zx2c4.com>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
 <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com>
 <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>

On Tue, Oct 01, 2024 at 09:29:45AM -0600, Shuah Khan wrote:
> On 10/1/24 09:03, Jason A. Donenfeld wrote:
> > On Tue, Oct 01, 2024 at 08:56:43AM -0600, Shuah Khan wrote:
> >> On 10/1/24 08:45, Jason A. Donenfeld wrote:
> >>> On Tue, Oct 01, 2024 at 08:43:05AM -0600, Shuah Khan wrote:
> >>>> On 9/30/24 21:56, Jason A. Donenfeld wrote:
> >>>>> This is not stable material and I didn't mark it as such. Do not backport.
> >>>>
> >>>> The way selftest work is they just skip if a feature isn't supported.
> >>>> As such this test should run gracefully on stable releases.
> >>>>
> >>>> I would say backport unless and skip if the feature isn't supported.
> >>>
> >>> Nonsense. 6.11 never returns ENOSYS from vDSO. This doesn't make sense.
> >>
> >> Not sure what you mean by Nonsense. ENOSYS can be used to skip??
> > 
> > The branch that this patch adds will never be reached in 6.11 because
> > the kernel does not have the corresponding code.
> 
> What should/would happen if this test is run on a kernel that doesn't
> support the feature?

The build system doesn't compile it for kernels without the feature.

