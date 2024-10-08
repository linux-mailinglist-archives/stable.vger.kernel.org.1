Return-Path: <stable+bounces-83077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8E99551F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 18:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4CC1C24EF9
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DBE1E0E09;
	Tue,  8 Oct 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWFUjXgr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2BC1E0DEB;
	Tue,  8 Oct 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728406620; cv=none; b=OXj7GrlBVBvTcpRDlOpXkK1s+eFz4qOaF2kUDySXJVjm/myvdZOpsq3H2L9v7ydDfDUt1W2FWixVN1bN3RBQtHWGE/6UnH30XkI9xdnD7n6OTj+/6v6x69OOMWwaXO3CCcP8yW70lNHQzCJerqBAn5kaR/Qx0RwZUE8opftKZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728406620; c=relaxed/simple;
	bh=TjuE1lpyj0KPwrOqFc2qqWD/4QiChx8KTqlN2KEH57A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNtFh/rgGaF3zad79DdWxRFn/cR13ATulqFhLub7CCAKdo2enijUIuJCbxepccpnrPaYr2eZh2oEistzMCFGi31Se6GjKhuDT8PXyen9bWbR/FV1CwLzA/XQjuetYtbmfNvK6prfM1BifhQn8xBtWJn21aK8uK+6ARfg5n1hVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWFUjXgr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728406619; x=1759942619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TjuE1lpyj0KPwrOqFc2qqWD/4QiChx8KTqlN2KEH57A=;
  b=HWFUjXgrd4uNr5nbh/NlVaTkN81kDlS5o8h1U6TQq11yiRlC8V+tGpUX
   h56DdGe33QP/Nsornm3S5icS6/3N1Ibhb0d868o1ejRnrvPXx3KfrnjM4
   W6x23VmIrz7xct99nSpym6VbVeclgmMFXQ7BbiL6L4ddk2QZ+BANF/0RB
   WnAjIP/aBb1pPzsEI+MUoWKKVIM4DgbLMGM5U6ci92YvCIGCBoT63y9Mk
   6ssgDczMOaeSy1Yvz+kxE05diLMvd5hI7jIAMrQNELEoIJvM4WJt9+t2Y
   BmufCiZszbZRWGDbpS0VHRNcIDtYL68WCe3zpKmKstMxc12wt1rIuznYC
   Q==;
X-CSE-ConnectionGUID: mZBFnl3gQT6q8eUyrpVffQ==
X-CSE-MsgGUID: B4VfjgllSGKzX4sdcruoow==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38984020"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38984020"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 09:56:58 -0700
X-CSE-ConnectionGUID: SUmYSgOJSomqo9ygta8+GA==
X-CSE-MsgGUID: RruUnu+gRoSSPg4zh8D/Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="113379971"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 08 Oct 2024 09:56:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BDCF520F; Tue, 08 Oct 2024 19:56:54 +0300 (EEST)
Date: Tue, 8 Oct 2024 19:56:54 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian Heusel <christian@heusel.eu>,
	Fabian =?utf-8?Q?St=C3=A4ber?= <fabian@fstab.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Message-ID: <20241008165654.GU275077@black.fi.intel.com>
References: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>
 <2024092318-pregnancy-handwoven-3458@gregkh>
 <CAPX310hNn28m3gxmtus0=EAb3wXvDTgG2HXyR63CBW7HKxYkpg@mail.gmail.com>
 <CAPX310hCZqKJvEns9vjoQ27=JZzNNa+HK0o4knOMfBBK+JWNEg@mail.gmail.com>
 <1c354887-c2a5-4df5-978c-94a410341554@heusel.eu>
 <5192a3c3-29dd-4249-9a69-fc4845ad419c@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5192a3c3-29dd-4249-9a69-fc4845ad419c@amd.com>

On Mon, Oct 07, 2024 at 12:33:54PM -0500, Mario Limonciello wrote:
> On 10/7/2024 12:21, Christian Heusel wrote:
> > On 24/10/07 06:49PM, Fabian Stäber wrote:
> > > Hi,
> > 
> > Hey Fabian,
> > 
> > > sorry for the delay, I ran git bisect, here's the output. If you need
> > > any additional info please let me know.
> > > 
> > > 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 is the first bad commit
> > > commit 3c1d704d9266741fc5a9a0a287a5c6b72ddbea55 (HEAD)
> > > Author: Sanath S <Sanath.S@amd.com>
> > > Date:   Sat Jan 13 10:52:48 2024
> > > 
> > >      thunderbolt: Reset topology created by the boot firmware
> > > 
> > >      commit 59a54c5f3dbde00b8ad30aef27fe35b1fe07bf5c upstream.
> > 
> > So there is a commit c67f926ec870 ("thunderbolt: Reset only non-USB4
> > host routers in resume") that carries a fixes tag for the commit that
> > you have bisected to. The commits should both be in v6.6.29 and onwards,
> > so in the same release that's causing you problems. Maybe the fix is
> > incomplete or has a missing dependency 🤔
> 
> You mean mainline commit 8cf9926c537c ("thunderbolt: Reset only non-USB4
> host routers in resume").
> 
> > 
> > >      [...]
> > >      Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > >      Signed-off-by: Sanath S <Sanath.S@amd.com>
> > >      Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > >      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > I have added Mika, Mario and Sanath to the recipients, maybe they have
> > inputs on what would be useful debugging output.
> > 
> > In the meantime maybe also test if the issue is present with the latest
> > stable kernel ("linux" in the Arch packages) and with the latest release
> > candidate (you can find a precompiled version [here][0].
> 
> To double confirm, does thunderbolt.host_reset=0 on the kernel command line
> help your issue?  Based on the bisect I would expect it should help.  Yes;
> comments on both 6.6.y as well as 6.12-rc2 would be ideal.
> 
> Also assuming it helps can you please post your dmesg from 6.12-rc2 both
> with thunderbolt.host_reset=0 and without?  A github gist or a new kernel
> bugzilla are good places to post it.

Also to understand the flow, you are booting with the dock connected
right?

Can you see also what:

  $ boltctl

outputs (after you have booted up, and the problem is reproduced)? It
should list the dock and show it as "authorized" but I'm not familiar
with Arch Linux so it could be that they are not using bolt and that
explains why things do not appear working as nobody is going to
re-create that PCIe tunnel that was torn down during host router reset.

