Return-Path: <stable+bounces-111117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D5EA21C96
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 12:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A458164FB4
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915021D934D;
	Wed, 29 Jan 2025 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPNZ8zRb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994801B6525
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738151662; cv=none; b=ged6ajJnMjMAv/6lE1KnNx7tSt+n/9l6dKgFf7inBRYyAvo73U0bFiGOE5TYRVBLx3qzhoZVjLEmjhN0+vFzAtzazi3b0j878yYI3PVIAgwAxgjqwlddxUHKluKIgL0uV8sNNZlssnhNABwP0/ZCdIbO+ZCjEB8/HCGL4EeYD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738151662; c=relaxed/simple;
	bh=PG/xepVkoE6TFwAOUblN1JhI4fKfhg5uSEiV2p9fFEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvlBq2A2lNhKlfc08Np0fBr70b0wlNAujV3pwhwdUfKces6mkcv+ncx8iEggvNZaHDBqxdtSq+07O66CcIGa655l+s1aIM+PcitXVyx/aLYO+IJL3vS2sGBC2Pf67QXvMLSdV1BamIrxmBi28Y4M9TDk7LMcDBK7XrS5aiIzLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPNZ8zRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738151659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZQr+sWP4JJuuRk9zHd8B8Ps+AYS2S2IVxxQCmOGAGE=;
	b=CPNZ8zRbb8uLWAnCXZTLRWjjPtPmGi4mtQaeeZvrfI+TY80P4RFVUAUpUly50IvY36XEi4
	X0NhOPZwxEFEs42/aWPriPDiyXW6c0lfh2W+pus06vC8JE0PQNh7Sm5MCpxEeLHvcOz2be
	v/XLl0vVEdHVcF1gtk0UysAwr/04Dfs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-lQ5KmVl-P_2gV1mb52F0OA-1; Wed, 29 Jan 2025 06:54:18 -0500
X-MC-Unique: lQ5KmVl-P_2gV1mb52F0OA-1
X-Mimecast-MFC-AGG-ID: lQ5KmVl-P_2gV1mb52F0OA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361b090d23so34439185e9.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 03:54:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738151657; x=1738756457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZQr+sWP4JJuuRk9zHd8B8Ps+AYS2S2IVxxQCmOGAGE=;
        b=kVukIF/T3f8Z+t/2RQxdjt5HaeCLIu0mvvxOtCsThSEp8iVBJPi47p4sDk+7f8J6re
         g5RLkAdqxQFjEHzM8hYtRZz8CQs6G2P+Fib3XXjeQKXnRiZkfhD/Y++1APYs8/cdrqn+
         GB+i4MTID2jkxMEuPchbMm2R8LI+uHSt/iVJMyQk40lsmlZ+UyLUsOb3wYFcn2gFVcvx
         tt9e3Y20afzEhy8i5/PU53vsRKhs4XEuf+Q/NR2bXJU/poCNWMl+ztzbYZqzMQKaLYf0
         adzBoooz43bxT8AyELtoepf+Ccrd9Ql0hpG+GBW30a+LW7TL6oid9K0zp8qVEO16dKmu
         G+2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5r4G/Ao34+eL6alwRAWGglFFXYQiwXD9zgEV3sSfRje1Ju2k+PBZcQBMEwVWIihirrmW7c4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhxB0P+rIGk+ID2Ei70yh+Av+t4QU3ccU3+A8898T5Z+MkjuDq
	XMN8XyIIBEq8uIB9TMWPpnIdGAH0FQWjTxvQjK4WMtaefrWrrxL2Xvm5F0emkcV6FvdsjpqjOan
	6M5/Ul215KitET/RratHerzlj1n1q57By22jf6O2P18f5eCS/IvYKrw==
X-Gm-Gg: ASbGncti4pPhiPLu6Qq/5yl+bMC0iwWoKpP9pCGhHGTjCqfJI4kIEx77vxiPJVLCDqR
	3vQ1cqIX11ShyeLeO+XJ93/MyDSHqUrMyVcoMqqWTJYoxm8s5jdWVjhDy06k1SXJ++Qhfe1AjoW
	YdUMJ9BqKo5g4p8jU/smnYD3pdwngdQMa+d+7QZZsX3GXYBW4TmtHVAo8gxPD574PwOK1WTDYpU
	Vjbokhv+mjy9S+7zVIMm3GPjxxacZSx1+I/7Y/3XKyw06DgY5rIzdeXPjhO2gnK3S2nbRqgUToy
	+gB+ol2szcFaAS5MH5WXY4nfHfnJZbSjY5KvQX6LGP7lrpXaxCi+BjbQtci67RJRsg==
X-Received: by 2002:a05:600c:cce:b0:434:ff9d:a370 with SMTP id 5b1f17b1804b1-438dc3366f8mr24658405e9.0.1738151657103;
        Wed, 29 Jan 2025 03:54:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIkSHUg8u1CZ6d8yOIa8EuB96MLk/b/TKJcDJCOFvAxggFPdf4ivg/UC1RFEcPGInF41YvMw==
X-Received: by 2002:a05:600c:cce:b0:434:ff9d:a370 with SMTP id 5b1f17b1804b1-438dc3366f8mr24658175e9.0.1738151656750;
        Wed, 29 Jan 2025 03:54:16 -0800 (PST)
Received: from localhost (p200300cbc7053b0064b867195794bf13.dip0.t-ipconnect.de. [2003:cb:c705:3b00:64b8:6719:5794:bf13])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38c2a1bad92sm16868229f8f.61.2025.01.29.03.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 03:54:15 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 01/12] mm/gup: reject FOLL_SPLIT_PMD with hugetlb VMAs
Date: Wed, 29 Jan 2025 12:53:59 +0100
Message-ID: <20250129115411.2077152-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250129115411.2077152-1-david@redhat.com>
References: <20250129115411.2077152-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only have two FOLL_SPLIT_PMD users. While uprobe refuses hugetlb
early, make_device_exclusive_range() can end up getting called on
hugetlb VMAs.

Right now, this means that with a PMD-sized hugetlb page, we can end
up calling split_huge_pmd(), because pmd_trans_huge() also succeeds
with hugetlb PMDs.

For example, using a modified hmm-test selftest one can trigger:

[  207.017134][T14945] ------------[ cut here ]------------
[  207.018614][T14945] kernel BUG at mm/page_table_check.c:87!
[  207.019716][T14945] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  207.021072][T14945] CPU: 3 UID: 0 PID: ...
[  207.023036][T14945] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
[  207.024834][T14945] RIP: 0010:page_table_check_clear.part.0+0x488/0x510
[  207.026128][T14945] Code: ...
[  207.029965][T14945] RSP: 0018:ffffc9000cb8f348 EFLAGS: 00010293
[  207.031139][T14945] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffffffff8249a0cd
[  207.032649][T14945] RDX: ffff88811e883c80 RSI: ffffffff8249a357 RDI: ffff88811e883c80
[  207.034183][T14945] RBP: ffff888105c0a050 R08: 0000000000000005 R09: 0000000000000000
[  207.035688][T14945] R10: 00000000ffffffff R11: 0000000000000003 R12: 0000000000000001
[  207.037203][T14945] R13: 0000000000000200 R14: 0000000000000001 R15: dffffc0000000000
[  207.038711][T14945] FS:  00007f2783275740(0000) GS:ffff8881f4980000(0000) knlGS:0000000000000000
[  207.040407][T14945] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  207.041660][T14945] CR2: 00007f2782c00000 CR3: 0000000132356000 CR4: 0000000000750ef0
[  207.043196][T14945] PKRU: 55555554
[  207.043880][T14945] Call Trace:
[  207.044506][T14945]  <TASK>
[  207.045086][T14945]  ? __die+0x51/0x92
[  207.045864][T14945]  ? die+0x29/0x50
[  207.046596][T14945]  ? do_trap+0x250/0x320
[  207.047430][T14945]  ? do_error_trap+0xe7/0x220
[  207.048346][T14945]  ? page_table_check_clear.part.0+0x488/0x510
[  207.049535][T14945]  ? handle_invalid_op+0x34/0x40
[  207.050494][T14945]  ? page_table_check_clear.part.0+0x488/0x510
[  207.051681][T14945]  ? exc_invalid_op+0x2e/0x50
[  207.052589][T14945]  ? asm_exc_invalid_op+0x1a/0x20
[  207.053596][T14945]  ? page_table_check_clear.part.0+0x1fd/0x510
[  207.054790][T14945]  ? page_table_check_clear.part.0+0x487/0x510
[  207.055993][T14945]  ? page_table_check_clear.part.0+0x488/0x510
[  207.057195][T14945]  ? page_table_check_clear.part.0+0x487/0x510
[  207.058384][T14945]  __page_table_check_pmd_clear+0x34b/0x5a0
[  207.059524][T14945]  ? __pfx___page_table_check_pmd_clear+0x10/0x10
[  207.060775][T14945]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[  207.061940][T14945]  ? __pfx___lock_acquire+0x10/0x10
[  207.062967][T14945]  pmdp_huge_clear_flush+0x279/0x360
[  207.064024][T14945]  split_huge_pmd_locked+0x82b/0x3750
...

Before commit 9cb28da54643 ("mm/gup: handle hugetlb in the generic
follow_page_mask code"), we would have ignored the flag; instead, let's
simply refuse the combination completely in check_vma_flags(): the
caller is likely not prepared to handle any hugetlb folios.

We'll teach make_device_exclusive_range() separately to ignore any hugetlb
folios as a future-proof safety net.

Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 3883b307780e..61e751baf862 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1283,6 +1283,9 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
 		return -EOPNOTSUPP;
 
+	if ((gup_flags & FOLL_SPLIT_PMD) && is_vm_hugetlb_page(vma))
+		return -EOPNOTSUPP;
+
 	if (vma_is_secretmem(vma))
 		return -EFAULT;
 
-- 
2.48.1


