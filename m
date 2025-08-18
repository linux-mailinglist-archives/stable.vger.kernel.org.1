Return-Path: <stable+bounces-170049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678B4B2A0B2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6913AD162
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FFF21FF38;
	Mon, 18 Aug 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVsWxSXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DEB2E2283
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755517276; cv=none; b=GPf4OQhxtmCAmIeqBFSE/7yceLU3PvAi7qy4QXkDYj21ESYhOk2vmd8bFd7+FsURZiv+EKyi0hFkOC8tZdJ8pi+6HT2P5eTIgBgi5b4AkEhocFWfxDxXDT7G9Iv0KRyPABhjxuGMp5fxcRjyq4pLM92CQ+ju4glUa26JZB9W3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755517276; c=relaxed/simple;
	bh=KARksXz8kGSJICeCPybif3Z+aJK7Z4/IrOjTpAbKAHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKVdkCoFVAZwaBbF4HirvgGSkLRgkmT8rT9fwPHnQkFz9Y+vsWfjAoHlraUpMQo66wmkL4gHDV7EMwvsUgrw16YAev9E4RW7HmzuqNhyZoSVzmO+HHf91PXc4q7i60/b5JEKAcPKGPdVuqZ61w5HxCi65XmPWBc+moD0+URMwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DVsWxSXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F60DC116B1;
	Mon, 18 Aug 2025 11:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755517276;
	bh=KARksXz8kGSJICeCPybif3Z+aJK7Z4/IrOjTpAbKAHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVsWxSXQSibJZND/sPu7KE/j2/qJSukT1sDi1nZPYboqSzAlDVAZDGkDZ4GVB2bXJ
	 sbpk1zlNw/PO7sdj00IL6iwse0e0S2AN1z7NlPv84OazAzFqRFLcgAIblyPp9GGx/V
	 1/e5HU02ctreaoSQAg5/N4lgfwjQYPfSnW0Iu0BU=
Date: Mon, 18 Aug 2025 13:41:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, qat-linux@intel.com,
	Damian Muszynski <damian.muszynski@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH 6.1 v2] crypto: qat - fix ring to service map for QAT GEN4
Message-ID: <2025081806-hasty-nectar-4d65@gregkh>
References: <20250722150910.6768-1-giovanni.cabiddu@intel.com>
 <aKMOiXg0KvyxWb6F@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKMOiXg0KvyxWb6F@gcabiddu-mobl.ger.corp.intel.com>

On Mon, Aug 18, 2025 at 12:29:13PM +0100, Giovanni Cabiddu wrote:
> Hi Greg and Sasha,
> 
> On Tue, Jul 22, 2025 at 04:07:09PM +0100, Giovanni Cabiddu wrote:
> > [ Upstream commit a238487f7965d102794ed9f8aff0b667cd2ae886 ]
> > 
> > The 4xxx drivers hardcode the ring to service mapping. However, when
> > additional configurations where added to the driver, the mappings were
> > not updated. This implies that an incorrect mapping might be reported
> > through pfvf for certain configurations.
> > 
> > This is a backport of the upstream commit with modifications, as the
> > original patch does not apply cleanly to kernel v6.1.x. The logic has
> > been simplified to reflect the limited configurations of the QAT driver
> > in this version: crypto-only and compression.
> > 
> > Instead of dynamically computing the ring to service mappings, these are
> > now hardcoded to simplify the backport.
> > 
> > Fixes: 0cec19c761e5 ("crypto: qat - add support for compression for 4xxx")
> > Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> > Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > (cherry-picked from commit a238487f7965d102794ed9f8aff0b667cd2ae886)
> > [Giovanni: backport to 6.1.y, conflict resolved simplifying the logic
> > in the function get_ring_to_svc_map() as the QAT driver in v6.1 supports
> > only limited configurations (crypto only and compression).  Differs from
> > upstream as the ring to service mapping is hardcoded rather than being
> > dynamically computed.]
> > Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> > Tested-by: Ahsan Atta <ahsan.atta@intel.com>
> > Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > ---
> > V1 -> V2: changed signed-off-by area:
> >   * added (cherry-picked from ...) after last tag from upstream commit
> >   * added a note explaining how this backport differs from the original patch
> >   * added a new Signed-off-by tag for the backport author.
> 
> Just following up on this patch as I haven't seen any activity on it yet.
> 
> Was it possibly missed, or is there anything I should do to move it
> forward?

It's in a pending queue of hundreds of stable backports I have yet to
get to.  That's what I get for trying to take a vacation... :)

Don't worry, it's not lost, just that we have to process patches for the
newer stable kernels first, as that's where we have the most users.
This, and many others, will be gotten to in a week or so.

thanks,

greg k-h

