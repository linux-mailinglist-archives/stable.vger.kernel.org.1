Return-Path: <stable+bounces-93610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB69CFAB2
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 00:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654BEB26B01
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 22:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F331E5738;
	Fri, 15 Nov 2024 22:07:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00B118FC85;
	Fri, 15 Nov 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708451; cv=none; b=PZAiANQV9rhR5F9GLLCzBKgHv0ssV6EOZ/VV97kGgqROoU4uwjgNU9dlHbeRJ8nxEyBSBZsU8HYo//IDeMQwhn0BNIfWHnTMTODJ7PVr6uYrYuwWKZ9X7akEUIUc0lhdkCwPH/mEZMEunk93n5aS/6mWI4Lo3zXy9mzWADE6fb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708451; c=relaxed/simple;
	bh=S1gbOZnwHTkvKX7h3+VujJFAcGcCLknMJrBJYnSZHuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDwTa0eAbGg+AIuKwrS87qOAk6vxdGtE6f5m57g68fiZ2+nRPfzBlHFKIWlwUW6S5x/yCQrFkcV4AxTMKpoWmtt9WTj0NKPG3wV5bd2TkrNQvcYtOfvS5AK7OlUI+qBIfPJE0kagnYsFujHw5ata4S8FRw+9ylpHy8M69Ef7t2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tC4SE-0000000046q-2vQ1;
	Fri, 15 Nov 2024 17:06:14 -0500
Message-ID: <8dcc96f65ebbcb5d26d18342b0dffda6acd77b91.camel@surriel.com>
Subject: Re: [PATCH] mm: Respect mmap hint address when aligning for THP
From: Rik van Riel <riel@surriel.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: kernel-team@android.com, android-mm@google.com, Andrew Morton
 <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Yang Shi
 <yang@os.amperecomputing.com>, Ryan Roberts <ryan.roberts@arm.com>, Suren
 Baghdasaryan <surenb@google.com>, Minchan Kim <minchan@kernel.org>, Hans
 Boehm <hboehm@google.com>, Lokesh Gidra <lokeshgidra@google.com>,
 stable@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Jann Horn
 <jannh@google.com>, Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 15 Nov 2024 17:06:14 -0500
In-Reply-To: <20241115215256.578125-1-kaleshsingh@google.com>
References: <20241115215256.578125-1-kaleshsingh@google.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Fri, 2024-11-15 at 13:52 -0800, Kalesh Singh wrote:
>=20
> To restore the expected behavior; don't use
> thp_get_unmapped_area_vmflags()
> when the user provided a hint address.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Hans Boehm <hboehm@google.com>
> Cc: Lokesh Gidra <lokeshgidra@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries")
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>=20

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

