Return-Path: <stable+bounces-45471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831738CA780
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 06:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F08D2822A6
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 04:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A6936AF8;
	Tue, 21 May 2024 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7v23qj4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD85B13FF9;
	Tue, 21 May 2024 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716267586; cv=none; b=ZlA5t8gK+N31SwP2kflzAsf2jsL84ehDqK+LZyHZV/5HSrgGeck/6vT+sSx2xMjaexZV+IgpFc9wYYudUzR8Mha6eb5aRVWSfvDliihjPcJ0YksJ6GwJII2eS6tbdC+x+eut76ffKr0eGvgN+D7PcKXRqbCY3lHpibz+Y9W8nJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716267586; c=relaxed/simple;
	bh=VPid/XdZiKogI7hU4m4Xc7/+ltEiS5oOPGuIP8CkX7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM3ILqil40PHtD8CzqnktBO1quVkv/WUoen1i9Xq22P8aCu+FVPKKh7VCBasu9ocAmvtzqCGyrErAgr6ltXmRl2/epJoi9HjexvzOKO58He37vMFHjA39d6MzhRLNgg/4bNXRhZaEt6cbPVB7qnAH9rU4nIxegnqX1et79AJuv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7v23qj4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716267585; x=1747803585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VPid/XdZiKogI7hU4m4Xc7/+ltEiS5oOPGuIP8CkX7c=;
  b=L7v23qj4KdEvavJ36aYUbEjvP9m+I8l+JcEQY7miH8ocgte0v8ooqbpY
   bBTF2G7W3LHT2hMOJhUUwPlnv7pD/JEZDiJNvhmjNDu78m/fxKreGokIm
   GcU/JGpNID7oIDNaeBd/ygdjtH1wK5UN3pHZ90NLZlW/X8wGsyzym/FKy
   B0TuyCjOk7Ezx+Hwm2U5Mis++855I408T6b0aLX0qlsCs7pxHPAVKeOQ/
   UljGUYpSOXWu8FSTJAjEbRQBNeAjgozltuecmpQHKV78Y3vQOORIBP3uZ
   bTBN7NYNXvMNzyN/tQHBW2oJxCFCrGKLbDe9/AuXMmjkmCy/Wm5d0WVFb
   g==;
X-CSE-ConnectionGUID: Kdb31h5mTlSUt1kryPwELQ==
X-CSE-MsgGUID: NIZFwnYVS5+oELOxPYaW+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="15380568"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="15380568"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 21:59:44 -0700
X-CSE-ConnectionGUID: DqMLqRLNQta2q0LxllhmeA==
X-CSE-MsgGUID: qakD+Ow7S063xRnPYT0EYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32678289"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2024 21:59:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 2110F179; Tue, 21 May 2024 07:59:40 +0300 (EEST)
Date: Tue, 21 May 2024 07:59:40 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Benjamin =?utf-8?Q?B=C3=B6hmke?= <benjamin@boehmke.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Christian Heusel <christian@heusel.eu>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Gia <giacomo.gio@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kernel@micha.zone" <kernel@micha.zone>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
Message-ID: <20240521045940.GJ1421138@black.fi.intel.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <61-664b6880-3-6826fc80@79948770>
 <20240520162100.GI1421138@black.fi.intel.com>
 <5d-664b8000-d-70f82e80@161590144>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d-664b8000-d-70f82e80@161590144>

Hi,

On Mon, May 20, 2024 at 06:53:18PM +0200, Benjamin Böhmke wrote:
> > All the USB devices seem to work fine (assuming I read this right).
> 
> To keep the log small I unplugged all USB devices from the dock.
> But even if connected I don't have issues with them.

Okay that's good to know.

Yeah, in the dmesg it might seem odd that the xHCI is "gone" for a while
as we do USB4 topology reset but it comes back after the tunnels get
re-created.

> > There is the DP tunneling limitation but other than that how the dock
> > does not work? At least reading this log everything else seems to be
> > fine except the second monitor?
> 
> Exactly only the second monitor is/was not working.

Got it.

> > Now it is interesting why the link is only 20G and not 40G. I do have
> > this same device and it gets the link up as 40G just fine:
> > 
> > [   17.867868] thunderbolt 0000:00:0d.2: 1: current link speed 20.0 Gb/s
> > [   17.867869] thunderbolt 0000:00:0d.2: 1: current link width symmetric, single lane
> > [   17.868437] thunderbolt 0000:00:0d.2: 0:1: total credits changed 120 -> 60
> > [   17.868625] thunderbolt 0000:00:0d.2: 0:2: total credits changed 0 -> 60
> > [   17.872472] thunderbolt 0000:00:0d.2: 1: TMU: current mode: bi-directional, HiFi
> > [   17.872608] thunderbolt 0-1: new device found, vendor=0x3d device=0x11
> > [   17.879102] thunderbolt 0-1: CalDigit, Inc. TS3 Plus
> > 
> 
> My dock is a little different model (see https://www.caldigit.com/usb-c-pro-dock/)
> I don't have a CalDigit TS3 Plus.

Indeed, my mistake.

> > Do you use a Thunderbolt cable or some regular type-C one? There is the
> > lightning symbol on the connector when it is Thunderbolt one.
> 
> The dock was connected with a Thunderbolt cable, that I used for a
> couple of years without any issues. Based on the hint I replaced the
> cable and the issue is now gone for me.
> 
> I still don't understand why this happened as it was working great for
> years and is still working with kernels 6.8.7 or older. But
> nevertheless sorry if I wasted time of anyone because of broken
> hardware.

I think the BIOS CM creates the "first" tunnel using reduced
capabilities already so this makes the "second" tunnel fit there in the
18G link. Now that we do the reset the "first" tunnel is re-created with
max capabilities and that makes the "second" not to fit there anymore.

But now you get the full 40G link :)

