Return-Path: <stable+bounces-121536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DF6A578B7
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 06:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804CE189344D
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 05:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8CF15E5B8;
	Sat,  8 Mar 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNAR3WuW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9CB660
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741413555; cv=none; b=hV4AIMmbaCtgfOytTYY6Z4bh1GaArLLbavODumKSnY5t2P/k5TTV6cqzhxbJsLKrGHeB9xi6U5FNdugRK0V/+rfi2A3VJ0FV4OC3je2HCQrjXJiQwveaGTL6NZ3LbL4y2XAvfNiiJjs9rQ37Dt7rRo21z3enn12DNcZzMKltCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741413555; c=relaxed/simple;
	bh=nmsZKyE+hDGxJXEBt/AOYFHsa9rveiOY7jNPqwPf09U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu4JFSrjxoTJeHf6ZTejEoerPi7HUZSdvu0mDaWLcwQKrpqG56BwKmxfPx1cwTbDh4eZRg3k6Mz9oEtSiRe4apJQygiYAA2r0ka0wB9//dwNLyr/Umf30qDq4oLshAddO97cmJTuQaxXN6x33+lkdzqgJGvOvnh7m5mhIXu7BWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNAR3WuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB07C4CEE0;
	Sat,  8 Mar 2025 05:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741413555;
	bh=nmsZKyE+hDGxJXEBt/AOYFHsa9rveiOY7jNPqwPf09U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNAR3WuWPOx6ZL8k8TpqkQXCYJS/8iA8tVydMzWm/Lg0YIjyXG564d0YWARUfDRFm
	 QMNCe1Deod6MA5bRZ0cvVEGRiwkdM+ue6UAH9SiLV9Yg40M1ghv6CtU42LJNp1JYzu
	 ov8hvc/QfeuwDGMVykpHgvPJTdXM0DMgMbmjDesY=
Date: Sat, 8 Mar 2025 06:59:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Andreas Hindborg <nmi@metaspace.dk>
Subject: Re: Apply 0c5928deada1 for 6.12.y and 6.13.y
Message-ID: <2025030806-tumble-finalize-435c@gregkh>
References: <CANiq72=SXs+N3Fn1OD-Sj=h_HfEtaEBFgcNETNzVRuPbtwFtxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=SXs+N3Fn1OD-Sj=h_HfEtaEBFgcNETNzVRuPbtwFtxA@mail.gmail.com>

On Fri, Mar 07, 2025 at 11:54:45PM +0100, Miguel Ojeda wrote:
> Hi Greg, Sasha,
> 
> Please consider applying the following commits for 6.12.y and 6.13.y:
> 
>     0c5928deada1 ("rust: block: fix formatting in GenDisk doc")
> 
> It is trivial, and should apply cleanly.
> 
> This avoids a Clippy warning in the upcoming Rust 1.86.0 release (to
> be released in a few weeks).

Now queued up, thanks.

greg k-h

