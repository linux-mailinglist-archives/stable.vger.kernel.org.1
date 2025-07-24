Return-Path: <stable+bounces-164589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C7B107D7
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937C11C253CB
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225E265CA2;
	Thu, 24 Jul 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1KNec3km"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B219343B;
	Thu, 24 Jul 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353282; cv=none; b=EEToNU/15oW452M3fnFExoxu/YVppsRSJixbwamYRW1jtYaAz8HhIDUZGFsyo2wRQXm5AiVBXgMRjIOhXoyIroHsSCb2ERzm0YR4WwOp1Xx5sC6ivyqG7E2ORGU3ouzVUGuQjFCNZR1v4z/JjWw/aVHjhAwVfYPAnJ7ScwUeWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353282; c=relaxed/simple;
	bh=NDilOfv7K6odjmyecSbZuzdlKXMxM+WWIVS998QQo3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1wibBr6pc03E0Yw2suhEG24OMzSufgZgA3JehPfmtVqu3ql94A8CWfxUsdE7DPcJ044kCuxAOZbPOWtmz9LrqpkD46rG+pLRXbCtxxk0QP0M6dgspgDeZV8aly3BzVZ2B+fuM2TVDMcOQrxtLL5L/TLRlwlICmDFSOWkJshd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1KNec3km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555F7C4CEED;
	Thu, 24 Jul 2025 10:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753353282;
	bh=NDilOfv7K6odjmyecSbZuzdlKXMxM+WWIVS998QQo3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1KNec3kmD3NefOaBgg+wriwqMsUWXfJ90MwZjClDvBeLrf39THwDx43argCqG7l/t
	 5O0F5IifB2D/7g44XpBGoJafHitZRfYLH6tMLavWmlCdS/Xu5pycrVEaDk8gNhnVCm
	 9VSD2OjH+duR1e/VAYOUQP6+bRisD4wRYp2fszcE=
Date: Thu, 24 Jul 2025 12:34:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kyung Min Park <kyung.min.park@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>, xin3.li@intel.com,
	Farrah Chen <farrah.chen@intel.com>, stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: Clear feature bits disabled at compile-time
Message-ID: <2025072459-emergency-slighting-9d60@gregkh>
References: <20250724094554.2153919-1-maciej.wieczor-retman@intel.com>
 <7rugd7emqxsfq4jhfz47weezipfoskf43xslgzgwea2rvun7z6@3tdprstsluw4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7rugd7emqxsfq4jhfz47weezipfoskf43xslgzgwea2rvun7z6@3tdprstsluw4>

On Thu, Jul 24, 2025 at 12:13:25PM +0200, Maciej Wieczor-Retman wrote:
> Hello Greg,
> 
> I'd like to ask you for guidence on how to proceed with backporting this change
> to the 5.10 stable kernel and newer ones.

Don't worry about it UNTIL your patch lands in Linus's tree.  Then, if
it doesn't apply to a specific stable branch, just send us a working
backport.  Not too complex :)

thanks,

greg k-h

