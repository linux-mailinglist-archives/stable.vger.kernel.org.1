Return-Path: <stable+bounces-105057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A439F573E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63971891FA4
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC69E1F8EF4;
	Tue, 17 Dec 2024 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djW1Dqug"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852E15A843
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465009; cv=none; b=k1lfT3H4Q6pqcQARYtPkB1TrwhLFzuXhpHwRvf0bK/gW8F7B+Cz9ddH2cT7Nr2FLxyMmdSsotBuWjey5bqFS8ecSettd+UxFh4FCbJevVBzposnVzAS+MWt6VM3RE4cJJwTXD7vcZtC4TKFgPXnFHKw30qrqRSxcDr4PEll0gg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465009; c=relaxed/simple;
	bh=xaoGY3xOfNRHW2SsMhyh6UaqjjDud38OX4F7jRmwu7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZdDdlk9M1HTK6eTePlNriP5wtcL54Oe+m3LneBndCyyv5Ijo0OWraApuxu+asM8BFIeybWFTmXTuBsRkHTEunply1V4IY47M/UWi/JDtzoFhgDO50UiQnM1R2yvFXZFgh1K7+KweraoiE8Eg+xUu4RpaLbjwQC9sElFRIT3qCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djW1Dqug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734465006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QiZlarG1yu2H+EY33I6/wxU1gz8WjSpLM11KEi/0F6c=;
	b=djW1Dqugz0JXVCC+MEu+6UNoDsxVUpBvOoxzQjbOoCI++URnuYHVT9dfhhktodZm0L0B8E
	bzhTBrOca+uZnch7CCklf9UsL+kp6HRYW19YuWDYvoG9RF9MJaojgs0yYa3BaonaOyzcPd
	vEbhGiKbRkIn8aU2wPQrDs4UJ8XI1AQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-QODpzJnqNDKNRqlqTuHjyg-1; Tue, 17 Dec 2024 14:50:04 -0500
X-MC-Unique: QODpzJnqNDKNRqlqTuHjyg-1
X-Mimecast-MFC-AGG-ID: QODpzJnqNDKNRqlqTuHjyg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43624b08181so241155e9.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 11:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734465003; x=1735069803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiZlarG1yu2H+EY33I6/wxU1gz8WjSpLM11KEi/0F6c=;
        b=V27eT1Z7bjfWMhTNssN814t6nSd6GtNNHsklzShqqqEXMMx5lI+SCrgGcFkhPRt7At
         LtxTSK33YyIF9avSutwZpFpU2oush2WK0kPlBdh7i3eJ9ybuI4hm4oIsNH+6BV52Itwe
         GSPMXEOU+EOzLh2DcJwC9/DueUFvfo/dt1z7VhtRvO91cKaZ+Zk5KZVwA8l+WBm+xntw
         QCiLZZ5fYu5AE1EwnO1/yyvFEyS2Yg0xTRHSWtb1lc4cKwRVQ+IlEaw0PkCMO66Kgg7x
         Bz5kDB3g4zNV2bYJ4+R7ofmD0NkvKtWewl1zRgekGdtB8jqwP671qaUfZ3I3ACCPO5LK
         BnHw==
X-Forwarded-Encrypted: i=1; AJvYcCWZfysaXBKY2QG5fOE05FdkAiBGBDe/TYzCo8LjgnO1tENvyTjdkKRUyaiBg9XQFxObWVgpSJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafG14rF+zpKu9TbHU4/jKGxxD61eCp9C/IXGrlNuXmcSqBAbz
	Mtwysp2eYGHNoE6XXE0g1RcTiXqzECrWVZ1Qv08YMA1HeC14bMTkmVV+RwL1Z1hUcei84q4ILuz
	5B7X0pATfg1IPnCD1qF1IkS3F48Pxb7R6ZHrw+SugUCDUdM+L8qWpvHCiClZ3MQ==
X-Gm-Gg: ASbGncvHlrGRYU6srkVA+D4FKNFAwMwL8kUp7dVk+o4I3ZIhYu7K+GEu7F5ho+zOpnO
	xtSYkmbxr5VhbP1YZI8fOTZxCvvUrPixIfEQWpjztVfJ7SrJDhaCDasKgo8tt2gaSNRPGcyrlNG
	KfnplkZfvD9KZHmZgHWZAWXTYJsgkVH/gu/eAuyK18vNczmkmXg7AfwQLfbi5+BGqguO49iwSFf
	hcgwRlOVwj/h4J+y6PQ7umLLkYYWSUEs61xWkDSxNf8Pmc628cE5TTuazfl/yjDYUu8heYlJTPi
	15f7qxns1qeFibNLU5m9jXKaiGpitcpFoch4C6Ca9g==
X-Received: by 2002:a05:600c:4fc6:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-4364820bd31mr43596205e9.16.1734465003225;
        Tue, 17 Dec 2024 11:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu01heuMRPqdAutYPFEMpZEU82k3XDseEOR+rvfMk6ZreF6rabCJOfIKhZbv7US17WUW2jqQ==
X-Received: by 2002:a05:600c:4fc6:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-4364820bd31mr43596125e9.16.1734465002900;
        Tue, 17 Dec 2024 11:50:02 -0800 (PST)
Received: from localhost (p200300cbc739b8006397a28153925533.dip0.t-ipconnect.de. [2003:cb:c739:b800:6397:a281:5392:5533])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-388c8060862sm11817576f8f.100.2024.12.17.11.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:50:02 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v1] fs/proc/task_mmu: fix pagemap flags with PMD THP entries on 32bit
Date: Tue, 17 Dec 2024 20:50:00 +0100
Message-ID: <20241217195000.1734039-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Entries (including flags) are u64, even on 32bit. So right now we are
cutting of the flags on 32bit. This way, for example the cow selftest
complains about:

  # ./cow
  ...
  Bail Out! read and ioctl return unmatched results for populated: 0 1

Fixes: 2c1f057e5be6 ("fs/proc/task_mmu: properly detect PM_MMAP_EXCLUSIVE per page of PMD-mapped THPs")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 38a5a3e9cba20..f02cd362309a0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1810,7 +1810,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		}
 
 		for (; addr != end; addr += PAGE_SIZE, idx++) {
-			unsigned long cur_flags = flags;
+			u64 cur_flags = flags;
 			pagemap_entry_t pme;
 
 			if (folio && (flags & PM_PRESENT) &&
-- 
2.47.1


