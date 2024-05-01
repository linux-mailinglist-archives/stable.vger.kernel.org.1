Return-Path: <stable+bounces-42889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B328B8EF5
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 19:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1146AB2181C
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A084218637;
	Wed,  1 May 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EGhthy+H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483901CA85
	for <stable@vger.kernel.org>; Wed,  1 May 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584119; cv=none; b=e3fx1rz6HFeo/752dBFa4N3fwIzUbrhiBWjxZGCVB76achgIxDr27zpVaZlauVtawg/fju46jkzkhH9zSocAGaXQRgaqQi4cJRSyBj19pvy6lfJcCTEveg0X9e+CwMny7S0Xu/RzQxEXbmMeb6nd3uN/STF8pO7ThiJTQhc3v6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584119; c=relaxed/simple;
	bh=6tDm/qkcTZZvAmzDzxt6srGQeiQ4aTSqIg61oSRUpis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0Z+pDXP61O49tRsgPTLD9M8sC7sz5f70257vTkQgsoNqt1b1vbeZYnkXVay40Vrhxc/nl0VKBjCtmx87bQULUXFBE4CsXkUP5YLPQEXWjah9o+kO8K+b7To4UuUHwVUR3Xbp5i0bpJBwbyeM8N3F2U63ksR1noaiH4xMYPohQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EGhthy+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78347C072AA;
	Wed,  1 May 2024 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714584118;
	bh=6tDm/qkcTZZvAmzDzxt6srGQeiQ4aTSqIg61oSRUpis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGhthy+HNY6TnSopkNqgLEajAalV9ZaBPnaJfPypJpsrtOMVPGPf0SIEYYxg02mfc
	 kQMRkcJMybUVLUbtnwcY47L+TrzgAgLXVFPXEe0ITgmwbgsSKuiMyhsxiGnENFEUjG
	 5NU0g5KzxPt5vO8l2yvUlWy5jm9qZIL+7LXdWMjE=
Date: Wed, 1 May 2024 19:21:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: stable@vger.kernel.org, jolsa@kernel.org,
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: Request to backport "bpf: Add missing BPF_LINK_TYPE invocations"
 to 6.6 kernel
Message-ID: <2024050126-stank-unbaked-3489@gregkh>
References: <CALrw=nG=+tWmUGgBe5Tyip+PJiMPR_7FWG=e1Ws6OP8mDhqPZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALrw=nG=+tWmUGgBe5Tyip+PJiMPR_7FWG=e1Ws6OP8mDhqPZw@mail.gmail.com>

On Wed, May 01, 2024 at 05:13:17PM +0100, Ignat Korchagin wrote:
> Hello,
> 
> We recently saw a KASAN report on a 6.6.27 kernel similar to [1] and
> noticed that commit 117211aa739a ("bpf: Add missing BPF_LINK_TYPE
> invocations") was never backported to the 6.6 stable tree. Is there a
> reason? Can it be backported?
> 
> [1]: https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/
> 

Please submit a backported and tested version of this, and you should
 cc: the developers/maintainers involved as well.

thanks,

greg k-h

