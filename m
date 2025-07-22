Return-Path: <stable+bounces-164279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C704DB0E235
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 18:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B8B1AA5CB0
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217327C84F;
	Tue, 22 Jul 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wrZnyrWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBD1FECAF;
	Tue, 22 Jul 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203404; cv=none; b=XJsApd3aSe4Ob9qcWDhqkbQbetbKhG3HzggfWL9GG+FtUSGZivcTuC69j6RP51YDxUX3u929U16nIW/J0KOL8btvmV3NR2TbAI/rm+Uwsl67b/t/TpoN+XaoWOiPC3gjsOiOydVPvi2EZ1Ac/LCj780u+/HO04s/vbaZI8fyN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203404; c=relaxed/simple;
	bh=zs1NQWnNp7XQsncuGCuB7JtNCj7MZLHC06EhaBgNnKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fej43UBVlTq6LculggaXGIkXBsencs04E8a12GqYU5Sj9d+enSDIt16vqJDpRkmF0WyOSbLCJgVgjbKgpc54qsmiQDL9e+rRs5XeeBwQGYrwa4eDINR5mWRfv/0u1yuJxNHDik3WHKyM2cFqzaakhm4fX+ChqPyfT4SPyUFEl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wrZnyrWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B666C4CEEB;
	Tue, 22 Jul 2025 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753203402;
	bh=zs1NQWnNp7XQsncuGCuB7JtNCj7MZLHC06EhaBgNnKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wrZnyrWGeNYZafl9tfGe47aGZqMcY2WA+m37wxAvofufLop+T/OqvWKRticmNRKGH
	 q2EHVXFDPXaBUGn/2oubuhxwEASg13tPrkOfXVGvwf2my9J2XyEPtVC46HyqWovr3A
	 +cRiR2EoIDCHZ6YzcGnCLMiQbauxTQvr/J9XAM1E=
Date: Tue, 22 Jul 2025 18:56:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Michael Zhivich <mzhivich@akamai.com>, stable@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Fix use of possibly uninit value in
 amd_check_tsa_microcode()
Message-ID: <2025072219-mulberry-shallow-da0d@gregkh>
References: <20250722122844.2199661-1-mzhivich@akamai.com>
 <20250722142254.GAaH-evk-BqchvvIaZ@renoirsky.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722142254.GAaH-evk-BqchvvIaZ@renoirsky.local>

On Tue, Jul 22, 2025 at 04:22:54PM +0200, Borislav Petkov wrote:
> On Tue, Jul 22, 2025 at 08:28:44AM -0400, Michael Zhivich wrote:
> > For kernels compiled with CONFIG_INIT_STACK_NONE=y, the value of __reserved
> > field in zen_patch_rev union on the stack may be garbage.  If so, it will
> > prevent correct microcode check when consulting p.ucode_rev, resulting in
> > incorrect mitigation selection.
> 
> "This is a stable-only fix." so that the AI is happy. :-P
> 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by:  Michael Zhivich <mzhivich@akamai.com>
> 
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> > Fixes: 7a0395f6607a5 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> 
> That commit in Fixes: is the 6.12 stable one.
> 
> The 6.6 one is:
> 
> Fixes: 90293047df18 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> 
> The 6.1 is:
> 
> Fixes: d12145e8454f ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> 
> The 5.15 one:
> 
> Fixes: f2b75f1368af ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> 
> and the 5.10 one is
> 
> Fixes: 78192f511f40 ("x86/bugs: Add a Transient Scheduler Attacks mitigation")
> 
> and since all stable kernels above have INIT_STACK_NONE, that same
> one-liner should be applied to all of them.
> 
> Greg, I'm thinking this one-liner should apply to all of the above with
> some fuzz. Can you simply add it to each stable version with a different
> Fixes: tag each?
> 
> Or do you prefer separate submissions?

Ideally, separate submissions, otherwise I have to do this all by hand
:(

thanks

greg k-h

