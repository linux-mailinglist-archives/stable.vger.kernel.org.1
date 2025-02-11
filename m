Return-Path: <stable+bounces-114868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F0A30739
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442C27A06C3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEC1F03F2;
	Tue, 11 Feb 2025 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RpsEXz+0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666261BD9D2
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266481; cv=none; b=SnYiQOrXrT9gadFVAKfa9EAGUz0AOjlJrZndOOZoYDCFEeN0z8kUFda0cLKQFUk2FIuyAO4T/CVltMlTPuXQln1L4cQ9Q470AoiY5nWZaxYOH38vwImxL2ogGVoJ69MEXyV2BD95cx8N1olzH3u9655sjpOVO4x6nZAx+0vxulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266481; c=relaxed/simple;
	bh=2DXwQ0Dv3SXEo6ey+zzdnIRAelLdPDTRqsXXy4q80eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjZURZQIF/wu5//UdY2KDarHF+WdnIZN905CSIn3KPh8WQo4dEu6uIURXenzhxdlLTvJ7mI/+jGZ9PlMt2GrSd6DjBcrwsOeRpdAJNsu/W9Sv27ElLauZ25DQ0wMatQmR+ws/Y8/O+yh+6LQXrkUjcIiod9BRsMJaHzWsPu1E4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RpsEXz+0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7c81b8681so273084666b.0
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 01:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739266476; x=1739871276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWZrRCAqmm1HJq4yoBamD/E8kURmTGZ8stbmrSYpKAI=;
        b=RpsEXz+0YGVNnagI7zi1C2UxT+s2mHVfGewazCxjPDQSjRzOupgvhJdx1d/AjYBGBA
         KClSyqHrRZphgDDgtdsYFy7nNiBqxaRuXImfKKirKMFzybYlSwL6g4ign0m9ZJLmlQlN
         CRAkzKNWeuS2clhjAgOzEkr1YP1qRyTNpEZRvIE0IvPK5QvESWsHkqBem+doESEsDtqz
         TzyOvCFrrACshhfj96wWsQIaLCAgYJFI3oT4bux1E0pSqwB9s54EbgtMjJl6ptmTDZlg
         3KFRGP65aWI8n8CxKA5HBwjy6ar1QM7zqWoNbwU+4yOn6058qYrqNd6P240mItDkCLSl
         xFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739266476; x=1739871276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWZrRCAqmm1HJq4yoBamD/E8kURmTGZ8stbmrSYpKAI=;
        b=SSEmEz2mLKo8pRVSivk0TPtG6oC0cJGjAPT4vb2HAByhhgf7+U+gV7JLq4mdfpEKLK
         10/ThhLZkiFQH2vOlMdKeoLya8t4TdPus6+Onh6K4iyL/Zus0VVoWWj/scGzlnTvkTGX
         zyZ3OgK08UAHgn5sT/XeMzXxRewW4jACGSUtnRqTjHDdlDm1+itaeGLPcAyBse4vOIDr
         q7s7XLU5daj6N0s59uZyqy4YMzBr4hcCntswj1TvDzLvRPv3Yfqq6xIfmWtc7KuCxxIV
         os0+oQMR+pZfRxRg5q0U9jX/x0gujz1Ux3I6YqEq5zF6jDR+YCAz5rCb0pXaufpsMiFw
         3Pgw==
X-Forwarded-Encrypted: i=1; AJvYcCUBuLXo5reZyRLN+8PPOdPRaTpNIaCXU57k2cK4IGjEsVwZzf1Xbl+V/IQgvNznJhBdYkys67o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVpcZ30AWBpwR2VIkYgefAyXpvYfoXHdJDBxy9pQdczx4g4eB
	Si3xH2/xD5yi+qc73Y4UG7hapR4UhIs6sxBMM6GmGFBkpGug9nhLnJOPg2h8N0U=
X-Gm-Gg: ASbGncvP7jPb9BUA2Mw9J4WKHaAsEyFVkXc2ebP5GxTwTbeZDhcA81SMY8DWnvkOiKd
	sXk5KryUn/geyD1ADLs+ZQg2BviQbmK5wMMeJ2tHugilh1VfQHm75KvUfHe6i+3+qbDdQFZLEGv
	yKbJ9NKhjjRgSCFGszSvk1/ABJ6FV1BrfCz7tVCY0INra64I6nlmNf+jkFmyKa8X6YB4gSHi7s5
	WBpnmwpMqVbCt4UYoL9Sie8RFdWYGgUbRt4A9xC8PZ8Z2pxf55DfVlqKib9ZKja1/rfYxnKZS6s
	zQnd83iu3Zij5sJ7Fr2yYdFklkKkCMZizU+uZubM7JeIE2CdXj0gz2zs1SjUOSIq2UsNAUgFTSX
	MNwSvB5x72c39Cqg=
X-Google-Smtp-Source: AGHT+IHDDasHCdrvqrKdpCEPB2/a6ZQXLLnon5IvhjBOb5WHhk7B9V6sO1FIu7eIIDlvI9dDI7iAoA==
X-Received: by 2002:a17:907:96aa:b0:ab2:bd0b:acdf with SMTP id a640c23a62f3a-ab7da4be883mr295839466b.36.1739266475632;
        Tue, 11 Feb 2025 01:34:35 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f19d800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f19:d800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7bbf40b2bsm418668666b.23.2025.02.11.01.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 01:34:35 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v6.13] fs/netfs/read_collect: fix crash due to uninitialized `prev` variable
Date: Tue, 11 Feb 2025 10:34:32 +0100
Message-ID: <20250211093432.3524035-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checking whether the edges of adjacent subrequests touch, the
`prev` variable is deferenced, but it might not have been initialized.
This causes crashes like this one:

 BUG: unable to handle page fault for address: 0000000181343843
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 8000001c66db0067 P4D 8000001c66db0067 PUD 0
 Oops: Oops: 0000 [#1] SMP PTI
 CPU: 1 UID: 33333 PID: 24424 Comm: php-cgi8.2 Kdump: loaded Not tainted 6.13.2-cm4all0-hp+ #427
 Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89 11/23/2021
 RIP: 0010:netfs_consume_read_data.isra.0+0x5ef/0xb00
 Code: fe ff ff 48 8b 83 88 00 00 00 48 8b 4c 24 30 4c 8b 43 78 48 85 c0 48 8d 51 70 75 20 48 8b 73 30 48 39 d6 74 17 48 8b 7c 24 40 <48> 8b 4f 78 48 03 4f 68 48 39 4b 68 0f 84 ab 02 00 00 49 29 c0 48
 RSP: 0000:ffffc90037adbd00 EFLAGS: 00010283
 RAX: 0000000000000000 RBX: ffff88811bda0600 RCX: ffff888620e7b980
 RDX: ffff888620e7b9f0 RSI: ffff88811bda0428 RDI: 00000001813437cb
 RBP: 0000000000000000 R08: 0000000000004000 R09: 0000000000000000
 R10: ffffffff82e070c0 R11: 0000000007ffffff R12: 0000000000004000
 R13: ffff888620e7bb68 R14: 0000000000008000 R15: ffff888620e7bb68
 FS:  00007ff2e0e7ddc0(0000) GS:ffff88981f840000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000181343843 CR3: 0000001bc10ba006 CR4: 00000000001706f0
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x15c/0x450
  ? search_extable+0x22/0x30
  ? netfs_consume_read_data.isra.0+0x5ef/0xb00
  ? search_module_extables+0xe/0x40
  ? exc_page_fault+0x5e/0x100
  ? asm_exc_page_fault+0x22/0x30
  ? netfs_consume_read_data.isra.0+0x5ef/0xb00
  ? intel_iommu_unmap_pages+0xaa/0x190
  ? __pfx_cachefiles_read_complete+0x10/0x10
  netfs_read_subreq_terminated+0x24f/0x390
  cachefiles_read_complete+0x48/0xf0
  iomap_dio_bio_end_io+0x125/0x160
  blk_update_request+0xea/0x3e0
  scsi_end_request+0x27/0x190
  scsi_io_completion+0x43/0x6c0
  blk_complete_reqs+0x40/0x50
  handle_softirqs+0xd1/0x280
  irq_exit_rcu+0x91/0xb0
  common_interrupt+0x3b/0xa0
  asm_common_interrupt+0x22/0x40
 RIP: 0033:0x55fe8470d2ab
 Code: 00 00 3c 7e 74 3b 3c b6 0f 84 dd 03 00 00 3c 1e 74 2f 83 c1 01 48 83 c2 38 48 83 c7 30 44 39 d1 74 3e 48 63 42 08 85 c0 79 a3 <49> 8b 46 48 8b 04 38 f6 c4 04 75 0b 0f b6 42 30 83 e0 0c 3c 04 75
 RSP: 002b:00007ffca5ef2720 EFLAGS: 00000216
 RAX: 0000000000000023 RBX: 0000000000000008 RCX: 000000000000001b
 RDX: 00007ff2e0cdb6f8 RSI: 0000000000000006 RDI: 0000000000000510
 RBP: 00007ffca5ef27a0 R08: 00007ffca5ef2720 R09: 0000000000000001
 R10: 000000000000001e R11: 00007ff2e0c10d08 R12: 0000000000000001
 R13: 0000000000000120 R14: 00007ff2e0cb1ed0 R15: 00000000000000b0
  </TASK>

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
David/Greg: just like the other two netfs patches I sent yesterday,
this one doesn't apply to v6.14 as it was obsoleted by commit
e2d46f2ec332 ("netfs: Change the read result collector to only use one
work item").
---
 fs/netfs/read_collect.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index e8624f5c7fcc..a7f285c52a79 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -258,17 +258,19 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 	 */
 	if (!subreq->consumed &&
 	    !prev_donated &&
-	    !list_is_first(&subreq->rreq_link, &rreq->subrequests) &&
-	    subreq->start == prev->start + prev->len) {
+	    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
 		prev = list_prev_entry(subreq, rreq_link);
-		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
-		subreq->start += subreq->len;
-		subreq->len = 0;
-		subreq->transferred = 0;
-		trace_netfs_donate(rreq, subreq, prev, subreq->len,
-				   netfs_trace_donate_to_prev);
-		trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
-		goto remove_subreq_locked;
+		if (subreq->start == prev->start + prev->len) {
+			prev = list_prev_entry(subreq, rreq_link);
+			WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
+			subreq->start += subreq->len;
+			subreq->len = 0;
+			subreq->transferred = 0;
+			trace_netfs_donate(rreq, subreq, prev, subreq->len,
+					   netfs_trace_donate_to_prev);
+			trace_netfs_sreq(subreq, netfs_sreq_trace_donate_to_prev);
+			goto remove_subreq_locked;
+		}
 	}
 
 	/* If we can't donate down the chain, donate up the chain instead. */
-- 
2.47.2


