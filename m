Return-Path: <stable+bounces-185597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BFDBD8223
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E4E4027C2
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1252DF6F9;
	Tue, 14 Oct 2025 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adsibxpF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768C221703;
	Tue, 14 Oct 2025 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429939; cv=none; b=lh0xmRaRxmAqCwwmDijQIG4PlTowFFAwy4idNVFBFGq4B7vYDLiL2GKzzvcvDD1RcFFb7OE3SHbiD+4KSBRs9WPpJcWl9ae9PczshtM7ybBYFvhftePQjzsHaiHzXfQi5jgrobR226tidAxenBEYpSa2KkURcLQNVc9I6wxNQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429939; c=relaxed/simple;
	bh=YdHjqTNgP74jckAY3AUrjqsDyYyjvpD259UQSVwnYKc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=isoikURXmgfaWRzUDwCpv8D2sRwBhj5KfQJybgCQlSkbdI72NDN97SyDql3/R3AbPvY7LnofmkDNyAbbccj2Y5Mrz9XhDlcDoxd81HYwV6hCCaO3mG+Fhco0fJirtvsAgNWkgIaBddOksOt3aCmNg96dRnxcMfsuWkSMARz2zQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adsibxpF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760429937; x=1791965937;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YdHjqTNgP74jckAY3AUrjqsDyYyjvpD259UQSVwnYKc=;
  b=adsibxpFRBFrei047J2MFo2tgk3Hrp+XYPbzISaElDqK+hBeIIqAgWhf
   cPqqnDG0pVUS5j2+hipA0HoEDwN0+Ifs4RzcQlB85bt5pOllSAeU1pEBj
   fTnkNhifn9lNo1v5kOpLqJGz0VrkOxDzw3u+UWKrE+yr6NlWe4txey3cD
   cLA9tm10e5pvnFibVbXhqNOvB4sE6JU6QVgSesdpTOqUB+mfjxmX75vsS
   Q/+edr5G0KIx4ofOHHTrssLdIenAgMRZC88mczg90k1ZZFseGVPRo/gMR
   kyHaOVPd1NCd/UmO8nMkimbW4i5YH9fIFOdzXjj1sJ59Klw74ZsuCHYjt
   A==;
X-CSE-ConnectionGUID: VjnRXY4ZSLi+SHX6s+TMTA==
X-CSE-MsgGUID: eTE6iek7SxyZ/plZOxtCJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62733623"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62733623"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:18:56 -0700
X-CSE-ConnectionGUID: rDR0MUa9QeGjXTn5n7hfxQ==
X-CSE-MsgGUID: T5E+1zUeQ8eiX6T/PqpYPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="186237930"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.195])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:18:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Oct 2025 11:18:49 +0300 (EEST)
To: Markus Elfring <Markus.Elfring@web.de>
cc: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
    Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hansg@kernel.org>, 
    Dell.Client.Kernel@dell.com, stable@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Gal Hammer <galhammer@gmail.com>
Subject: Re: [v2] platform/x86: alienware-wmi-wmax: Fix null pointer derefence
 in sleep handlers
In-Reply-To: <1e179db8-1c44-4bda-ba07-1be2195febae@web.de>
Message-ID: <2007c648-1a39-f458-41a0-fcda54f9d5b5@linux.intel.com>
References: <176036823039.2473.15648931584117338012.b4-ty@linux.intel.com> <1e179db8-1c44-4bda-ba07-1be2195febae@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1534069840-1760429929=:925"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1534069840-1760429929=:925
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 13 Oct 2025, Markus Elfring wrote:

> =E2=80=A6
> > The list of commits applied:
> > [1/1] platform/x86: alienware-wmi-wmax: Fix null pointer derefence in s=
leep handlers
>=20
>                                                            dereference?
>=20
>=20
> >       commit: 5ae9382ac3c56d044ed065d0ba6d8c42139a8f98
>=20
> How do you think about to avoid a typo in the summary phrase?

Thanks for noticing it. I've corrected it now.

--=20
 i.

--8323328-1534069840-1760429929=:925--

