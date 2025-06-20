Return-Path: <stable+bounces-155174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A8AE1FDD
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 18:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238F64A6C97
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E502E6D15;
	Fri, 20 Jun 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x63HB5Cm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1C2DFA35
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435915; cv=none; b=FnoQkc3AV+PNFYHsLVcyZ2qNhllmwJsBge98ZwhfFVJR4yKEEysuPu4ImOwDa5P6u04YIePss9HUzNw59lfZjgYTOLqtdBdZ4I0gz0svqUvWMYh2gLaVUCDiJm/nbh9A4Tlhm5/T2DAlyuDu5bn+snfIMySWiLTzWYT7ntopuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435915; c=relaxed/simple;
	bh=U/CChP/w+enDXP7wkBOrhSUV9PHeYT8NFxvii9HVvvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0OwdRrSS+WcM/7xwpoUvQuGHulnH5dbPhmfTAGzUX/gEzTe+w0SWJqPGLv+0N0SkARXmBcFwrit+0B6szQWvu3sm46LDV5JqBI6VodXXySMBycTF0Wl2zzDfqQ1WnPTvE/arCrFJTTCz67LlskX6XvsJJhuwiekew2WIOl1PFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x63HB5Cm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA40FC4CEE3;
	Fri, 20 Jun 2025 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750435915;
	bh=U/CChP/w+enDXP7wkBOrhSUV9PHeYT8NFxvii9HVvvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x63HB5CmxuppZopjievPYKsIBuSkBtp6fd9c1+jlE3bzpFeKT719E/r6tQXcwu/1r
	 2/WPZk0QqdGC4FQ1A5E6PEZWPjnRD1GeNCWuwkoTE/h4pctoWJ687UFVvBjQ00wn+I
	 7naku0YYst4OZyko3CtKRGmWsSAcFndX1hQq1M4c=
Date: Fri, 20 Jun 2025 18:11:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable <stable@vger.kernel.org>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Larry Wei <larryw3i@yeah.net>,
	1103397@bugs.debian.org
Subject: Re: [stable 6.12+] x86/pkeys: Simplify PKRU update in signal frame
Message-ID: <2025062025-requisite-calcium-ebfa@gregkh>
References: <103664a92055a889a08cfc7bbe30084c6cb96eda.camel@decadent.org.uk>
 <2025062022-upchuck-headless-0475@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025062022-upchuck-headless-0475@gregkh>

On Fri, Jun 20, 2025 at 05:56:29PM +0200, Greg KH wrote:
> On Sun, Jun 15, 2025 at 09:25:57PM +0200, Ben Hutchings wrote:
> > Hi stable maintainers,
> > 
> > Please apply commit d1e420772cd1 ("x86/pkeys: Simplify PKRU update in
> > signal frame") to the stable branches for 6.12 and later.
> > 
> > This fixes a regression introduced in 6.13 by commit ae6012d72fa6
> > ("x86/pkeys: Ensure updated PKRU value is XRSTOR'd"), which was also
> > backported in 6.12.5.
> 
> Now queued up, thanks.

Nope, this broke the build on 6.12.y and 6.15.y, so now dropped.  How
did you test this?

greg k-h

