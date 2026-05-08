Return-Path: <stable+bounces-244803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB8mB0Aa/mmQmwAAu9opvQ
	(envelope-from <stable+bounces-244803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:15:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6514F9D9C
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A0783029746
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D53F660E;
	Fri,  8 May 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbnW8LgC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623936166F;
	Fri,  8 May 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260417; cv=none; b=W6oaNKvqDLeGZXbOMDYRbfjy5g6kLGya+KXNcOOclTPUg67jLzi8yLjas+RgIdYxUxUIPVM+BaizPnEI/YIpYyYgDquoGNktGR5sYc1fwb3kd8M2r6Fr5twulqebhJ0lc6ZRHb/Cdd0FbH2D4TCyumubkpTGKcu+jafk6C+KEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260417; c=relaxed/simple;
	bh=R3XXvBMzWhJsAbVidWoyOdoPUoj7TaExO4inCZD6wxA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OvudrMkgY9UzdXE1lSfba6kyd8n5Se/QhSe3t9IEXdvLXXGIPymFjrFnMwco9N0yhSzHiHQLiNL27dm5Y/uuhkaloaZG09dKVMcSBDOLPmuoTTe7a/5fOoP+o7WjPaGFmH92V7bZopt1mpMGhThE4arlcupJCGGEKaK61rvThlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbnW8LgC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778260416; x=1809796416;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=R3XXvBMzWhJsAbVidWoyOdoPUoj7TaExO4inCZD6wxA=;
  b=CbnW8LgCW7uWIYODF2hak5uSD6mXafb1A8nt7ikxzb5ojIl9U6pFrwfj
   2czXAXsbzqQQXm+iF15Y/StNnRrReuBhU7Fvek5rHXnnhPl8ErwW1R5Ax
   nzRyXCxIfQkqe98F1PRbyyrbefQUS2kt6pPXjrKPp5AFm6QKq/FQawV9K
   riim6I+O5h0a/ed1riaC4nn+6kO92F1cch1LUmvax7L0PR6Chj93qZX69
   qzdF+ghUrDkLnx/J4ao1PD2y0uO2NfoWFVQtt+72c64vqmXP0OCRx5W+K
   WIA2nadglsTBbfPjn7XBFVKvpoW1Rlsozkt7zuMwNVrwn+5BW5gF3K9q4
   w==;
X-CSE-ConnectionGUID: +pJzEe1AQRyAlqzeDpLonw==
X-CSE-MsgGUID: d3mZdd2ySjOsk1+Awm0vUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="82854428"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="82854428"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 10:13:35 -0700
X-CSE-ConnectionGUID: ZDeomalFSHShz5p2bUBs2A==
X-CSE-MsgGUID: P3BIDXJcRNyZ7qQI989Hbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="240802003"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.100])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 10:13:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 8 May 2026 20:13:30 +0300 (EEST)
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    chris.friesen@windriver.com
Subject: Re: [REQUEST] Backport 8250_dw BUSY deassert series to 6.12.y
 stable
In-Reply-To: <20260508154629.530915-1-ionut.nechita@windriver.com>
Message-ID: <deb9499d-3245-7e38-9034-e533d4b5f512@linux.intel.com>
References: <20260508151614.498810-1-ionut.nechita@windriver.com> <20260508154629.530915-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-780460965-1778255682=:1002"
Content-ID: <02748eff-fc6d-b845-0aea-8a88231abc08@linux.intel.com>
X-Rspamd-Queue-Id: BB6514F9D9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-244803-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,windriver.com:email]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-780460965-1778255682=:1002
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <4d90be43-a2fb-a148-91c6-9494c55bddc8@linux.intel.com>

On Fri, 8 May 2026, Ionut Nechita (Wind River) wrote:

> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> Hi Greg,
>=20
> Fair question. We're shipping 6.12 as part of a certified platform
> (StarlingX/Yocto) that is already deployed in production at customer
> sites. A major kernel version bump requires a full re-qualification
> cycle across the entire platform stack (RT latency validation,
> out-of-tree driver compat, storage/networking regression testing),
> which is a multi-month effort we cannot justify for a single
> subsystem fix.
>=20
> We are planning the move to a newer LTS for our next major release,
> but for the current production branch 6.12 is what we're committed to.
>=20
> Since patch 7/7 already carries Cc: stable, would it be possible to
> pull in just the minimal dependencies needed to make it apply on
> 6.12.y? We're happy to do the backport work ourselves and submit it
> for review if that helps =E2=80=94 we just wanted to check with Ilpo firs=
t
> on what the correct minimal subset would be before sending something
> that might be wrong.

Ah, this didn't get backported that far likely due to some syntax related=
=20
changes causing conflicts with the series.

To backport the entire series my suggestion is to take parts of the=20
commits:

dbd26a886e94 ("serial: 8250: use serial_port_in/out() helpers") (8250_dw.c =
only or just all if it goes cleanly)
b339809edda1 ("serial: 8250: use guard()s") (8250_port.c shutdown hunks)

And this completely (just syntax changes):

bd8cad85561b ("serial: 8250_dw: Comment possible corner cases in serial_out=
() implementation")

Those above are effectively just syntax changes but result in conflicts if=
=20
not applied prior to the BUSY fix series.

This leaves only minor conflicts in:

a7b9ce39fbe4 ("serial: 8250_dw: Ensure BUSY is deasserted")
with type change in
fc9ceb501e38 ("serial: 8250: sanitize uart_port::serial_{in,out}() types")
(trivial resolution as the change was in the code removed by the BUSY=20
change)

73a4ed8f9efa ("serial: 8250_dw: Rework IIR_NO_INT handling to stop interrup=
t storm")
with probe function changes (handle_irq assignment changes and unrelated=20
dw8250_setup_dma_filter() change) in
c213375e3283 ("serial: 8250_dw: Call dw8250_quirks() conditionally")

Hope this helps.

--=20
 i.
--8323328-780460965-1778255682=:1002--

