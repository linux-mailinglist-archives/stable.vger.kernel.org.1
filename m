Return-Path: <stable+bounces-87804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D4A9ABE70
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 08:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75E91F21768
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 06:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31791474A4;
	Wed, 23 Oct 2024 06:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHqx+J9F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F52146A79;
	Wed, 23 Oct 2024 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663809; cv=none; b=Ujh1huIJ2+bPS/YvWeppUofWsox0LrR7Yzqk2lkuL0nD2mN7gW2TStNv+B4FXa8cdeG/xnQPdWiNx76Nq1nTaoumuWpIjJ4wwsx5lBxaz3Ji6f7Vlb/rv91wWMPjeNOpj7L5ahKPTSU7p2InWTbdKFmiCvOEHP4gIjwry3M+Wr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663809; c=relaxed/simple;
	bh=d6pW4xi0LQC9Mf1CBRcA8IVQ88uK0iTTORzaAqW6ieE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9bPN3Aukqf3Tv41FY81QzkRnwm7rnM757EfwMaXYrkgywwr9yEcYswCXnFmh59U3pPuEdXpK8M1COLCKR47X1Z8z6ptNgbyuPPNiOVCfG4rPLjLxenIrWU+lNj3SDSHLMVHqp7kXq7wHp9D14xwGe0zumOQGFw2aJtWOO4RBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHqx+J9F; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729663807; x=1761199807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d6pW4xi0LQC9Mf1CBRcA8IVQ88uK0iTTORzaAqW6ieE=;
  b=hHqx+J9FlnJ2GMCyHCz3a2B+3t7t/M5Wm+Jw2avt7RBFHItzDvjhWPMy
   yrMJl3qU/EWD9MVYubLFT813zcsbRa6JaGNQKoy6CKQtGQGE48sYRo3zM
   HxF/Wkh+jw9D0hj3CndILAqnmwKjzEdxIs6tJhHJ4xKMd6VX+aELLB2Ob
   uUmQRbnj2FyPokfCjxCUSg3tvHh1D15NRi14gVYEWEO7RLWhMU1pKlBvW
   024q5aVcD7R9utLAexG9HwMTUuz6/ENf/Css1RV8iH+eEXt6OeP2/Ywwq
   xCvvJjwF6GWddTMhxFGhUrGvwQ4jS7/9b/fqR1Vci9cjOvn3lSZWTxJs+
   w==;
X-CSE-ConnectionGUID: fZCIIb0aQgGZj4gs7ckGbQ==
X-CSE-MsgGUID: GyU0RRblRI64GhlOFM2xDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54632075"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="54632075"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 23:10:06 -0700
X-CSE-ConnectionGUID: T+YlXsULSgWe4jrst28lJw==
X-CSE-MsgGUID: 4ZW84SJkQT2oRkMuOjcsPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80899370"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 22 Oct 2024 23:10:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 1E164301; Wed, 23 Oct 2024 09:10:01 +0300 (EEST)
Date: Wed, 23 Oct 2024 09:10:01 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rick <rick@581238.xyz>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Sanath.S@amd.com,
	christian@heusel.eu, fabian@fstab.de, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Message-ID: <20241023061001.GF275077@black.fi.intel.com>
References: <000f01db247b$d10e1520$732a3f60$@581238.xyz>
 <96560f8e-ab9f-4036-9b4d-6ff327de5382@amd.com>
 <22415e85-9397-42db-9030-43fc5f1c7b35@581238.xyz>
 <20241022161055.GE275077@black.fi.intel.com>
 <7f14476b-8084-4c43-81ec-e31ae3f7a3c6@581238.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7f14476b-8084-4c43-81ec-e31ae3f7a3c6@581238.xyz>

Hi,

On Tue, Oct 22, 2024 at 07:06:50PM +0200, Rick wrote:
> Hi Mika,
> 
> I have removed pcie_asm=force as kernel parameter but still not working on
> latest non LTS kernel.

Okay, I still suggest not having that unless you absolutely know that
you need it.

> In regards to the disconnect; sorry I think I might have turned of the
> docking station myself during that test. I have taken another dmesg without
> me disconnecting the docking station:
> https://gist.github.com/ricklahaye/9798b7de573d0f29b3ada6a5d99b69f1
> 
> The cable is the original Thunderbolt 4 cable that came with the docking
> station. I have used it on this laptop using Windows (dualboot) without any
> issues. Also on another Windows laptop also without issues. It was used in
> 40Gbit mode.

In the dmesg you shared above, there are still unplug and USB tunnel
creation fails so you only get USB 2.x connection with all the USB
devices on the dock.

How do you determine if it "works"? I guess keyboard and mouse (both
USB 2.x devices) and display (tunneled over USB4 link) all are working
right? However, if you plug in USB 3.x device to the dock it enumerates
as FullSpeed instead of SuperSpeed. There is definitely something wrong
here. I asked from our TB validation folks if they have any experience
with this dock but did not receive any reply yet.

What you mean by 40Gbit mode? The dock exposes two lanes both at 20G so
it should always be 40G since we bind the lanes, also in Windows.

Also In Windows, do you see if the all USB devices on the dock are
enumerated as FullSpeed or SuperSpeed? I suspect it's the former there
too but can you check? Keyboard and mouse should be FullSpeed but there
is some audio device that may be USB 3.x (SuperSpeed), or alternatively
if you have USB 3.x memory stick (or any other device) you can plug that
to the dock and see how it enumerates.

