Return-Path: <stable+bounces-36159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481F89A790
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 01:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13F32843FB
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2414364BF;
	Fri,  5 Apr 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5Yekg7L"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76C36121
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712359167; cv=none; b=XCDgKInTE3S6kCTDHvu8bT3h7ff2g4xTZ2hQWMStLRg8hgW0b8nczkEFskvE9zzdn7S7kivq89CoUlsNP4anIRJq3OyZdtTQ2k/+YomYpPTv5VYx6SqzyOC3rO7r4NODoVTDIv8EgqOqzZf6pJesDYqkkP2WOiiNuxzs1yDmUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712359167; c=relaxed/simple;
	bh=nTD0gkfW1v3gofTr/mokto28ytoGlLof1Sal1Q1071Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPopgshnQZPf/XoMV7p1nCRxg6iZ0Tgh7hZ0UKiT3izP3iCiPSMDmCnvUydslqUYjnu+JySfHDwPIyn3f8IowvyjaD0YkCFKOenuhBqNPZHM0bGh21FW71m6Nk/bWys3pM4gSsoZ0JVuHvYXHx9uuW6w7CG7vSo7bS7rJLxSyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5Yekg7L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712359164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HKzTrJInktvfKVrY1P9Lu04jr4tbB0gdRSWQZFOhm8U=;
	b=F5Yekg7Lgc/m3SeOuxUVQsvH64Jpw/bnuPmbqnF6x0SRunkwlM7rie7xIeuzPzrwSrdwpH
	MysfPIibsHxJf45qN9vv2liPsyxgIprHp/D3EczF4m2bTqkQLRcsJkSnC8p9UvhKX61pfC
	2sNPdGLSXKJhkJFfye5pcGlhN6jjivU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-x8IZ_-YwPMuPad5afvblBw-1; Fri, 05 Apr 2024 19:19:23 -0400
X-MC-Unique: x8IZ_-YwPMuPad5afvblBw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dea8b7e74aso796735a34.1
        for <stable@vger.kernel.org>; Fri, 05 Apr 2024 16:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712359162; x=1712963962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKzTrJInktvfKVrY1P9Lu04jr4tbB0gdRSWQZFOhm8U=;
        b=WYR486njGnHlfHydycIxCvKFf9atdUOCUuyYG3hlkjT1fjt+eKY8l6Ag/a4t/b0cC5
         GVvBuIv3TjKBcPwJe5hKX0FJCybKIEcfkGx37TIB1gSnBk0bhhL0ag1UR6UywYtNOqKo
         APIxtXFTtl+F7fdfjJNM+F/0R+XAoO8w1X13ENTrdEn8VCoNiMfjF8L27vGk8RDnkixx
         +d7PaS9Vrh+PFEOORhgeCt7N7sYS4zZFWBVPUbz3Ei/qt5l7mjjpuLEudkJ9yQiXHuTI
         k+i1LKfy1wZz8Ihk5BIIP+bkP8js3gkW5NRbQcn1E5dnfrMpx6UunVh0ZJx5c6RpsRbA
         DsJg==
X-Forwarded-Encrypted: i=1; AJvYcCURJBH/co9DjYg0EzoHJKy7S0j8K+8tReyMArpRxx5KIPDeyc5VJ74DzHBaoCuHoCeXjc6gCu5W/Qw1GbDpY365CXICnZAO
X-Gm-Message-State: AOJu0YzsBhvAPBkRXczPvaXSUuvGWCpF39bic0Vce0IzxX7R2N4xbszp
	yv/gH8ITW10JEKVUXeL8D40dgurP86uZKdb47SDsp2IZIP5ip9557cHwlhhCoGONNz13NuadG+J
	EQenNuj0amj+plSr38qzz5C3iw2bx0mM8cLp8jAExhVlIvVsRyZOI2w==
X-Received: by 2002:a05:6808:2385:b0:3c5:dc47:99e9 with SMTP id bp5-20020a056808238500b003c5dc4799e9mr3109023oib.5.1712359162423;
        Fri, 05 Apr 2024 16:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfjPnSmiyv8P7CJzOP7HOWBiDhIEG/B6ZJWV2xwl0fun8uJUpqbxe6oOulVbdccni8vhEdEA==
X-Received: by 2002:a05:6808:2385:b0:3c5:dc47:99e9 with SMTP id bp5-20020a056808238500b003c5dc4799e9mr3109003oib.5.1712359161965;
        Fri, 05 Apr 2024 16:19:21 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id fb17-20020a05622a481100b00434383f2518sm1201198qtb.87.2024.04.05.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 16:19:21 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-stable <stable@vger.kernel.org>,
	syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com
Subject: [PATCH] mm/userfaultfd: Allow hugetlb change protection upon poison entry
Date: Fri,  5 Apr 2024 19:19:20 -0400
Message-ID: <20240405231920.1772199-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

After UFFDIO_POISON, there can be two kinds of hugetlb pte markers, either
the POISON one or UFFD_WP one.

Allow change protection to run on a poisoned marker just like !hugetlb
cases, ignoring the marker irrelevant of the permission.

Here the two bits are mutual exclusive. For example, when install a
poisoned entry it must not be UFFD_WP already (by checking pte_none()
before such install).  And it also means if UFFD_WP is set there must have
no POISON bit set.  It makes sense because UFFD_WP is a bit to reflect
permission, and permissions do not apply if the pte is poisoned and
destined to sigbus.

So here we simply check uffd_wp bit set first, do nothing otherwise.

Attach the Fixes to UFFDIO_POISON work, as before that it should not be
possible to have poison entry for hugetlb (e.g., hugetlb doesn't do swap,
so no chance of swapin errors).

Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-stable <stable@vger.kernel.org> # 6.6+
Link: https://lore.kernel.org/r/000000000000920d5e0615602dd1@google.com
Reported-by: syzbot+b07c8ac8eee3d4d8440f@syzkaller.appspotmail.com
Fixes: fc71884a5f59 ("mm: userfaultfd: add new UFFDIO_POISON ioctl")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8267e221ca5d..ba7162441adf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6960,9 +6960,13 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			if (!pte_same(pte, newpte))
 				set_huge_pte_at(mm, address, ptep, newpte, psize);
 		} else if (unlikely(is_pte_marker(pte))) {
-			/* No other markers apply for now. */
-			WARN_ON_ONCE(!pte_marker_uffd_wp(pte));
-			if (uffd_wp_resolve)
+			/*
+			 * Do nothing on a poison marker; page is
+			 * corrupted, permissons do not apply.  Here
+			 * pte_marker_uffd_wp()==true implies !poison
+			 * because they're mutual exclusive.
+			 */
+			if (pte_marker_uffd_wp(pte) && uffd_wp_resolve)
 				/* Safe to modify directly (non-present->none). */
 				huge_pte_clear(mm, address, ptep, psize);
 		} else if (!huge_pte_none(pte)) {
-- 
2.44.0


