Return-Path: <stable+bounces-135137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518ECA96E06
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB06188653C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF8283CAE;
	Tue, 22 Apr 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQT3JcQX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA60202978
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331081; cv=none; b=MeVl2oFHJk8lDfn9npaZcd4Ult2W2BqtBxN0t/DdcCVl1sXxhd06gtCiZAaq+fhPVgUPFWfeDVwliMD5s+rytMeb2yzTpzCFozVHd7BgcJauJ8YWKprsr/OcCPnt9484dtVS/oyqoDKijiyE/+AGEwecbbbVT9RUYmT0B74lapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331081; c=relaxed/simple;
	bh=98oXZUkFm0O4O3FzYc/xFOIDtxMOyBT1yw5OSwPldMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQxJr+riVOSxSisTBpl89CBgSV1iIndKVvpLfv9umq74HHl9k0BAu+XaNT+LPxyNcfMMpli/AFhffk61EOwKzmOV1oOYT4cGexSEuM1+X+WXPfcnV+mIRpCpxdm13x88O3Vu654HCKC73WtaKWfqlztQcYar5IhT0t2ykMt+9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQT3JcQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3915BC4CEE9;
	Tue, 22 Apr 2025 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745331079;
	bh=98oXZUkFm0O4O3FzYc/xFOIDtxMOyBT1yw5OSwPldMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQT3JcQXfG/ibRhKpVzSEOspY8AfxuMHrfw54Lhf7PE4m5C5gJQ7Tx4NjWII3wlb6
	 HbjcbYVDQu1BAAhi5Unqyr4Ipy89EQvsde24z0PMlc6K7zFLK4r3KqIJ83O3i5qFaI
	 UM5e85Z0b+WThOWzFQCLDvAbW1tZRBMon/VXVvIg=
Date: Tue, 22 Apr 2025 16:11:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/3 v5.4.y] dmaengine: ti: edma: Add support for handling
 reserved channels
Message-ID: <2025042230-equation-mule-2f3d@gregkh>
References: <20250416064325.1979211-1-hgohil@mvista.com>
 <2025042246-hush-viable-35fa@gregkh>
 <CAH+zgeHyLBNMz=kWw0xbfKfw2Fy6BtbWZAub6w_cTsAhNEsxSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+zgeHyLBNMz=kWw0xbfKfw2Fy6BtbWZAub6w_cTsAhNEsxSw@mail.gmail.com>

On Tue, Apr 22, 2025 at 07:33:03PM +0530, Hardik Gohil wrote:
> >
> > > I'm sorry, I have no idea what to do here :(
> > >
> please add all the patches 1/3,2/3 and 3/3 to v5.4.y.

Please do not post in html format :(

Anyway, I do not see patches 2/3 or 3/3 at all.

Please resend them all as a full patch series, don't just give links.

thanks,

greg k-h

