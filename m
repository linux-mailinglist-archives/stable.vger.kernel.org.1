Return-Path: <stable+bounces-181683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84F9B9E1CE
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4F0176AC7
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C775C141;
	Thu, 25 Sep 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuaVVZpX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90827280E
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790050; cv=none; b=eaUKESSkoaBQM85IWzpdyrQHvrtNSscVnFGH8q+7/1OfpoA4S7IhdioNRH1UdsgWJ1lVgdJC1CZ2CKf/4FRuxUhUhaS/78uEYjtWAM57xGkIfGg23grMmSac/ufqHJH06eg3FnIYOzTZ0RKZlrsW5liyDq3bzocHohNwXa4AGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790050; c=relaxed/simple;
	bh=Vl/3oy2i+VkUIKpusiaXM4vwLV9JAzgiqkwN0ZBK560=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLAh5BOA+bhsqvGRO91W40Ldf2YKA4GvNpT3Sttrpm/Y7BLpduuHXHYQZAzkdU9GvUKl+zUwy9O5HM/7h5+ePgc0cq+tamGOOVR4CPD8WSsCUOpu6v4+fsC62DyjdSnB/BAcwCGC/hSHtDNvm7XpEai0N2haVmVOrb9sJf9bWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuaVVZpX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758790046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytvh9Mi9NZnOjZ13mHmZtjEG3efGey6pvhUPQwUWTZg=;
	b=MuaVVZpXOAZThqgdljTIZ+6orY/SfeCDE2ZDPjvT4pXLAWqzBHGw2PwPVbWQNvHrOQt7sK
	gYmuGtsZH0YKGKQ+lx74SnO+DzSManBoWeN/4SWt8OnNcpXJBEAJQfaKReRuZcphRWIffa
	y5lSXg7V9d/s9AUEc/Mca0UZPWGBLzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-jKp1IcwtP9iDRpj5hqjPNw-1; Thu, 25 Sep 2025 04:47:24 -0400
X-MC-Unique: jKp1IcwtP9iDRpj5hqjPNw-1
X-Mimecast-MFC-AGG-ID: jKp1IcwtP9iDRpj5hqjPNw_1758790043
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso3885895e9.0
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790043; x=1759394843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytvh9Mi9NZnOjZ13mHmZtjEG3efGey6pvhUPQwUWTZg=;
        b=FjXyfPi3U4DOBiulgBN+ndOblCTwF8qbfaoGVSLiWPePruELvBS3CtKSGTkMvGjuAz
         oMQ+6762Jkn0Brzb5NL0NmYGdcU2fpzg7co+9S2zlFKyW9RoWFXQObvLZt7x4DI2QIBD
         dl/meaiBlLyL+GtFXusUFmmBFHBGcsPOX1esHEucyX9O6+MoqPi1oSCcbdzyCXNRgvmz
         DPQG9DTj9MwbThXxSqcIUkeAz2sWZdHTho/dv5ielCix4QU6N/26FhoYPFHTys9NSN8l
         gXVOAHYVNuZn8GE1StexNazr2icAtVfTzTVLGEdimZCysENe+bdNC1sxrMKX062iSJZr
         IP5w==
X-Gm-Message-State: AOJu0YxTLZkRR18gf0a2DLhoxw6xTeOs+qYu/8txbqosjZUBIKPGDizM
	HNuoClNwS5ClvDKZewtlJqLr3/lXZso3+u97cbqqKkvrLgc0IimzqG+rsn2kOiGHcItKJTCmr/+
	pSgzq/zuEUGIRUkgwfj9i36WgL6AbmgNthG6fYm8gv2tJ+m87qod7eyS5a/aupyyjYXfHOtjeQm
	WwX2sRPFfebxVyDsE9075Rc18j3VCsjMrBOq9eeD6P
X-Gm-Gg: ASbGncu/taOGkNsRySk9QQBpGvZvZMruF/nni1PqFUhD8x63ns+bn6y9t73rjTTnFgW
	Z+i9sW6NzHylp87NQMFV0N6OLLSmnK8HyU7Sy/5ZPdg/+H4uPPuXLzJsRWcFDwxzg5/a5AAuGVL
	lL/yCCHkbSWLCJvPVYq6x0rvYj+rZHps0QkGN6xdcz/odkyQ30rDH0OHFcZ5DrY1Q2RWFzN3kKh
	GJtKkgGo/DHi0deAgwe+ltKCfn8PXRAI7IdN+iHn6JcIelMs/+TeUnEw1dImfgLPYQt1WRt6vAS
	ktalcA3bIdfjmlTCDUcdusuU55C9bDPRU5g7rnACTdtx622YlTNCYneER0IS+VI3KTzN5f2/KYR
	CbUle7Gg0hvSBbtCfMPUtYyC38A==
X-Received: by 2002:a7b:c8c8:0:b0:46e:1c97:e214 with SMTP id 5b1f17b1804b1-46e329eb0c2mr16790135e9.19.1758790043096;
        Thu, 25 Sep 2025 01:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX0jfIZio1fHF95MfkT0t5zEbNwO85FYXIBLSG1GXZo4PT5vwAlnnGWbTCna5dU4DPME14aA==
X-Received: by 2002:a7b:c8c8:0:b0:46e:1c97:e214 with SMTP id 5b1f17b1804b1-46e329eb0c2mr16789835e9.19.1758790042478;
        Thu, 25 Sep 2025 01:47:22 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2ab6a514sm66598965e9.22.2025.09.25.01.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:47:21 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 5.10.y] mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:47:21 +0200
Message-ID: <20250925084721.3856196-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025022405-surpass-stipend-ca02@gregkh>
References: <2025022405-surpass-stipend-ca02@gregkh>
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
index c0a8f3c9e256c..aafad2112ec82 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3105,20 +3105,16 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
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


