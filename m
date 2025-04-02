Return-Path: <stable+bounces-127406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D8A78BE0
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 12:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78A31894170
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC3236456;
	Wed,  2 Apr 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dknpKXcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2D23496B;
	Wed,  2 Apr 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589220; cv=none; b=Vq+pDsqyPC3VBzxNV0N7aW9kt08XyDSHaRM/UboFa9M44QDhjurui6Z7cjPS9CeddYMVgOC4cUCOOmJO56SdP8nNRi6WdEjcnP0Igp5wtxSLGeSD6CE3w/v0QYUCWGCi6J78fEplaterya8RvptL+jpqLQrCMTIGyQiZnnqQhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589220; c=relaxed/simple;
	bh=TyyPs0p5eFVUOyDW73JSTQcX2PCR1IQY7elIRNEAOJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLCAP9gh5/TiRa+lsx3URObZIjN8AH+f1gTfdHgRavFsOLDkqd5l2KmmstNzstDNqr1JruRs9WLZpqlkPQRVDJ5ZkdIE2kDVYxS/pYQzAhjC510Ms6/ENc9QrNmrvphzwzj3DTfxmdNvGQN7aUowLmR1UGHsF16vYUD14nN2iEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dknpKXcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25939C4CEDD;
	Wed,  2 Apr 2025 10:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743589220;
	bh=TyyPs0p5eFVUOyDW73JSTQcX2PCR1IQY7elIRNEAOJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dknpKXcfkk26yr7R2zIPj/4hceyMDvdWxMAylqFtjZjFcTOKPvqqI8P4OZbmFphHx
	 hDfeIotH46h+drHQAXprsQilnxcugWHp9figMekJEEOcIZATyVXIyJhzqjYYsoLOVe
	 tmMqsAhvFiiWce+5XB2ZgyVpl82KTUbMotGm/pTfSwRP92v6aQLUX/2JfxRxZQMufH
	 MCiaVnVGBMyV8/yk2Q9dv09O9tuf7XJUbHYa8W0dHZtaEih9adUtxMoaCGKvnT5hy/
	 F6XWwg0nBi2ctbx4zCZ7V6R/Gq3jzt1XIKpO5DeWXYScAAku2xzvvoTYyhzlhwFiqb
	 t1p1uzmfOEB3Q==
Date: Wed, 2 Apr 2025 11:20:15 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
	jeroendb@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	pkaligineedi@google.com, willemb@google.com, joshwash@google.com,
	shailend@google.com, jrkim@google.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] gve: handle overflow when reporting TX consumed
 descriptors
Message-ID: <20250402102015.GL214849@horms.kernel.org>
References: <20250402001037.2717315-1-hramamurthy@google.com>
 <Z+zGrWljk7u91VMY@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+zGrWljk7u91VMY@mev-dev.igk.intel.com>

On Wed, Apr 02, 2025 at 07:10:18AM +0200, Michal Swiatkowski wrote:
> On Wed, Apr 02, 2025 at 12:10:37AM +0000, Harshitha Ramamurthy wrote:
> > From: Joshua Washington <joshwash@google.com>
> > 
> > When the tx tail is less than the head (in cases of wraparound), the TX
> > consumed descriptor statistic in DQ will be reported as
> > UINT32_MAX - head + tail, which is incorrect. Mask the difference of
> > head and tail according to the ring size when reporting the statistic.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 2c9198356d56 ("gve: Add consumed counts to ethtool stats")
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_ethtool.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > index 31a21ccf4863..4dea1fdce748 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> > @@ -392,7 +392,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
> >  				 */
> >  				data[i++] = 0;
> >  				data[i++] = 0;
> > -				data[i++] = tx->dqo_tx.tail - tx->dqo_tx.head;
> > +				data[i++] =
> > +					(tx->dqo_tx.tail - tx->dqo_tx.head) &
> > +					tx->mask;
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> I will add it in gve_tx_dqo.c as num_used_tx_slots() and simplify
> num_avail_tx_slots()
> {
> 	return tx->mask - num_used_tx_slots();
> }
> but it isn't needed, even maybe unwanted as this is just fix.

I think that would be a nice cleanup, but should be as a follow-up
to this minimal fix.

Reviewed-by: Simon Horman <horms@kernel.org>


