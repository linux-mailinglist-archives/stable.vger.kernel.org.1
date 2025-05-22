Return-Path: <stable+bounces-146083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD0AC0BC8
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 14:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8539F3AF6AB
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 12:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066B28B4FD;
	Thu, 22 May 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q1kXA6V4"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571C28B419
	for <stable@vger.kernel.org>; Thu, 22 May 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917623; cv=none; b=LWFMintBOOMDmlLFV+pW/8ZrjH6fDkmHs/TVdcjhb3rieyz/4hocM/IgJltzOpGZKkkewbVB+kzcICqzhOUkjc5dgxI6mnODDUiBEuXwUlIVnABZ/WdYm9iRYv9au5KL78kgV4RCfTX1I4VwSEX2o0OSCqDkQRRrKHmfy2f0Tjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917623; c=relaxed/simple;
	bh=o/jJvwOkURxtxoRnJBvK627eN5WNgntlDWEx9DwDX9c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cDlQekucIljMmssSzxCd+fCGxnQS4HMw3+JSgBtw9KLTps2DQt6Fm7I6/CDD3C/7/IHBzQ94l/HyXdo8KbgcrU+JQaPEo/6Vq3N2sv/Ot5KNuRcZK14HtKe0GohmNI844jiM04OVf2HPVtSh7IXP0o/drSCZIJ52u2eut+ZJe9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q1kXA6V4; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747917615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/jJvwOkURxtxoRnJBvK627eN5WNgntlDWEx9DwDX9c=;
	b=q1kXA6V4zfGfrNy51OHqH8rO7FuEZmHb/i59g2jWLmszj+qNGOE9AN2vqsptKOXl5iHjaU
	fnvY86wo+qJ/P/NcfiS2H2yfXi36ba+5ZxJYamSbRxJ2FH31ymZTUnb1jiAeQalUXgczhM
	7OWlVUU/AI78YSia2VIR8bVvUdZPKwg=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <aC8PRkyd3y74Ph5R@localhost.localdomain>
Date: Thu, 22 May 2025 20:39:39 +0800
Cc: Ge Yang <yangge1116@126.com>,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 21cnbao@gmail.com,
 david@redhat.com,
 baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B8641A1-5345-44A5-B610-9BCBC980493D@linux.dev>
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
 <ff6bd560-d249-418f-81f4-7cbe055a25ec@126.com>
 <aC8PRkyd3y74Ph5R@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On May 22, 2025, at 19:49, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Thu, May 22, 2025 at 07:34:56PM +0800, Ge Yang wrote:
>> It seems that we cannot simply remove the folio_test_hugetlb() check. =
The
>> reasons are as follows:
>=20
> Yeah, my thought was whether we could move the folio_hstate within
> alloc_and_dissolve_hugetlb_folio(), since the latter really needs to =
take the
> lock.
> But isolate_or_dissolve_huge_page() also needs the 'hstate' not only =
to
> pass it onto alloc_and_dissolve_hugetlb_folio() but to check whether
> hstate is gigantic.

But I think we could use "folio_order() > MAX_PAGE_ORDER" to replace the =
check
of hstate_is_gigantic(), right? Then ee could remove the first parameter =
of hstate
from alloc_and_dissolve_hugetlb_folio() and obtain hstate in it.

>=20
> Umh, kinda hate sparkling the locks all around.
>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs


