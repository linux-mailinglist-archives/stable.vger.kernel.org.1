Return-Path: <stable+bounces-105316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296DB9F7FF9
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098C71889EA8
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BA9227B93;
	Thu, 19 Dec 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GNgiQpfg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64917836B;
	Thu, 19 Dec 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626184; cv=none; b=rblZWFxCf92L4q3mbD+DjP3CmHSo/3CKKskSj2elAhi6ugt26lucc8lRb5qZ2czLS9Eklz09eu9yARH6ym+mircz2Pt9eQhJ20XUYYU3+F84S5DWpzUA7XN0IKdRIZsuHH4MToHZtSYxZjpvsdRf7HUP5wsF/bvvI2w3JgSQ4tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626184; c=relaxed/simple;
	bh=YyJI0Gr39q4RbuZ+ijY5FOWNoVjZqid0t7aAcQyTFiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5VJ1eN0TIDmZkZW6WmtsJ80hop2QLFIfAHIIba3T99mMqf3WIwiX547P8QlM5HcNsB0PjTexTrH+Mptt4+i1NnvlL7jn16gS+gF5xWOC8O+MadT4QodunImYOCvI4rMtIqVDZXmD65fVvSy2Lee3RmlupWVXrbV8P9Lqp4TEWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GNgiQpfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0042BC4CED4;
	Thu, 19 Dec 2024 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734626183;
	bh=YyJI0Gr39q4RbuZ+ijY5FOWNoVjZqid0t7aAcQyTFiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNgiQpfgw67wvQl3aLVtZFmUzOey6e8qhHhWiPzuxj8SpKHl9xDSyoPwjBnF4PEK2
	 u2nbYzMVbJ2eZlwgIEvJx23ieouxBf9hpW0bxOjPXLJVTDIE05q9Z/ktSuqPMKUP2j
	 evaG8CvWOcfVnZZwN4GXtjSkLRD6+FWlb5ScqAXk=
Date: Thu, 19 Dec 2024 17:36:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jan Beulich <jbeulich@suse.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Subject: Re: [Linux-6.12.y] XEN: CVE-2024-53241 / XSA-466 and Clang-kCFI
Message-ID: <2024121902-eggnog-playmaker-6552@gregkh>
References: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>

On Thu, Dec 19, 2024 at 05:14:28PM +0100, Sedat Dilek wrote:
> Hi,
> 
> Linux v6.12.6 will include XEN CVE fixes from mainline.
> 
> Here, I use Debian/unstable AMD64 and the SLIM LLVM toolchain 19.1.x
> from kernel.org.
> 
> What does it mean in ISSUE DESCRIPTION...
> 
> Furthermore, the hypercall page has no provision for Control-flow
> Integrity schemes (e.g. kCFI/CET-IBT/FineIBT), and will simply
> malfunction in such configurations.

WHat is the error that you get?

> ...when someone uses Clang-kCFI?
> 
> My full kernel-config is attached.

You don't show the error, please do so.

thanks,

greg k-h

