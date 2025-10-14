Return-Path: <stable+bounces-185620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3918BD891F
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43ABB4FD397
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91E259CBD;
	Tue, 14 Oct 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPcpshgQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BA2E2EF8;
	Tue, 14 Oct 2025 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435447; cv=none; b=ux7NHsyGsa+3QdekWW7DD3b4lIcjcdGj1Qc9xWCG38KHMmsN4uGFe1ksOI0aiiOHYHnZQ+4EXzWjZshH2hCR0PUIvEtANX63PApcfyaZazZvz8dxhO3Z1VW97F3dGjJI2GLygyI0s/5DEyLjTmNJhkGFJGkLWHPePTq838KYsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435447; c=relaxed/simple;
	bh=mTnPuwprhL1kApju2BghnqenrZrPLPzmn0K030R5TPw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SNquV4F/PyRq8wefeM4ph8j5w7mjRbv1Um4Bu3Xq1xSR7H+DS79lzW7dXARG3qKnOGsmiazxx2pLwKS45v9HtUmt5x8eKfVQmriByA+6mNO0vJiidyH2yUnE0vCbp+Flon9SUGk5wu3IIk3vZsMtxYMH1ln9qllkpJsjVbFEsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPcpshgQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760435446; x=1791971446;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=mTnPuwprhL1kApju2BghnqenrZrPLPzmn0K030R5TPw=;
  b=GPcpshgQ+O0Ld0u0vl2cZiNCDj56pQW7TvLhytZx+nqfWNtbfkApy0QQ
   /n+2RCTKhGy2gVkUsggplsHXigA1qGpxttuPd9/4kCTvnjnvD+reiiuYm
   lIsXIPlkTizZdSqweLzfptnhfUUejdPp5nVOoBkB0riYbb1LYSdo8bFQ7
   aMnxl7WZwEKqGq87kMZGelim152bnyp8pGQNejTt1OvOzXbkkbT6YN/QF
   KqHsSV1EI/mpkmWU3juRQofS8rtUfibVOqfyC593KrW83fcmeHogI8imV
   Q7Cz89cYt03fBEbbJ7Q0r+GWjMMETDaMIkBRHRlj6gVkntawdVdhY5mBq
   A==;
X-CSE-ConnectionGUID: bpL1c0R/Q9STkuCxpuETlQ==
X-CSE-MsgGUID: URKXQEZLTcCBbZYpK4di6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73193327"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="73193327"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 02:50:45 -0700
X-CSE-ConnectionGUID: Q4wwLd30ThS1aG8wkyNp+g==
X-CSE-MsgGUID: yQbLQctcSzuWh6NXhOpPHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="181847204"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 02:50:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Oct 2025 12:50:38 +0300 (EEST)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
    platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
    Gal Hammer <galhammer@gmail.com>
Subject: Re: [PATCH v2] platform/x86: alienware-wmi-wmax: Fix null pointer
 derefence in sleep handlers
In-Reply-To: <DDHY8FVSX42E.1SG926NXKG2FL@gmail.com>
Message-ID: <305092f3-7901-0a69-3459-b9f6b7d198db@linux.intel.com>
References: <20251013-sleep-fix-v2-1-1ad8bdb79585@gmail.com> <176036823039.2473.15648931584117338012.b4-ty@linux.intel.com> <DDHY8FVSX42E.1SG926NXKG2FL@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1269750449-1760435378=:925"
Content-ID: <720f1d53-260f-ad44-3ffd-d73277d83ce0@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1269750449-1760435378=:925
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0d969903-4d6a-9b29-ca27-daa7053c6c78@linux.intel.com>

On Tue, 14 Oct 2025, Kurt Borja wrote:

> On Mon Oct 13, 2025 at 10:10 AM -05, Ilpo J=E4rvinen wrote:
> > On Mon, 13 Oct 2025 00:26:26 -0500, Kurt Borja wrote:
> >
> >> Initialize `awcc` with empty quirks to avoid a null pointer dereferenc=
e
> >> in sleep handlers for devices without the AWCC interface.
> >>=20
> >> This also allows some code simplification in alienware_wmax_wmi_init()=
=2E
> >>=20
> >>=20
> >
> >
> > Thank you for your contribution, it has been applied to my local
> > review-ilpo-fixes branch. Note it will show up in the public
> > platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
> > local branch there, which might take a while.
> >
> > The list of commits applied:
> > [1/1] platform/x86: alienware-wmi-wmax: Fix null pointer derefence in s=
leep handlers
> >       commit: 5ae9382ac3c56d044ed065d0ba6d8c42139a8f98
> >
> > --
> >  i.
>=20
> Hi Ilpo,
>=20
> Gal has just noticed this approach prevents the old driver interface
> from loading, which is a huge regression.
>=20
> Do you prefer to drop this commit or should I submit a revert?
>=20
> Thank you for your patience!

Okay, thanks for the information. I'll drop it, it's very easy to drop as=
=20
it's the HEAD commit.

--=20
 i.
--8323328-1269750449-1760435378=:925--

