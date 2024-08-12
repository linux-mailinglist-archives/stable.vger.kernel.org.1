Return-Path: <stable+bounces-66538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A794EF25
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEAF280E4F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7517D35C;
	Mon, 12 Aug 2024 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXCKFhbT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE017D354
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471667; cv=none; b=ekkkzqDEHU+K8Oc0IPswLQu68Eh8vTpfKnURRqf2LL1nich60pKznvsd3xrGqoHajZETUuXH7/ZRQ8gzXL8tz+jGCIp+yBz61pJiDaz4pdqe3d06/418fz+CAb69n9DndhESZaJiQ8LYLWojZWBWO1VgSvS3H/WRHue4Kx56E7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471667; c=relaxed/simple;
	bh=biIw/E+Scy4ea7tGR5kU/902hBqXlUOvhQQu0dppZTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUsX8CErM4CKf/DnZjmwskn5I6+PZ0fRzBjQtgCiNegBW+aIpV9Wh4a6scLZNlySOM86fDZ+cr68l34Tu5oyiZ1EzgYUHX/0YvWXx4YsYiPnJUnkc7j/sZU5XjlB7ZpF1X238DiMcxWXe7f7DpVACiBZ8iJzuZpyo8G+j5kIpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nXCKFhbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0CFC32782;
	Mon, 12 Aug 2024 14:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723471666;
	bh=biIw/E+Scy4ea7tGR5kU/902hBqXlUOvhQQu0dppZTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXCKFhbTcfxzQ5s9lrGsOo/RDbD+iWsxmCZeQLYuj6tpsobM2z/13Zt/8JzQ60nO3
	 ufAKFzDV3sHMBw4/C+QV9h4lzxXqBpA0KcN/Tw6UVfpCex23vLpp/XA76xahzWytUG
	 8f1jSFXgMqutkYKEoTBaEdy625zAoYdfPuz2VigE=
Date: Mon, 12 Aug 2024 16:07:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	anshuman.khandual@arm.com, catalin.marinas@arm.com,
	james.morse@arm.com, will@kernel.org
Subject: Re: [PATCH 6.10.y 0/8] arm64: errata: Speculative SSBS workaround
Message-ID: <2024081239-repugnant-disaster-67b9@gregkh>
References: <20240809095120.3475335-1-mark.rutland@arm.com>
 <ZrnxgS9RTDP4FDtK@sashalap>
 <ZrnyqZxR_0mjNFdZ@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrnyqZxR_0mjNFdZ@J2N7QTR9R3>

On Mon, Aug 12, 2024 at 12:31:53PM +0100, Mark Rutland wrote:
> On Mon, Aug 12, 2024 at 07:26:57AM -0400, Sasha Levin wrote:
> > On Fri, Aug 09, 2024 at 10:51:12AM +0100, Mark Rutland wrote:
> > > Hi,
> > > 
> > > This series is a v6.10-only backport (based on v6.10.3) of the upstream
> > > workaround for SSBS errata on Arm Ltd CPUs, as affected parts are likely to be
> > > used with stable kernels. This does not apply to earlier stable trees, which
> > > will receive a separate backport.
> > 
> > I've queued up the backports for the various versions, thanks!
> 
> Thanks; much appreciated!

Did you not backport commit adeec61a4723 ("arm64: errata: Expand
speculative SSBS workaround (again)") on purpose?  Shouldn't we also be
taking that one?

thanks,

greg k-h

