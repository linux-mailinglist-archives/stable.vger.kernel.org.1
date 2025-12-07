Return-Path: <stable+bounces-200288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB8CAB45A
	for <lists+stable@lfdr.de>; Sun, 07 Dec 2025 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9416B30056E3
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645B2EB85B;
	Sun,  7 Dec 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT1+hQAf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDF2BE63A
	for <stable@vger.kernel.org>; Sun,  7 Dec 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110289; cv=none; b=KINWAeNdmx8t8pIMyBxh/z/9LXEZmr1f6D+VeP7wJGUHBT6XfHBkpf/nUDm5Kmk8di2zQMz1TwlYRvz+JO38+RdtMYMyHPiAUmhEqkCxsRMt9tctrwepLcgTywz+D3ysguSRHSn5lI92+orQY0Bgko8dWwiGBO3EeYfVtr72MeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110289; c=relaxed/simple;
	bh=77jv+KFNbqJ5gbQ0yMtkfIpBkMu3Ba/WQ5SaNdqlD8M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jU7S2ELrfHI4Aa5v4IRgaes79A9eXrpjXMzl9s55pf8187pOrdG2ifUnXQxzGuiWU4GZdw4BjsiON+xZq41LOEVSBg64rNDh7oy1kO0dSxqJd4POy3Q1VyKQnjjxl2DI5YCRqplp90edkjeQu2slg93S8Q3S3H5jvdwCyBuAqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT1+hQAf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47789cd2083so21326835e9.2
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 04:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765110286; x=1765715086; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl1kkKhpVPyl0p4GnJfcedu4IBpEFqXBvrIdqh+PkaI=;
        b=LT1+hQAfwlW2c1/a8FNWnMauIRpNTRgnK2orwZt33pqd7j50o/fDk3aWE7xJljq7Md
         ioKuJJk1R4KrbIAXlsh7Ak0oUyL58ZVfIPJpmlaWH/If2a7d5G2NgEujgE/g3aFcagry
         BaTe1E2Fe8m31afbOB0ic2Ku+DfAIOnau1gIPp9jf45aDMRAOT+/CLFN+q3wtdVzaIRk
         tpfmDEv3vhu3jFwkx5mQwogzTDaP+J50eT695UQ1PiFl5h+IfqB9fPrKN+iwXkLQ+7ql
         X1M26hFbNCkJKUgI4Kh5XnfU7kE9ZVQm7vNBZrwJJjhgxsK28c2rSFOLxp6ImRPNDlhP
         Ymqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765110286; x=1765715086;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fl1kkKhpVPyl0p4GnJfcedu4IBpEFqXBvrIdqh+PkaI=;
        b=gOyWWY0DrWFcfSs9fGSmxs7iIRTTRJ2kxKL69rn6M4NbOuDlg8Px331DPS+GXGq3X7
         2kzWHRBSy208w8J1W68jekSO9a7L/fvBzQY00Clrhde4GWfTnR172wLA9mfV6fflA8Hh
         OHBZye+NVfdF6WRwJ/Z/nmhhXKHA5i5Z5q0chkF3UsGvwApmUNyzJK/+ZkTaiZTHbSg6
         YVtNSfopY1GNYZTCJo0SodIrN5TYvdJQjoMe6B/N4L2oTFoFFXSdV2GKoxl9ouDO21Gm
         cTGaaMy1g76dzLe0l7JyYicUXT7KCiqq+cDNfbJn79kOpWstO0DKy8UBiujBfnRRWzBC
         pIfw==
X-Forwarded-Encrypted: i=1; AJvYcCX7cnbT42tKPtRkK5KCehaFAT2om1HIJ3GzhYCX7vg8a3zoq1WsQWWX3xBTSK2oWntQPUTh4Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHRciyRgyXGydN2l0eYJiiLsHFGSCEIovd2eG9bzg0nVi5nhD
	JPfgnNeHxBpFwF+pBiwK48aXr19JYEPS2dDyO4di0x5E4TFHu4iZox6f
X-Gm-Gg: ASbGncv4Yot9n33kHF5p9x4jh44APzzQZjb6ixFQGQqKIEQtnjSFAFch8UGTHu45jo3
	bBF2MYeSEVtWP7sLxJtErUg5GcswbhzeltyoTqMk7oGv86sI+kYaI7OO4Q/SjFaa1uFApI2KTug
	/SIat46aQgWEGFQesKQ63Ek2GXgQZQsc++kbU7je9+TA39v1r88wQd62jxXvpw+DqWarXdgpzIV
	2qzL9/2mpdS8olomTGbxA91U/mF4nJgdaoW0Uf2+KFR7+z8I5wvqT1HaNPOSxnWBjpWqpuWmA13
	2qo2/rdc9+cg9qnrQfATvk2Q5OoSSq+bSyTaVhW8uZY68Kk3HJMS7VB5/Ew3wvCMthv3vNyPsOJ
	O6XafMm7YIJuAe9qyPsb/I3dNMqmgy9U2dmiM0I+7HrEQI2XMVcFZklNp5q1z80+Iyn2m8DaQ60
	oEH5TqcdLVmhJAE5L4Yy+E/YccWwr/2ONxDtybwH6pXg==
X-Google-Smtp-Source: AGHT+IFYNytRWOoRWAn3wuIAxlT2l9Sf9Gj3BBpCG6lKrrYKjNp1jrrzXLs8UNkcqC+phor02o5mjQ==
X-Received: by 2002:a05:600c:19cf:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-47939e3a6c6mr53136075e9.24.1765110286247;
        Sun, 07 Dec 2025 04:24:46 -0800 (PST)
Received: from smtpclient.apple ([212.59.70.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47933aef61fsm148718095e9.7.2025.12.07.04.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Dec 2025 04:24:44 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.200.81.1.6\))
Subject: Re: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <0914A8DB-447C-4E62-B151-62E5E4E99749@gmail.com>
Date: Sun, 7 Dec 2025 14:24:32 +0200
Cc: linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-mm@kvack.org,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>,
 Laurence Oberman <loberman@redhat.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9D5EFFF-05D9-435C-96C1-4B13134E2904@gmail.com>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
 <0914A8DB-447C-4E62-B151-62E5E4E99749@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
X-Mailer: Apple Mail (2.3864.200.81.1.6)



> On 7 Dec 2025, at 14:15, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>=20
>> On 5 Dec 2025, at 23:35, David Hildenbrand (Red Hat) =
<david@kernel.org> wrote:
>>=20
>> @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct =
mmu_gather *tlb)
>>=20
>=20
> @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct =
mmu_gather *tlb)
> 	tlb->cleared_pmds =3D 0;
> 	tlb->cleared_puds =3D 0;
> 	tlb->cleared_p4ds =3D 0;
> +	tlb->unshared_tables =3D 0;
> 	/*
> 	 * Do not reset mmu_gather::vma_* fields here, we do not
> 	 * call into tlb_start_vma() again to set them if there is an
>=20
> I understand you don=E2=80=99t want to initialize =
fully_unshared_tables here, but
> tlb_gather_mmu() needs to happen somewhere. So you probably want it to
> take place in tlb_gather_mmu(), no?

To clarify my messed up response: the code needs to initialize =
fully_unshared_tables
somewhere during tlb_gather_mmu() invocation.



