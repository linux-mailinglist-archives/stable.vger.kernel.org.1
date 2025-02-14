Return-Path: <stable+bounces-116416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A668CA35EB6
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BA0164A28
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9230A264A90;
	Fri, 14 Feb 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NSCXiI30"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB5263F5C
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538753; cv=none; b=rBwQ/DTU5Xn5CTod0vxuWug3uy3TLiliwkaYZn9QZ4qMWubeMXA2Pj1ua2nc2g2TmBbwhKstjmNYv0zLtFogyxSurGcSF0AUqVIMHIu6z1eJR8HD0Jbn6pBqBl4sjExYMCe0DSc/+WU8hhQowvpyBDUy9SxbQ8lVEHK65b0M8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538753; c=relaxed/simple;
	bh=xqYFFqc/j6MS2c5Dx47HMDg/z3uY0XGHoCzPe3s2lYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbal9RpWPvjSccQXFIMw0myng64s0hTQUI9qkRQC22sfLXgpiGwlxAD7+Lq0C/tUWtXL43CvV9Axoa3MJlnHwegC6cv4iagJfxKMn1fyDMkKvTPQwSHsPDL03xM5vm86C4/DPfsKI1ILP9+78fF6NciyrzW1zNubJHpPVAoYX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NSCXiI30; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so14816415e9.0
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 05:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739538748; x=1740143548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=419CXPNdKmp8M+eK7LikZJ3BOVCAY8RCFua0ebGArto=;
        b=NSCXiI30nMCUQiGEomkbcZX3niQd7mAXTJXmhWlyE6/cwxZDyQzHF4RWj2KyGl1eL/
         gmu0VANDjCiGd+AhRIm9n3R9QvBI+oZNblzAvZRRyu6EaFbkPwi2g3GwLK91ChWOTJL4
         luVlYVE1ZhZURjvJspIoBJPWOPWYuq7RpTaDNA1hHkXWK8qy8JKQv/bcXmKB2rHy8nCC
         va/9+57gX8GSicU8dkREYTIcXO3wz4mkAC4BS9OXy2j61lHeYujzIMA4gPcviEmOpVBL
         ghsNzoKFTqwv0+KcWrTU6v/SigFUggzQnheFUaq095Iatmb17te3Wa+5JB8aqyuPdWM/
         0PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739538748; x=1740143548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=419CXPNdKmp8M+eK7LikZJ3BOVCAY8RCFua0ebGArto=;
        b=Ykl5yLh0R2hzCKmboZ67LQNShTXji5mKdL6Lm4CQf/ZjHRD6AeXQqnMPSYwmBHLg3F
         6pwPze/jeeO7F0eOX8ANuhWM0hw1VQmIeM34gPok9A9gwrTh+nyXeEv214BIWi+YT7Xf
         kOQaulS18TCW0rTfap7CLhcUlAvv4Oru/4cWWcleO56dFnZrbpfMCUtEQCYcCmmRA1KZ
         YM59IYqAJ7CkIvYibUfB4DEhMQCMGy/oP3kysdDKr4q0fUFTBnIuBKK7CAQm3Gd1zQYY
         dVc0ihPP+06IK3ijxrfChnc0DmIfCQqCwZaP7pVdoyQ79pnRavtVRe35vLTapXO+AHiA
         YVZw==
X-Forwarded-Encrypted: i=1; AJvYcCVN2+kxch3R3j/8fEOa7y7jGkXGA4CJuuSxVk/HjxYUsqx8FQxTm/UehDRrWNI9OG5txkK0GCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkR62dnMx7kF38LZ3Dw8KTZYQY8OgTrfL1/KGoIQDATMo9/J1
	YF1JsajfSIQrQo5kZVMctOqSwN18RiXW788QjEbdvFmpeQN6wDAY5iHX6wKGuks=
X-Gm-Gg: ASbGncvnTmGVEApQ8zumATekdCDR6+m/u6GPf0ENNzK020n7zt6mHsnkqfhKVF48OCC
	Cj2nLC8Fe3niPGY5Z5LBAm8KnI2dkkm8Zck8hLb5MZWrg5lIcRJS40PH4ji8S0hfBUg2I8/Xd72
	KLuNHA90EgqVEhZCoMdG9Rwt4JQEQCERnx3A5ADGG1cCKmDmueSLkR8amg/0+Z6AL8I0kcVcfkO
	hHcMPKhyFNJOrtICIzsxKBTXDf/PSoIa+mkzMlQ1L3JNU20bw41s1OckMJvwqNmPVsl2BC9OPvY
	mqIv8LxlowLXNgqgAJyoD+1kdzLMbJrNvu1+dg/mYtVOl2Vx4E2cnrjdIoIjiLtBu2YURJiWAV+
	H+WRnMtIA4Bu7abM=
X-Google-Smtp-Source: AGHT+IG1SkH2rMSyUMKP4WuMh6dcembrpS+LW1VCHT5iUX2p5xHpF+IXvYCa4+sIkF0Qiz7p57HCow==
X-Received: by 2002:a05:600c:1c92:b0:434:f739:7ce3 with SMTP id 5b1f17b1804b1-43958173ef5mr127753565e9.8.1739538748070;
        Fri, 14 Feb 2025 05:12:28 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f19d800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f19:d800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a055bffsm75452105e9.12.2025.02.14.05.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:12:27 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v6.13 v2] fs/netfs/read_collect: fix crash due to uninitialized `prev` variable
Date: Fri, 14 Feb 2025 14:12:25 +0100
Message-ID: <20250214131225.492756-1-max.kellermann@ionos.com>
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

v1->v2: duplicate "prev" assigment removed.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/read_collect.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index e8624f5c7fcc..8878b46589ff 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -258,17 +258,18 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
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


