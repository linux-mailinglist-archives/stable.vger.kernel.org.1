Return-Path: <stable+bounces-75825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6E97529D
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 14:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1777B22A50
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13718F2DF;
	Wed, 11 Sep 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xjaUwSlV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC1770E8
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058239; cv=none; b=bCLeL1QoLXr2s9aLJTDV+X/zuxD3zjieA36qJlpUQDuTBWgjy3roOfKCA9WGXJpkx5VVXRhHVSDMa8kBzOuSTWhobXZdqkiPCk49/f6Wsgz2JbgcUXQJYpMyhiYhk5hJQgrDCwbyes5e27YartKB0C2LF7KAz6uCKr5xoTaW2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058239; c=relaxed/simple;
	bh=XGfR16Gv3pYvFbdInbchv2JqQUMXBTzS5B/HiiA32c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFNXReD9tXXWdN7cQXi8ZV+6Jz+enKWy9rQdRLDR0H63fFJTAZLM4190d99KKnNOYmo2qTWXCsDKWlVlFdgMejp1jFzXWz8fY7OWOYap9//sLY65l+8FtD0yfhDtKeo+dluD9H0Bl0cx/xKOA7se2Jloh6m/eB5eGL9hWbnTHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xjaUwSlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83C0C4CECF;
	Wed, 11 Sep 2024 12:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726058239;
	bh=XGfR16Gv3pYvFbdInbchv2JqQUMXBTzS5B/HiiA32c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xjaUwSlVndt1PPI9yINn3jsiZRduihovg9MkSOQdaJr/B+/0okbnDACBUmpFxSsK2
	 MCMNM6+F/GgUltJrwhZWpHhvVTs96t0tXSFpdyD66bA/qYZqJlQy5fVsjY7K9E7Vok
	 pVVpgER4XCnoNOcEjSTunxTAD9l3mKn+MmhMFy0w=
Date: Tue, 10 Sep 2024 12:06:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: HeLuang <helugang@uniontech.com>
Cc: stable@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y 2/2] iio: adc: ad7124: fix DT configuration parsing
Message-ID: <2024091052-reach-proclaim-b8ae@gregkh>
References: <2024090914-province-underdone-1eea@gregkh>
 <20240910090757.649865-1-helugang@uniontech.com>
 <0ACF46DADA3C2900+20240910090757.649865-2-helugang@uniontech.com>
 <2024091053-boundless-blob-20bd@gregkh>
 <0D03D3D118FBAF5F+abf1276e-4c7d-4c9a-8d6f-278b69022680@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D03D3D118FBAF5F+abf1276e-4c7d-4c9a-8d6f-278b69022680@uniontech.com>

On Tue, Sep 10, 2024 at 05:43:21PM +0800, HeLuang wrote:
> 
> 
> 在 2024/9/10 17:23, Greg KH 写道:
> > On Tue, Sep 10, 2024 at 05:07:57PM +0800, He Lugang wrote:
> > > From: Dumitru Ceclan <mitrutzceclan@gmail.com>
> > > 
> > > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > 
> > Why is this 2 different addresses?
> > 
> > And why was this sent twice?
> > 
> > confused,
> > 
> > greg k-h
> > 
> 
> Hi,greg
> 
> About the two email addresses because the email address mismatch message
> from the checkpatch.pl,so I just and the signed-off-by one,should we just
> ignore it?

Please use what is in the upstream commit.

> Also pls just pass over the first patch mail because of lack of dependency.

Please tell us what is going on, otherwise we get confused.

Please fix this up and resend a new series that we can take.

thanks,

greg k-h

