Return-Path: <stable+bounces-196986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523BC891C9
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FA954E5098
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04E2F9DAB;
	Wed, 26 Nov 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqPJxe4x"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA2287506;
	Wed, 26 Nov 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150624; cv=none; b=l9T07KRaRCHLJV47xwfqNZ4bi8NOo8MhWMliTwANpzC5LUozj4bxYFCIG4RGnAilu/pkS7Ejec4yCVCKi+9uQmC3bgdHWJa/jZB00CO5CvnHxxGcRcpUNlZESqkhZ05nSSyvqx+ky3aXp9DUoSDcrlLl4HxDJk0KvYbsfxwY5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150624; c=relaxed/simple;
	bh=mp3f3CKtLoajMyv+kwe/o5yTvIU3sW1y+uUZdm/u8RE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lxnZ/fQYYtdFI4xMYIkdiNmJwQ6A4DujMlaiumH1OIrqd2JDivfycTwTr0d9cTHGyBQMIjVgBTvBEhgtEKe+iajfFAFpvjHe+Pw2PaR4Z/DE3TTeAagK3dPthinWZ0U4JfCegcAd8iAq/cKZKCp3mEKYvWsHP7wKIGwCqRAvQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqPJxe4x; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764150622; x=1795686622;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mp3f3CKtLoajMyv+kwe/o5yTvIU3sW1y+uUZdm/u8RE=;
  b=TqPJxe4xdg7aFqTYhor2FRZqWLWBh4ZNwPXvrOpFiNRQAwVTjjWbe9VY
   Fz0VI3Uj/Y3qTENfr52hoKrai4iisBtLZhYuAKOzyNfMsOMzHcLTzsKWy
   x2YkZKcEz4Y1/Q54KqfhJ+hg6iD7JwCWtVzgCU73+cSmgj/YNcf01+nOr
   e26Rm9pMGhz9fTmBNCxmz321ji8DCLBHdfKD0wWqb6VpkTuWoUAkTboSc
   7SJk3aIpwj5ENxDYQJri15Z7MkSxRCGEkUoGWySkyngNNGTmdvWDCJAMc
   91anRGMBHPUKBi5I0kQWVmK5GRa3gR8kgkf0MSai+ehNgjaYqk8Sd8U21
   g==;
X-CSE-ConnectionGUID: iNFRct8gT+KDXX/IZ4t9Ng==
X-CSE-MsgGUID: 4WHYMG/vTbCg0K1ZVcycAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="88830049"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="88830049"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 01:50:21 -0800
X-CSE-ConnectionGUID: IHw+FPsLRsOeDVNUYVrOGQ==
X-CSE-MsgGUID: cQjoBjXVRRKRNX571I4cgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192688248"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 01:50:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 26 Nov 2025 11:50:10 +0200 (EET)
To: "Liu, Yongxin" <Yongxin.Liu@windriver.com>
cc: Jakub Kicinski <kuba@kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>, 
    "andrew@lunn.ch" <andrew@lunn.ch>, 
    "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, 
    "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
 memory leak
In-Reply-To: <SJ0PR11MB50725E455D5B0089507E8311E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com>
Message-ID: <6505d4a2-9d21-64ef-e07d-dabc7123c4c1@linux.intel.com>
References: <20251125022952.1748173-2-yongxin.liu@windriver.com> <20251124185624.682de84f@kernel.org> <SJ0PR11MB5072CCB0B5213AE5467C1456E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com> <20251124191443.4bd11a48@kernel.org>
 <SJ0PR11MB50725E455D5B0089507E8311E5D1A@SJ0PR11MB5072.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Nov 2025, Liu, Yongxin wrote:

> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Tuesday, November 25, 2025 11:15
> > To: Liu, Yongxin <Yongxin.Liu@windriver.com>
> > Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> > david.e.box@linux.intel.com; ilpo.jarvinen@linux.intel.com; andrew@lunn.ch;
> > platform-driver-x86@vger.kernel.org; stable@vger.kernel.org
> > Subject: Re: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI buffer
> > memory leak
> > 
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and
> > know the content is safe.
> > 
> > On Tue, 25 Nov 2025 03:07:30 +0000 Liu, Yongxin wrote:
> > > > -----Original Message-----
> > > > From: Jakub Kicinski <kuba@kernel.org>
> > > > Sent: Tuesday, November 25, 2025 10:56
> > > > To: Liu, Yongxin <Yongxin.Liu@windriver.com>
> > > > Cc: linux-kernel@vger.kernel.org; netdev@vger.kernel.org;
> > > > david.e.box@linux.intel.com; ilpo.jarvinen@linux.intel.com;
> > > > andrew@lunn.ch; platform-driver-x86@vger.kernel.org;
> > > > stable@vger.kernel.org
> > > > Subject: Re: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI
> > > > buffer memory leak
> > > >
> > > > CAUTION: This email comes from a non Wind River email account!
> > > > Do not click links or open attachments unless you recognize the
> > > > sender and know the content is safe.
> > > >
> > > > On Tue, 25 Nov 2025 10:29:53 +0800 yongxin.liu@windriver.com wrote:
> > > > > Subject: [PATCH net v2] platform/x86: intel_pmc_ipc: fix ACPI
> > > > > buffer
> > > > memory leak
> > > >
> > > > Presumably typo in the subject? Why would this go via netdev/net.. ?
> > >
> > > Because the only caller of intel_pmc_ipc() is
> > drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c.
> > > I have sent both to the platform-driver-x86@vger.kernel.org and
> > netdev@vger.kernel.org mailing lists.
> > 
> > Just to be clear -- the CC is fine, but given the code path - the platform
> > maintainer will likely take this via their tree. And the subject
> > designation is to indicate which maintainer you're expecting to process
> > the patch.
> 
> Got it. If needed, I will resend with the correct subject.

Hi Yongxin,

As this code belongs to pdx86 domain, please ignore Andrew's feedback on 
not using __free() (which was given with the assumption this would fall 
under netdev's domain that applies a different rule).

Using cleanup.h helpers is required for new pdx86 code when it avoids 
error handling gotos.

-- 
 i.


