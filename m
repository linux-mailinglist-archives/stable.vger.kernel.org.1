Return-Path: <stable+bounces-119969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1EDA49F57
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5E91899CE3
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBDC276024;
	Fri, 28 Feb 2025 16:52:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3327293A;
	Fri, 28 Feb 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.196.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761526; cv=none; b=IOLrl+NYeO8o60CyLfcyOdQYXWbYEt0w+JXGGz2otUe8UBvr9qRxbVXz8tEyohnF/Icxdnmxx2td86M1UYlQsb+oeVMyS6hjkc8FynCXB2qajdWSoglgVzD+pBm67TMh0pugXBhhni/YLIhtCV6OhqNl5l/M+vAeVCEa4lQchfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761526; c=relaxed/simple;
	bh=IP9g1eSFTx9/9l1F3zGbiHkCg+HxQDS6R0GpeyAaTeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmJvLxoo7Tt9i2m3okAEeOf5DFzDKQ+5cYfwRVb4ogqwg35IKFDcAhjIoy81Tydn9rCZRZOoCU3xRA2vOrbGY7o+4/3hL0BHWXh4GPVTiKIvbZm1QLVbnJTzmVZvOGscN5zO6+FNO56eauBa1/pYlIqEVuSy4hW3FX5Hhfl2/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; arc=none smtp.client-ip=37.230.196.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 8E90324C21;
	Fri, 28 Feb 2025 19:51:55 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail03.astralinux.ru [10.177.185.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Fri, 28 Feb 2025 19:51:55 +0300 (MSK)
Received: from rbta-msk-lt-156703.astralinux.ru (unknown [10.177.20.117])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4Z4Dky5Jb6z1h0PW;
	Fri, 28 Feb 2025 19:51:54 +0300 (MSK)
From: Alexey Panov <apanov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Panov <apanov@astralinux.ru>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 6.1 2/2] erofs: fix PSI memstall accounting
Date: Fri, 28 Feb 2025 19:51:03 +0300
Message-Id: <20250228165103.26775-3-apanov@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250228165103.26775-1-apanov@astralinux.ru>
References: <20250228165103.26775-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/02/28 15:31:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: apanov@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191391 [Feb 28 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/02/28 06:44:00 #27492638
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/02/28 15:31:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Gao Xiang <hsiangkao@linux.alibaba.com>

commit 1a2180f6859c73c674809f9f82e36c94084682ba upstream.

Max Kellermann recently reported psi_group_cpu.tasks[NR_MEMSTALL] is
incorrect in the 6.11.9 kernel.

The root cause appears to be that, since the problematic commit, bio
can be NULL, causing psi_memstall_leave() to be skipped in
z_erofs_submit_queue().

Reported-by: Max Kellermann <max.kellermann@ionos.com>
Closes: https://lore.kernel.org/r/CAKPOu+8tvSowiJADW2RuKyofL_CSkm_SuyZA7ME5vMLWmL6pqw@mail.gmail.com
Fixes: 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of crafted images properly")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20241127085236.3538334-1-hsiangkao@linux.alibaba.com
Signed-off-by: Alexey Panov <apanov@astralinux.ru>
---
 fs/erofs/zdata.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index ac01c0ede7f7..d175b5d0a2f5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1589,11 +1589,10 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
 			move_to_bypass_jobqueue(pcl, qtail, owned_head);
 	} while (owned_head != Z_EROFS_PCLUSTER_TAIL);
 
-	if (bio) {
+	if (bio)
 		submit_bio(bio);
-		if (memstall)
-			psi_memstall_leave(&pflags);
-	}
+	if (memstall)
+		psi_memstall_leave(&pflags);
 
 	/*
 	 * although background is preferred, no one is pending for submission.
-- 
2.39.5


