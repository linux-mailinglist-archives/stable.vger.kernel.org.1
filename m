Return-Path: <stable+bounces-233299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH5gK3GB0WlAKgcAu9opvQ
	(envelope-from <stable+bounces-233299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 23:24:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F25139C98F
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 23:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 449A6300AEC2
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9557B355813;
	Sat,  4 Apr 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="T6z0ImG4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57E434E761
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775337832; cv=none; b=CRrCdTl7tjgeumwWMPrO35Obo7aCLWC+CRBCr/PPc5OT5UGtxYXnrRSH0YtjZFtcA5e5ymm2lJ+wzrJrq3HVTz0aKeMAteammd4Bb4Y8QyJXFLkJeysZJpBfNcS0MTTqkbE6u01Xc8t3IrDrLcB5nmr2659ZJOhwTQzxJfr5Ueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775337832; c=relaxed/simple;
	bh=gLjOUfPPYN64uhpAO70wHvdMU3V82Q0fkiYuP0qp11Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwekZ0PcSij7U3Q6EQ8xxAj8FAUhDASJUuGFiyQipZPpcpd0FKAUg7rN7Ip9sFoDOkQebD6IJZEbmk0VkqPZtU4G3http9MZ1lN10NFUyEnQCHLc9+0TuFe0L6t4IZhXHgXmndJsadvvb56quoVh9WKtXDCN8ewsT8/JMxcWmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=T6z0ImG4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EAA283F1C4
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 21:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1775337826;
	bh=Vqjn8PI0owOj+dl3IsGnOnkCkDv7BUM2CiLCXiFENmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=T6z0ImG47AwksPDYq4Ip4LxmvkcYIYeKWxROez5p07dcYPse/AyNfjpTW3rJm3mkO
	 tOT8R6XozAG3ZICTHPkBtxTOeNbnKnNBpt3UPcRnVCTfKTqQlPMEHj36mGzxNggPSR
	 OhIhNS9BiGqWdtCEYAkCCK+iBq9caiPq5D2MzwTmJOCYEgrwXSaOG8mkKnjQBvmpT7
	 eX2M9QGlqVbsa2614pN/BxWbkNRDYh1B984jLTwt7dmcf+OEIhyPlt7A+j/O0I7HAb
	 /0GyOPGduDYRYH0ysZk4Og/Bfm/pDyOuJcuyUVbiri648acK75//4M6WqcsH+TEjmN
	 qlKjPOLf1AratUkAqgoPhHAiti5ceKtXeRq4O0C/ajxXRRUr/UyyXq5wEi9Q0agtu9
	 Sw/bkW86kh1kFkc5VmV0G7jnoDLZ050eZOS4hZGbF7xFApo3Hd1QMcGaHdQHvLRjrw
	 Bf+L4+JdAWydvBApZ4hHWJHwM9ckbN746iMXhAszBJejwU7pWcgjHD3awlYFjLiPsC
	 z8rdI8WMEsl4xp/fD+E+N+zHcaLJ6Xhxs0LWE4ER2YjuNJ/1/rFtTLv10ivFfV3mjY
	 LiQBkQIrEU3HgbFvI6Rq+1BQRF7+EKkMkO3+5oZjlOTd9kYthN+RPlIdw/6sSCBrsk
	 pcom9ykGsCgLmaehgIzS1Cxk=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b9b8e3af6so2819621f8f.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 14:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775337826; x=1775942626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vqjn8PI0owOj+dl3IsGnOnkCkDv7BUM2CiLCXiFENmE=;
        b=HSOVXoqxMm2FrWDBTq8i5/Gd4VV1VU4GMXE9YFufS15UkADM/pE0PA5ZVacLCjzwUc
         J3wJxddQjS5VZnx6Zza+Ft5PPRUbY7w9dKA//TizRCHbkrruTXXjyTDitjt75EDCkVQC
         sNfUO5ZBAjClc3slKh3oELpllBGLescdIMWJKGkjU6hzCL+sMDCQEPHW088m+1kFoCBC
         x7zOD5SWOgrQeXO1+fV6if/XU47c2EKQnDEhw42N1tEzrW97yRkVIWHiGh9zJ4CMOjd+
         YtIcMHuCmm16zbHFbiK6XjaeIY52GFol6bq5TlH4rtgS9UVABcKO7GorLj0RahH3n1gJ
         T9iQ==
X-Gm-Message-State: AOJu0Yx2ioPE4E9Z8ujfwaNDL3qVt6hU5VOmV0xMy5GIRIYApdKnzDr1
	T3DhUik5ark1sGGcvItiPw+e0FkAe4v8toycP+0pmAYIfrw+9WN97XbNGVdHlDU7qkG3zPajpef
	h4TsDqGUkWW11JEP5o2b4fcJRgztoGuYTA5Orachwe0ZInmpRR4E4dwgLRuEUfsZbdzW8pt5cpi
	q9IyY0Jg==
X-Gm-Gg: AeBDietiDTHxd5VkCEDwrwYT1J9hoHM0h1BGFUiP5EvLt3yB1oJYmZxvFfeVOSTpIN/
	D43HUuTJ09T0YOYQUY4XOBbGgjd/5WYC9NbUQxHZ5AojULHYXDeUBzSPx6Gw22aLWRZUQFz5NAX
	q+/sE3D0hjkLIyEiTyzCxDy2b6xPRTBxU/EaWvjqaTWaGDe7T8uSNLwdfbHla57sDlNyV2iEEJZ
	Nsd+vPMKtAD2dEKB9rpo04dAKWDQCwXigKR6YtE0D0WrBwQJt3c7TcAUdhtNJ1ggsr1qz2yB8RL
	QCAfAAgHj14jNSboDzWtNju0Tgd8VP2mCD+OV4h4fWfvdHqTYgCuOO0exrZSJjaXoCxx8KjFGQg
	2B9hBIzyNcNGpkU7X3/GGUXU=
X-Received: by 2002:a05:6000:2313:b0:43d:855:f161 with SMTP id ffacd0b85a97d-43d2927f945mr12169366f8f.11.1775337826292;
        Sat, 04 Apr 2026 14:23:46 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:43d:855:f161 with SMTP id ffacd0b85a97d-43d2927f945mr12169357f8f.11.1775337825900;
        Sat, 04 Apr 2026 14:23:45 -0700 (PDT)
Received: from localhost ([176.41.26.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5419sm32068643f8f.11.2026.04.04.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:23:45 -0700 (PDT)
From: Cengiz Can <cengiz.can@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	ioerts@kookmin.ac.kr,
	sagi@grimberg.me,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5.10.y] nvmet-tcp: fix use-before-check of sg in bounds validation
Date: Sun,  5 Apr 2026 00:23:44 +0300
Message-ID: <20260404212344.1808777-1-cengiz.can@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233299-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cengiz.can@canonical.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[grimberg.me:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F25139C98F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The stable backport of commit 52a0a9854934 ("nvmet-tcp: add bounds
checks in nvmet_tcp_build_pdu_iovec") placed the bounds checks after
the iov_len calculation:

    while (length) {
        u32 iov_len = min_t(u32, length, sg->length - sg_offset);

        if (!sg_remaining) {    /* too late: sg already dereferenced */

In mainline, the checks come first because C99 allows mid-block variable
declarations. The stable backport moved the declaration to the top of the
loop to satisfy C89 declaration rules, but this ended up placing the
sg->length dereference before the sg_remaining and sg->length guards.

If sg_next() returns NULL at the end of the scatterlist, the next
iteration dereferences a NULL pointer in the iov_len calculation before
the sg_remaining check can prevent it.

Fix this by moving the iov_len declaration to function scope and
keeping the assignment after the bounds checks, matching the ordering
in mainline.

Fixes: 043b4307a99f ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Cc: stable@vger.kernel.org
Cc: YunJe Shin <ioerts@kookmin.ac.kr>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Cengiz Can <cengiz.can@canonical.com>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5d8e57e5fdb1..6db9dcdbb3c3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -300,7 +300,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
-	u32 length, offset, sg_offset;
+	u32 length, offset, sg_offset, iov_len;
 	unsigned int sg_remaining;
 	int nr_pages;
 
@@ -317,8 +317,6 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
 
 	while (length) {
-		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
-
 		if (!sg_remaining) {
 			nvmet_tcp_fatal_error(cmd->queue);
 			return;
@@ -328,6 +326,8 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 			return;
 		}
 
+		iov_len = min_t(u32, length, sg->length - sg_offset);
+
 		iov->bv_page = sg_page(sg);
 		iov->bv_len = iov_len;
 		iov->bv_offset = sg->offset + sg_offset;
-- 
2.43.0


