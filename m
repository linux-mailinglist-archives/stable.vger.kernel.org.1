Return-Path: <stable+bounces-116689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27EDA39739
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAC73A3E29
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E2022FF42;
	Tue, 18 Feb 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F3cdap2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0C230D08
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871013; cv=none; b=n90hcEZiKctaW7cGHtftTBWN6JLSpc8nd0fSk38URnYLdY0HzTq+LHCO89WQRjlmyt0IlX6vUNSzDD305WaXkSveh5bfRN22e8y0Up9BbOpERBKMDa6gSdCW5R4MWbmv+BVwNIwJ30kLajc7FvjQzZBR7BvncTHz8LksAqVQVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871013; c=relaxed/simple;
	bh=WzXhyKLcMhBmM9oESr782DdYx0U1IJNf75pf+3PL13g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA5yBB8YmelZc7Xv0BJ6H4wVjcpDKClXk7nvXZsro7UXXAtdF7h6voDLeZ8kNDugUis3ksuoh9Ecq5BHP3F5ZMzp2+suy1QJ49EjA43RylHUP1+gHbVhKVtNKR6H/W3/0dP2a3AxMqTYGFzgsLHc4PU9wzOGDSHPq+eTjRS0tDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F3cdap2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B6BC4CEE2;
	Tue, 18 Feb 2025 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739871013;
	bh=WzXhyKLcMhBmM9oESr782DdYx0U1IJNf75pf+3PL13g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3cdap2/l+4P3VZdy8sgAMQYYili0fVNnf4ibfOEGs6xSL354NsEUuhymvFwu/gk4
	 O312RxCx5VV0gItWHkk32cTF2D00RK27m5l4UdJj9T73Gm7YSnw1brQDGsHhJFgaoK
	 LQ4Hpfm/MrH4EtJtm2u/QC8Ox/y4LrArtEbrN/Jg=
Date: Tue, 18 Feb 2025 10:30:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Max Krummenacher <max.oss.09@gmail.com>
Cc: stable@vger.kernel.org, max.krummenacher@toradex.com
Subject: Re: regression on 6.1.129-rc with perf
Message-ID: <2025021843-confess-omit-42c6@gregkh>
References: <Z7NUbhkfDZeKeIu9@toolbox>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NUbhkfDZeKeIu9@toolbox>

On Mon, Feb 17, 2025 at 04:23:26PM +0100, Max Krummenacher wrote:
> Our CI built linux-stable-rc.git queue/6.1 at commit eef4a8a45ba1
> ("btrfs: output the reason for open_ctree() failure").
> (built for arm and arm64, albeit I don't think it matters.)
> 
> Building perf produced 2 build errors which I wanted to report
> even before the RC1 is out.
> 
> | ...tools/perf/util/namespaces.c:247:27: error: invalid type argument of '->' (have 'int')
> |   247 |         RC_CHK_ACCESS(nsi)->in_pidns = true;  
> |       |                           ^~
> 
> introduced by commit 93520bacf784 ("perf namespaces: Introduce
> nsinfo__set_in_pidns()"). The RC_CK_ACCSS macro was introduced in 6.4.
> Removing the macro made this go away ( nsi->in_pidns = true; ).
> 
> 
> Second perf build error:
> | ld: ...tools/perf/util/machine.c:1176: undefined reference to `kallsyms__get_symbol_start'
> 
> Introduced by commits:
> 710c2e913aa9 perf machine: Don't ignore _etext when not a text symbol
> 69a87a32f5cd perf machine: Include data symbols in the kernel map
> 
> These two use the function kallsyms__get_symbol_start added with:
> f9dd531c5b82 perf symbols: Add kallsyms__get_symbol_start()
> So f9dd531c5b82 would additionally be needed.
> 
> 
> The kernel itself built fine, due to the perf error we don't have runtime
> testresults.

Thanks for letting me know, I'll go drop those patches from the queues
now.  Dealing with perf issues on older kernels like this really isn't
needed.

thanks,

greg k-h

