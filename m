Return-Path: <stable+bounces-83216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA95996C44
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A822B21EEE
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37019644B;
	Wed,  9 Oct 2024 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f+nejPWm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8B1E4A4
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481006; cv=none; b=WOTWnyWaYE4lQTkJrtLs5pf5zzA6aqrwBLG61zn4bXL4S6IL0HPejIIIy9FsTQDp3a/9UE1V2Ud/Jyz/nMFJvH3LYWFQ8dt612+farxIBtRIC+8gla6RTZYWY6QPn3v5MwtUtwTbUFCMbgJ4i9HGpjAL5eivcUhjb1yNtq1f378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481006; c=relaxed/simple;
	bh=l92a5v9xeLmPhoy9pBlTEhi062GSpO4m/VysWxGLmKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFgBGdTtaYCa3ACTLuV8/TqtkgSibL0XGZMKNga8tydSwC5seWTs8ES8XrjsEAY4llfynC6gRNwcA/RdUbeD3jgwWqToX92Y1uJYwhgBwhimT2yg61aMxNE3y86PjR8Xxquh2QkFRa3ob50xDeiGiHXtWBXAGJS3M7f4iCOEBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f+nejPWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034C3C4CEC5;
	Wed,  9 Oct 2024 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728481005;
	bh=l92a5v9xeLmPhoy9pBlTEhi062GSpO4m/VysWxGLmKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+nejPWm86CGIV217JBV6f33cRYhhWlwdDe2a/eifMIEG/CwMmEja9Sw2+1XQkReg
	 g8g54skuwTKXyG9eVdXrE3CeJv6G/RbmHPTNoegBjY9p1HLkomEO1NWAtDoLzk2LAD
	 F3qeQwqI5KWNKn6bequVctzCCOX8rbflbl0K288w=
Date: Wed, 9 Oct 2024 15:36:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, jeyu@kernel.org,
	rostedt@goodmis.org, mingo@redhat.com, ast@kernel.org,
	jolsa@kernel.org, mhiramat@kernel.org, flaniel@linux.microsoft.com
Subject: Re: [PATCH 5.10.y 0/4] Backport fix commit for
 kprobe_non_uniq_symbol.tc test failure
Message-ID: <2024100909-neatness-kennel-c24d@gregkh>
References: <20241008222948.1084461-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008222948.1084461-1-sherry.yang@oracle.com>

On Tue, Oct 08, 2024 at 03:29:44PM -0700, Sherry Yang wrote:
> 5.10.y backported the commit 
> 09bcf9254838 ("selftests/ftrace: Add new test case which checks non unique symbol")
> which added a new test case to check non-unique symbol. However, 5.10.y
> didn't backport the kernel commit 
> b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols")to support the functionality from kernel side. Backport it in this patch series.
> 
> The first two patches are presiquisites. The 4th commit is a fix commit
> for the 3rd one.

Should we just revert the selftest test instead?  That seems simpler
instead of adding a new feature to this old and obsolete kernel tree,
right?

thanks,

greg k-h

