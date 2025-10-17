Return-Path: <stable+bounces-186324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEC5BE8D27
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8DC6E2981
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B7C34F488;
	Fri, 17 Oct 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqVr3H4t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F74332ECD;
	Fri, 17 Oct 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707476; cv=none; b=aMPIhojHfqRnweFvGr4TWbMHGE5nxJIekByNDCiIUm3r8nchNR+2ulwZWk/xB0xKt+otUmhUnV1f6xX4efAOkuFLwcFFOiijAeGE2VLNSIsoGsS5gYHAB8MYFbiA4dEyFPiCn00c4/+An22tCfFv4rR5mwz8Bdce78tsOd42wEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707476; c=relaxed/simple;
	bh=OJG0btO9mK5cD8BkzgHp6FWSeXog2428DkzWPSMdbMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R54TbpsCiuJRzTKY1Vb4yxw3j63WI5A+NwRl2wJ+pSts/8cWF/y4o9ZLf4Rw35laXPLh92GBqyv4AfNvQb0Bc3zglQ4P3SjUe0IaAyu/ND31cEERjnkeAZJ/m6OyESPTd+u+zN/tOLhqz6FCd1CG7vf6FOT/AOMx1zzqNOEs/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fqVr3H4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035E0C4CEF9;
	Fri, 17 Oct 2025 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760707475;
	bh=OJG0btO9mK5cD8BkzgHp6FWSeXog2428DkzWPSMdbMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqVr3H4trlS9SOn/0U46bLvIfk+tcyAPvwD0Uwb36pTdNbZFohgPSknE1++cD3B5n
	 SXXrZgj0v6KoS+60mGw85iauS9ureynXPV2y+AmxAXIY//xe1kRl3JIINUfHL8OVtn
	 /nJIKuKCKhCvrs91dGhlLIDfn3Yi9zlGIKD+ttPU=
Date: Fri, 17 Oct 2025 15:24:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable-commits@vger.kernel.org, geliang@kernel.org, kuba@kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "selftests: mptcp: join: validate C-flag + def limit" has
 been added to the 5.15-stable tree
Message-ID: <2025101722-relative-stunt-b387@gregkh>
References: <2025101612-civic-donated-16c8@gregkh>
 <03816237-f54d-4483-a8d4-98bf12e0ac00@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03816237-f54d-4483-a8d4-98bf12e0ac00@kernel.org>

On Fri, Oct 17, 2025 at 12:16:56PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 16/10/2025 15:25, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     selftests: mptcp: join: validate C-flag + def limit
> > 
> > to the 5.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      selftests-mptcp-join-validate-c-flag-def-limit.patch
> > and it can be found in the queue-5.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> It looks like this patch was applied at the wrong place, and further
> adaptations are needed to work in v5.15. Do you mind dropping it from
> the v5.15 tree, please?
> 
> I will send a newer version later on.

Now dropped from both queues, thanks for the review!

greg k-h

