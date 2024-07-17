Return-Path: <stable+bounces-60486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7682093439B
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B4C286BF1
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451939FFE;
	Wed, 17 Jul 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Op4RU/zR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC10282E5
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250073; cv=none; b=BrHcvnRWj+6+ut6DUZTlgcKs8qSJbmwRlhqAoqNoqGzt9kVqcCAEhf2KFVpSNHHJelm87Ld2p9CtcK+Iy9nNJpZczk4HH2a4OxDXjFbpmBBQlZXfkH3m+3tL8y2RoDuP+AwN40mkcdU4Io0EUsFCebZCTbU4MjJSdEl3VAkK55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250073; c=relaxed/simple;
	bh=Qa2XvP+C/3oeccCjHgfKummAIm8e+1hP7Ck2ED7Kxsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvfOhZw7H5UAFU7K6z26FJlf0aB4C7ezixky0w0JB9XElosygxukt26AdInexjkOCGcvEtfZPf0ETFqTuNWYka+Y8JdL8oXZ9UQBNEXVHbL3m+ZLZIIHbOkgrCv4o6UQn3UGj/SCzb8XwHpvigF6BwQtCqcXlrQLYmgwKOZ8RDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Op4RU/zR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-663dd13c0bbso584957b3.1
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721250071; x=1721854871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa2XvP+C/3oeccCjHgfKummAIm8e+1hP7Ck2ED7Kxsg=;
        b=Op4RU/zR1h4pGG3zH2oUufMmw/Qvkyo23R0IG5DSTA3viLXtxMbSRrLJ3RJw7db9m7
         UJnra/Uh0XCFqKCSIlD6/0AknwsmNDPrP04/MabjrJxu6GAm21reLUdK2FaxClv+UVPt
         xDMZuiZgJ8IpHxfqsn10tcOXGxTJuwN11hqh1iT+uH+4l8FF6zCmxCyElOAP1DogCJ+y
         0cKtX0tMRc/DUSu30aJP/tBlM+wm6BZrQuL096GE3peSyT0KAugz3vOl0MNYxTuCgAgO
         xUaj4d4bTK5y0eWIWiXCmlOgbhIrP/Awf8qlmEs1Ix42rHNoyYmAVFNbiCBJL3qM6cwq
         rcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250071; x=1721854871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa2XvP+C/3oeccCjHgfKummAIm8e+1hP7Ck2ED7Kxsg=;
        b=rC5JEJN0ZzcUL8OsHmE89vXapkT0Cdfab/M23hXKhqgiwICdohZXD5Caz4iaOC0Gc7
         CZHSZX1spX6EX6GQcgTkxDg8N+oBWnqEcOb7IKMaueUCHGXuyBdRp/F2nN3i4H+tPjAH
         Gg+5qtUw9w+LSp5yUAOSEgpNiVNrOk1gQ2iAibHzx84uM1qqwCdOquI7g6rTe8dPKgBE
         4+n+z9nAMykSADVvmkEdlqJX8Enk6aglnBsPPK8sBYuyMCWJrwOPFKUYzReIBXmI70NE
         vKBSaydg2syoKit3wsfu3sQCMJFG8Z+1GQxVclMY1d20L1+WlTLaInTU637QhHEptjrW
         ATIg==
X-Forwarded-Encrypted: i=1; AJvYcCUbX3Z4VP8/VGWwv9yjJD2bb3ugmmeV/nNkI4+MscNSPBYbGYv5Gk7gjiZ0YhodOwxwWL48Hc8+FkyyU1wGlhw1j2cAHRxx
X-Gm-Message-State: AOJu0YzET+wLYLbJJv6DxY+ZfQqYZmfLQsh3TuLnkwZmFWkQzrmy2fEY
	Oe8MXgT0mkUWg1wvc5wSQBywp2ZE4lxfuWJ/E8cRhPBdpiAPFb9MdBeo4UQr0Y4Po5hLnm0xEXp
	qF7r+InduYUGzimRA6aKUh7izgJd12yiCwHGRE9LcVHawxV2Biw==
X-Google-Smtp-Source: AGHT+IHdAN8Zygajofm83EFiNsxZUGRZYcOfrMblNz/bnqG3bIIRWIxc/dHHBoQXgnAbK/ILfo8V2BUbVMDkWG5u0/k=
X-Received: by 2002:a05:6902:1502:b0:e05:fa51:9f89 with SMTP id
 3f1490d57ef6-e05fa51a28dmr2191237276.22.1721250070367; Wed, 17 Jul 2024
 14:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Wed, 17 Jul 2024 14:00:56 -0700
Message-ID: <CAMGD6P1E+hoH_HGhmBvXskMgNvALYiNj-dhJWvzQuTx4sd1SxQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted memory.
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:00=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Unaccepted memory is considered unusable free memory, which is not
> counted as free on the zone watermark check. This causes
> get_page_from_freelist() to accept more memory to hit the high
> watermark, but it creates problems in the reclaim path.
>
> The reclaim path encounters a failed zone watermark check and attempts
> to reclaim memory. This is usually successful, but if there is little or
> no reclaimable memory, it can result in endless reclaim with little to
> no progress. This can occur early in the boot process, just after start
> of the init process when the only reclaimable memory is the page cache
> of the init executable and its libraries.
>
> To address this issue, teach shrink_node() and shrink_zones() to accept
> memory before attempting to reclaim.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Jianxiong Gao <jxgao@google.com>
> Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> Cc: stable@vger.kernel.org # v6.5+

Tested-by: Jianxiong Gao <jxgao@google.com>
I have verified that the patch fixes the systemd issue reported.

