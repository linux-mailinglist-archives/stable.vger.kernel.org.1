Return-Path: <stable+bounces-46060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571198CE4F7
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C4E282292
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 11:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F98624B;
	Fri, 24 May 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mbvJzNZC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1908E8565B;
	Fri, 24 May 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716551238; cv=none; b=MLT31Dae15Zmg06cXgJxk4dkYh9xcgBlss5h3JBpllvWFXhJ3UeUamPhILYxFffrLJB43fCG9riunzUWAzJSFyvDoKWFLLaHKJaLt5dJF4voP2bEJWGvcS4bZMu7kJ/DhmZ7mhMFqLIV0zp+t5eSmsMAYKH8wjHxz9igVyzdo0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716551238; c=relaxed/simple;
	bh=laFCZAQzfWR8fPbw0NoR/VGc8vV6Sykpx1HdwgikE3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOxLK+WFAOwczrqiLAz5f3ADy/Cs0Y17f9OydPYts7kHCtujOBeuBZRi/plNXPVodk7re1E+5XC0P4e5IlSK/rkIDiu0YIOI3dPdJXdtdHnvtzdXYL1iYXe5LWPu9oMpPgWYZaehg94jhu95DqKUtrf77DvgYD/lb/aaYEnqeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mbvJzNZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DACBC2BBFC;
	Fri, 24 May 2024 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716551237;
	bh=laFCZAQzfWR8fPbw0NoR/VGc8vV6Sykpx1HdwgikE3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbvJzNZCaW0uOIWYaqqHJj3FGGC1eFebNTFK8GrmNzV/CQj1j07zUjzfcn1qQVwiq
	 CQWPGPtUcbmW2jhoWUBRfILe63X9j8GbZtBZ9I4KYK34sJEKYYktUhVw8aJVEq/ZPi
	 FlV6GlklfJDH9Ow4Hgda/AaVKDpK6MfQplzSxJnI=
Date: Fri, 24 May 2024 13:47:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
Message-ID: <2024052405-award-recycling-6931@gregkh>
References: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024052418-casket-partition-c143@gregkh>
 <74465bf5-ca18-45f8-a881-e95561c59a02@quicinc.com>
 <2024052438-hesitate-chevron-dbd7@gregkh>
 <5acce173-0224-4a05-ae88-3eb1833fcb39@quicinc.com>
 <2024052458-unleash-atom-489b@gregkh>
 <0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b916393-eb39-4467-9c99-ac1bc9746512@quicinc.com>

On Fri, May 24, 2024 at 05:08:06PM +0800, quic_zijuhu wrote:
> On 5/24/2024 2:56 PM, Greg KH wrote:
> > On Fri, May 24, 2024 at 01:34:49PM +0800, quic_zijuhu wrote:
> >> On 5/24/2024 1:21 PM, Greg KH wrote:
> >>> On Fri, May 24, 2024 at 01:15:01PM +0800, quic_zijuhu wrote:
> >>>> On 5/24/2024 12:33 PM, Greg KH wrote:
> >>>>> On Fri, May 24, 2024 at 12:20:03PM +0800, Zijun Hu wrote:
> >>>>>> zap_modalias_env() wrongly calculates size of memory block
> >>>>>> to move, so maybe cause OOB memory access issue, fixed by
> >>>>>> correcting size to memmove.
> >>>>>
> >>>>> "maybe" or "does"?  That's a big difference :)
> >>>>>
> >>>> i found this issue by reading code instead of really meeting this issue.
> >>>> this issue should be prone to happen if there are more than 1 other
> >>>> environment vars.
> >>>
> >>> But does it?  Given that we have loads of memory checkers, and I haven't
> >>> ever seen any report of any overrun, it would be nice to be sure.
> >>>
> >> yes. if @env includes env vairable MODALIAS and  more than one other env
> >> vairables. then (env->buflen - len) must be greater that actual size of
> >> "target block" shown previously, so the OOB issue must happen.
> > 
> > Then why are none of the tools that we have for catching out-of-bound
> > issues triggered here?  Are the tools broken or is this really just not
> > ever happening?  It would be good to figure that out...
> > 
> don't know why. perhaps, need to report our case to expert of tools.

Try running them yourself and see!

