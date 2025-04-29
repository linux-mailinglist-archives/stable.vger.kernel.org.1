Return-Path: <stable+bounces-137107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D4AA0F70
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1DE87A84DB
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E831535966;
	Tue, 29 Apr 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="SulWdXUp";
	dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b="SulWdXUp"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-2.centrum.cz (gmmr-2.centrum.cz [46.255.227.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047A4431;
	Tue, 29 Apr 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938061; cv=none; b=AK7PIcLOw7L6JR9E6VA0OkKi8A4m4Ga0LgXUFpTUG144oK2XhT2obqt+gshkOvakLcgtnPjkaqGt1KKIAVbvBU+61TX4PKpyKVM4F2NhuN2jbrceq1l0fVSgbNTpTmS0JM38dT6iWb/Wow7QrnDOUJpAmoTJPb68JjaqTonhhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938061; c=relaxed/simple;
	bh=lCWLwV0QsDYg09C7wweVWAByFd3y/Z0TIjaO8og8KZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJ/k9JxZ+WXBfv3u45kxGWUYhCCFiVw/9gjfSRtgn71R3PkGs30zRpcySDEePXx5CPr7XfzYffsW40hYacA5XwjTM1SJIKLdkvU3b7gdM29NM/A2TVO5pYWdp0/M8AK0VMAg1kL82cZMU995VE/YMGp2Xrob/iWPVA9lmf0BGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz; spf=pass smtp.mailfrom=atlas.cz; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=SulWdXUp; dkim=pass (1024-bit key) header.d=atlas.cz header.i=@atlas.cz header.b=SulWdXUp; arc=none smtp.client-ip=46.255.227.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlas.cz
Received: from gmmr-1.centrum.cz (envoy-stl.cent [10.32.56.18])
	by gmmr-2.centrum.cz (Postfix) with ESMTP id 836272038BAB;
	Tue, 29 Apr 2025 16:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1745937950; bh=n2fineH2KiM0gAU2nno3zyw2Xd1Yc+c4zpdkIDc4l+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SulWdXUpLeomLiBPXZMFtBWmDL/plbPNhyymvKLaM8W9G2w5pB07Uup8HaCsV3y6+
	 j2XF+Uru4tn/wBshK2wkhN3/siqy3Ro4LtQry4+5dXqnYjjJsUMSN+pgO/gSKTFFLS
	 sUxYjvsnZ56dso+6N/IgoLtznAjRzzjXMfJD8zY8=
Received: from gmmr-1.centrum.cz (localhost [127.0.0.1])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id 7FBE01A5;
	Tue, 29 Apr 2025 16:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
	t=1745937950; bh=n2fineH2KiM0gAU2nno3zyw2Xd1Yc+c4zpdkIDc4l+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SulWdXUpLeomLiBPXZMFtBWmDL/plbPNhyymvKLaM8W9G2w5pB07Uup8HaCsV3y6+
	 j2XF+Uru4tn/wBshK2wkhN3/siqy3Ro4LtQry4+5dXqnYjjJsUMSN+pgO/gSKTFFLS
	 sUxYjvsnZ56dso+6N/IgoLtznAjRzzjXMfJD8zY8=
Received: from antispam21.centrum.cz (antispam21.cent [10.30.208.21])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id 7E27CEB;
	Tue, 29 Apr 2025 16:45:50 +0200 (CEST)
X-CSE-ConnectionGUID: crGLesLxRuC8KMLyJI4WmQ==
X-CSE-MsgGUID: mn/L3bo1S7ubox7jRB6q5A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2GOAAAW5RBo/03h/y5aHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?YE5BAEBCwGFJIRVkXSLdoYzjWkPAQEBAQEBAQEBCUQEAQE/hEgCizMnNwYOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQ0BAQYBAQEBAQEGBgECgR2FNVOCYgGDfwEBA?=
 =?us-ascii?q?QECASMECwFGBQsLDQsCAiYCAlYGE4MCgjABAw4jsWJ6fw0mGgJl3HACSQVVY?=
 =?us-ascii?q?4EqgRsuAYhPAYVshHdCgg2EBzg+iB6CaQSDQ4V6mCZSexwDWSwBVRMXCwcFg?=
 =?us-ascii?q?SZDA4EPI0sFLh2CEYUhghGBXAMDIgGDE3QchGaEUC1Pgy+CAmg9HUADC209N?=
 =?us-ascii?q?xQbBpZ2g2QHchxDCWXFT4JDgxyBCYROnRUzl3ADkmQuh2WQaxupGoF9ggAzI?=
 =?us-ascii?q?jCDIlIZywJ2PAIHAQoBAQMJgjuNYYFLAQE?=
IronPort-PHdr: A9a23:QJ0emRGIiDzvySlAwZr8D51Gf7pLhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21hmRBc6Bta4c26L/iOPJZy8p2d65qncMcZhBBVcuqP49uEgNJvDAImDAaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 RuooQnLqsUanYRuJrgwxxbGvndFePldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6HQEXGoZixZFHQfL4gziUpj+riX1uOx92DKHPcLtVrA7RS6i7
 6ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWWROQNpeVy1ZAoO9c
 YQPCfYBPf1FpIX5vlcCsAeyCRWpCO7p1zRGhGL53bci3uovEQ/IwhItEc8NvnTao9r6KLodX
 ++3w6TT0TXObOlb1Svh5ITUcB0sp+yHU7JqccrWzEkiDxnLgUuMqYz/Ijia2f4Cs26F6upjS
 OmijHQoqxtyoje1w8cjkJPJi5kPxVDY8SV22p01KcekR096eNOpFoZbuC6GOYVsWMwiX31ot
 zggyr0AoZO2YCcHxZsoyRDRb/GKcIiG7xzsWuqPITp1i25odK+iixi870Ws1O3xW8iq3FpWr
 idIkMXAumwO2hHO6saKV/tz80G80jiMzwDe8u5JLEEumabFK5MswqQ8moQNvUnDBCP7mkf7g
 LeIekk59OWk8frrbqv6qpOGKYN5hR3yPr4ql8G+B+kzLxIAUHKB+eum0b3u5Uj5QLJXgfIoi
 qTZq5XaJdgDpq6+Hg9Vzp4v6xahADei19QVhXYHLFdcdBKciojpJ0nOLO3kAfuln1ujjjFrx
 +zcPr38B5XBNGTMkbb5cbZ87U5T1hYzwMhQ6p9VEL0NPvL+V0/ruNDGEBM0Mxa4zuTlBdll0
 4MRQ2OPAquXMKPItl+I4/oiLPOWZI8Wojn9LuIq5+T1gHAjhV8debOm3YANZH+kH/VqO1+Zb
 mb0gtcdDWcKuRIzTPbqiVKYVz5ffWyyX6Un6T4lEoKmEZzDS5u3j7yb2Se3BIFZZmdDClyUC
 3fna52EW+sQaCKVOsJhlj0EVb68S44uzB2usQr6xqFkLurK4CIXqZHj2MJy5+3JmhE+7SZ0A
 NiF02GRU2F0mXsFSCU13KBnpExw0VOD0al+g/xFGt1f/v1JUgAnNZ7a0uN1EczyWgPGftePU
 lqmRc+mAT4pQtIr39AOe1p9G8mljh3bwiWlGaEVl72WC5Ev6KLTwWX+J8ZnxHbazqUuk14mQ
 s5XOW28mqF/7xTTB5LOk0iBk6aqdKIc3DPC9WuazmqBoltYUAhuXqXBRn0feETWosrj5k/YT
 L+hF64nMg1fxs6GMKdKbcfpjVpeSPf5JNvee36xm3u3BRuQ3bOMcJDldH4Z3CrDE0UEjQ8T8
 micNQQkBSeuvXjeDDpwGlLreU/s9vN+qHyjQk8y1A6Fd1dh2Kat+h4JmfycTOse07MctCg8q
 DV0HVO90srOBdSPqQVvYrlSbM877gQP6WWMmwVjP5DoD6FmilMYeR5+uU+mgxl+FIRMudIno
 HMj0Ex5LqfOg31bcDbN5Z3sIPXpI29R/1j7YrTV01TXyv6f5qMG87IzuQOw70mSCkM+/iA/g
 JFu2HyG68CPVVJKOa8=
IronPort-Data: A9a23:L5TdB6kPWDU5gS8zSkzIeM/o5gy1J0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIYCGnVOPmOYjH8eY0nPorn8UlSuZfQxoNiSQM++ythQltH+JHPbTi7wuYcHM8wwunrFh8PA
 xA2M4GYRCwMZiaB4Erra/658CQUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dga++2k
 Y20+pC31GONgWYubzpIsfPb8nuDgdyr0N8mlg1jDRx0lACG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaPVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 ONl7sXsFFhzbsUgr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXADsXQTSOnMam+q+QGspJotUBDZXUObpK7xmMzRmBZRonaZ/GBr7P+ccBhHE7i8ZSB+vbI
 cELAdZtREieJUcSZxFNUs94w7jAanrXKlW0rHqcv6k+5mHJ5AVt1LH2dtHHEjCPbZ4MwxbA+
 zieoAwVBDkfMpu7kjCCq0nzm+XIjXz5YqhMDeCRo6sCbFq7gzZ75ActfUGqqP//kEm0VshDM
 GQd4C9opq83nGSvT9/gT1i9pVaHoBcXWJxXCeJSwAiO0q/85wefG3hBQDlcbtAvqM4xQ3otz
 FDht9/gGz1jmKeYRXKU6vGfqjbaESwUK3ISICwJVw0I5/H9r4wpyBHCVNBuFOiylNKdMSrsy
 jqOoQAgiLgJy80GzaO2+RbAmT3Em3TSZlJroF+KAyT/tF4/O9HNi5GU1GU3JM1odO6xJmRtd
 lBf8yRCxIji1a2wqRE=
IronPort-HdrOrdr: A9a23:cscW9qOK8oYF68BcTsyjsMiBIKoaSvp037Dk7S9MoDhuA6mlfq
 eV7ZAmPH7P+VQssR4b8+xoVJPsfZqYz+8T3WBzB8bAYOCFggqVxehZhOOI/9SjIU3DH4Vmu5
 uIHZITNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3AqVCDg2gQGjzfzq+ZpKvTzMsypjJueWfy6HrLB1+?=
 =?us-ascii?q?CFE05a5ixWH2xpJxhqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9qR+8gw5lGmyDi2RAAZyvwLV+rKaqKGoT2RWm5J?=
 =?us-ascii?q?fgJaZPytgZDWnpmquH6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,249,1739833200"; 
   d="scan'208";a="315805207"
Received: from unknown (HELO gm-smtp10.centrum.cz) ([46.255.225.77])
  by antispam21.centrum.cz with ESMTP; 29 Apr 2025 16:45:50 +0200
Received: from arkam (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gm-smtp10.centrum.cz (Postfix) with ESMTPSA id 15D7780911A0;
	Tue, 29 Apr 2025 16:45:50 +0200 (CEST)
Date: Tue, 29 Apr 2025 16:45:47 +0200
From: Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
Message-ID: <2025429144547-aBDmGzJBQc9RMBj--arkamar@atlas.cz>
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>

On Tue, Apr 29, 2025 at 04:29:30PM +0200, David Hildenbrand wrote:
> On 29.04.25 16:22, Petr Vaněk wrote:
> > folio_pte_batch() could overcount the number of contiguous PTEs when
> > pte_advance_pfn() returns a zero-valued PTE and the following PTE in
> > memory also happens to be zero. The loop doesn't break in such a case
> > because pte_same() returns true, and the batch size is advanced by one
> > more than it should be.
> > 
> > To fix this, bail out early if a non-present PTE is encountered,
> > preventing the invalid comparison.
> > 
> > This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
> > optimize unmap/zap with PTE-mapped THP") and was discovered via git
> > bisect.
> > 
> > Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> > ---
> >   mm/internal.h | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/internal.h b/mm/internal.h
> > index e9695baa5922..c181fe2bac9d 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> >   			dirty = !!pte_dirty(pte);
> >   		pte = __pte_batch_clear_ignored(pte, flags);
> >   
> > +		if (!pte_present(pte))
> > +			break;
> >   		if (!pte_same(pte, expected_pte))
> >   			break;
> 
> How could pte_same() suddenly match on a present and non-present PTE.

In the problematic case pte.pte == 0 and expected_pte.pte == 0 as well.
pte_same() returns a.pte == b.pte -> 0 == 0. Both are non-present PTEs.

> Something with XEN is really problematic here.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

