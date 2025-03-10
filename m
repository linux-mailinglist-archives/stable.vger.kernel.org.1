Return-Path: <stable+bounces-121729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C301A59B04
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA4F16C0D7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF123026D;
	Mon, 10 Mar 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d5/HrIXr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CED4230264
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624152; cv=none; b=R1HnnxudLgb3HEW78fjJj5U2H7yTIV88CLhFedPYpbFApordp/FfPCigpEloaGhZqBbMjqH76zJNfgvqnKTFP3wxNveabARBVgQQFd00HJeL9sNQIcbtOZvijo/6MkuZaZ4xn3MOeIugl2r+GJW8fVTZSo7/i2GjQ6zCxlcfwfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624152; c=relaxed/simple;
	bh=2fEWzt7MyrwDO62MOYXBV2NWVY+NJz1zOYmMJ0EYEA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqQ4RZYhIxSgben3zaRBSHJuhawFciIJkFg1+9qT4G58ZVR95cqHr0vG5MC9omx0F51jNfyhQJL2+9TLQSKjJ8/8YtCBb4ArrJG6Y5Oet+qhcZNtXowhFohP1it2piZpUS4wOVBlXke6+RK8x40wZgZxf7gq1+HUjRGI5ETBcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d5/HrIXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D46DC4CEE5;
	Mon, 10 Mar 2025 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741624151;
	bh=2fEWzt7MyrwDO62MOYXBV2NWVY+NJz1zOYmMJ0EYEA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5/HrIXrGbdFVkEaWvlN0z2E5cVY1OeaUY+2AI4GMpGfcb0VAYFtASV0780O/I4Ks
	 ezTEaQG0wYBXHKgyecFAEVcVBaccMUX7wK5r2odTxnyCrWzktkjCM7cckL3ha8ssyt
	 3e8sPnrnLx52PBkBdHUJU/70pL6Pv0VCLSmMfucs=
Date: Mon, 10 Mar 2025 17:29:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ben Hutchings <benh@debian.org>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 5.4,5.10 2/2] udf: Fix use of check_add_overflow() with
 mixed type arguments
Message-ID: <2025031054-kiwi-snowdrift-678b@gregkh>
References: <Z7yXm_Vo1Y0Gjx_X@decadent.org.uk>
 <29f96d04ceac67563df0b4b17fb8a887dff3eb04.camel@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f96d04ceac67563df0b4b17fb8a887dff3eb04.camel@debian.org>

On Mon, Feb 24, 2025 at 11:28:22PM +0100, Ben Hutchings wrote:
> On Mon, 2025-02-24 at 17:00 +0100, Ben Hutchings wrote:
> > Commit ebbe26fd54a9 "udf: Avoid excessive partition lengths"
> > introduced a use of check_add_overflow() with argument types u32,
> > size_t, and u32 *.
> > 
> > This was backported to the 5.x stable branches, where in 64-bit
> > configurations it results in a build error (with older compilers) or a
> > warning.  Before commit d219d2a9a92e "overflow: Allow mixed type
> > arguments", which went into Linux 6.1, mixed type arguments are not
> > supported.  That cannot be backported to 5.4 or 5.10 as it would raise
> > the minimum compiler version for these kernel versions.
> [....]
> 
> And for 5.15, I think it should be safe to backport commit
> d219d2a9a92e.  Otherwise this patch should be applied to fix the
> warning there.

I'll take either, whch do you want us to do?

thanks,

greg k-h

