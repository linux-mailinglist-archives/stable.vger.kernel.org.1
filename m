Return-Path: <stable+bounces-35991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CBC89941C
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C041C2517F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 04:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BBD1C687;
	Fri,  5 Apr 2024 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0st0y7iI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D2179AE
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 04:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291390; cv=none; b=hL6zxshzrS1k+Z+Y5ZwkWECOmxqDXLNHEZY2EHB01ECfbYV5TpSO/NG1woRQU/rp24GBBAKsFhqWTDZYsJnWOdmAuJOFXIRPne48p4aE4dNN0SLbMF0/SMRzS3eV2psrPe8s6z4OitH+FnAmsoCTwNZInuZENLQC4wO6zeXsI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291390; c=relaxed/simple;
	bh=dnzJr1njtimP/ttE0yuQEACvsEmhII7RV6ev0GeA3z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqaCPuE9cN6fjyoRY23nPA7l1xek+6Lr2lyOlBrwNjOKbiomdZdQXse71veYvX1mh8RXlSZchBlH2IgzpmsNp+6darV4hzU94b+4CRej4xIRGhYlfxJYs5rhaALunsxEjcV/HSwkTMmRKugy0xOg68KDRlsRnGiPvimI+W98JKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0st0y7iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B496C433F1;
	Fri,  5 Apr 2024 04:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712291389;
	bh=dnzJr1njtimP/ttE0yuQEACvsEmhII7RV6ev0GeA3z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0st0y7iI0ag76C8m7e7e9SqTzq+CHpEo2PxcpmmMvArR31U85F995bBNRb/cFNw7N
	 YbT5776URTlsClfvTfm+CCmWq9IM0fa9qvLcEMoko2qgH0LPB0eOSbHHQtSTu/wrJZ
	 jAcvSCYOOf9iq8YHGUWtQX3ylUL7CBmcV1kKNwY8=
Date: Fri, 5 Apr 2024 06:29:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Imre Deak <imre.deak@intel.com>, stable@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: v6.8 stable backport request for drm/i915
Message-ID: <2024040536-creature-starlet-9967@gregkh>
References: <Zg6rIG0idN3NSTbP@ideak-desk.fi.intel.com>
 <Zg6ww+JomUKR//nh@ideak-desk.fi.intel.com>
 <Zg8aye1ee7T4dNJD@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg8aye1ee7T4dNJD@intel.com>

On Thu, Apr 04, 2024 at 05:25:29PM -0400, Rodrigo Vivi wrote:
> On Thu, Apr 04, 2024 at 04:53:07PM +0300, Imre Deak wrote:
> > On Thu, Apr 04, 2024 at 04:29:04PM +0300, Imre Deak wrote:
> > > Stable team, please backport the following upstream commit to 6.8:
> > > 
> > > commit 7a51a2aa2384 ("drm/i915/dp: Fix DSC state HW readout for SST connectors")
> > 
> > Just noticed that the above commit is not yet upstream, still only
> > queued in drm-intel-next. I presumed patches will be cherry-picked from
> > drm-intel-next to drm-intel-fixes based on the Fixes: tag, so I only
> > pushed the above patch to drm-intel-next; maybe the cherry picking
> > doesn't (always) happen automatically.
> 
> This patch was cherry-picked this week and sent with the drm-intel-fixes
> pull request targeting v6.9-rc3
> 
> Since it has the proper 'Fixes:' tag, it will likely get propagated to
> the stable branches 'automagically' in some near future.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

