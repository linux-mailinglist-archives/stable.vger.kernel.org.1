Return-Path: <stable+bounces-181677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C782DB9E05A
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C31323FE3
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 08:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEF22701DC;
	Thu, 25 Sep 2025 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlFcvA2M"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF0270575
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788408; cv=none; b=J/BG9hGML0NusVyQr3Z9/7ODnmoCs50+QysZfzxNLdXMCcrUIv3kZ0btP3sDiT+Hp2BSras62hZccWe0DbNBiwTILFkF/zLmMFMbjN9uPSZ8Q7XgB7DM0yXR3RwMGOV9SCpT6ejyy/s8rlV0HbZHhgnBp94DnQejqFEjfzjwl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788408; c=relaxed/simple;
	bh=J6B8kkK9BDt/xyDcTyHRqxc9XKe7o+WiHD3yiFGfVHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2uEoVX2P4Kj4h4DC+JxCVhg21mwBpPhUFq7QXqv2K9xgIFpVpbk2WtxkSdqWoqH2csxSO6w0UjcTRhaRhvIuk6TMsElt/7ean84Y3fX3ZILa9USnJwinmT521JC8eg5C7Leh7X3kMN0Zr48CmeFMz+ZhSXHVorFIg2NrXucYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlFcvA2M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758788404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQyATlrnC+wowTPbvk0SB6NXeUbtxy3oLcwFt8kaAo8=;
	b=XlFcvA2Mze7ftfC7TcSleg+VsemKqEMoy0/oAIGbgt5fNvfJxiuAwZ6HDBu2TCt/rqxkCg
	26wp1iZ1nanr8hFk/fcsH7lLTCilbhtA42umqTBTO2ulEfMp+Q+B1lsTerauqRcE6itL7N
	I0mKWEPO7OiHAcioD0fYLAY+7PBdN1k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-w1NFRkCEOf-dTJlXFObRmw-1; Thu, 25 Sep 2025 04:20:02 -0400
X-MC-Unique: w1NFRkCEOf-dTJlXFObRmw-1
X-Mimecast-MFC-AGG-ID: w1NFRkCEOf-dTJlXFObRmw_1758788401
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45e037fd142so5070435e9.3
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 01:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788401; x=1759393201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQyATlrnC+wowTPbvk0SB6NXeUbtxy3oLcwFt8kaAo8=;
        b=ry4sWeXk2SkgByvAPo/ezQEInx+Y2R3SFk2mbO8PT+4LH38o0TmOo+Mh8kEp6rrxHx
         w08dpLqgKKyvzny3Ei0bfVn813mefjB1Rz5upuwrx5rO+BNveBYlzXnuUC2SIxVylTsl
         oVTLB+ugtMXBuRSto58fiVYINbHRzEDgXdjRhs81quy2BMnNDeg9q5fS53C6gGacnKYP
         /VYQ6dGrMjj/Gpg4TXd0DGnA6PYjrkspRCKYwZRHEjeVUX1xGNUmmWg1ixn5ZsusuyL6
         DZvK9nUe5hZDdCwGTfDPVn0iTDZUy5KCjlRBBsVCT5UzCUbqdZ9u99KRbv/SuERntUYK
         kcQg==
X-Gm-Message-State: AOJu0YyeJQ7Dtlb18xe6FEziI7Pj+TtBPSm16gftiqmWu2dhYHEePS3Z
	CWfVLsldCveMmNZjLjUYGu0JjRMExeSWywP30f6rxu9tmzet7riIL90aqeZMljyF59iHtXJj62u
	rPnuz/PZMDHVvS0bdKA7iuxAJVQBATWjoXEZRlvUlWCViuxnnAMqiU2+uPn/ch7IikZlRpSer6F
	3agzf0NJ3Suw6iG1BR4+y6XwAKDfLNT4u3iXBOaQ==
X-Gm-Gg: ASbGncttVh7LM6Z4tyr30jGnjOTcAHITcDRZEIEsiSVjoappgAb2Ldb3u7MukDprzEH
	eUb0IrHWpx1MvlABF724DjyXMZ0JSMiYn9GuXtQC81obKUubAirP611O/6m9SFCyCYZe1JTzGHq
	qpBjoMi+riHMWwbbxag0fhwPrk1fkfah6EYyQJWBHdCw7sjbU1aAfy6COO8mtEN/LjERzXC93Dh
	GAXyoJavsPLpb7k6RpwTFv5BAP8n5wyppW0e4HW9Uk7DnvJ+goWKT/cskQTPhI/JpzmR8C9vo0o
	MFnpcL2lQiigCYo7bsgU+R48XyLERjkFnN6CnmU5ErrGTs7XILMZ/6ERh9FOVMUF+KILr+VePJq
	HhhIb/DvOUwGGn+6ou2RJlZeZFQ==
X-Received: by 2002:a05:600c:1986:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-46e32a057c2mr22542675e9.27.1758788401272;
        Thu, 25 Sep 2025 01:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbC+TtRneWX13e58C5C/EoikI53nXNNt4+T6sl+welA2z2gykiSxedmAf1xpwS0M/6obS7Zw==
X-Received: by 2002:a05:600c:1986:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-46e32a057c2mr22542205e9.27.1758788400656;
        Thu, 25 Sep 2025 01:20:00 -0700 (PDT)
Received: from localhost (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb72fb71esm1915655f8f.1.2025.09.25.01.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:20:00 -0700 (PDT)
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
Subject: [PATCH 6.6.y 2/2] mm/migrate_device: don't add folio to be freed to LRU in migrate_device_finalize()
Date: Thu, 25 Sep 2025 10:19:53 +0200
Message-ID: <20250925081953.3752830-3-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925081953.3752830-1-david@redhat.com>
References: <2025022401-batting-december-cf51@gregkh>
 <20250925081953.3752830-1-david@redhat.com>
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
index 06a52612b2c45..f209dc512d821 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -839,20 +839,15 @@ void migrate_device_finalize(unsigned long *src_pfns,
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


