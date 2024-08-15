Return-Path: <stable+bounces-69217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C5953641
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9125C283734
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381419FA9D;
	Thu, 15 Aug 2024 14:51:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1AB1AC8BE
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733511; cv=none; b=bjjWewqZZcDs1S450Lt7GEhWFy7/0xo3G8rnfRiIp4jO0q/S2X6F6inZVojDHk+TlYhVMaVOGlG07Rw7DXWJwUAqCRxDoMvOFIEAMCaCYVdEZGJAqASHe43XnwIBY4+mz4ONU/r+vGB3iKDqYDra+uuJPoE75Yp7R0ZmADcSCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733511; c=relaxed/simple;
	bh=3l6nYyd0G0aXALkJWYBtwQtEmECnyeuj0UC/PPOxYIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPLryQcBs9ht2mp+GrIkP09ivGui6bJ4SLrphQzRTGXhf7El6cby3mDoilln8+BKQtYv28xiXrLjW6Sln54u+tBfNUbPPkvdbAnIgg4ABCTjhNCK3dSqkB/fOGptf9FH3YGVrPmbltaxOcd746h7zIl7hRAe94PLtSbnji0tSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B20C314BF;
	Thu, 15 Aug 2024 07:52:14 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C38C3F58B;
	Thu, 15 Aug 2024 07:51:47 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:51:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, anshuman.khandual@arm.com,
	bwicaksono@nvidia.com, catalin.marinas@arm.com, james.clark@arm.com,
	james.morse@arm.com, will@kernel.org
Subject: Re: [PATCH 6.6.y 13/13] arm64: errata: Expand speculative SSBS
 workaround (again)
Message-ID: <Zr4V_T8_ugiJmGJg@J2N7QTR9R3.cambridge.arm.com>
References: <20240809095745.3476191-1-mark.rutland@arm.com>
 <20240809095745.3476191-14-mark.rutland@arm.com>
 <2024081211-props-gimmick-e3f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081211-props-gimmick-e3f5@gregkh>

On Mon, Aug 12, 2024 at 05:03:45PM +0200, Greg KH wrote:
> On Fri, Aug 09, 2024 at 10:57:45AM +0100, Mark Rutland wrote:
> > [ Upstream commit b0672bbe133ebb6f7be21fce1d742d52f25bcdc7 ]
> 
> Now I figured it out, this is the wrong git id, and is not in any tree
> anywhere.  It should be adeec61a4723fd3e39da68db4cc4d924e6d7f641.
> 
> I'll go hand-edit it now...

Thanks, and sorry about that.

Looking in my local tree, the incorrect commit id is a copy of
adeec61a4723fd3e39da68db4cc4d924e6d7f641 where the earlier commits had
been updated with "[ Upstream commit XXX ]" wording. Evidently I grabbed
the commit ID from the wrong branch when I was folding that in.

I'll try to make sure that doesn't happen again. Is there any public
tooling for sanity-checking this?

Mark.

