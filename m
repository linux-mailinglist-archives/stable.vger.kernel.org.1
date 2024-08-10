Return-Path: <stable+bounces-66300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B113494D9B4
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 03:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703E32826B9
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 01:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73F28379;
	Sat, 10 Aug 2024 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sN2pCAGi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEE0DDDC
	for <stable@vger.kernel.org>; Sat, 10 Aug 2024 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723252623; cv=none; b=kI9nBKuA6Q2Y2bnvha9RKlzeul2C76RiMS93R2qP5yiFylJV+ss3M4188kMX+4t/KGwrkR1M/OX9DOkDSfOVO6Ahk0Y6SAMY9naboCHDObg7QrTEMjF9hdqlsdE0ctdTTAlW63pKX23pdXAs3CS0co177sDrrZS8DAekehkpA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723252623; c=relaxed/simple;
	bh=jVidmmJSJCHMjCbvcwDROW4wNdl7moiLujt9wpGQKSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R0rl9nREEFU81aRerL8ggknJfV5EUXNTJVRQ4HRdOABEwCRwqi1ZYz61/PyQTavqm3kvonvRS8GSoD9ST6KjGsapgA3yXb/twyeqVEJnzGcXyAhV49gMPmjMH4f6IqYFq2ZTPN/fvxaXTyPI2IHf1tmLfQQcwDj7VtiYrlKdnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sN2pCAGi; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d1c28cd89so2470432b3a.1
        for <stable@vger.kernel.org>; Fri, 09 Aug 2024 18:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723252621; x=1723857421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzuGDO8q1udHGjWzP2mZRvfBY0jHkPQ93TjSZVq4gBM=;
        b=sN2pCAGiufe4pjXKdWVOeHR8+tk/qRdbdCHbS6qa2G6CSV1W7cNdXWZXMoHkSKd7x8
         S1ZowneKeeiRF7c51Ask9wolWwZYdXwMvVzAbyzPpPwpYzGgS/gMk7/S1GBjA4hMNY83
         LlPLogztivuU9JXMe7N7gSO2/mAv4fZ5drSUZK7rbBAjiiRqbQ1qmUL/1il4Wle7idze
         L240PEqUadaYsJokHH9UvVxLWdeO03Ee3EiY2OE7FOw+f+XaqHOiS7bg2g74iQ0hV3mj
         MftVGTT9jNjxIr2O2tckmy44GU7VMFm+O0dHqviKnNLH6FFf2mnBzUVlqueoqYuim8yf
         CjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723252621; x=1723857421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzuGDO8q1udHGjWzP2mZRvfBY0jHkPQ93TjSZVq4gBM=;
        b=QHEbSjm9+TBOyprCK+yaTwosvQg90W5SnImV+aEjcvWrJTbN81u4WkRfW/WvY3oHFK
         MLk5fZnR008GOFvwKT8idfPGbddWKCgRH0EExXG4M7FUXHmysS7D24RtNC6rCxHm66t7
         cEI5UPYjGJpKpIQt5AlI0fZ4ufo+KZetBqe9qWItw/2YPlqoBHRfZXDJDBXuhbwDSm65
         a9OKb0SQnZ1klwC9MBdcmLN338VW20tnFgwbKHia1NFov19mTb4iCDf9aZkhCToq+F79
         ndrD1H8VU7ciiiOhLocFxL+/biSOmtaNwqJrGPCCwqQ/W3077j6dwUWBbBxMRkhXA3h5
         rJ5A==
X-Gm-Message-State: AOJu0YxMgniNEBerOCjEIBY+UqPDvCFhsVHOuHYwObIJN54raPXHFMGS
	KpPnW9qk3R7WOvkGRtjnZRri3nfOkOfuue7YjaqtZFbhujy0UV1TGEL/FqS4XNCEczw++ftnmaQ
	Do/ZzyczdliU+M3uElhZQdT0GnG1m8xV7Ykn2tzh+nMG3vVpaTf/81W504WH/1yjAjT8h8VIkfC
	7uQNvA9vw/09VIJc4adw2X08A5McdbYnbaSb31Eg==
X-Google-Smtp-Source: AGHT+IFMomNBWY9RIl8MG3x9++PDmzfZdK11wn1AVDRaHuoN8BvvnJKC/lZBof3IZkAqF6HTXI4MEEVBhgH/
X-Received: from kpberry.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:1f28])
 (user=kpberry job=sendgmr) by 2002:a05:6a00:138b:b0:70f:84b6:8634 with SMTP
 id d2e1a72fcca58-710dc2cfb49mr177766b3a.0.1723252619912; Fri, 09 Aug 2024
 18:16:59 -0700 (PDT)
Date: Sat, 10 Aug 2024 01:16:46 +0000
In-Reply-To: <20240810011646.3746457-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240810011646.3746457-1-kpberry@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240810011646.3746457-2-kpberry@google.com>
Subject: [PATCH 1/1] xfs: fix log recovery buffer allocation for the legacy
 h_size fixup
From: Kevin Berry <kpberry@google.com>
To: stable@vger.kernel.org
Cc: ovt@google.com, Christoph Hellwig <hch@lst.de>, Sam Sun <samsun1006219@gmail.com>, 
	Brian Foster <bfoster@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Chandan Babu R <chandanbabu@kernel.org>, Kevin Berry <kpberry@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 45cf976008ddef4a9c9a30310c9b4fb2a9a6602a ]

Note: The upstream commit was adjusted to use kmem_free instead of
kvfree since kmem_free was used in xfs_log_recover.c until commit
49292576136f (xfs: convert kmem_free() for kvmalloc users to
kvfree()), and the remainder of the file still uses kmem_free.

Commit a70f9fe52daa ("xfs: detect and handle invalid iclog size set by
mkfs") added a fixup for incorrect h_size values used for the initial
umount record in old xfsprogs versions.  Later commit 0c771b99d6c9
("xfs: clean up calculation of LR header blocks") cleaned up the log
reover buffer calculation, but stoped using the fixed up h_size value
to size the log recovery buffer, which can lead to an out of bounds
access when the incorrect h_size does not come from the old mkfs
tool, but a fuzzer.

Fix this by open coding xlog_logrec_hblks and taking the fixed h_size
into account for this calculation.

Fixes: 0c771b99d6c9 ("xfs: clean up calculation of LR header blocks")
Reported-by: Sam Sun <samsun1006219@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Kevin Berry <kpberry@google.com>
---
 fs/xfs/xfs_log_recover.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 57f366c3d355..9f9d3abad2cf 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2965,7 +2965,7 @@ xlog_do_recovery_pass(
 	int			error = 0, h_size, h_len;
 	int			error2 = 0;
 	int			bblks, split_bblks;
-	int			hblks, split_hblks, wrapped_hblks;
+	int			hblks = 1, split_hblks, wrapped_hblks;
 	int			i;
 	struct hlist_head	rhash[XLOG_RHASH_SIZE];
 	LIST_HEAD		(buffer_list);
@@ -3021,14 +3021,22 @@ xlog_do_recovery_pass(
 		if (error)
 			goto bread_err1;
 
-		hblks = xlog_logrec_hblks(log, rhead);
-		if (hblks != 1) {
-			kmem_free(hbp);
-			hbp = xlog_alloc_buffer(log, hblks);
+		/*
+		 * This open codes xlog_logrec_hblks so that we can reuse the
+		 * fixed up h_size value calculated above.  Without that we'd
+		 * still allocate the buffer based on the incorrect on-disk
+		 * size.
+		 */
+		if (h_size > XLOG_HEADER_CYCLE_SIZE &&
+		    (rhead->h_version & cpu_to_be32(XLOG_VERSION_2))) {
+			hblks = DIV_ROUND_UP(h_size, XLOG_HEADER_CYCLE_SIZE);
+			if (hblks > 1) {
+				kmem_free(hbp);
+				hbp = xlog_alloc_buffer(log, hblks);
+			}
 		}
 	} else {
 		ASSERT(log->l_sectBBsize == 1);
-		hblks = 1;
 		hbp = xlog_alloc_buffer(log, 1);
 		h_size = XLOG_BIG_RECORD_BSIZE;
 	}
-- 
2.46.0.76.ge559c4bf1a-goog


