Return-Path: <stable+bounces-25889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750086FFA0
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D3C1C22732
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3D9381B4;
	Mon,  4 Mar 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/Hs7qr0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD226376FD
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549924; cv=none; b=rhHSaCId0Q5u1lByXt9+dNAmJGluh3CYgBr3rnF2jVGCSB0p9MNBJgVmk0KjT/ByWvUMI+oYIuOujcawE188HsaX6ZTu73fd6sPXGhdUYtEvVHfr0v5YasJURgqibyhd1WXs6gjIGjNZK86aOvjz/j67d/dm4NAT1VxQ8wE/WUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549924; c=relaxed/simple;
	bh=aJ8Nrqr6WZf4ma76x9JqXiXKw9DPFgf44RecgW681iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUaWd4NXnyyoB12xtaPR8QPuRJ/Gjs0GefJWhdTpxRY26LkD01bVgKhIZiJVermS1g/dgBe6WhQ50wYvn7yKmbNoM+PEftS2uEd2CdUqYO/izQMAHc1bEF+zl4Bsq/QAeU5I6qDq6loGdGvuhDJgZfaqSFMGLxcyVleyXY0BTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/Hs7qr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB685C433F1;
	Mon,  4 Mar 2024 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709549924;
	bh=aJ8Nrqr6WZf4ma76x9JqXiXKw9DPFgf44RecgW681iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/Hs7qr0THn0qXdnQIPuNAeFoOA8RPqU3JVuPOHgljyW2fFB1Q0hagjycEfqo++nn
	 +woLSX6AcKTUukrxHkAz5qogL+YL0/uiTFVWWrvqknYInj4lVCM5ELSn9nFrWUcPM9
	 8Km7lCRJxaVW/r1LQ3wh5H8lYHdTzsmIm+Vd/Z9I=
Date: Mon, 4 Mar 2024 11:58:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: tanggeliang@kylinos.cn, kuba@kernel.org, martineau@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: rm subflow with
 v4/v4mapped addr" failed to apply to 6.1-stable tree
Message-ID: <2024030453-spotter-undermine-b600@gregkh>
References: <2024030422-dinner-rotten-5ef3@gregkh>
 <0991a6b7-2d74-4f26-9959-68d745086902@kernel.org>
 <2024030430-pessimism-unveiling-715f@gregkh>
 <79f149f6-e5aa-455e-832e-8ae3356cb690@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f149f6-e5aa-455e-832e-8ae3356cb690@kernel.org>

On Mon, Mar 04, 2024 at 11:40:49AM +0100, Matthieu Baerts wrote:
> On 04/03/2024 11:32, Greg KH wrote:
> > On Mon, Mar 04, 2024 at 11:07:01AM +0100, Matthieu Baerts wrote:
> >> On 04/03/2024 09:30, gregkh@linuxfoundation.org wrote:
> 
> (...)
> 
> >>> ------------------ original commit in Linus's tree ------------------
> >>>
> >>> From 7092dbee23282b6fcf1313fc64e2b92649ee16e8 Mon Sep 17 00:00:00 2001
> >>> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>> Date: Fri, 23 Feb 2024 17:14:12 +0100
> >>> Subject: [PATCH] selftests: mptcp: rm subflow with v4/v4mapped addr
> >>>
> >>> Now both a v4 address and a v4-mapped address are supported when
> >>> destroying a userspace pm subflow, this patch adds a second subflow
> >>> to "userspace pm add & remove address" test, and two subflows could
> >>> be removed two different ways, one with the v4mapped and one with v4.
> >> I don't think it is worth having this patch backported to v6.1: there
> >> are a lot of conflicts because this patch depends on many others. Also,
> >> many CIs validating stable trees will use the selftests from the last
> >> stable version, I suppose. So this new test will be validated on older
> >> versions.
> >>
> >> For v6.6 and v6.7, I can help to fix conflicts. I will just wait for the
> >> "queue/6.6" and "queue/6.7" branches to be updated with the latest
> >> patches :)
> > 
> > Should all now be up to date,
> 
> Maybe we are not talking about the same thing: are the "queue/X.Y"
> branches from the "linux-stable-rc" repo [1] not updated automatically
> when patches are added to the "stable-queue" repo [2]?

Ah, that, yeah, it somehow automagically works, I have no idea how it
does it or what controls it or who uses it, sorry :)

> It is just to know which base I use to resolve conflicts :)

If it works for you, great!

thanks

greg k-h

