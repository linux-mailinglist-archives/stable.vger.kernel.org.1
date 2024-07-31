Return-Path: <stable+bounces-64711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07644942738
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 08:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8716CB21907
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CDC1A3BDF;
	Wed, 31 Jul 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgKyiKWv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7E4EB38;
	Wed, 31 Jul 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408979; cv=none; b=qu5GDQDb4NzviZLmzkryKk12tb4d5tO7npevzlbU39L8NCVaqLPlS7rGVqkNcprIHXj0S/kEBqafPASZG9AtTFX6iqakU/w1g5ygvWlP4GzoU6Dm95iufWJkQ1Xw7xAZ5wPb7ontq98QqOAea06PeIk7ixtJIuz3vLoPWnmynLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408979; c=relaxed/simple;
	bh=DxYj0k8cH2mRzu6X3HbgLur3mDxmu+xBiLex6wyTmFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0TnVzKRWQOQH8M5+DxDEGIz6u3QuxOFNsC9S5GPJj56FeHw20KveNP6W7oEwF+Y30QsMWrvBpZLkuv+f2sDsyj6nsYrjx8JXKQajRzRwqqxJU/bGchW2vHhllSM4jo4BiAA6GLDnMW20XEK3LSqpv1i+8ip7Y/Xd1gzOHSJhj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgKyiKWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FC8C116B1;
	Wed, 31 Jul 2024 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408979;
	bh=DxYj0k8cH2mRzu6X3HbgLur3mDxmu+xBiLex6wyTmFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgKyiKWviPnt+df/P+O22U23kPuJr7EIR5Ye0Bt8dmpuF1cLqszzr1PbjBVjKw86L
	 iuwcnDTfn5/GWrAG3paET9NlrpGX6oC4Ks81Pate5V7U/K2dSLH+5TKzKSHrlB1sL/
	 6KDf17G2unb6Vr5aDnVBoXsZ8Bk6Lz44e/n4J8MsptFwwYC9CDSuviEIcGI0v3f5fi
	 AyNDfXWpkQeDc5kOKOeMQpUYjwwm4s8wVDz8l1YqKVL8zhw3hLRoTCYCa5J1xyWnrp
	 cZiua7wgFeTvjdlqbb0eLmtU82G9jpWAjS/2FOhX5PFKUcztCqHuhpleRoEGQoRkUg
	 25V5+ZfT9leMw==
Date: Wed, 31 Jul 2024 12:26:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] soundwire: stream: fix programming slave ports for
 non-continous port maps
Message-ID: <ZqngD56bXkx6vGma@matsya>
References: <20240729140157.326450-1-krzysztof.kozlowski@linaro.org>
 <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <095d7119-8221-450a-9616-2df6a0df4c77@linux.intel.com>

On 29-07-24, 16:25, Pierre-Louis Bossart wrote:
> 
> 
> On 7/29/24 16:01, Krzysztof Kozlowski wrote:
> > Two bitmasks in 'struct sdw_slave_prop' - 'source_ports' and
> > 'sink_ports' - define which ports to program in
> > sdw_program_slave_port_params().  The masks are used to get the
> > appropriate data port properties ('struct sdw_get_slave_dpn_prop') from
> > an array.
> > 
> > Bitmasks can be non-continuous or can start from index different than 0,
> > thus when looking for matching port property for given port, we must
> > iterate over mask bits, not from 0 up to number of ports.
> > 
> > This fixes allocation and programming slave ports, when a source or sink
> > masks start from further index.
> > 
> > Fixes: f8101c74aa54 ("soundwire: Add Master and Slave port programming")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> This is a valid change to optimize how the port are accessed.
> 
> But the commit message is not completely clear, the allocation in
> mipi_disco.c is not modified and I don't think there's anything that
> would crash. If there are non-contiguous ports, we will still allocate
> space that will not be initialized/used.
> 
> 	/* Allocate memory for set bits in port lists */
> 	nval = hweight32(prop->source_ports);
> 	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
> 					  sizeof(*prop->src_dpn_prop),
> 					  GFP_KERNEL);
> 	if (!prop->src_dpn_prop)
> 		return -ENOMEM;
> 
> 	/* Read dpn properties for source port(s) */
> 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
> 			   prop->source_ports, "source");
> 
> IOW, this is a valid change, but it's an optimization, not a fix in the
> usual sense of 'kernel oops otherwise'.
> 
> Am I missing something?
> 
> BTW, the notion of DPn is that n > 0. DP0 is a special case with
> different properties, BIT(0) cannot be set for either of the sink/source
> port bitmask.

The fix seems right to me, we cannot have assumption that ports are
contagious, so we need to iterate over all valid ports and not to N
ports which code does now!

> 
> 
> > ---
> >  drivers/soundwire/stream.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> > index 7aa4900dcf31..f275143d7b18 100644
> > --- a/drivers/soundwire/stream.c
> > +++ b/drivers/soundwire/stream.c
> > @@ -1291,18 +1291,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
> >  					    unsigned int port_num)
> >  {
> >  	struct sdw_dpn_prop *dpn_prop;
> > -	u8 num_ports;
> > +	unsigned long mask;
> >  	int i;
> >  
> >  	if (direction == SDW_DATA_DIR_TX) {
> > -		num_ports = hweight32(slave->prop.source_ports);
> > +		mask = slave->prop.source_ports;
> >  		dpn_prop = slave->prop.src_dpn_prop;
> >  	} else {
> > -		num_ports = hweight32(slave->prop.sink_ports);
> > +		mask = slave->prop.sink_ports;
> >  		dpn_prop = slave->prop.sink_dpn_prop;
> >  	}
> >  
> > -	for (i = 0; i < num_ports; i++) {
> > +	for_each_set_bit(i, &mask, 32) {
> >  		if (dpn_prop[i].num == port_num)
> >  			return &dpn_prop[i];
> >  	}

-- 
~Vinod

