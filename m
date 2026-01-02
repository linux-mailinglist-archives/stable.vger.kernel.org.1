Return-Path: <stable+bounces-204471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453CECEE834
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 13:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCC2930019F5
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E289A2E1743;
	Fri,  2 Jan 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjHg8CuF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7F2571D7
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356624; cv=none; b=VS3eH9UHnh4yFnN6qoshepo3alkAs8+EmVcPx8pt7IQMTNBucUGCjfSozhyu/4m3i6NfDTGgJwXhgbGMtJqwBbguGT3mH4jrV6/m70LN8TqD3K79+MFq/CyFbSKL3IyBnVqpal2Ov/ka7GJPgs81g5e1te3WvfgXpkH8s11tCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356624; c=relaxed/simple;
	bh=Il6vtJBmZFcHo7j9Qa1hq4r7IH6E3gpG1ZauhomDTgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwrdwDHLLQ2qpbyREEyPHkoV2vgr1nvJBlQN3nkrQLaNJI2t9DefPC6mBzNfcwdjnTrpcls4FpwNj/Ex3+76clO98W2qUYGWWHVqJ4QaRiTogNUKRxu6U74ILipVw/e+8sSvqWTXZz78Y+nUVWTLi1+28kyB+cKKD3kfJdGHzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjHg8CuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F45C116B1;
	Fri,  2 Jan 2026 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767356624;
	bh=Il6vtJBmZFcHo7j9Qa1hq4r7IH6E3gpG1ZauhomDTgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjHg8CuFlrT/SwApaoVVvj4huM2y1EcH6SExr8Qyuns7xlWi5KZm2npIRQOBYhAHA
	 yMxuxhOfYKALFyTxnUM3sasXBSSQ0F+GyFZsb7Kuz1Jyt68FpQOtksFq2aKsRyfOIM
	 Rwh9J1CwNzwv/7QURXQokJ+QEVIx6h2wpKfmCMFM=
Date: Fri, 2 Jan 2026 13:23:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>, stable@vger.kernel.org,
	Nouveau Dev <nouveau@lists.freedesktop.org>
Subject: Re: ba1b40ed0e34bab597fd90d4c4e9f7397f878c8f for 6.18.y
Message-ID: <2026010235-spied-quote-cb42@gregkh>
References: <CANiq72=ti75ex_M_ALcLiSMbfv6D=KA9+VejQhMm4hYERC=_dA@mail.gmail.com>
 <DFC0SMRNXSCF.VFRFCASVMX5F@kernel.org>
 <7737ff62-163b-45eb-857f-c9eb00ea2914@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7737ff62-163b-45eb-857f-c9eb00ea2914@nvidia.com>

On Wed, Dec 31, 2025 at 12:02:20PM -0800, John Hubbard wrote:
> On 12/30/25 5:44 PM, Danilo Krummrich wrote:
> > On Wed Dec 31, 2025 at 1:57 AM CET, Miguel Ojeda wrote:
> >> Cc'ing Danilo and Alexandre so that they can confirm they agree.
> > 
> > Good catch! Greg, Sasha: Please consider this commit for stable.
> 
> Alex is away, but I also agree with this.

Now queued up, thanks.

greg k-h

