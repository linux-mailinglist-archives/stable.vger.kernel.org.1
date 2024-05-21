Return-Path: <stable+bounces-45500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE18CAD5E
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 13:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF641C21C76
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 11:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EEF74C1B;
	Tue, 21 May 2024 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFDQ/6M4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0A73174;
	Tue, 21 May 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290961; cv=none; b=XbQOZhnbES+IEYY5KgZDQ57rDGVS3ikFALzXbScp3Gk/qq2YaMPbd6FE+rBHNEe0oEO4RyDEBBxO0LJJI9bbDPqqdpc9WOhZn12XbcwJo5ik+/U8Rsc6Hg3pKeGZ5fTfn0zUR5ycxiscYjiyvHnqhICZZ0yjkFiB2j4xK1CuSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290961; c=relaxed/simple;
	bh=9UyG8NR2nB4nFh3V+pbEi6yVtB+rOBjbai89rumi9dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJhHh4BtdGgLI+kHTyNxeo9vkMi6jDJN9x1q0V918tCrS0x7IYcmsrwrrx0WNAERsDBbkpP6Ca2KoyAC82wftxvsUsqXN2piG9Lp19FEN0eGK2//bhV13gqV7km6nzeblQPLghBd42Ohc2+kCK9j/2c/T4Pv38v0+v4chT9HKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFDQ/6M4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716290960; x=1747826960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9UyG8NR2nB4nFh3V+pbEi6yVtB+rOBjbai89rumi9dU=;
  b=DFDQ/6M4ei/FLuIYgrdaGiu4KFWHbYsTSKi9K7BRAW7JqzB8IuXT4DDS
   H0AFJZJhBhJ9Wez4qfqIxwEPW1dZCIZvAI+drH1fTIFpHVnH5rzQKvjur
   TEif52BvIcYJH8bYNTvIqORDWqJg9ymqV5QsefJ9vYo5rfK3qHVYl8wPy
   7Tomw6TdL7oJfrz6HqRM9AVGXiSTxK3rzJu4VLFuWkoawHhvCfwk5IiY+
   IzdHpzbWqFI6CUVuq8p8Q5zbAFAsro/8rnj38MjAUpOhXy+EykRgX5A1E
   /OOkdDG94k3Kejjzl9Gmx12vAIlOfQogfEwo9iZqXtL9NDJN622cUnRbZ
   g==;
X-CSE-ConnectionGUID: CWvuyZOtT5KNugreJYGzWA==
X-CSE-MsgGUID: +9wMWUlGSpe/SLQoqKoUyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23145733"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="23145733"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 04:29:19 -0700
X-CSE-ConnectionGUID: p/A6XjsLRyiWx1rx3gursw==
X-CSE-MsgGUID: RQLoNqTiQfabFqgjd56z0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="37275244"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 21 May 2024 04:29:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4AF2917F; Tue, 21 May 2024 14:29:15 +0300 (EEST)
Date: Tue, 21 May 2024 14:29:15 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Gia <giacomo.gio@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Christian Heusel <christian@heusel.eu>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kernel@micha.zone" <kernel@micha.zone>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Benjamin =?utf-8?Q?B=C3=B6hmke?= <benjamin@boehmke.net>,
	"S, Sanath" <Sanath.S@amd.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
Message-ID: <20240521112915.GQ1421138@black.fi.intel.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <CAHe5sWY_YJsyiuwf2TsfRTS9AoGoYh4+UxkkZZ0G9z2pXfbnzg@mail.gmail.com>
 <20240521051525.GL1421138@black.fi.intel.com>
 <CAHe5sWY3P7AopLqwaeXSO7n-SFwEZom+MfWpLKGmbuA7L=VdmA@mail.gmail.com>
 <20240521085501.GN1421138@black.fi.intel.com>
 <CAHe5sWaABJi0Xo4ygFK4Oa3LdNUiQJSLidGPdAE=gwmy=b+ycw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHe5sWaABJi0Xo4ygFK4Oa3LdNUiQJSLidGPdAE=gwmy=b+ycw@mail.gmail.com>

On Tue, May 21, 2024 at 11:24:56AM +0200, Gia wrote:
> Thank you for your suggestion Mika, as a general rule I totally agree
> with you and I do not mess with kernel default parameters, but I
> remember "pcie_aspm=off" was necessary at the time I set up the
> system. Probably a kernel or a BIOS update makes it unnecessary today.

Okay, thanks.

> I see it removes these messages from my logs but I trust you when you
> say they have not an impact on functionality:
> 
> May 21 11:01:36 um773arch kernel: pcieport 0000:05:04.0: Unable to
> change power state from D3hot to D0, device inaccessible
> May 21 11:01:36 um773arch kernel: igb 0000:09:00.0 eth0: PCIe link lost
> May 21 11:01:36 um773arch kernel: xhci_hcd 0000:08:00.0: xHCI host
> controller not responding, assume dead
> May 21 11:01:36 um773arch kernel: xhci_hcd 0000:07:00.0: xHCI host
> controller not responding, assume dead

Correct these are side-effect of the USB4 topology reset we do. As
explained earlier the tunnels get re-established and the devices will
come back soon after this.

