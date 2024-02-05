Return-Path: <stable+bounces-18856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DC84A1B1
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 19:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989962847C6
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38314595A;
	Mon,  5 Feb 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jax/aN/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A4481AC;
	Mon,  5 Feb 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156004; cv=none; b=BOcm60vuYp+j6ta9CMUGATfDGnumGsxVqq1bv4TGAWXUfWbEC5iXDlS/0cGhYLWCoHlErGyUucy1YnvBY0MykkyxynvMt5qdGUEpjUob3dr5RngLywy8V+44Cv7ywAywswhgCZS9aenN23JOouNwSbksbJ6up+9KLQ2kbgKiSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156004; c=relaxed/simple;
	bh=E7tpQ1f16A97znTE9JG5WFTEVpqraMCZdv1KO7GfMcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbozJaSmjdzlEl/S8fHinz+i1+W/g5+G+bZ7NwmOYfFV/bRiyaF7e6ILqrxbmfCbc+iR+Ll75Dau0Yl4MTB7KR3LrHFzt/Ndj7XATw/tXEtCCBPMtaT3aGeCNM+5LGpUE/oLcmYo/E73ynqddq0NYOmiTKkcLppfoBD59dvrE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jax/aN/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0646FC433C7;
	Mon,  5 Feb 2024 18:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707156003;
	bh=E7tpQ1f16A97znTE9JG5WFTEVpqraMCZdv1KO7GfMcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jax/aN/8vv9fw2fDFy1993p/he6UCCtBocYkjOuilCIiRitEaLIf3RyrnqFcwuuU8
	 Qk9zlNPmKjgiG9m3SIQHdQiBxyl4AvVPm16Y0K2n9DLNToL7ECi935fi54cQo6u+jb
	 1taJueZudIxi5nrlXFIThix822ZsR6QiXJ7TDKofK20g0f+ogCqoICC9n9Px5IRMR4
	 UCjwfMH2qk+Kg45MeOsAd9StxUeAmonIrmP1LRtnX47lZuAHrjwgS0PXrPpDda+RHy
	 0/VW1v5Wrp9hdiprLRt5dk4ej/WYE/z6hbmZPUxvFJbnLqA7hBkJCUIhG5BHnTuTET
	 G8B1DFmIWqTQg==
Date: Mon, 5 Feb 2024 17:58:29 +0000
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net 2/3] nfp: flower: prevent re-adding mac index for
 bonded port
Message-ID: <20240205175829.GN960600@kernel.org>
References: <20240202113719.16171-1-louis.peens@corigine.com>
 <20240202113719.16171-3-louis.peens@corigine.com>
 <20240205133203.GK960600@kernel.org>
 <ZcDtbBeW5epRpZqR@LouisNoVo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcDtbBeW5epRpZqR@LouisNoVo>

On Mon, Feb 05, 2024 at 04:15:08PM +0200, Louis Peens wrote:
> On Mon, Feb 05, 2024 at 01:32:03PM +0000, Simon Horman wrote:
> > On Fri, Feb 02, 2024 at 01:37:18PM +0200, Louis Peens wrote:
> > > From: Daniel de Villiers <daniel.devilliers@corigine.com>
> > > 
> > > When physical ports are reset (either through link failure or manually
> > > toggled down and up again) that are slaved to a Linux bond with a tunnel
> > > endpoint IP address on the bond device, not all tunnel packets arriving
> > > on the bond port are decapped as expected.
> > > 
> > > The bond dev assigns the same MAC address to itself and each of its
> > > slaves. When toggling a slave device, the same MAC address is therefore
> > > offloaded to the NFP multiple times with different indexes.
> > > 
> > > The issue only occurs when re-adding the shared mac. The
> > > nfp_tunnel_add_shared_mac() function has a conditional check early on
> > > that checks if a mac entry already exists and if that mac entry is
> > > global: (entry && nfp_tunnel_is_mac_idx_global(entry->index)). In the
> > > case of a bonded device (For example br-ex), the mac index is obtained,
> > > and no new index is assigned.
> > > 
> > > We therefore modify the conditional in nfp_tunnel_add_shared_mac() to
> > > check if the port belongs to the LAG along with the existing checks to
> > > prevent a new global mac index from being re-assigned to the slave port.
> > > 
> > > Fixes: 20cce8865098 ("nfp: flower: enable MAC address sharing for offloadable devs")
> > > CC: stable@vger.kernel.org # 5.1+
> > > Signed-off-by: Daniel de Villiers <daniel.devilliers@corigine.com>
> > > Signed-off-by: Louis Peens <louis.peens@corigine.com>
> > 
> > Hi Daniel and Louis,
> > 
> > I'd like to encourage you to update the wording of the commit message
> > to use more inclusive language; I'd suggest describing the patch
> > in terms of members of a LAG.
> Thanks Simon, this have not even crossed my mind this time and I feel
> bad - I should be more aware. Thanks for politely pointing this out.
> This did get merged earlier today as-is unfortunately, I'm not sure if
> there is a good way (or if it is pressing enough) to have it retracted.
> I will try to be more cognizant of this in the future.

Hi Louis,

thanks for acknowledging my concern.

Given that the patch has been applied,
I think it would be best to do as you suggest,
and keep this in mind for next time.

