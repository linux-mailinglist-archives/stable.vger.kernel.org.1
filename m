Return-Path: <stable+bounces-118782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E7FA41B95
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FFD1890D43
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50647255E5A;
	Mon, 24 Feb 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mIO5vb/+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF824F587
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394164; cv=none; b=uHE4CI/MYsb1oG4wUTFiB69Y+W37/a+6rTf9JIrCcS8SzltGvwPlokn+jObeT0VX63PeR+VWRUSSKFclApt924dgsRFpTtAJF6w99PDbSRhOFkKVTktThQNCI1jAXHcZTQEoK8hAnuhplc3bMEVPSZy7FA5mIsYnhbCgZouLz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394164; c=relaxed/simple;
	bh=O+3hc2uspzUuGySeq35PHHzR5JH/rChsfvYHdlzz6CY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loz9zAPSsosd384ojrHFqTLZ93zUy2Y9SAxMSVp2VVhTqek7P561/0NT9fSdAyGvY+XUqBGYo4wyGgVnAUN/vp3kDT77PSTf5ZFu41rLBRKxHxRnSd3bdf/Of0LCxihdFYRb3uXenhlMLwc+eYvRzuW7dCVzanRxMp0L7e/PVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mIO5vb/+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb892fe379so678013966b.0
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 02:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740394161; x=1740998961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+3hc2uspzUuGySeq35PHHzR5JH/rChsfvYHdlzz6CY=;
        b=mIO5vb/+NY+ghdyJCROBKWXlgrOt9EFtnwud0yNzMEKqFPbp2XCPxfRemWP2+Phcv4
         LCrZjo84M63NUz7mEhosk09X9pDaI9tGjegudnstUubjox1DM7yxx3LHkLZloGADuPnh
         uMkH2dczKEdmE3jWJSncwJlfdLJ6Eu6vXWl4Iaj/Jk6IRSLefagOHszyi9oqp4wbAc80
         yIvL4yLo2q3MiHe/4elv1SZBysUNis6Jy+pJWjXAZn9wAntSLwKIaSOm28o+saK++0IM
         jZOThIWsHmNFO7zGYtO1u7A+Y6RnhkVyWAUFeSk32vloi/Iy3Ae+F8myv/5LIpv2PeUf
         dU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740394161; x=1740998961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+3hc2uspzUuGySeq35PHHzR5JH/rChsfvYHdlzz6CY=;
        b=BXZr7Rw3l829VXnPII+KmFVo/fk0+3vHmH1uA1MYMH+Xz+3QzGVOE5iw69WBnJsoa2
         vN1mhbdAoHKz4GHiIADbKkyHNy4QeRf6bRkWLZ+sahMv7lR0DgnCcoVeS0MQpfqiNj+F
         MOPbbN8e5LH7Vzz3dD6bzy9Y9vpqZDus/ZheuNM3URgJ7RpqnRJu2QlIZitkys0riUco
         Uutwx0dJQZERwhfS2qdjroRSPghJ3AbGIEnJXArK9rjlSbwQYVSkHjOwiQTrbvQkIdU7
         y7RaaR92+PiEY+jNqfe9kj9MFfo5MdZPBnApFVEkPbBUyzPcJmapD8J/eI+UTBNabddV
         oL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQHRlMAKObFsHnZJYtJt/1QtcBbrfI86B939cJyl+M/ZjSsLJucbhkBYpMyLUJRBH4Fvaw/VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rJf4SizIlCwFZymQQzrPthyv/LSOEP2eyy8fliQ0zr4Vr0b7
	CjLbf9gKM/ou7gUtcKbBV9rUwPbNCkRKosau6i1NVsAJh5nh9yL9r02IAhALNXXGUj+lzjG1CzT
	o79Gl+Ws7iouk810LQ68WTPIxYmY/saQ0jOgwig==
X-Gm-Gg: ASbGncuaMusU0AhpyHQGHlw0iOwKf0EW27HJmG+/1nsTX4mWUG8n5JlYZxfT9W2Ephl
	kI5N3bKpfNWhf4KaHqNSmADJKu4ZG/C5xICyQnYtVmqas2OJq0sikt3naIdXBmdvlcdhOk6V22u
	BBF/Zs480=
X-Google-Smtp-Source: AGHT+IHHpKWXIm/v2k+338UkHDIVLeb79WjMIsWoo/8r7lA3uc+V3rq9HglSj1eZuVQogWlVvckU5UsUcnUd6gUjF0M=
X-Received: by 2002:a05:6402:388c:b0:5e0:7cc4:ec57 with SMTP id
 4fb4d7f45d1cf-5e0b7266ba5mr26764777a12.31.1740394160578; Mon, 24 Feb 2025
 02:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140419.1702389-1-ryan.roberts@arm.com>
 <20250217140419.1702389-2-ryan.roberts@arm.com> <b6341aac-8d5e-435b-b900-5c9d321a7ce6@redhat.com>
In-Reply-To: <b6341aac-8d5e-435b-b900-5c9d321a7ce6@redhat.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Feb 2025 11:49:09 +0100
X-Gm-Features: AWEUYZlGjIT4eI7eKQbJ3SHrGN78CEaD_5h64M0X3Xtov-A0DdsnodalQc20rYI
Message-ID: <CAHVXubjy+VmvmV7FLuR8y=bWc4MqKgoWp4R8hqUs8xKBN-DQcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Thu, Feb 20, 2025 at 10:46=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 17.02.25 15:04, Ryan Roberts wrote:
> > In order to fix a bug, arm64 needs to be told the size of the huge page
> > for which the huge_pte is being set in huge_ptep_get_and_clear().
>
> s/set/cleared/ ?
>
> > Provide for this by adding an `unsigned long sz` parameter to the
> > function. This follows the same pattern as huge_pte_clear() and
> > set_huge_pte_at().
> >
> > This commit makes the required interface modifications to the core mm a=
s
> > well as all arches that implement this function (arm64, loongarch, mips=
,
> > parisc, powerpc, riscv, s390, sparc). The actual arm64 bug will be fixe=
d
> > in a separate commit.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bi=
t")
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks,

Alex

> > ---
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

