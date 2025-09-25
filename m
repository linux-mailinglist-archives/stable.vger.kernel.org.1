Return-Path: <stable+bounces-181680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B5B9E075
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8B97A6833
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E9B270EBB;
	Thu, 25 Sep 2025 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUIlEuBV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5E270569
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788635; cv=none; b=TtIJO+uZ3/3jyRYk0ck9dYY/8iSmR6nomE399kvQh1O1GH/KETUZNYWlfjMHfqGwK+mVJjXXuvlqS1iW6OMp9BuQLj5CtrjUFaCV7bQIiWZaWX/12piv+Q3cQ7mGRrrVJbdbO8QrZVDM2WXb9TeoE9sppWbGm5dkMFsqbO7u0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788635; c=relaxed/simple;
	bh=s5T6Vn455/sr/vkaT5+Ey96O+rbn3GPWix61AhM2m4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1dUHl3xcxFMDcDMhE/DypW/jBv6QguxfuiWUdHV3fGiNB09rTwNRF6NyMUd5R/tVUotdB9Gi5Ubh40/+MMKYYLRlKpCQOP4pLF8cAu6K25IfUaOD77RxXjaZBnfK9C1brSPDGEmJtY9UI+HqGuLY7Wf8L4Enj+hIQx4fEf5eNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUIlEuBV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758788631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PqVvZUfdgTpL3nfasC58wu42gflIPAUI1k0hSCR4jG8=;
	b=DUIlEuBVaSxNPN/09tU49kGEeNwQxUMwSyruVaKClvhOmIWWhpbDF4DAMVrKKLVEKZmgjF
	3pGnOvwSSbv+6Bf1rjXGbvz7VKs9ZbUYl7vNCgMRYfQ8AJgM+jR8ksFEjH4Y2kd9rJUhnp
	974Uf9QZKe0l9cZ9GmcJxwWccNMksbw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-_41Re3fGNeOY-IjYIxN69w-1; Thu, 25 Sep 2025 04:23:50 -0400
X-MC-Unique: _41Re3fGNeOY-IjYIxN69w-1
X-Mimecast-MFC-AGG-ID: _41Re3fGNeOY-IjYIxN69w_1758788629
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e1e147cc0so4647275e9.2
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788629; x=1759393429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqVvZUfdgTpL3nfasC58wu42gflIPAUI1k0hSCR4jG8=;
        b=CX/lnlAUEXokf1zhgkR6FyqvX7tngKYcX5s294VAao/FBCupns+nGmBwFots13ovH2
         C3f4qFWQUa/8jQLW5krVseUg4rwCdTyP5zTPN/vAoqf6rxsNkiF6FgAdS6O17keWfc7G
         h1vjPYZQx0dQal8gBtBPgHQRVC64M6vD1gMtf1vLbfi/tXMSn3b4q9QMz7kSx8r+FyJO
         dXqWGAPfuPlmqEOHT8BlC/ZRpO6q95sG5db18NXznVikP3w1b6lIojKgRV/Cfd0QMuEu
         T0c2/4j5SPFdj76c6iHxvTN0L2ejs+m/4Iaj5yHkhTJ47yanXdEZGr8A10SwSITIGZid
         sNvA==
X-Gm-Message-State: AOJu0YxzleNzKYOwYiZ4KtJ2x5UcIuT0nhVGjxDnseuPYNYykrlThGAd
	IbayzAoUFlOk+C1loWNHSoM9tU8Rjmxu/edQLBeLqmimmWX/aXgBsoEMr/CdQmpdFyzU/S+R/Cg
	jsZjew/AX49p7vQaLfyBjt/6SWHV1U/BMn4aZ9MeIhKOI8+YphhVIO9iyKhKcZuJi6dv6yQ0xI3
	xv8Zyqpy/ozZ4h5928p36+ZkQEW6r3BC1VBZSBCK6e
X-Gm-Gg: ASbGncuy7QDRrEXIHoG4WvQ38SZNZzOC7Z0kceG1GeaA3y/OGd1l4+Bg/LGXHkDT7R7
	HUgK0Ph252RpaODpildZ5+GfoX+6HWFdJzQtQW8q7Ofck+H3I9VX2Id7YPRdpxn5aBfsq5P6umK
	hqh+2V8TFUpcezikmxCw9ajOsNSWI8h4O2Y8eFbx+IBiMWQFA4WCCPu1hiYtV9Le8CrzPukXKGB
	RNuUqGiOI9CDXr95Wo2yz3HLSyw9Nm1qLXuQEPTL76tzs6T36OaX14aYYBsMuKp8rr99YmDvGm2
	gPAo2tZwh9J8eVZ3B5b0yGedg0sLFxb0jdFKzSG598g4/i9MJ5E7LvwMM+RtQNXpEF8OzxTUcRY
	s59iZhvyxm7//mNvsXY3l2bhgNA==
X-Received: by 2002:a05:600c:608c:b0:46e:2f74:2b9a with SMTP id 5b1f17b1804b1-46e32a1a097mr31960165e9.30.1758788629163;
        Thu, 25 Sep 2025 01:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ12tKaFcH2IPN93xdvFrnUinK0BFJgywoLTw/akd+C2/PdLGf6WCWrFNWTUyyuEy29M7LgA==
X-Received: by 2002:a05:600c:608c:b0:46e:2f74:2b9a with SMTP id 5b1f17b1804b1-46e32a1a097mr31959745e9.30.1758788628607;
        Thu, 25 Sep 2025 01:23:48 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2a9ac5basm78621715e9.7.2025.09.25.01.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:23:48 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH 6.1.y 2/2] mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:23:43 +0200
Message-ID: <20250925082343.3771875-3-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925082343.3771875-1-david@redhat.com>
References: <2025022402-footprint-usher-aa6e@gregkh>
 <20250925082343.3771875-1-david@redhat.com>
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
---
 mm/migrate_device.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 180dbb99c320b..afe3b2d2e7b9d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -854,20 +854,15 @@ void migrate_device_finalize(unsigned long *src_pfns,
 			dst = src;
 		}
 
+		if (!folio_is_zone_device(dst))
+			folio_add_lru(dst);
 		remove_migration_ptes(src, dst, false);
 		folio_unlock(src);
-
-		if (folio_is_zone_device(src))
-			folio_put(src);
-		else
-			folio_putback_lru(src);
+		folio_put(src);
 
 		if (dst != src) {
 			folio_unlock(dst);
-			if (folio_is_zone_device(dst))
-				folio_put(dst);
-			else
-				folio_putback_lru(dst);
+			folio_put(dst);
 		}
 	}
 }
-- 
2.51.0


