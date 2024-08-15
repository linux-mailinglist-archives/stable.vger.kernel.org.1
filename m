Return-Path: <stable+bounces-69219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C0195369D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5201C24CC2
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D78B1A706A;
	Thu, 15 Aug 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2ZR4qR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11821A7068
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734311; cv=none; b=E8vIK8Dd1VzKqWga4+TBg3+PEL8XPxvnz2eNfbNKpgBt67o+ntY3X36X/iElpToZyXrxkz9GMYyIzXNmHLnwsl2rykqUP0gAze5WM46e9P8DLeF3BynhDW53HLHdhzMmvC4auyZfRel75wq72O/PJwM3NbjHLT0veP8U1NWHB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734311; c=relaxed/simple;
	bh=I0BfDFRxKEnLda2Pri6exgQF3tiMe84UkWe7MpusdxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLAgDnbEebFmcPnPQbFeo6SKwQ+k2vEGp6KzyPKuCklUUoBbNefJs6gHiaSErZDgclbMabMnLZzAM+xjk4WkqXi8a7hMsnuTkF0Pgjl9JOQOJHjp2nZ1EgDMHXskkIigMGKfIjh+qAaMKvPS3UqVDP7/hgGMLiewECSFXoYsdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d2ZR4qR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E04C32786;
	Thu, 15 Aug 2024 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723734311;
	bh=I0BfDFRxKEnLda2Pri6exgQF3tiMe84UkWe7MpusdxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2ZR4qR7jB3Ez43f/u7NY9tJbpwED+WakZuPmF2odLwfPvhIbOV0iaYmNrKKd253v
	 2zhom77LAFP9IG6mf/2fymwj4dH5YVN3b9nYRhXmMsR/SKb0vCJZ6DK4nx+0lQ4AXw
	 y70Aqbfz/vwOyvC/kz196R6jmnFOSwNpHPRiWqkc=
Date: Thu, 15 Aug 2024 17:05:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org, anshuman.khandual@arm.com,
	bwicaksono@nvidia.com, catalin.marinas@arm.com, james.clark@arm.com,
	james.morse@arm.com, will@kernel.org
Subject: Re: [PATCH 6.6.y 13/13] arm64: errata: Expand speculative SSBS
 workaround (again)
Message-ID: <2024081501-dispute-underwear-a9ca@gregkh>
References: <20240809095745.3476191-1-mark.rutland@arm.com>
 <20240809095745.3476191-14-mark.rutland@arm.com>
 <2024081211-props-gimmick-e3f5@gregkh>
 <Zr4V_T8_ugiJmGJg@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr4V_T8_ugiJmGJg@J2N7QTR9R3.cambridge.arm.com>

On Thu, Aug 15, 2024 at 03:51:41PM +0100, Mark Rutland wrote:
> On Mon, Aug 12, 2024 at 05:03:45PM +0200, Greg KH wrote:
> > On Fri, Aug 09, 2024 at 10:57:45AM +0100, Mark Rutland wrote:
> > > [ Upstream commit b0672bbe133ebb6f7be21fce1d742d52f25bcdc7 ]
> > 
> > Now I figured it out, this is the wrong git id, and is not in any tree
> > anywhere.  It should be adeec61a4723fd3e39da68db4cc4d924e6d7f641.
> > 
> > I'll go hand-edit it now...
> 
> Thanks, and sorry about that.
> 
> Looking in my local tree, the incorrect commit id is a copy of
> adeec61a4723fd3e39da68db4cc4d924e6d7f641 where the earlier commits had
> been updated with "[ Upstream commit XXX ]" wording. Evidently I grabbed
> the commit ID from the wrong branch when I was folding that in.
> 
> I'll try to make sure that doesn't happen again. Is there any public
> tooling for sanity-checking this?

Not that I know of :(

