Return-Path: <stable+bounces-176530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 270FCB38961
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 20:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA106981BBD
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A2B2D9787;
	Wed, 27 Aug 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eKZ9EQ9V"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCC2D837E
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318635; cv=none; b=bk5knwHgcMQ82qChXXATJr3257tI1LZzR1edP49FXLL5jVDKNzpq4JqSHeyNteYyqPEz2mLCt8MVlmEUlaMxbQwLEK9SjMZHvHadWtf3ovqwimar+ECuvYzjsYXZn7rl/CAcgoUlYimQlbt+McjEA2xXgIBU6D8wbF1aD/pVQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318635; c=relaxed/simple;
	bh=Qgu6/RdKA4nKwsBeRMdnCSK3IDF8FjZbqqOVA6mr5MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bu3FxEjL51zw/iTU/4wyu45aeCBMbDuLsA5saN1XFNzIt9f3jZ1fUdp5KdDW957WoU/OW9geRECWGkkT00hklhjnOfUe/w27gJ4NUGOT0kjse4GsiMZlhhXFYYknfrwzW2Nn6ZNDAWP0OeBv9sQYr55DC09DTWs54pcwvvaISKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eKZ9EQ9V; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso701715e9.3
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756318631; x=1756923431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfiFhb80UdeegfuksVoSRuVkJVqC353CpIpZ8GK/9hE=;
        b=eKZ9EQ9Van4InK0MfGmq2nY/g3UasJFQ4uviwUW0aemsqGN1cqe5fvYjCiyN5+M82O
         l+orjaUnkuTz9zc9S/6uepU1nwq558N6xmcmpfARpzLE4sbODCA/3qyG7s2rmXh5F7/P
         gqNAcTvxUP3cqIXiU97nko92LMB0VtXrrixn2h1Kiq16jDgv8GmCXOLYOnKL87qi1l2n
         /5auYM4wgYW6MAE1G87uOue0r5FHQxXlB/Qslkj80Ge1nISb0AEbsxVdiFmsw9zN9VGU
         r3MeVLnkvc4jw+vRM4/iOdS9Ncxje5bKq9d+gZ0M9AGe0HpqRx+wIrTvi2+mUNwh0fve
         88fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756318631; x=1756923431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfiFhb80UdeegfuksVoSRuVkJVqC353CpIpZ8GK/9hE=;
        b=hQY0H2wPWfQkZo6iuvxCMuUkzpmlE66sXlH3+VpY7NNR9d0CuZdZ3/YZGV2nejnQPq
         GpnupsppiRYp520Ixi0B7bSqc4k/H/r1Ma+56yOGNqhlaiLSsAm9XPA0VmfRVzm3j1UD
         24ktO0R0cj9osXXx84ZWkBL46aM4p7pTak/kMt4KvqYzDKnPO0km/kR6aL12WlNCix0W
         CtbzTUSYN562H9r9hsSHN9euN2epi6n3IdE1eYmwlgThupUJ/61OBkeIxhlS1GQlqOvj
         eqbBIxDpnDKW0sOzPkbyA/+7sfjUZuuUwj+Lbnst3CGMMpB8q+NLFmxQ4gdIU/RjOXT7
         MMkw==
X-Forwarded-Encrypted: i=1; AJvYcCVURURyYQm0OybcXfcbgNMpCRSup+1EbA3vKZzg4brFjdTXVUz+xzOX+ksIxMTSSrqbg30ntdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlcX860F7pJIgqGQJxrw37VnYrziy8HKqTevYzrnCQKQFcpf1E
	fAXa+GjxYj0Ht/ZGoaNFlepAK8ZwbjaWtdUGGp7w/A1/NlZv2wQV0qtNG3mPHRxy05o=
X-Gm-Gg: ASbGncsQpsC/Ne4PfPrSQI7vMPOI0rwUKrDxt2a8o/NLrpIKvmBdWTwxo7FUZdq1h0o
	NzEcFQe1/qzAYDiSuecVzIMWiNTNApg0/DyGVwJQ6jtC0m/9t6h7HKT3SpN+EOmxN3o05B+HU7A
	dAifXW7Wg5zZtnS4BshA60dLDkx3IKmiP0MlANtkNGn2nKeN+g7+u1LS9O1aTWMqZ+p8XWg7QT6
	Q+XXYXNbu02n4JZuhkGoNN837TW9LOgw5MNYbZRy5qFm7yoDKRnxCNmEngidU1tznHhy+jOH7jZ
	bNLQyLGN1AYo+d5V8cplblmplhcrMDjoIPPchxAscyLGA5YPSL7WLkY5bMLLCD20nelUDZr4Xfr
	HfnDqmdwCUwt7nTrB4744Hrsc/IDzeGGrGhdFcUYgf+/E0wSAo8ROD3Nxmt7IaMSobs6IbEyzX5
	qpmlUGsU0IMtyru1fSwD7jcw==
X-Google-Smtp-Source: AGHT+IGqJ/GzQEWFQVd2ZnAV2tc6BCr/NnNnCcxzUwX006UuCMKNuwXKfoncaQGKE/l2cQi85xDhag==
X-Received: by 2002:a05:600c:1c25:b0:45b:7608:3ca1 with SMTP id 5b1f17b1804b1-45b76212044mr6014835e9.23.1756318630791;
        Wed, 27 Aug 2025 11:17:10 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c8bedsm42223905e9.1.2025.08.27.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 11:17:10 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Slava.Dubeyko@ibm.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph/addr: always call ceph_shift_unused_folios_left()
Date: Wed, 27 Aug 2025 20:17:08 +0200
Message-ID: <20250827181708.314248-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ceph_process_folio_batch() sets folio_batch entries to
NULL, which is an illegal state.  Before folio_batch_release() crashes
due to this API violation, the function
ceph_shift_unused_folios_left() is supposed to remove those NULLs from
the array.

However, since commit ce80b76dd327 ("ceph: introduce
ceph_process_folio_batch() method"), this shifting doesn't happen
anymore because the "for" loop got moved to
ceph_process_folio_batch(), and now the `i` variable that remains in
ceph_writepages_start() doesn't get incremented anymore, making the
shifting effectively unreachable much of the time.

Later, commit 1551ec61dc55 ("ceph: introduce ceph_submit_write()
method") added more preconditions for doing the shift, replacing the
`i` check (with something that is still just as broken):

- if ceph_process_folio_batch() fails, shifting never happens

- if ceph_move_dirty_page_in_page_array() was never called (because
  ceph_process_folio_batch() has returned early for some of various
  reasons), shifting never happens

- if `processed_in_fbatch` is zero (because ceph_process_folio_batch()
  has returned early for some of the reasons mentioned above or
  because ceph_move_dirty_page_in_page_array() has failed), shifting
  never happens

Since those two commits, any problem in ceph_process_folio_batch()
could crash the kernel, e.g. this way:

 BUG: kernel NULL pointer dereference, address: 0000000000000034
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0002 [#1] SMP NOPTI
 CPU: 172 UID: 0 PID: 2342707 Comm: kworker/u778:8 Not tainted 6.15.10-cm4all1-es #714 NONE
 Hardware name: Dell Inc. PowerEdge R7615/0G9DHV, BIOS 1.6.10 12/08/2023
 Workqueue: writeback wb_workfn (flush-ceph-1)
 RIP: 0010:folios_put_refs+0x85/0x140
 Code: 83 c5 01 39 e8 7e 76 48 63 c5 49 8b 5c c4 08 b8 01 00 00 00 4d 85 ed 74 05 41 8b 44 ad 00 48 8b 15 b0 >
 RSP: 0018:ffffb880af8db778 EFLAGS: 00010207
 RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000003
 RDX: ffffe377cc3b0000 RSI: 0000000000000000 RDI: ffffb880af8db8c0
 RBP: 0000000000000000 R08: 000000000000007d R09: 000000000102b86f
 R10: 0000000000000001 R11: 00000000000000ac R12: ffffb880af8db8c0
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff9bd262c97000
 FS:  0000000000000000(0000) GS:ffff9c8efc303000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000034 CR3: 0000000160958004 CR4: 0000000000770ef0
 PKRU: 55555554
 Call Trace:
  <TASK>
  ceph_writepages_start+0xeb9/0x1410

The crash can be reproduced easily by changing the
ceph_check_page_before_write() return value to `-E2BIG`.

(Interestingly, the crash happens only if `huge_zero_folio` has
already been allocated; without `huge_zero_folio`,
is_huge_zero_folio(NULL) returns true and folios_put_refs() skips NULL
entries instead of dereferencing them.  That makes reproducing the bug
somewhat unreliable.  See
https://lore.kernel.org/20250826231626.218675-1-max.kellermann@ionos.com
for a discussion of this detail.)

My suggestion is to move the ceph_shift_unused_folios_left() to right
after ceph_process_folio_batch() to ensure it always gets called to
fix up the illegal folio_batch state.

Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Link: https://lore.kernel.org/ceph-devel/aK4v548CId5GIKG1@swift.blarg.de/
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8b202d789e93..8bc66b45dade 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1687,6 +1687,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 process_folio_batch:
 		rc = ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
+		ceph_shift_unused_folios_left(&ceph_wbc.fbatch);
 		if (rc)
 			goto release_folios;
 
@@ -1695,8 +1696,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 			goto release_folios;
 
 		if (ceph_wbc.processed_in_fbatch) {
-			ceph_shift_unused_folios_left(&ceph_wbc.fbatch);
-
 			if (folio_batch_count(&ceph_wbc.fbatch) == 0 &&
 			    ceph_wbc.locked_pages < ceph_wbc.max_pages) {
 				doutc(cl, "reached end fbatch, trying for more\n");
-- 
2.47.2


