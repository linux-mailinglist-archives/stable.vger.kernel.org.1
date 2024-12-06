Return-Path: <stable+bounces-99063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BDC9E6F23
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2190163230
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D222066DD;
	Fri,  6 Dec 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iY+egNGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314642066C2
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490762; cv=none; b=NMw0vzahq49rFE+Ph1FUUPoWRe5ItwedDeXfwnXO3sEwvrI1iCpY9DL/aBhirnvm6D6gegGF+pZt57Ez0SqZMJuu0NsRtQZ0VQry9ZeA46mMcq5WAqOdYEwNvtM25KOOL6Ica6528nNerfwXFqgUmPukET414ejoFuNxKyF9kAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490762; c=relaxed/simple;
	bh=dh2Eu7TvJWyKVAzI9SowxP/JsGTqUJ6mWKY/CYq+8jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oeo4uA09oy1v/fYpq0c43whniEK/Lf4/PPN8ct02CeMsbQMt4cTLQLBsPOKfnRrjRmRjuuQH2z8GvBhj9TKuU5WdbKC5oANXe2P9/+IR7JOxQxWs+8CKK9LkkQ9wqup6tpk9hRahGA52Ckz+Pq5TCaLKwFMXAnHF1jblg4BY4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iY+egNGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33769C4CEE0;
	Fri,  6 Dec 2024 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733490761;
	bh=dh2Eu7TvJWyKVAzI9SowxP/JsGTqUJ6mWKY/CYq+8jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iY+egNGb1+1s+a5aDQBy7RpyyepwQJ+Hp5qbjPJr1BsMwE2ig02xAvpb4tQLAYLG3
	 /7lWfPPuyA6juFJY4cKV/djqIByoU6Y7hhzaRgW7rV+481w1b0iJBm3MRLvwguLI8a
	 Lmc0o/UMr4okz+UQ52aMsvB2+sYt74IJuBoZSs4c=
Date: Fri, 6 Dec 2024 14:12:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Fangzhi Zuo <Jerry.Zuo@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Message-ID: <2024120610-depose-hatching-821c@gregkh>
References: <20241202172833.985253-1-alexander.deucher@amd.com>
 <2024120301-starring-pruning-efe3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120301-starring-pruning-efe3@gregkh>

On Tue, Dec 03, 2024 at 08:11:14AM +0100, Greg KH wrote:
> On Mon, Dec 02, 2024 at 12:28:32PM -0500, Alex Deucher wrote:
> > From: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > 
> > Streams with invalid new connector state should be elimiated from
> > dsc policy.
> > 
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
> > Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > (cherry picked from commit 9afeda04964281e9f708b92c2a9c4f8a1387b46e)
> > Cc: stable@vger.kernel.org
> > ---
> >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> What kernel tree(s) is this series for?

Dropping from my queue due to lack of response :(

Please resend if you need this, with a hint of what we are supposed to
be applying it to.

thanks,

greg k-h

