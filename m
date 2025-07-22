Return-Path: <stable+bounces-163716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0BAB0DB19
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F80116C3ED
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34372624;
	Tue, 22 Jul 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SvPuOET5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB112E8E0F
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191573; cv=none; b=uURHx/gYY10LX2U4cEPjPoPHfQ3Idi93KDhmU3zSR1JGqNjbchLdmlMkqVOrz+sU1LF3CjCJfdKKCNNXjd4JJJrpAeVW2lSljvShLxX4dgiBY576PuMO4ZrmosOGMHDcAfH8LcidyLdDsdCfto3Fh4t7ZNxegGCPT9tHx6fpBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191573; c=relaxed/simple;
	bh=hU+76LwX91pzp4heav2T3j1q2BEjeJXo44fo8w7hXnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orLne4Gd2zTuH+Ibfhgih4EaYxuY28DH8uBl0a+G9tzCC7gbV52w+CLwLfN23TW+LhfO3JVNlGzmM+3LgYzOaIiBlNtntS5QUKBFa+3GHFT+5PBJowNuRD6A0kPmVowLN5hDkjVEh2E2Hl6jSSCNWNov+rF0CJ4i/5IgDj4sKg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SvPuOET5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A64C4CEF1;
	Tue, 22 Jul 2025 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753191572;
	bh=hU+76LwX91pzp4heav2T3j1q2BEjeJXo44fo8w7hXnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvPuOET5LZbPuekY9/9kboVrEVCzFvlUQARcI2JrOar/rVi5tjNrzh+A+lFRzQMud
	 7SANahx9no6dZPV0PWXhmc3rc7uV7s+fzzyR77P0vmux+oGpS4uvKTvzi4nF4PH+Cr
	 NnPgTI9iTUwCRSBtLAuU8JCQIYIMN1DNblz1c4iw=
Date: Tue, 22 Jul 2025 15:39:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: stable@vger.kernel.org, qat-linux@intel.com,
	Damian Muszynski <damian.muszynski@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH 6.1] crypto: qat - fix ring to service map for QAT GEN4
Message-ID: <2025072227-postnasal-suburb-1f7f@gregkh>
References: <20250717170835.25211-1-giovanni.cabiddu@intel.com>
 <2025072202-partridge-utilize-9db7@gregkh>
 <aH+SPEqs+qf8jiDT@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH+SPEqs+qf8jiDT@gcabiddu-mobl.ger.corp.intel.com>

On Tue, Jul 22, 2025 at 02:29:32PM +0100, Giovanni Cabiddu wrote:
> On Tue, Jul 22, 2025 at 11:42:37AM +0200, Greg KH wrote:
> > On Thu, Jul 17, 2025 at 06:06:38PM +0100, Giovanni Cabiddu wrote:
> > > [ Upstream commit a238487f7965d102794ed9f8aff0b667cd2ae886 ]
> > > 
> > > The 4xxx drivers hardcode the ring to service mapping. However, when
> > > additional configurations where added to the driver, the mappings were
> > > not updated. This implies that an incorrect mapping might be reported
> > > through pfvf for certain configurations.
> > > 
> > > This is a backport of the upstream commit with modifications, as the
> > > original patch does not apply cleanly to kernel v6.1.x. The logic has
> > > been simplified to reflect the limited configurations of the QAT driver
> > > in this version: crypto-only and compression.
> > > 
> > > Instead of dynamically computing the ring to service mappings, these are
> > > now hardcoded to simplify the backport.
> > > 
> > > Fixes: 0cec19c761e5 ("crypto: qat - add support for compression for 4xxx")
> > > Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > > Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> > > Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
> > > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > > Cc: <stable@vger.kernel.org> # 6.1.x
> > > Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> > > Tested-by: Ahsan Atta <ahsan.atta@intel.com>
> > 
> > You did not mention anywhere what changed from the original commit (and
> > it changed a lot...)  So this looks to me like an incorrect backport, so
> > I have to just delete it :(
> It is mentioned in the commit message:
> 
>   This is a backport of the upstream commit with modifications, as the
>   original patch does not apply cleanly to kernel v6.1.x. The logic has
>   been simplified to reflect the limited configurations of the QAT driver
>   in this version: crypto-only and compression.
> 
>   Instead of dynamically computing the ring to service mappings, these are
>   now hardcoded to simplify the backport.
> 
> I didn't port the original algorithm that builds the ring to service
> mapping as the QAT driver in v6.1 only supports two configurations
> (crypto and compression), therefore I simplified the logic in the
> function get_ring_to_svc_map() to just returns the mask associated to
> each configuration.
> 
> BTW, I'm also the author of the original patch.
> 
> > 
> > Please fix up and send it again.
> Is this sufficient or shall I resend?

Please resend and put the comments you made that differ from the
original changelog text down in the signed-off-by area like other
backports do.

Here is an example of that:
	https://lore.kernel.org/r/20250717124556.589696-2-harshit.m.mogalapalli@oracle.com

thanks,

greg k-h

