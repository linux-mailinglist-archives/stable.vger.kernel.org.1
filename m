Return-Path: <stable+bounces-195483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA94DC783A2
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02B7E4E97C9
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6933A029;
	Fri, 21 Nov 2025 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uP66n868"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35483346B4
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718424; cv=none; b=Ay8mmcDA3uRHn1Aw24+w0BhW5YSs4MddtUroHFwiHMfJbnCYSmuABGt+JVb43LKg0vw2Bj8tuO+xqxLbxsrRhi9UzN81za+jilDRv6nmDlgkimQlXr0OmsCpTLoK5aI9cF4MljPQeJagXHkDzErmelhfFY1FZUcOqT3SVQVU61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718424; c=relaxed/simple;
	bh=v5OQ0Ro4ieMtTpnoZv+iT876VOwAjXszAP2NE/waJNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Be61GDWL1EmTDqcdUNFYhrdFDcHkUEHr4qQ9PNpsCTXu2SvxJFvcOPwk4dv5SqYuaCXgmY9Rf66vN3lG+o/kgCieX02gALbWpsqe4XFaAto66vTp4poMe4COPi7aFRUGzFOQ7Uv6ifQzFn+KAkrdLLBIPCtrlVM7EvY5ndi7PCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uP66n868; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8026C4CEF1;
	Fri, 21 Nov 2025 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763718423;
	bh=v5OQ0Ro4ieMtTpnoZv+iT876VOwAjXszAP2NE/waJNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uP66n868Jmph2qksUND9TyMYJgtSrgmrdf/Xmf0BXqCx54nsXqtYNr4235ZocdV26
	 V7y/Y5+3tCjjG9H8eIDIQ2HrQ4BVRv2nqstXIeL8OaJE9SaSDO3xMCYTsORM/8hUwb
	 nsMJ8ujgRa7XuLcFgxT6XZE0WxOk4avqv5CHXeH4=
Date: Fri, 21 Nov 2025 10:47:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: akpm@linux-foundation.org, broonie@kernel.org, catalin.marinas@arm.com,
	leitao@debian.org, luca.ceresoli@bootlin.com, mark.rutland@arm.com,
	matttbe@kernel.org, mbenes@suse.cz, puranjay@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] scripts/decode_stacktrace.sh: fix build
 ID and PC source" failed to apply to 6.17-stable tree
Message-ID: <2025112154-shelter-showcase-4333@gregkh>
References: <2025112031-catalyze-sleep-ba6e@gregkh>
 <aR9P13YfvZ6AMSfC@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR9P13YfvZ6AMSfC@google.com>

On Thu, Nov 20, 2025 at 05:28:55PM +0000, Carlos Llamas wrote:
> On Thu, Nov 20, 2025 at 04:56:31PM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.17-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 7d9f7d390f6af3a29614e81e802e2b9c238eb7b2
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112031-catalyze-sleep-ba6e@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..
> > 
> > Possible dependencies:
> 
> The dependencies I missed to specify are the following 2 fixes:
>   d322f6a24ee5 ("scripts/decode_stacktrace.sh: symbol: avoid trailing whitespaces")
>   4a2fc4897b5e ("scripts/decode_stacktrace.sh: symbol: preserve alignment")
> 
> They apply cleanly on top of linux-6.17.y:
>   git cherry-pick -xs d322f6a24ee5 4a2fc4897b5e 7d9f7d390f6a
> 
> I've also verified the expected fixes work for all 3 patches.
> 
> Greg, do you need me to send these?

Nope, that worked, thanks!

greg k-h

