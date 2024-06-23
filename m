Return-Path: <stable+bounces-54957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DF3913D44
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDA32827C4
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 17:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF71836C0;
	Sun, 23 Jun 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQaWJ7dP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B721F183099;
	Sun, 23 Jun 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163659; cv=none; b=dMDycHlskGydjca5LkRusx0qbps2QKbLKOsERmHcAlW6rI7Z/n0f8u5CgnCHY8G5AM9swRFBBzmo7tmfFoUFnK+/htJlhevvZSrSq/QVems1hQ8+esXzxEJaIhebcLFDbrVP0Z0BSlJK1qcLgS2RKx9k1t3tmpwlR9EFqNE6zY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163659; c=relaxed/simple;
	bh=bHjJ/UFsisAATvMmZ8nO02PbyPzunLK80yjWDJJZiLI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o1ZSGa0I5fy8/DEzqulYVUhxQQBAQugz/lWd8UzDO+vZJ5NPt3YdRu7hKBK626kCG3Q78+m8Rodcy4Cec1JQe1Bd7tnYRmvI2ljCrmIHT35DtZpTe5+wf1d+7UBs2SpA7Sz1zvNn4MrKle/tCWaKsaEuf8QLgXnxx7v+N/4bTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQaWJ7dP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719163657; x=1750699657;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bHjJ/UFsisAATvMmZ8nO02PbyPzunLK80yjWDJJZiLI=;
  b=mQaWJ7dPvH1LBbcSXIG/uPjQ4XgOuzEvu5hez1EMGiw4dlGFPuyiv1uG
   uC8AJDR9lJMpccLk+4znxKmWkSeL55iBSwhoW93Alfh9UdKTn7BWZFOb/
   SyygUdDEJPQl5ZkEfG1diWFICreQEklzG824/iCqmQ+U1FronBBQt58//
   kUjXnNR6QT0W3lRsR6EGsDyYq+DVTN+dab6XSQOimHvwFJcJLaON83tys
   jsIkfj3IW0Y5NIWZsqFsxQ4YRmLpZPzWqCUtHQxDhAKFkT22H5ftReD+0
   o4Eq7B73n1BplGRowsGxC7vX+nSps5n8kNvly72gBSXV1mQihIOmlF66S
   A==;
X-CSE-ConnectionGUID: /WeivNjXS/aK6UpCrNh3jA==
X-CSE-MsgGUID: 5cl1ttLMSVmNeSjYq1ZPGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16272107"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="16272107"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 10:27:37 -0700
X-CSE-ConnectionGUID: fO0s43NfSPaJr9J3H+jq9w==
X-CSE-MsgGUID: 63eV8MN6Tgi2Z6y1hfIH4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="43192063"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 10:27:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 23 Jun 2024 20:27:29 +0300 (EEST)
To: Borislav Petkov <bp@alien8.de>
cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
    "H. Peter Anvin" <hpa@zytor.com>, Grant Likely <grant.likely@secretlab.ca>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/of: Return consistent error type from
 x86_of_pci_irq_enable()
In-Reply-To: <20240621141507.GHZnWK6-r6XEH2a9CR@fat_crate.local>
Message-ID: <ba1d6bba-847a-f249-72f0-0fd2a0a461eb@linux.intel.com>
References: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com> <20240621141507.GHZnWK6-r6XEH2a9CR@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-216487811-1719163649=:1423"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-216487811-1719163649=:1423
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 21 Jun 2024, Borislav Petkov wrote:

> On Mon, May 27, 2024 at 03:55:35PM +0300, Ilpo J=C3=A4rvinen wrote:
> > x86_of_pci_irq_enable() returns PCIBIOS_* code received from
> > pci_read_config_byte() directly and also -EINVAL which are not
> > compatible error types. x86_of_pci_irq_enable() is used as
> > (*pcibios_enable_irq) function which should not return PCIBIOS_* codes.
> >=20
> > Convert the PCIBIOS_* return code from pci_read_config_byte() into
> > normal errno using pcibios_err_to_errno().
> >=20
> > Fixes: 96e0a0797eba ("x86: dtb: Add support for PCI devices backed by d=
tb nodes")
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: stable@vger.kernel.org
>=20
> Any particular reason why this is CC:stable?
>=20
> I'd say unless you're fixing a specific failure, this should go the norma=
l
> route to 6.11...

It can go the normal route. And feel free to drop Cc stable too but I=20
don't think it matters much as stable folks will autoselect things=20
regardless of cc being there or not.

--=20
 i.

--8323328-216487811-1719163649=:1423--

