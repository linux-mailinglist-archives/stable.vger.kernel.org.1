Return-Path: <stable+bounces-80587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F2398E123
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B1D1F2475A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE01CF7C0;
	Wed,  2 Oct 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBoGFt6y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884B38DF9;
	Wed,  2 Oct 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887543; cv=none; b=qXK3Ce9lOcEMhliEMQbjt+cxskYbd7ASTKvFUpkYq1M9qNoIRaJm8QWIlPahiKaGuG1BWhmZpbIXkmz1GPH7rCuRReD61aX/d9usdxPtQPzKgZeg3LRPlGykPYf4tIV3o9Cht2x+M9uqnUz5NmZKiiAmfey8Y+p8lvkY4dxP3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887543; c=relaxed/simple;
	bh=hsr3MddGJ8Fm9saou9WsLupnbEMlesYj0Knl4aQcfcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxchZfIKztrJ+Om7l9s12N09inBN/KCQ+wamhuNely57o/YylPCroOva3ucQ2dpU8t1Vc2lqP66uJ8tulbs42cRd0sLlx2BugrI/xBvbhiTVDwo6dShQWklemeD1myVtyx4/7uF5fv9t+VtYviL/TSKi0SqBUyUJm8rF1ldXcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBoGFt6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED42C4CEC2;
	Wed,  2 Oct 2024 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727887542;
	bh=hsr3MddGJ8Fm9saou9WsLupnbEMlesYj0Knl4aQcfcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBoGFt6yR284N3TDtXw1mOIlxrnCb4+DUNXYV0dx5uY5tKnaBQyVDVthDdXtoZKHE
	 iqQ0J+5Vi7/thINGjLq9CsHDVEceYBM7ruJchbFXv45Rfc1mSiDmBzm2eS15GI9DxH
	 t31qn7fmkivk1sfAYiziuA5g53SfcS/mnFdznzLGgMj8Z/+Mx2IfPzJIVL7MJPiEY9
	 ILBi3oy/CZYpRr+KX/PW37Au/bywtrl091o/Dy2Tx7WAU+oEuSGwuwgtbLYExvdmnD
	 Maz8KVJE98h8ITkAtV9Xsgh1niGoJu+YnPfh85/NvL10zPCprdZUVThYQ5lqGQtwPI
	 WTGzCSPJQc5fA==
Date: Wed, 2 Oct 2024 09:45:40 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Justin Stitt <justinstitt@google.com>, llvm <llvm@lists.linux.dev>,
	kernel <kernel@collabora.com>, George Burgess <gbiv@chromium.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: Fix type of len in
 rfcomm_sock_{bind,getsockopt_old}()
Message-ID: <20241002164540.GA3369312@thelio-3990X>
References: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>
 <20241002152227.GA3292493@thelio-3990X>
 <1924e1095d0.c47411862290357.1483149348602527002@collabora.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1924e1095d0.c47411862290357.1483149348602527002@collabora.co.uk>

On Wed, Oct 02, 2024 at 06:29:22PM +0200, Andrej Shadura wrote:
> > On Wed, Oct 02, 2024 at 04:12:17PM +0200, Andrej Shadura wrote:
> >> Commit 9bf4e919ccad worked around an issue introduced after an innocuous
> >> optimisation change in LLVM main:
> >>
> >>> len is defined as an 'int' because it is assigned from
> >>> '__user int *optlen'. However, it is clamped against the result of
> >>> sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
> >>> platforms). This is done with min_t() because min() requires compatible
> >>> types, which results in both len and the result of sizeof() being casted
> >>> to 'unsigned int', meaning len changes signs and the result of sizeof()
> >>> is truncated. From there, len is passed to copy_to_user(), which has a
> >>> third parameter type of 'unsigned long', so it is widened and changes
> >>> signs again. This excessive casting in combination with the KCSAN
> >>> instrumentation causes LLVM to fail to eliminate the __bad_copy_from()
> >>> call, failing the build.
> >>
> >> The same issue occurs in rfcomm in functions rfcomm_sock_bind and
> >> rfcomm_sock_getsockopt_old.
> 
> > Was this found by inspection or is there an actual instance of the same
> > warning? For what it's worth, I haven't seen a warning from this file in
> > any of my build tests.
> 
> We’ve seen build errors in rfcomm in the Chromium OS 4.14 kernel.

If there is any reason to send a v2 (since I don't think my nit below
really warrants one at the moment), you may consider adding this
information and the warning text that you see to the commit message for
future travelers. I definitely have to go back to look at prior commits
for understanding on current issues and I appreciate having easy things
to look for when searching.

Is the warning reproducible on mainline with the same configuration?
Just curious, I still think it is worth sending this through mainline
even if there is no warning currently, since we cannot say that an
potential future LLVM change could not make this show up there if not
properly fixed. I am just wondering what my test coverage is missing :)

> >> Change the type of len to size_t in both rfcomm_sock_bind and
> >> rfcomm_sock_getsockopt_old and replace min_t() with min().
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 9bf4e919ccad ("Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()")
> 
> > I am not sure that I totally agree with this Fixes tag since I did not
> > have a warning to fix but I guess it makes sense to help with
> > backporting.
> 
> It’s a shame there isn’t a Complements: or Improves: tag :)

Heh, who is to say we can't be the first? :)

There is some prior art with References: but eh, like I said above, I do
not think it truly matters, since it should make it easier for the
stable folks to apply it. That comment was more directed at how
overloaded Fixes: has become to me that maybe it is worth considering
expanding the type of tags for referring to previous commits but I am
sure there would be push back in some form... No worries regardless!

Cheers,
Nathan

