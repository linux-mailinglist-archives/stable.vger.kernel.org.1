Return-Path: <stable+bounces-181682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E9B9E1B3
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D287D3B0C54
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767E339A8;
	Thu, 25 Sep 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z20Rq3pa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB8277CB1
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789927; cv=none; b=re+epWyvR6iXanGszzRGwiJAPh4GaF0eOaukSkTqGh9NrMyuq92rAJVlvdDXAn9fo08FFPaNVZ6N7emKkYxJtfR5ZU/+JGoNZCt8n9bixsedcIjLbQ5EqXo48xXz9eNMnUUKpvIAuiGs+jmS3AE0UVAMSvYJ80dTYMtObBVNeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789927; c=relaxed/simple;
	bh=tnvTI9wxhL+KOFeMtqHnkFmurT66rZV3Xne0IrhsIMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbTabKVMyB4pl+ytxAmUX3AqTaGLv6XBvaKPAuHxgX+Kgy9Vhf5kq5egF7vJcTVP7tFe8dOICKQ53eQjTKgqcZiZMcIAPB7DkBoS800Uyy8MugLzq9SUv/Ji6TTVcSCZHd5e78/nEDW1PDuYa8xLvWtH3kYmNk9AHfqdI8M80A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z20Rq3pa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758789924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXWTj/yjoOPAq6UeO3tE9io6RSG2iM/aBSBKIJ60TxE=;
	b=Z20Rq3pa7Lwr0iZ1zH/V+yNsuOUWgqjzoOb80dLmhO7NHbKNlrwNY2G4ssmqDPB+pKgdXp
	AlAzxAV275D0aBA1defAP+5bDvFzipONo8QdAjFr9A5pGf7GjpvLPmdvgxTyg/alsmmUCc
	bZg9Vy/UX81lcwKqSBpX2LT5+Yp+p44=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-txcCyadOPH6cAE-6OvsjJA-1; Thu, 25 Sep 2025 04:45:22 -0400
X-MC-Unique: txcCyadOPH6cAE-6OvsjJA-1
X-Mimecast-MFC-AGG-ID: txcCyadOPH6cAE-6OvsjJA_1758789921
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3eb8e43d556so768081f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758789921; x=1759394721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXWTj/yjoOPAq6UeO3tE9io6RSG2iM/aBSBKIJ60TxE=;
        b=JpqpS+7rncirKPfQTCsPMsi95S48wpiH0PVNeSGDtbPgUafvRnANss2Ub31Qeb3u7u
         +LE1iAncalPAjgWSUfrRIGCr7rf4PYcASl/n75JDrKAGoApMdbBgN7iiEiYVT4LF0+5m
         EuFTGVhO+U7IxzvsFQowCOZZAl/eVMv3KkzI7/lfF/91J11hQCZHBauSJ60OGYQlEXh3
         f4CaBG6YGySU3jUp0mumF5zCH9BvMuRf8ouAz0BXgORtvpphYFR9EPkgidXBKy/H6LkB
         +YU2nV8GkbLb874UDYVwVK/MpV+2MEnoDdGHq4pBXSHGZIwnX4qg26HlappPkVQf7Auv
         jnKA==
X-Gm-Message-State: AOJu0Yybwfkjj4h0hWGbeYWYgduU2oFRHWZHP3DKWnLZzr2pc7vCKp8N
	FCiH38dNczlw2yIQVW+tJW/3WupIUjHzV7zoq3YYLSnENhbsam7kjdKEUQSCX1bxYyDMBp+hBU8
	SsbC8KcLnjBdmwO7i1G3nGgGxZ5XY/ItzLQu8LArLt1vG3sHEqnAIXOd/MoFSHmcniw4tJTMnsq
	BEN6t+bB6zH7fLP/TZF6v1kpo4U1AFGtv6gnQb39IS
X-Gm-Gg: ASbGncsWtEdqvpHr5PwyOvG2vI+aTfIsaGleWo8SFE+pazy2crWtuP8KwbNHOD3tL/7
	0XgizkvUgzLZAUh55HfwLC7hRVpwmh2CSbmkqBM6Bs/nDFMuVKPeLrBzqw2mMztWySn40M4sBZw
	GM2DjEMayelhZz2CtFwAegYr0db0Ds1aEvs7bJrUNdrisF9xobpXARSwDSmSA1GNQjRs6L3IzHX
	R+8WeIPq1T3IeHAN+7L7h3FJtWQ9iPyKKTYYPVesQ2BtS+lVYCTvaUa8snNC9UrKWURkNr427xl
	Zmnv/CRGemVLnQMWv4bnaOCUID7YTggMIAJiCSV52GIsKLsGIaF4Xk6nv2WOQQv5oz98hFWUxFr
	noZDkKsCjNA6b0vepPIfCB6i5Vw==
X-Received: by 2002:a05:6000:2909:b0:404:c253:a38 with SMTP id ffacd0b85a97d-40f69ec9203mr1506480f8f.28.1758789921130;
        Thu, 25 Sep 2025 01:45:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHcL9mwBhqGWiSkjInXXSpBiC6FSEeywCyzKqbCEZ+E6knAmcc1tYAu1YNqhpk+XsmsE9KRw==
X-Received: by 2002:a05:6000:2909:b0:404:c253:a38 with SMTP id ffacd0b85a97d-40f69ec9203mr1506424f8f.28.1758789920523;
        Thu, 25 Sep 2025 01:45:20 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2a996bf1sm68443525e9.1.2025.09.25.01.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:45:19 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 5.15.y] mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:45:18 +0200
Message-ID: <20250925084518.3832079-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025022404-rebuttal-laundry-1cf8@gregkh>
References: <2025022404-rebuttal-laundry-1cf8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If migration succeeded, we called
folio_migrate_flags()->mem_cgroup_migrate() to migrate the memcg from the
old to the new folio.  This will set memcg_data of the old folio to 0.

Similarly, if migration failed, memcg_data of the dst folio is left unset.

If we call folio_putback_lru() on such folios (memcg_data == 0), we will
add the folio to be freed to the LRU, making memcg code unhappy.  Running
the hmm selftests:

  # ./hmm-tests
  ...
  #  RUN           hmm.hmm_device_private.migrate ...
  [  102.078007][T14893] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x7ff27d200 pfn:0x13cc00
  [  102.079974][T14893] anon flags: 0x17ff00000020018(uptodate|dirty|swapbacked|node=0|zone=2|lastcpupid=0x7ff)
  [  102.082037][T14893] raw: 017ff00000020018 dead000000000100 dead000000000122 ffff8881353896c9
  [  102.083687][T14893] raw: 00000007ff27d200 0000000000000000 00000001ffffffff 0000000000000000
  [  102.085331][T14893] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
  [  102.087230][T14893] ------------[ cut here ]------------
  [  102.088279][T14893] WARNING: CPU: 0 PID: 14893 at ./include/linux/memcontrol.h:726 folio_lruvec_lock_irqsave+0x10e/0x170
  [  102.090478][T14893] Modules linked in:
  [  102.091244][T14893] CPU: 0 UID: 0 PID: 14893 Comm: hmm-tests Not tainted 6.13.0-09623-g6c216bc522fd #151
  [  102.093089][T14893] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
  [  102.094848][T14893] RIP: 0010:folio_lruvec_lock_irqsave+0x10e/0x170
  [  102.096104][T14893] Code: ...
  [  102.099908][T14893] RSP: 0018:ffffc900236c37b0 EFLAGS: 00010293
  [  102.101152][T14893] RAX: 0000000000000000 RBX: ffffea0004f30000 RCX: ffffffff8183f426
  [  102.102684][T14893] RDX: ffff8881063cb880 RSI: ffffffff81b8117f RDI: ffff8881063cb880
  [  102.104227][T14893] RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
  [  102.105757][T14893] R10: 0000000000000001 R11: 0000000000000002 R12: ffffc900236c37d8
  [  102.107296][T14893] R13: ffff888277a2bcb0 R14: 000000000000001f R15: 0000000000000000
  [  102.108830][T14893] FS:  00007ff27dbdd740(0000) GS:ffff888277a00000(0000) knlGS:0000000000000000
  [  102.110643][T14893] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  102.111924][T14893] CR2: 00007ff27d400000 CR3: 000000010866e000 CR4: 0000000000750ef0
  [  102.113478][T14893] PKRU: 55555554
  [  102.114172][T14893] Call Trace:
  [  102.114805][T14893]  <TASK>
  [  102.115397][T14893]  ? folio_lruvec_lock_irqsave+0x10e/0x170
  [  102.116547][T14893]  ? __warn.cold+0x110/0x210
  [  102.117461][T14893]  ? folio_lruvec_lock_irqsave+0x10e/0x170
  [  102.118667][T14893]  ? report_bug+0x1b9/0x320
  [  102.119571][T14893]  ? handle_bug+0x54/0x90
  [  102.120494][T14893]  ? exc_invalid_op+0x17/0x50
  [  102.121433][T14893]  ? asm_exc_invalid_op+0x1a/0x20
  [  102.122435][T14893]  ? __wake_up_klogd.part.0+0x76/0xd0
  [  102.123506][T14893]  ? dump_page+0x4f/0x60
  [  102.124352][T14893]  ? folio_lruvec_lock_irqsave+0x10e/0x170
  [  102.125500][T14893]  folio_batch_move_lru+0xd4/0x200
  [  102.126577][T14893]  ? __pfx_lru_add+0x10/0x10
  [  102.127505][T14893]  __folio_batch_add_and_move+0x391/0x720
  [  102.128633][T14893]  ? __pfx_lru_add+0x10/0x10
  [  102.129550][T14893]  folio_putback_lru+0x16/0x80
  [  102.130564][T14893]  migrate_device_finalize+0x9b/0x530
  [  102.131640][T14893]  dmirror_migrate_to_device.constprop.0+0x7c5/0xad0
  [  102.133047][T14893]  dmirror_fops_unlocked_ioctl+0x89b/0xc80

Likely, nothing else goes wrong: putting the last folio reference will
remove the folio from the LRU again.  So besides memcg complaining, adding
the folio to be freed to the LRU is just an unnecessary step.

The new flow resembles what we have in migrate_folio_move(): add the dst
to the lru, remove migration ptes, unlock and unref dst.

Link: https://lkml.kernel.org/r/20250210161317.717936-1-david@redhat.com
Fixes: 8763cb45ab96 ("mm/migrate: new memory migration helper for use with device memory")
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 41cddf83d8b00f29fd105e7a0777366edc69a5cf)
Signed-off-by: David Hildenbrand <david@redhat.com>
--

Code was moved in the meantime and converted to folios. But the code
flow is essentially unchanged.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c37af50f312d9..3050dd85910a8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3065,20 +3065,16 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 			newpage = page;
 		}
 
+		if (!is_zone_device_page(newpage))
+			lru_cache_add(newpage);
 		remove_migration_ptes(page, newpage, false);
 		unlock_page(page);
 
-		if (is_zone_device_page(page))
-			put_page(page);
-		else
-			putback_lru_page(page);
+		put_page(page);
 
 		if (newpage != page) {
 			unlock_page(newpage);
-			if (is_zone_device_page(newpage))
-				put_page(newpage);
-			else
-				putback_lru_page(newpage);
+			put_page(newpage);
 		}
 	}
 }
-- 
2.51.0


