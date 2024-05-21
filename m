Return-Path: <stable+bounces-45489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61C68CAA6D
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0340D1C2171E
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2B56759;
	Tue, 21 May 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZpTGooHQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47956757;
	Tue, 21 May 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281972; cv=none; b=RqmEKAz/7ZgL4XukAJpTFHQKhg0TZsXpz3BFOAbJDldb0mk5tO87S9upbHh2+NfMYWsNLy+GFI9Q0v3obtAu8UHdtbsNsaXrLdpxJPAcjNyfsbQDEK4YpUSJGsUYcJnc0sZ0hnIwgeYBpfXDyyi6OAJ+7ixHzi6RLetYARBq3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281972; c=relaxed/simple;
	bh=eLQ0BJe2tf8WdoA4nuR/w6z7pYRZ+D8yZ7mBE5sZuTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtUGPaUR5rO7qF8oHgr5yPnc25LzbDnwALFy83RkKQ+OutC3CZPzhUj9erLxaRQ8I2Sgh+aMn3DlT0CbV5Xz1Tl+E/qIDzCwBOiKwrkvC39xXIgU4e4tQxs81DuqC4WC35BNqeWXoMSZfVLVdTVgieK33eAMPIGHKCCR9HKHjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZpTGooHQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716281972; x=1747817972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eLQ0BJe2tf8WdoA4nuR/w6z7pYRZ+D8yZ7mBE5sZuTE=;
  b=ZpTGooHQ8j1InIoqUrX/OYmMK41tQRePHgqWKBzlz5Tl71bhNKKAFAqs
   X55BuUjLT48aWOtGNZzL2JlaB5OQgVYlCpZ8NCLpVJXlGEPw4Dnu+LzNY
   CAXDPNAMF0TUp+Xyt487bh/2eiqVH8aqrHrFCtCW+PF7RfySTEmOJUEue
   G8eYDACzLwwpSU8Rh3e9Zj7OPT3ckjt4amPV49vi2Vx6S8ohS8s36qswL
   KqZWy4KFKAuT5/llc2XGx4S/K8aUSNvTy+Jvbs+vKU46AX/GUIy2ZRvj7
   1PBjv3qoSjMVYRyc4EzL6bdhqA4ExjUohkWVlqy3yjBBugvxfP116e9eb
   g==;
X-CSE-ConnectionGUID: xG398G0YQgWhXpEoW7LQmw==
X-CSE-MsgGUID: 9tpoe4gPSVihGVGJsBUHmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12397954"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="12397954"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 01:59:32 -0700
X-CSE-ConnectionGUID: FftiZykYSUCdUe0RkF1edQ==
X-CSE-MsgGUID: HMoiWVMPT/GmbDeTOoP0Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="32706683"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 May 2024 01:59:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id E4AD7179; Tue, 21 May 2024 11:59:26 +0300 (EEST)
Date: Tue, 21 May 2024 11:59:26 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Gia <giacomo.gio@gmail.com>
Cc: Benjamin =?utf-8?Q?B=C3=B6hmke?= <benjamin@boehmke.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christian Heusel <christian@heusel.eu>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
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
Message-ID: <20240521085926.GO1421138@black.fi.intel.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <61-664b6880-3-6826fc80@79948770>
 <20240520162100.GI1421138@black.fi.intel.com>
 <5d-664b8000-d-70f82e80@161590144>
 <CAHe5sWazL96zPa-v9S515ciE46JLZ1ROL7gmGikfn-vhUoDaZg@mail.gmail.com>
 <20240521051151.GK1421138@black.fi.intel.com>
 <CAHe5sWb7kHurBvu6JC6OgXZm9mSg5a2W2XK9L8gCygYaFZz7JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHe5sWb7kHurBvu6JC6OgXZm9mSg5a2W2XK9L8gCygYaFZz7JQ@mail.gmail.com>

On Tue, May 21, 2024 at 10:15:28AM +0200, Gia wrote:
> Here you go:
> 
> 0x0080 0x003c01c0 0b00000000 00111100 00000001 11000000 .... LANE_ADP_CS_0
>   [00:07]       0xc0 Next Capability Pointer
>   [08:15]        0x1 Capability ID
>   [16:19]        0xc Supported Link Speeds
>   [20:21]        0x3 Supported Link Widths (SLW)
>   [22:23]        0x0 Gen 4 Asymmetric Support (G4AS)
>   [26:26]        0x0 CL0s Support
>   [27:27]        0x0 CL1 Support
>   [28:28]        0x0 CL2 Support
> 0x0081 0x0828003c 0b00001000 00101000 00000000 00111100 .... LANE_ADP_CS_1
>   [00:03]        0xc Target Link Speed → Router shall attempt Gen 3 speed
>   [04:05]        0x3 Target Link Width → Establish a Symmetric Link
>   [06:07]        0x0 Target Asymmetric Link → Establish Symmetric Link
>   [10:10]        0x0 CL0s Enable
>   [11:11]        0x0 CL1 Enable
>   [12:12]        0x0 CL2 Enable
>   [14:14]        0x0 Lane Disable (LD)
>   [15:15]        0x0 Lane Bonding (LB)
>   [16:19]        0x8 Current Link Speed → Gen 2
>   [20:25]        0x2 Negotiated Link Width → Symmetric Link (x2)
>   [26:29]        0x2 Adapter State → CL0
>   [30:30]        0x0 PM Secondary (PMS)

Thanks this looks fine (although the link is still Gen 2). Can you run
the same from the dock upstream port too?

  # tbdump -r 2 -a 1 -vv -N2 LANE_ADP_CS_0

