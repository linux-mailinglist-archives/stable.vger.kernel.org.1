Return-Path: <stable+bounces-182074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC4BAD235
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EC8171EB6
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B81F03C5;
	Tue, 30 Sep 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0OXInAw0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87262238C1A
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759241053; cv=none; b=YRpcfEUdnMU/83o8bFETmEWwSVp6n2RrWKjH1jKfm2x8uUYaMtLtILp1nrdvgiTEJqunbPFkQ0ne1xRxoOmdrdu1QKqypHHr7pBxHeCCRcHNEtJp0jnihfPrdCypJWcTuwhNQ22fce38eTYZat+WFFH27dncwDiOn7IeV6QQSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759241053; c=relaxed/simple;
	bh=JiHP1ztuAnIDaRoxBa5hkslOGdadzloL5a9/wQm51IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SveMhKagXnC2NQ28K1ZnVljKYyfkHSS0JD1cECKNlksIhc/VUpvsewg31A/3Q0q6icQlm9Rd1DeBl3BVUhirq7PxMNLZfyjHXNapuidro+zVbDERPm/zj5BiEmtO11+ahGUBAaZ748a/9o+V6bAYuO4l6me07EcuilVFh1aYxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0OXInAw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0ABC113D0;
	Tue, 30 Sep 2025 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759241052;
	bh=JiHP1ztuAnIDaRoxBa5hkslOGdadzloL5a9/wQm51IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0OXInAw0fqEcv2NoDHYMNFLo20VRMTuVMzeVGSdIjcyTSGGdKV8LjWXhBQrI2U2Fk
	 KnWL0mU13RDu4eZLkGq7AgQBUFK2ARQukeGNDDDxYPEat6Oa5q+Ku0FRa1lRm2SFIi
	 9yMjyauTtJKU1UyOWB0USPl5cjo4jYOKBuQpMeVQ=
Date: Tue, 30 Sep 2025 16:04:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>, stable@vger.kernel.org,
	Wolfgang Walter <linux@stwm.de>
Subject: Re: [PATCH] Revert "usb: xhci: remove option to change a default
 ring's TRB cycle bit"
Message-ID: <2025093059-unrobed-eligible-ae6c@gregkh>
References: <20250930132251.945081-1-niklas.neronin@linux.intel.com>
 <902780b3-7bc0-431d-bbb7-fe7b7b7fabd7@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <902780b3-7bc0-431d-bbb7-fe7b7b7fabd7@linux.intel.com>

On Tue, Sep 30, 2025 at 04:51:35PM +0300, Mathias Nyman wrote:
> On 9/30/25 16:22, Niklas Neronin wrote:
> > Revert 9b28ef1e4cc0 [ Upstream commit e1b0fa863907 ], it causes regression
> > in 6.12.49 stable, no issues in upstream.
> > 
> > Commit 9b28ef1e4cc0 ("usb: xhci: remove option to change a default ring's
> > TRB cycle bit") introduced a regression in 6.12.49 stable kernel.
> > The original commit was never intended for stable kernels, but was added
> > as a dependency for commit a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer
> > ring after several reconnects").
> > 
> > Since this commit is more of an optimization, revert it and solve the
> > dependecy by modifying one line in xhci_dbc_ring_init(). Specifically,
> > commit a5c98e8b1398 ("xhci: dbc: Fix full DbC transfer ring after several
> > reconnects") moved function call xhci_initialize_ring_info() into a
> > separate function. To resolve the dependency, the arguments for this
> > function call are also reverted.
> > 
> > Closes: https://lore.kernel.org/stable/01b8c8de46251cfaad1329a46b7e3738@stwm.de/
> > Tested-by: Wolfgang Walter <linux@stwm.de>
> > Cc: stable@vger.kernel.org # v6.12.49
> > Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
> 
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

Thanks, now queued up.

greg k-h

