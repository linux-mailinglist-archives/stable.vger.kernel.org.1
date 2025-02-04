Return-Path: <stable+bounces-112133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09EA26F70
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5FA18873B5
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978D920A5DF;
	Tue,  4 Feb 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDorDaIh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735420A5DA
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665817; cv=none; b=hAMxQrl2G0GysvGBscg5rH4stQvucp+KLtu67pvrSwAMOGsvdohG1GgYSwqQ3MDUfAL7gHIxA6nle6HjF6kHVWCvckizDMjK6gTXeLNABqrsPwpC6DheiEE19e2+BX6hiKhrC8L8UWl6EV+Kj6TnMryonF0m3zyPBK1jWrvDxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665817; c=relaxed/simple;
	bh=8z6kgTfmmf2owrXxKwswJXe3v3VPDNpy84KRvpFeUYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE7RiVdvR86LPb7f4ZU9KNfsl9Vd/2lAonr9X5Im0njR72/dfuBrPiDO0gqln/g1ps1oyRRLTQ1+MChxf6H8+RRzg48j0wfJL4KIkhJNuor9Q4ls7HtBv5BTWUtyMswOjbhAiv1jABR7zstNskrorjIt1Rq3hqqsVchT9kIX59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iDorDaIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A789C4CEDF;
	Tue,  4 Feb 2025 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738665816;
	bh=8z6kgTfmmf2owrXxKwswJXe3v3VPDNpy84KRvpFeUYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDorDaIhfH+Wf72FcmGGuWLR+YddbANlwaR+ZgWn+1kUMGOm1yrz+IgwPzoptYzRP
	 yjPZ0JUkOfToyYCEZ2lKpHb3U04yhw46vJuMmu1r+YvTmJkrUQLEmGGp41dpLUwG+r
	 u6a4Qq0r930P/Aq2zTOyGu12SSjdT9o7hRfNoMW0=
Date: Tue, 4 Feb 2025 11:43:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: KernelCI bot <bot@kernelci.org>
Cc: kernelci-results@groups.io, stable@vger.kernel.org, gus@collabora.com
Subject: Re: stable-rc/linux-5.10.y: new build regression: passing 'const
 struct net *' to parameter of type 'struc...
Message-ID: <2025020423-quickness-feeble-90c1@gregkh>
References: <CACo-S-2UhmehXF0AEA1rco9AckS7nDpOSRwZrAK4ba-b1Tj9-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACo-S-2UhmehXF0AEA1rco9AckS7nDpOSRwZrAK4ba-b1Tj9-A@mail.gmail.com>

On Mon, Feb 03, 2025 at 04:34:53PM -0800, KernelCI bot wrote:
> Hello,
> 
> New build issue found on stable-rc/linux-5.10.y:
> 
>  passing 'const struct net *' to parameter of type 'struct net *'
> discards qualifiers
> [-Werror,-Wincompatible-pointer-types-discards-qualifiers] in
> net/ipv4/udp.o (net/ipv4/udp.c) [logspec:kbuild,kbuild.compiler.error]
> 
> - Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:841ec27ef8554e3fda7cfd5babc4831387ac9e8e
> - Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=maestro:841ec27ef8554e3fda7cfd5babc4831387ac9e8e
> 
> 
> Log excerpt:
> net/ipv4/udp.c:447:29: error: passing 'const struct net *' to
> parameter of type 'struct net *' discards qualifiers
> [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>   447 |                 score = compute_score(sk, net,
>       |                                           ^~~
> net/ipv4/udp.c:359:55: note: passing argument to parameter 'net' here
>   359 | static int compute_score(struct sock *sk, struct net *net,
>       |                                                       ^
> 1 error generated.
> 

Now fixed, thanks.

greg k-h

