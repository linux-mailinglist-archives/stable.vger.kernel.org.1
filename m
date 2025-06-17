Return-Path: <stable+bounces-154568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D85AADDC11
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A3D194048F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF428C00E;
	Tue, 17 Jun 2025 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQzT2zDI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0696215F42
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187522; cv=none; b=rqa+57lPgCiIqH2XWEv7R5YM3sLEHadIlOezAGFH1J5sD9btSQ7Hu9orEB2WD3WiTBBBQMsXoxKSBU9lbVS6OXeKy7xElr9TpF2oO+IAD2DfWndnxQovoWGy4d98a9FPeZp21AFzWl9Cnu0OCo4HlL4CKnPIL1KPxyhvxZMNonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187522; c=relaxed/simple;
	bh=ipF6kzFDMY9lYmWsPip8CUck4/Efv/60o2fUVvfcl+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuBP7Ky9uKVDinqsAuOghopC6CQkdFDIfwq/1N7IM1ONh86V+sKYMMXTMndP5fqEKsdZJfyliClR9NGpMqRT+eH9UDa4wrjHHle8g5+KqTfGcoekNYWmybZgc15Wv8aYaDSDTWt52lNpgO1LlQzl4ePneX0fqqkIghiHPRy2BC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQzT2zDI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750187521; x=1781723521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ipF6kzFDMY9lYmWsPip8CUck4/Efv/60o2fUVvfcl+U=;
  b=hQzT2zDIEkqTD6zaIJEZYODY+KQp/IgXC+JpE1KiWM16hDf1cl0S/12g
   HCP5vrvzNckPPrQPPdNt1Uo+HBTp623aimGCp7THmOfEE0pDxV/aiv73O
   nK2/5YMTKWcNB2bWYttfsHPSOIktsYs63HcJvH7JnpHNJQSVRjryjQmxu
   77rMyou9ArVKTrU63ckt55nDj0ug0UayWV+TeqUcs29Uz6+HUvui+kK6e
   cZ8blc1IQ6LV12eoVWClW53ixLNQrvBvbpREQqRzDHk/dpSS19TmyJyl0
   UCE54tbt1m5GB3hiib3rRJYGaLKQc3t8jjvTkNxokViCSHOZWpGXTCwpD
   w==;
X-CSE-ConnectionGUID: G7ot6xH5RP+ULFfTo0osow==
X-CSE-MsgGUID: iq7p4klpTfWJ/neJ9tCG5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="51607978"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="51607978"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 12:12:00 -0700
X-CSE-ConnectionGUID: QUJFadwfTdG01db6Gb4ppg==
X-CSE-MsgGUID: qe9Ft3x1RvKPmiN/ucHi2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="148782668"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 12:11:59 -0700
Date: Tue, 17 Jun 2025 12:11:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>, 
	Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, holger@applied-asynchrony.com
Subject: Re: [RFC PATCH 5.10 16/16] x86/its: FineIBT-paranoid vs ITS
Message-ID: <jadhobrooc3h7vb5lwi635jf6r4lb6o44sudv5k65eqngwa2qj@lo2w276w2lcz>
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
 <20250610-its-5-10-v1-16-64f0ae98c98d@linux.intel.com>
 <2025061751-wrongdoer-rebuttal-b789@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025061751-wrongdoer-rebuttal-b789@gregkh>

On Tue, Jun 17, 2025 at 03:44:26PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 10, 2025 at 12:46:10PM -0700, Pawan Gupta wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > commit e52c1dc7455d32c8a55f9949d300e5e87d011fa6 upstream.
> > 
> > FineIBT-paranoid was using the retpoline bytes for the paranoid check,
> > disabling retpolines, because all parts that have IBT also have eIBRS
> > and thus don't need no stinking retpolines.
> > 
> > Except... ITS needs the retpolines for indirect calls must not be in
> > the first half of a cacheline :-/
> > 
> > So what was the paranoid call sequence:
> > 
> >   <fineibt_paranoid_start>:
> >    0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
> >    6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
> >    a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
> >    e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
> >   10:   41 ff d3                call   *%r11
> >   13:   90                      nop
> > 
> > Now becomes:
> > 
> >   <fineibt_paranoid_start>:
> >    0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
> >    6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
> >    a:   4d 8d 5b f0             lea    -0x10(%r11), %r11
> >    e:   2e e8 XX XX XX XX	cs call __x86_indirect_paranoid_thunk_r11
> > 
> >   Where the paranoid_thunk looks like:
> > 
> >    1d:  <ea>                    (bad)
> >    __x86_indirect_paranoid_thunk_r11:
> >    1e:  75 fd                   jne 1d
> >    __x86_indirect_its_thunk_r11:
> >    20:  41 ff eb                jmp *%r11
> >    23:  cc                      int3
> > 
> > [ dhansen: remove initialization to false ]
> > 
> > [ pawan: move the its_static_thunk() definition to alternative.c. This is
> > 	 done to avoid a build failure due to circular dependency between
> > 	 kernel.h(asm-generic/bug.h) and asm/alternative.h which is neeed
> > 	 for WARN_ONCE(). ]
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> > [ Just a portion of the original commit, in order to fix a build issue
> >   in stable kernels due to backports ]
> > Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> > Link: https://lore.kernel.org/r/20250514113952.GB16434@noisy.programming.kicks-ass.net
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> Note, I did not sign off on the backports here, are you sure you want to
> do it this way?  :)

Sorry, your sign-off got added because I cherry-picked the commits from
5.15. Sending v2 with the sign-off removed.

> Also, I need someone to actually test this series before we can take
> them...

I have tested that ITS thunks are aligned properly.

Salvatore, since Debian is the main target for this backport, it will be
great if you could give this backport a try.

