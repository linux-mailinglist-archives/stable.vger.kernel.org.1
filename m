Return-Path: <stable+bounces-215925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL//MOeUjWmI4wAAu9opvQ
	(envelope-from <stable+bounces-215925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:52:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5692212B932
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 197E73010168
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C9D2BE647;
	Thu, 12 Feb 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOS+9fmj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A392DA750
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770886371; cv=none; b=smEV7HEO0/XQM34A9ul4CUiWSaGbdk72VRbn5nZ74CqgiNnNz/kINUJZBWC/oOYUmfz5GSHgJMNZtTAGjzQiOZ5Ew2afUAQi8O8qUTgMjf25eiiy3fN9dkmzVyO2vVYV1HL2Gsl2FNxceuE+YyagyLs8dI2Anyb6dANs+ICO9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770886371; c=relaxed/simple;
	bh=NqbK9AJa/Wxu/mSk+QPCbSAHGW0QQJLkSOUt9xiDgLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWqKq9auQs8/rJF8Hk9O0vMzaxRr26+WxkKFrWZHXI2lf8QT5dJ0oJOW40a0Ggvm023OrRkYqq7abouoh/Hs04ArDWa9O2TZtOe3E2RQ5JNbgq5ZKrr1bFyxbXgbvIa5T6UQY2yJ+tp5/CkfnLf8J+Z/zcCQt1dhp+r67bUTziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOS+9fmj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770886368; x=1802422368;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=NqbK9AJa/Wxu/mSk+QPCbSAHGW0QQJLkSOUt9xiDgLw=;
  b=nOS+9fmjV3vRr/abzkR43P49e026gLkbg+tcMhZedXnyLXGt12saPFIe
   SrC4K+p0tJOXktsiR/c42INM1TGw5LtZeBedMZ5vREta6TGAObGwC5M0o
   kuun1EPjIZTKvAFKWZpjpmoGBaDgwta9q2m594aPiFYOSJaAnDnwGnxSn
   ZtZ1rwwhwg1yUTTsTnx6YA0K4bAFhmfMljO6S2OeKZnbF7IhX3BsSglMi
   bwUz7oYEncX5Sn/alB1JrbFr9PgHLXmkDvpWw5FtoLDn64ZTmxjgMADAG
   MXud4qCbXwLLF2cJ5dKhcFCvTc7xZ+8uW6oo+TP16Fwcz5Oi70ZsEQE7u
   Q==;
X-CSE-ConnectionGUID: bsUfArjLSJqk3of1SAZyJg==
X-CSE-MsgGUID: 4AUjNdhrQWq3Ans1BRfj2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72238076"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="72238076"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 00:52:47 -0800
X-CSE-ConnectionGUID: Or/IkaulSwe++x5wKKy2iA==
X-CSE-MsgGUID: wrtzGgAjRh2Jtc4ZZI7BmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211370272"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.128]) ([10.245.245.128])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 00:52:45 -0800
Message-ID: <cce7d407e4749023271d39653cb7cef78e1a60a3.camel@linux.intel.com>
Subject: Re: [PATCH v4] mm: Fix a hmm_range_fault() livelock / starvation
 problem
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: intel-xe@lists.freedesktop.org, Alistair Popple <apopple@nvidia.com>, 
 Ralph Campbell <rcampbell@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jason Gunthorpe <jgg@mellanox.com>,  Jason Gunthorpe	 <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Matthew Brost	 <matthew.brost@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, 	linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Date: Thu, 12 Feb 2026 09:52:43 +0100
In-Reply-To: <20260209173446.b76547c4028132f71de1b8eb@linux-foundation.org>
References: <20260205111028.200506-1-thomas.hellstrom@linux.intel.com>
		<89cb1d4744789702cd80dba8eb40dd50bf053b4e.camel@linux.intel.com>
	 <20260209173446.b76547c4028132f71de1b8eb@linux-foundation.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-215925-lists,stable=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 5692212B932
X-Rspamd-Action: no action

On Mon, 2026-02-09 at 17:34 -0800, Andrew Morton wrote:
> On Mon, 09 Feb 2026 15:47:38 +0100 Thomas Hellstr=C3=B6m
> <thomas.hellstrom@linux.intel.com> wrote:
>=20
> > @Alistair, any chance of an R-B for the below version?
>=20
> Yes please.
>=20
> > @Andrew, will this go through the -mm tree or alternaltively an ack
> > for
> > merging through drm-xe-fixes?
>=20
> Either works.=C2=A0 I'll grab a copy.=C2=A0 It you want to take this via =
drm
> then
> I'll drop the mm.git copy once the drm tree's version appears in
> linux-next.
>=20
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
>=20
> >=20

The drm tree's version now appears in linux-next as

a69d1ab971a624c6f112cea61536569d579c3215

Thanks,
Thomas


