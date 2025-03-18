Return-Path: <stable+bounces-124853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61BA67D99
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 21:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8535B166D43
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289581DC9BA;
	Tue, 18 Mar 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kDMF5GxX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F6143748
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328043; cv=none; b=VuzcdfLJkLDH+zIgi1uikfzsc087FQEJPOoflS4vLDo3nhynjY701C5TUGByvuFo/Tzjflm9MpV2j0RnsLOUHcKfxAacyUpJLXhZzqNIZPCStzMyIbzVlMRc3bAxnLrvEQe3gzIrVbLQI4lVQTeEf5bzUXsj3ECojcQC1A50MNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328043; c=relaxed/simple;
	bh=DydfOKdNMJ93oTj+WxJ5pFW7/BU9wkAnN4RILM6ycAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqEBKKEyJD2OHaKqb82U/w9j57CMO7fnW40BBNZLleZYSBJGJZpP6Kp7HVszM65u1Rol3SZBHqbbnwvjoH69+Kw0wMTkRwARDW0N+TQRkaX7gImlqPMJiXFyHtszC70OPfWLHoW8K9/aLLg8wqfnLQKFpcehhJuJrtybgRu1XAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kDMF5GxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271EAC4CEDD;
	Tue, 18 Mar 2025 20:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742328043;
	bh=DydfOKdNMJ93oTj+WxJ5pFW7/BU9wkAnN4RILM6ycAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDMF5GxX/klntgptHc4mPV1HYts7woCxNOIorOsLzfNv0FdibXt+iR1q6KEb1VCvd
	 oRP4jks9CpvXga861+iDSIarAXXSS2Kvcr7Rcb1ZCdJKqYp+sDZLevh56hBAgmLVVh
	 eEtC6xDvyEIzt0J9pxJgl44Oz8FLqgZGzs8i1Bw8=
Date: Tue, 18 Mar 2025 12:59:24 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: levymitchell0@gmail.com, aliceryhl@google.com, benno.lossin@proton.me,
	mingo@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] rust: lockdep: Remove support for
 dynamically allocated" failed to apply to 6.6-stable tree
Message-ID: <2025031804-macarena-appease-83d4@gregkh>
References: <2025031632-divorcee-duly-868e@gregkh>
 <67d9b4a0.e90a0220.3d651b.b756@mx.google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67d9b4a0.e90a0220.3d651b.b756@mx.google.com>

On Tue, Mar 18, 2025 at 10:59:58AM -0700, Boqun Feng wrote:
> Hi Greg,
> 
> On Sun, Mar 16, 2025 at 08:15:32AM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 966944f3711665db13e214fef6d02982c49bb972
> 
> It's weird because `cherry-pick` works for me:
> 
> $ git cherry-pick -x 966944f3711665db13e214fef6d02982c49bb972
> Auto-merging rust/kernel/sync.rs
> [stable-6.6 f5771e91eac3] rust: lockdep: Remove support for dynamically allocated LockClassKeys
>  Author: Mitchell Levy <levymitchell0@gmail.com>
>  Date: Fri Mar 7 15:27:00 2025 -0800
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> my base is 594a1dd5138a ("Linux 6.6.83").
> 
> I checked the original commit in Linus' tree, it removes the `impl
> Default` which doesn't exist in 6.6, however it seems my `cherry-pick`
> can realise and fix this! Anyway I will send the fixed patch soon.

Yeah, git is smart, patch is not:

patching file rust/kernel/sync.rs
Hunk #1 FAILED at 30.
1 out of 1 hunk FAILED -- rejects in file rust/kernel/sync.rs

:(

thanks for the fixup.

greg k-h

