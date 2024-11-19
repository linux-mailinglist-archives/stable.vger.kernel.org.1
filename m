Return-Path: <stable+bounces-94010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16509D280D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315A4B2ED67
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EE41CCEC6;
	Tue, 19 Nov 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SkoII8tE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462E54673
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025656; cv=none; b=sBvxQaf7gtmyJbnsgRtKU8jG0JHiEuY8KZpbTA34kL/3Zi29cLOXp6VPQL+0y9qnz0pwcJ+1v1nU9ma/oCECeaf+8bKhqisrKSwFRtIBHlWgQnwh9o6oCrSJ/ur3bPZI+o+gVmZ00Tm0tb3JqArmVzHMk6LfsKMTLiWnVRvb/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025656; c=relaxed/simple;
	bh=fX1zM1t/7JGkhArh1AWTcDjgcwvlDsXhCkOh8o/yCXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqcli+PaKnDVlkvgIyiO/2AKXmsWHzGWM/HMfDY73+IkcgEbo9esenHxclZZQ7X48gypM2cPkg4prghQFEPP69cLnwAPncJHvoDVYbMhC67XeCK1WO8snVhHeNWaJ3WUqV+XhVB703kTVTOXXOdZPGB0CX5rHuXu2PzmbMRu934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SkoII8tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA73C4CECF;
	Tue, 19 Nov 2024 14:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732025655;
	bh=fX1zM1t/7JGkhArh1AWTcDjgcwvlDsXhCkOh8o/yCXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkoII8tEnznnoqm9h5FNzfjBHL5DGQ52G2U1aL3ACDzAcQx+cvX0a3VOOtulQYLkd
	 pN2H7/kUnouOz+I66uGKFBvP9CG44HAXAUo6pGbtjb/Kcy2tXGiUvoNxpiAsx+IEst
	 Jujan7z52KVZfg17KawiqhUdWn0YdjT4HU76aTxc=
Date: Tue, 19 Nov 2024 15:13:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, cel@kernel.org
Subject: Re: [PATCH 6.1 1/5] NFSD: initialize copy->cp_clp early in
 nfsd4_copy for use by trace point
Message-ID: <2024111915-annually-semisoft-c5d6@gregkh>
References: <20241118211900.3808-2-cel@kernel.org>
 <20241118211900.3808-2-cel@kernel.org>
 <ZzybZplCfSkWKsyi@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzybZplCfSkWKsyi@tissot.1015granger.net>

On Tue, Nov 19, 2024 at 09:06:30AM -0500, Chuck Lever wrote:
> On Mon, Nov 18, 2024 at 11:36:15PM -0500, Sasha Levin wrote:
> > [ Sasha's backport helper bot ]
> > 
> > Hi,
> > 
> > The upstream commit SHA1 provided is correct: 15d1975b7279693d6f09398e0e2e31aca2310275
> > 
> > WARNING: Author mismatch between patch and upstream commit:
> > Backport author: cel@kernel.org
> > Commit author: Dai Ngo <dai.ngo@oracle.com>
> 
> Is this a bug in my backport script? Should patches backported
> to LTS retain the upstream patch author, or should they be From:
> the backporter? If the former, I can adjust my scripts.

No, this is correct, I think Sasha's scripts are a bit too sensitive
here and in a few other places.

thanks,

greg k-h

