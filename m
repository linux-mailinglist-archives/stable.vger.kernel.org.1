Return-Path: <stable+bounces-25263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE4869A53
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 16:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38976281D39
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633E145350;
	Tue, 27 Feb 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oI5qvU/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29B14534C
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047641; cv=none; b=hmwHmCbMubknfd7c/bmtWX5s+jRjGXj6YXzjhErk7pHqyC+B7RYq510rCtnRt7KDE3ci8uJXfF+ToZNAZiRpW/Ux7adW8Mlt2gVyjVKUl7n5kpsT1kmqOQxyDiESsEkDcjes6HicG2PFJlMZXrgFDyzVoVrJzt7FbaoGonyxK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047641; c=relaxed/simple;
	bh=VJCXViu5/0CNocM84jxAZezeeGnFYHZuhR40OnGBgTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCNTZka9RUX9+wvUQNTyY/tUx+pg5OBsL8IkKJtOzgnCXYSXUt2d2/FCY3jj99zEGNvBkECOpqdLz/iodEQ3wsbcuQckv4+1Pw5A32fdXJgiRqGnthj2B5EQd8zYf8sO0ctRzQlKdUiujYyk4JSVqSZNeIMAJBr1uSUF20AUQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oI5qvU/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31BFC433F1;
	Tue, 27 Feb 2024 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709047641;
	bh=VJCXViu5/0CNocM84jxAZezeeGnFYHZuhR40OnGBgTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oI5qvU/Bdv+5c4ktOH+dWCFFpHxsai1yFBdGzER9YIktdd3GU+BIgSf2CaMkOBdpn
	 x/3iJQ++51uPMkJophMXJNpvQ9pNmqL1jF5MHkxX9nTHvP6Wsu+rjK5XCQs1tQZnWb
	 ywSNeGTsguL7rfe6KwKhnN4kNg6cKGgRCwwDpjxA=
Date: Tue, 27 Feb 2024 16:27:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: pabeni@redhat.com, davem@davemloft.net, martineau@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mptcp: fix more tx path fields
 initialization" failed to apply to 6.1-stable tree
Message-ID: <2024022704-reflector-conducive-6b5c@gregkh>
References: <2024021911-fragment-yearly-5b45@gregkh>
 <a9e6e10d-9d91-4ec8-b803-4df079ca68e3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e6e10d-9d91-4ec8-b803-4df079ca68e3@kernel.org>

On Tue, Feb 27, 2024 at 03:47:01PM +0100, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 19/02/2024 17:05, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> 
> (...)
> 
> > From 3f83d8a77eeeb47011b990fd766a421ee64f1d73 Mon Sep 17 00:00:00 2001
> > From: Paolo Abeni <pabeni@redhat.com>
> > Date: Thu, 8 Feb 2024 19:03:51 +0100
> > Subject: [PATCH] mptcp: fix more tx path fields initialization
> > 
> > The 'msk->write_seq' and 'msk->snd_nxt' are always updated under
> > the msk socket lock, except at MPC handshake completiont time.
> > 
> > Builds-up on the previous commit to move such init under the relevant
> > lock.
> > 
> > There are no known problems caused by the potential race, the
> > primary goal is consistency.
> 
> FYI, because of the various conflicts, and because "there are no known
> problems caused by the potential race", with Paolo, we think it is best
> not to backport this patch to v6.1 and older.

Thanks for the review of all of these and letting us know,

greg k-h

