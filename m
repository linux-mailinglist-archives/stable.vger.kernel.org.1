Return-Path: <stable+bounces-144545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40FDAB8D38
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 19:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E533AC5CA
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A160421B9D9;
	Thu, 15 May 2025 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kU90kA2V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC7198823;
	Thu, 15 May 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328802; cv=none; b=eXp/VaTYmUMEvIzFFf2Z1jqXjzyOnzRrgjFMHAgJNjBzqK5lOnBXg1gqj4/ui8IoagoFVryJYmWcpQeQtMbMmY36TflNqqkNbOc6f6wWggE67SWK6pwvu1U52oaU62/A53uJgNKMy/k7Qzw4y+2Syw9fWckIKxc+swuMMjZd1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328802; c=relaxed/simple;
	bh=SoofiAZqwtq5h1rl+TwdDhSZzNKP1lh1VxKTL480uGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8RU+ZglSETLFZdsNIMjr9RHB9WPPTWkSgyRBMxdhFe76hrD4hWyObYtCID8XGgsI6WPi4RObA0uIn+ci0jLgzKWE8HAHb/78CxB95yHHiDXWtFfjTeB7IqWFP5KSGWfvUSeB6vdSpaLAnyrfrzJOW+0883cQJXiJIWE+p8k0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kU90kA2V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747328801; x=1778864801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SoofiAZqwtq5h1rl+TwdDhSZzNKP1lh1VxKTL480uGk=;
  b=kU90kA2Vwox+qm2ImOE45Ntazdzq4EDqFc0HwwDo9iPB4CQ0t16iXgfO
   SETOuIZGTLUAZC23NhP2kcnpSu2u7RostRbv8cJ7fM4J5UasW/xu36Xq/
   +w/U+fqq97LV37dG0INT5TDbx9rDQT88ByAro1S3Cuqx2nNNOQ6/Rbj+N
   SuroecFz0WopjWuqr2LMqkTeGjC0m+a0XjJKx473k+/EK/tqvG2xbFddP
   kbsO9BzPz6UsECpsKjH339fffcD1BkpKspPiNJzuCEzwJ7IjkNUwmqYWE
   oTwb+U4Quj9cLiHtbkoND26llVaOGCTfQpBdf32C28TqKgvthK5FFzfbs
   w==;
X-CSE-ConnectionGUID: QIoC1Y0VQVi7o6kbE1uZ2g==
X-CSE-MsgGUID: qMK5LE+TQtGBwugLuubgxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="52954028"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="52954028"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:06:41 -0700
X-CSE-ConnectionGUID: qiMaK/NlRcKBj1amMuO9Ng==
X-CSE-MsgGUID: m8iEDxZuT8qlAVJkkh+wUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138162186"
Received: from gkhatri-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:06:40 -0700
Date: Thu, 15 May 2025 10:06:33 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Suraj Jitindar Singh <surajjs@amazon.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/bugs: Don't warn when overwriting
 retbleed_return_thunk with srso_return_thunk
Message-ID: <20250515170633.sn27zil2wie54yhn@desk>
References: <20250514220835.370700-1-surajjs@amazon.com>
 <20250514222507.GKaCUYQ9TVadHl7zMv@fat_crate.local>
 <20250514233022.t72lijzi4ipgmmpj@desk>
 <20250515093652.GBaCW1tARiE2jkVs_d@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515093652.GBaCW1tARiE2jkVs_d@fat_crate.local>

On Thu, May 15, 2025 at 11:36:52AM +0200, Borislav Petkov wrote:
> On Wed, May 14, 2025 at 04:30:22PM -0700, Pawan Gupta wrote:
> > This was discussed during the mitigation, and pr_warn() was chosen because
> > it was not obvious that srso mitigation also mitigates retbleed. (On a
> > retrospect, there should have been a comment about it).
> 
> Why is that important?

There are 4 mitigations that currently use return thunks,
retbleed=stuff(Call Depth Tracking), retbleed=unret, SRSO and ITS. They all
set the return thunks they want without checking if return thunks are
already set by another mitigation. I understand the SRSO mitigates
retbleed(BTC), but the same is not true for retbleed(RSB underflow
mitigated by CDT) and ITS. If ITS overrides CDT return thunk, it will make
CDT ineffective.

> We have multiple cases where a mitigation strategy addresses multiple attacks.

Agree, but here we are talking about the opposite case where a mitigation
unintentionally renders a previously set mitigation ineffective.

> > The conclusion was to make the srso and retbleed relationship clear and
> > then take care of the pr_warn().
> 
> So let's ask ourselves: who is really going to see what single-line warning?

Don't know. I guess some do, hence this patch.

> What are we *actually* trying to prevent here?

As I said above, a mitigation unintentionally make another mitigation
ineffective.

> How about a big fat splat at least if we're really trying to prevent something
> nasty which causes a panic on warn...?

Yes, maybe a WARN_ON() conditional to sanity checks for retbleed/SRSO.

