Return-Path: <stable+bounces-138933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1363AA1AB2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E606E1BC1596
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E7E253949;
	Tue, 29 Apr 2025 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="VLJC+HyF"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-2.centrum.cz (gmmr-2.centrum.cz [46.255.227.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214E25333E;
	Tue, 29 Apr 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951611; cv=none; b=WX9u1KqhByoKd73dXlfbWt/7j0iytoQdc+WbFtHbdI+yTKIf+Gny3vhhZIWQE6RLkqH19kAcyXjRckQbrS+YrArGbmSu7mekv7IhO6+VogLzkCqPa7SdIev6oKG4DjRA1kEuvQgX4F0sANmBtDoUa1ybPkQY+aBZ4/Vd5OCfbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951611; c=relaxed/simple;
	bh=oKSQX35Q/IW816bp0TVZjumhqVdp1zqv2ypYAPRaYGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9uPq8gKyiaLYuDlJl2hk3CWl89MB3yF/1GKrUXyTcHLeXYiwH2FLEST+2iFO3xsJn9pmfFv3tjoMKOWxcxpZNp7IuIomsFNU5vCrid9NbClU127dOTWyq6DCh0dD1v5UziExKhi+AVbDWH+ocNtnsU4RrG5ngC/ac8cG0JlfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=VLJC+HyF; arc=none smtp.client-ip=46.255.227.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-2.centrum.cz (localhost [127.0.0.1])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 5DAE12078205;
	Tue, 29 Apr 2025 20:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1745951604; bh=UviKfPN5+v0SBsUoC5z5Ae18skRFLQGuYZPCRcGgySE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLJC+HyF8Ci9BhNPmmddMHWHXwizgNMDVwq8yNrQ40DgTeYpIZWT5vgzzr8bNlzMM
	 I0Ofq1qs3rcpiHrI7p9+wlGOd8LSApiXvcuv6JFO88p/wmpab93gw+W7ieumV0Mma9
	 qneZtSJwLQQWQNWVgMTcKsk4j7Ok+4PBC0sHrY68=
Received: from antispam31.centrum.cz (antispam31.cent [10.30.208.31])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 5BA642024EF6;
	Tue, 29 Apr 2025 20:33:24 +0200 (CEST)
X-CSE-ConnectionGUID: ZnyxlZOzR/+6KfKYimKROQ==
X-CSE-MsgGUID: aP3vmKuER+yqDqXruykamg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2EXAACAGhFo/0vj/y5aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAJgTgEAQEBCwGFJIRVkXEDiiSBUoYzi2uBfg8BAQEBAQEBAQEJRAQBA?=
 =?us-ascii?q?T+ESAKLNSc2Bw4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBgEBAQEBAQYGAQKBH?=
 =?us-ascii?q?YU1U4JiAYN/AQEBAQIBIwQLAUYFCwsNCwICJgICVgYTgwKCMAEDDiOyXHp/M?=
 =?us-ascii?q?xoCZdxwAkkFVWOBKoEbLgGITwGFbIR3QoINhAc4PogegmkEg0OFepgmUnscA?=
 =?us-ascii?q?1ksAVUTFwsHBYEmQwOBDyNLBS4dghGFIYIRgVwDAyIBgxN0HIRmhFAtT4Mvg?=
 =?us-ascii?q?gJoSSBAAwttPTcUGwaWeYNkBgFyHEMJZcVPgkODHIEJhE6dFTOXcAOSZC6HZ?=
 =?us-ascii?q?ZBrG6kagW0Bgg8zIjCDIlIZzB92PAIHAQoBAQMJgjuNYYFLAQE?=
IronPort-PHdr: A9a23:EznWjBwgt9t0dS3XCzJFzVBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xaZva0m1gGVAN6TwskHotSVmpioYXYH75eFvSJKW713fDhBpOMo2icNO4q7M3D9N+PgdCcgH
 c5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFRrhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTezf79+N
 gm6oRneusUIgIZvJaY8xxXUqXZUZupawn9lKl2Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElR
 rFGDzooLn446tTzuRfMVQWA6WIQX3sZnBRVGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8
 aFmQwL1hSgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoWgb
 4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL406003fo/HA/b3wIgEd0Bv2jJo9v6NqgfS
 vy1warSwDnfc/9axTXw5Y7VeR4hu/GMWrdwfNLLx0YxCwPFlEibpoP/MDOTyOENsHWQ4u16W
 uK1iG4osQRxrSK1xso3kIbJmoYVxUrf9Slj3Ik0JMS1RUhmatGrDJVerTuVN5dqQsw8WWFov
 j43x6EJtJO0cyYExpAqyh3fZfGJfIaE/BLuWemNLDtlmX5rdqyyiwiy/EWh1OHwSsm53VRWo
 iZZkdTBq3AD2gHT5MWBV/Bz/V+h1C6A2g3S8O1IP0A5mKrBJ5I/3LI9lIAfvEbDEyPuhkn6k
 aGbel869uS29+jreKvqq5CAO4NujgzzM6IjkdGlD+siKAgBRW2b9Py51L3k4EL2Xq1HjuYzk
 qnFqJDaItkbprKhDw9VzIkj7xG/Ai+p0NQdhHUHN1dFeA6fj4T0Jl3COuz3Aum5g1Swijdr2
 vXGMqf9DZTMNnTDkbHhcqhh60NExwc+zMpT64xUB7wBOv7/RFH9ud7CAhI7MwG42+PnB8981
 oMaV2KPGKiZMKbKvFCS/OIvIPODZIoPtzbnMPUq/eLujXsjll8GZ6WmwZoWZGiiHvt6O0WZf
 WbsgtAZHGcQvgsxVurqhEeYUT5UfHm9Qbg85i0gCI+9F4jDXIWtjKad0ye8G51afnpGBUyUE
 Xf0a4WEXO8BaCaTIs9njzwFWqGtS4ok1Ry1tw/61aBoIfbX+iECspLjztd16/XJlR4u7Tx0E
 9id02aVQm5unWMIXzo20bt7oUx8zFeDzKd5j+VWFdxU+vNJVBo1OoTAz+x7DNDyXBjNftCTS
 FapWtmmGy0+Tsotw98SZEZwA8itgQrd3yqrHrAYjKaLC4Ip/aLcxXfxO9xxxGrB1Kkkl1UmW
 NdANXW6hq5j8AjeH4rJk0Sfl6a3eqUQxS3N+3mZzWqIok5YVBV9UbvKXX8BfEvat9f56V3YT
 7+oF7snNhFNycmYKqtFctHpl0lJRO//ONTCZGK8g3ywBQqSybyXaIrlZX4Q3DvSCEcaiQAf5
 3WGOhYkBienvW3eCCZiFVX1Y0Pj6eV+rmi0QVcuzw6Wd01hy6a1+hkNiPGdU/8cw7EEuCYkq
 zhsBFiz0NzZBcScqQd9eqsPKe86tXtOy2PV/yx8OpCtKap4j1gSO1B7tl3v2z1tB4lAmNRsp
 3QvmllcM6WdhWtMaynQ45n2mb6ffmDo/xmqYrT+003a2c3Q8bVZu6dwkEnqoAz8ThlqyH5gy
 dQAliLEvv33
IronPort-Data: A9a23:N/qkOKm9jgtfR9H4nE5jgvLo5gy1J0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIdXmGDb67ZMWP0KdgkbNiyo00HuJ/TnYcwGgJp/ysxRFtH+JHPbTi7wuYcHM8wwunrFh8PA
 xA2M4GYRCwMZiaB4Erra/658CQUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dga++2k
 Y20+pC31GONgWYubzpIsfPb8nuDgdyr0N8mlg1jDRx0lACG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaPVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 ONl7sXsFFhzbsUgr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAAILfwCHtcWk+vX4FMpipfUiKerRG7pK7xmMzRmBZRonaZ/GBr7P+ccBhXE7i8ZSB+vbI
 cELAdZtREieJUcSZxFNUs14w7rAanrXKlW0rHqcv6k+5mHJ5AVt1LH2dtHHEjCPbZwMxhnE/
 DibpwwVBDkTDIeBzBmY30jvl/bjhBPhRZMRHbi3o6sCbFq7gzZ75ActfUGqqP//kEm0VshDM
 GQd4C9opq83nGSvT9/gT1i9pVaHoBcXWJxXCeJSwAiO0q/85wefG3hBQDlcbtAvqM4xQ3otz
 FDht9/gGz1jmKeYRXKU6vGfqjbaESwUK3ISICwJVw0I5/H9r4wpyBHCVNBuFOiylNKdMSrsy
 jqOoQAgiLgJy80GzaO2+RbAmT3Em3TSZlJroF+KAyT/tFw/O9PNi5GU1GU3JM1odO6xJmRtd
 lBd8yRCxIji1a2wqRE=
IronPort-HdrOrdr: A9a23:z7hBMaCXzOhgliXlHemh55DYdb4zR+YMi2TDGXofdfVwSL38qy
 nIpoV+6faUskdyZJhOo7q90cW7LE80sKQFhrX5Xo3SPzUO2lHIEGgK1+KLqAEIWRefygc378
 ldmsZFZOHNMQ==
X-Talos-CUID: 9a23:zePfZGzsVcSYE9vKMsYLBgUmHNE1dk/63k2XYBGbB0VYSbi2c3iprfY=
X-Talos-MUID: 9a23:OxUBrgqslPxuIsBZZ9gezzhab9ltwLmDMgMciLkfi9OZJC95PjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,249,1739833200"; 
   d="scan'208";a="110742250"
Received: from unknown (HELO gm-smtp11.centrum.cz) ([46.255.227.75])
  by antispam31.centrum.cz with ESMTP; 29 Apr 2025 20:33:24 +0200
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp11.centrum.cz (Postfix) with ESMTPSA id DFBCB100AE133;
	Tue, 29 Apr 2025 20:33:23 +0200 (CEST)
Date: Tue, 29 Apr 2025 20:33:21 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
Message-ID: <2025429183321-aBEbcQQY3WX6dsNI-arkamar@atlas.cz>
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <2025429144547-aBDmGzJBQc9RMBj--arkamar@atlas.cz>
 <ef317615-3e26-4641-8141-4d3913ced47f@redhat.com>
 <b6613b71-3eb9-4348-9031-c1dd172b9814@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6613b71-3eb9-4348-9031-c1dd172b9814@redhat.com>

On Tue, Apr 29, 2025 at 05:45:53PM +0200, David Hildenbrand wrote:
> On 29.04.25 16:52, David Hildenbrand wrote:
> > On 29.04.25 16:45, Petr Vaněk wrote:
> >> On Tue, Apr 29, 2025 at 04:29:30PM +0200, David Hildenbrand wrote:
> >>> On 29.04.25 16:22, Petr Vaněk wrote:
> >>>> folio_pte_batch() could overcount the number of contiguous PTEs when
> >>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
> >>>> memory also happens to be zero. The loop doesn't break in such a case
> >>>> because pte_same() returns true, and the batch size is advanced by one
> >>>> more than it should be.
> >>>>
> >>>> To fix this, bail out early if a non-present PTE is encountered,
> >>>> preventing the invalid comparison.
> >>>>
> >>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
> >>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
> >>>> bisect.
> >>>>
> >>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> >>>> ---
> >>>>     mm/internal.h | 2 ++
> >>>>     1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>> index e9695baa5922..c181fe2bac9d 100644
> >>>> --- a/mm/internal.h
> >>>> +++ b/mm/internal.h
> >>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> >>>>     			dirty = !!pte_dirty(pte);
> >>>>     		pte = __pte_batch_clear_ignored(pte, flags);
> >>>>     
> >>>> +		if (!pte_present(pte))
> >>>> +			break;
> >>>>     		if (!pte_same(pte, expected_pte))
> >>>>     			break;
> >>>
> >>> How could pte_same() suddenly match on a present and non-present PTE.
> >>
> >> In the problematic case pte.pte == 0 and expected_pte.pte == 0 as well.
> >> pte_same() returns a.pte == b.pte -> 0 == 0. Both are non-present PTEs.
> > 
> > Observe that folio_pte_batch() was called *with a present pte*.
> > 
> > do_zap_pte_range()
> > 	if (pte_present(ptent))
> > 		zap_present_ptes()
> > 			folio_pte_batch()
> > 
> > How can we end up with an expected_pte that is !present, if it is based
> > on the provided pte that *is present* and we only used pte_advance_pfn()
> > to advance the pfn?
> 
> I've been staring at the code for too long and don't see the issue.
> 
> We even have
> 
> VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> 
> So the initial pteval we got is present.
> 
> I don't see how
> 
> 	nr = pte_batch_hint(start_ptep, pte);
> 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
> 
> would suddenly result in !pte_present(expected_pte).

The issue is not happening in __pte_batch_clear_ignored but later in
following line:

  expected_pte = pte_advance_pfn(expected_pte, nr);

The issue seems to be in __pte function which converts PTE value to
pte_t in pte_advance_pfn, because warnings disappears when I change the
line to

  expected_pte = (pte_t){ .pte = pte_val(expected_pte) + (nr << PFN_PTE_SHIFT) };

The kernel probably uses __pte function from
arch/x86/include/asm/paravirt.h because it is configured with
CONFIG_PARAVIRT=y:

  static inline pte_t __pte(pteval_t val)
  {
  	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
  					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
  }

I guess it might cause this weird magic, but I need more time to
understand what it does :)

> The really weird thing is that this has only been seen on XEN.
> 
> But even on XEN, a present pte should not suddenly get !present -- we're not
> re-reading from ptep :/
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

