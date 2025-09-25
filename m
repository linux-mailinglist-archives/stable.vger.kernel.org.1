Return-Path: <stable+bounces-181684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC8B9E1E9
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D5D14E1B60
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0D9277C8F;
	Thu, 25 Sep 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwYO45BD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38027702A
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790170; cv=none; b=HUuPA/wxkxmBiy7CCVoFtPKtvx3PMbd0W4wrfcUEQUQiPZuvOsgSUfWX942TYIMK9RM7aKR0Xp6MVqxe/7oyjvp+9Se+PcMe7AmlzsH546qBsTn7/IPkCHNDP4NQDkh0QvVlXqmDcLLTE4wXGYy0gF3r55FCGfbnkkHth3ZKvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790170; c=relaxed/simple;
	bh=Md1di4RKD1duOXTcQnEYn9EfNBa2FlcCNoSGjm+luGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWpi6rO3RXXzctYun/u/SlungiMqeb9QpaNQPWvEXH9f8qA/TF4GzD6xTsGhVXwkuj9XpXdJwHKVSGQVimE5C+2MVOiLwKCRFjQaY/YVUiTtW8qJhBIrmEuemzlT+zV8G3V003dXFnJlkCsqFIKLAFXxcpc3S1CbHpjinBBjTM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwYO45BD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758790167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96Myumouvefz+w6/wGcSm/myLCLF8eCGCwHV82PZpT0=;
	b=WwYO45BDkjszki+PDFMOG+XE7QMHMR8D0q5mw136oyWnvBw/aJQoX9ocvHqUTRTe+DaZTP
	WM01xtX8K4CPPruhx7/znkAL5GGbTUEXWaTPOREefxY04gpkJvJI2Zzrf1zdh0FASJHMSE
	JiZsVdwJ0zy8mowNH2E3DhMjxCMgBgY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-lDWwnWIWOsKxmUpZnUMQ-g-1; Thu, 25 Sep 2025 04:49:24 -0400
X-MC-Unique: lDWwnWIWOsKxmUpZnUMQ-g-1
X-Mimecast-MFC-AGG-ID: lDWwnWIWOsKxmUpZnUMQ-g_1758790163
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ed9557f976so583325f8f.3
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790163; x=1759394963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96Myumouvefz+w6/wGcSm/myLCLF8eCGCwHV82PZpT0=;
        b=PFGXmyLxq0Y2yyw7l/u88/tBlqYm6RAvbu7zt2zmltYq1mHuXbfrZohXSjTpTzu+Lr
         HI5KyRXC1ydSSdROiTnEvoKbmT3XamvYTCYsp26Rkko5AdyrUHCEhatS7qsLOr9febX/
         N1gFgI0czF5fOVQ1Pnzf/eWIrE00sWQb9c7EKqEz0PBGorllM76Ve3ntrSZDWA4T9eF0
         fNQjTpobmf/+jW8mNU1FYtgG4aO/CvehOGxpyHLD9wE6uLcb+T7/1C1Ndfh8mpApehbK
         YSpo3YTMFp4XVzsRKU4qNBVCkkHY7imkRRbM+LzRG86LYR+dD75RXNJssGxiJRzogEBp
         yG1Q==
X-Gm-Message-State: AOJu0Ywe4ICizn8igxKjOEm/C9inS4m4FjzIwzA06ipdNxtN9WY6o+a8
	EtO9A0CrtTKsq8d5NDKbsuKuNuTc6soSHZfONZ54VdOVznApA+32Ftt3oz5tO3c9lEw3vN+5MpG
	pgb4SwQvb7S2HHIO7sParnmfVjZGBRO93Dg7ThanTQhwxuY11UAFgBb+DGIQjQtRrHIUnSKjqsl
	g1DPf5iuVq2DbCGftKH43qXsHMZIzb0CFWwSSG0qa2
X-Gm-Gg: ASbGncvKcqD3NpsQfjU6wCTDscppzl9nH7ocB2XgQIM75fKvXL/FGxm4E/SOINTva3i
	6/TqLXpWjJ40lsCkEg8v/961ZS5TwSTlX9jwzXkn/5qnNRSB0wZbCxzmY5dVHAhZB+b12BDe2AO
	S3KirYEBrCaxOT1RNt8O2TWVk/6M4Za0rh/PGhle/EB8i9dOA1LAwoOzTtiO8gQtdx0/f+4xZcf
	XV10erYOhHUNfgURNMwLUpf1KitJwJ3cWtMFnA+eQZIq7dzZv7OUdDjLz0Xi3hbCN2M0cd0eRBK
	8NDROj/4pgd31akiURuQJ8RZ2CdODdeF5uWSA16PrJJ4T/zK3BrGWy2b+Rk8WzaQGr7Y8Tu6cPa
	2Ns1mQifky3uMHRzeFDpKpJHRlw==
X-Received: by 2002:a05:6000:2089:b0:3eb:5245:7c1f with SMTP id ffacd0b85a97d-40e429c9c58mr2551057f8f.2.1758790163332;
        Thu, 25 Sep 2025 01:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJXawuNWztXmHYJ9iUK4IjlVZc14jQcaTzlL8IJ56OZf0xhqA/uTbjXN2rk1CkLSG9voVrYQ==
X-Received: by 2002:a05:6000:2089:b0:3eb:5245:7c1f with SMTP id ffacd0b85a97d-40e429c9c58mr2551020f8f.2.1758790162754;
        Thu, 25 Sep 2025 01:49:22 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-410f2007372sm1181613f8f.16.2025.09.25.01.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:49:22 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 5.4.y] mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:49:21 +0200
Message-ID: <20250925084921.3874940-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025022407-amplifier-catnip-6e14@gregkh>
References: <2025022407-amplifier-catnip-6e14@gregkh>
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
index 9cfd53eaeb4e9..aef7978cc56b2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2967,21 +2967,17 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 			newpage = page;
 		}
 
+		if (!is_zone_device_page(newpage))
+			lru_cache_add(newpage);
 		remove_migration_ptes(page, newpage, false);
 		unlock_page(page);
 		migrate->cpages--;
 
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


