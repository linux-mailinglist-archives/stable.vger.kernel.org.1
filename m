Return-Path: <stable+bounces-59149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5992EEF0
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 20:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1473B213F5
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0B16DC36;
	Thu, 11 Jul 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uzj/oJ8U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113A16D4FA;
	Thu, 11 Jul 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722864; cv=none; b=CihzrC2YbmJoyEXhOS43caJBiVzRv1jq9VPDNY5CTGFyUudwIGdQc6UCdEfd8JuX4o9uQqAJBfAqcQq2Qww0eMlzyX0BSQwa5VoGiF3/pa2kyIpLmxoTrXMhidcujS850bvMoGw11wg0rfFTVTvarenW+aHJf82q8YDHfOVDdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722864; c=relaxed/simple;
	bh=1eZeHrsbmS3RqHuDkeo/0jOZIW6UaSiDPRHLfzsGrbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgZZOH4Y1abSzRBvFd2KJydIBtFGieuF5gYUzE/NQONhEuQ1g1DEGMyTPREuXaERQhQPlolpvB64ZY8HzUWXwBF1D0C5rLAaiH9xfooNEkKesmpdsTyDDFxNBCuG/qudJDBX9wiVBsNB2cA1FfRWqSpoUd+mL/n491jjshHK9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uzj/oJ8U; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720722863; x=1752258863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1eZeHrsbmS3RqHuDkeo/0jOZIW6UaSiDPRHLfzsGrbg=;
  b=Uzj/oJ8U8Po2y9JAGf5RAuExdhdupWWKqrk/PyFnNsluftuLRKB5T7Kw
   Rs88K8+hjGaPcxq0QqIvYpJGoOiEmVOMFlawdQw/g6KsdARDAc9o2A07E
   ND5PIto+Pumct4iG42RE0MQ7J9eFVClO1b9CUtGe3XRvZNnTPZfyQYxAe
   2vlXGoyjDiH3vShKP9itUDS+sqYDHJ1u+WS1VAfmmX+z7xcWsVv6Cv9e0
   qov7iDQIkk30X/SdXkhNZKPoyKwI08DZ9zeS4Wr39AbzQ76jtcwOTnmXN
   14F3JE8YBvMQhc0nDVJ6X84YwZP0f36UqsznvTyqkBqdIPkks2duWOAHR
   A==;
X-CSE-ConnectionGUID: dJ1d2AQKREyybi6brPYmhA==
X-CSE-MsgGUID: HIPU37BhTBOiZr7Qva3zZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29283111"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="29283111"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:34:22 -0700
X-CSE-ConnectionGUID: jtgdMEVgT0mI0EGcSUIstg==
X-CSE-MsgGUID: qgF8Boi5TrmyUDn222o7Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="53046401"
Received: from tmsagapo-mobl2.amr.corp.intel.com (HELO desk) ([10.209.8.238])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:34:21 -0700
Date: Thu, 11 Jul 2024 11:34:10 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] x86/entry_32: Use stack segment selector for VERW
 operand
Message-ID: <20240711183410.zakyzfpfy6p7komx@desk>
References: <20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com>
 <8551ef61-71fb-18f3-a8a8-6c7c3ed731e6@gmail.com>
 <20240710231609.rbxd7m5mjk53rthl@desk>
 <e321400f-0b76-4fdf-8773-cbad8a47baba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e321400f-0b76-4fdf-8773-cbad8a47baba@kernel.org>

On Thu, Jul 11, 2024 at 07:49:25AM +0200, Jiri Slaby wrote:
> > > Why not simply:
> > > 
> > > .macro CLEAR_CPU_BUFFERS_SAFE
> > > 	ALTERNATIVE "", __stringify(verw %ss:_ASM_RIP(mds_verw_sel)),
> > > X86_FEATURE_CLEAR_CPU_BUF
> > > .endm
> > 
> > We can do it this way as well. But, there are stable kernels that don't
> > support relocations in ALTERNATIVEs. The way it is done in current patch
> > can be backported without worrying about which kernels support relocations.
> 
> This sounds weird. There are code bases without ALTERNATIVE support at all.
> Will you expand ALTERNATIVE into some cmp & jmp here due to that? No.

Agree, will change it to the way Uros and Peter suggested.

> Instead, you can send this "backport" to stable for older kernels later,
> once a proper patch is merged.

Ok, will take care of the differences in the backports.

