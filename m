Return-Path: <stable+bounces-76059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A5977EDE
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 13:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08F5B20D7F
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0A81D86DC;
	Fri, 13 Sep 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnw0/Jrj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0D1D86EF;
	Fri, 13 Sep 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228292; cv=none; b=Rjho3ol/3mW2x8lPArDjLGRAn0bwm7ic0h8qh3I172tAFhD143E9ZAKcHrkxXOOxR4FM4/X6225MiDOaBBAruemJOnOXlJT9yOJI+JciRRW19z3JzIUSQOe34tf0Fotkai9Y28tOwZfiKzOBJIcPskpNgRv/5PqgpVwT+cIG1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228292; c=relaxed/simple;
	bh=bDQ2cHKwBgZirp1r+Hr2bpHWKmVZ+wjLFiy68UToSsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL+JNmpggHDoIM6OeQMDknpqE//bO9K7LG2Mu5rZn0aSUvjq7wiyZ8UrlICrxOrn4vm7+9sepRtqKKUfJ622iqGvChyjTUgv0rXa5OqTs4S105tk+vksgthOsWdcZdGx9VIlBpTLlRPRFRr7yTdEy6/KquJsMnDspjJcaVPb1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnw0/Jrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D26BC4CEC0;
	Fri, 13 Sep 2024 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726228290;
	bh=bDQ2cHKwBgZirp1r+Hr2bpHWKmVZ+wjLFiy68UToSsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cnw0/Jrj2V/AnMFdy16uEyvcUU9eEyu/3xxKMDM2cTRbzZSNWAP9C7uF5z6/avJfc
	 8aBl0mQVSY9DP3osEYsrAq9Nmh1rnYJCgcS97AzgCugxHjYvCBq4i7pqRXpL39uejY
	 TLf1ONc/DsRr/n0cof4p0CVA2lzcIjIirKJTAuHImByJLPCinlyyQC5jjt+fwntTKK
	 igk/thqZJUx809wRqwuQgANDuDTFcuy9LzSYJoMdOF/UhqZuEau18025GmX2slI240
	 bwoSMHU2RuYUjp0IUcOPYeMgumptePJFqZ8KYm7J24KGjwrwQBY+oz92SmKu7t50JZ
	 OTXQ5KvLjR/uw==
Date: Fri, 13 Sep 2024 17:21:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	krzysztof.kozlowski@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <ZuQnPnRsXaUEBv6X@vaman>
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
 <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
 <2024091130-detail-remix-34f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024091130-detail-remix-34f7@gregkh>

On 11-09-24, 14:31, Greg KH wrote:
> On Tue, Sep 10, 2024 at 04:02:29PM +0300, Péter Ujfalusi wrote:
> > Hi,
> > 
> > On 10/09/2024 15:40, Peter Ujfalusi wrote:
> > > The prop->src_dpn_prop and prop.sink_dpn_prop is allocated for the _number_
> > > of ports and it is forced as 0 index based.
> > > 
> > > The original code was correct while the change to walk the bits and use
> > > their position as index into the arrays is not correct.
> > > 
> > > For exmple we can have the prop.source_ports=0x2, which means we have one
> > > port, but the prop.src_dpn_prop[1] is accessing outside of the allocated
> > > memory.
> > > 
> > > This reverts commit 6fa78e9c41471fe43052cd6feba6eae1b0277ae3.
> > 
> > I just noticed that Krzysztof already sent the revert patch but it is
> > not picked up for stable-6.10.y
> > 
> > https://lore.kernel.org/lkml/20240909164746.136629-1-krzysztof.kozlowski@linaro.org/
> 
> Is this in Linus's tree yet?  That's what we are waiting for.

Yes I was waiting for that as well, the pull request has been sent to
Linus, this should be in his tree, hopefully tomorow..

> 
> > > Cc: stable@vger.kernel.org # 6.10.y
> > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> > > ---
> > > Hi,
> > > 
> > > The reverted patch causes major regression on soundwire causing all audio
> > > to fail.
> > > Interestingly the patch is only in 6.10.8 and 6.10.9, not in mainline or linux-next.
> 
> Really?  Commit ab8d66d132bc ("soundwire: stream: fix programming slave
> ports for non-continous port maps") is in Linus's tree, why isn't it
> being reverted there first?

I guess Peter jumped the gun, I was planning to ask you once this is
picked up Linus

-- 
~Vinod

