Return-Path: <stable+bounces-180687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E13CB8AEC0
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC65A00A51
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE42224B0E;
	Fri, 19 Sep 2025 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZUlZP1Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4B211A28
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306714; cv=none; b=KH4WNTQUACyD4mYqzkBfEp8B08NXk0H3S7UJqMstDlo2EG7FNS2pC5bkFJQIPAvHeB1pMmXNxfoqM0VeGL6NUpESf5eUm4ck1m/GhQ7E3/GuOvO/DcvQYgZyQvftks7Xq7BdMmihh4kE4dUcSbDpKdhJ+1fAabFL2yhMgn9KAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306714; c=relaxed/simple;
	bh=NtQC/MmlK7h+ZKGq10SDYcJ+Z2kx1r11RyDe42/+ZMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jT/u2YrSlatWO2OGtZEs4XCRX3ZNtnogDXChLrs1jHtBYUMcgalPX34A7InK1vujxuQO9Cn9kMAzOynlrQNv+fIyLYk4TBCoGI/aPL0QGwsTrUwxXcg7TmwWCnFrl4hi029EkHx27PLOd8zMv37NHT2nf/v03ot6cVQwpMSIaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZUlZP1Z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77e69f69281so1066435b3a.1
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758306712; x=1758911512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2yeL9qpe2dk3r4TeS6WdfN+7sBAeYo3Kd967A0Jh/U=;
        b=HZUlZP1ZTH4/iPzuQuz87wPuBVcMxuKzbq56sKhe3nQPAu8Pn1Bd6EVDt1aPg22yw1
         eSR+aKT8vrMs0IFCGIFnoSXqorcm0JAk54Ezegc4162KfoHgk3P/rsg4u4lLbQS3T+bk
         DQT6xfNzQmngeUgdXSilWW2pycwoykhIqxWlDHEVvPfyg6d3baudbGafx2E+RmpxkWFU
         IIQAkEMyX2TFOK+6NSMt4PCJnugX900lerFnWg265aVeSiCdDyTHocJ890OHUb8RWtLQ
         Nz5T4c+6/1syO8VevSaRgAEDo3rwKQo13g/N4jWfLBNh0z6wew7H4Ln5ez5O8d190Kay
         ddxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758306712; x=1758911512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2yeL9qpe2dk3r4TeS6WdfN+7sBAeYo3Kd967A0Jh/U=;
        b=HG2B32kYnpbyzhwpmLcPXiCNUozXReYbtkM7V3uPafIYRNqaUN+W8OgF+bddmtRilm
         NC107uWouRhUStPO4vnAaCN8U4dcmM2UYwPvD1dwzVCMNPD4GSdXdmZfibkHviyVOlkI
         JtzTevjRtnc4Va+/37OazL99YJFiNUyMJkMQoi+3EzUKG3qKgU0A8+Doopk+Iju1LBUo
         oY4oszkMxJ3kKvbf3Te4JrEBKUPvwSvD3bdEWeXo1svrcem3lQdU7PFhB/XYU5nBKZyK
         MFQF2CIblMfou1XWwznaZJ23kFwHKlTDHk0+koQDUHKl0CNTgYJeYYW/4pg8Ds915vgY
         1eZg==
X-Forwarded-Encrypted: i=1; AJvYcCVJo2jXU2fM5Pk3QHpyJMUtWw4/zZoSv0CUL2GKcSLaHtu2KUkzn4a8rjZ40k82S+/oBjN8R7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1r/5QOHvhXpggzbgPnnC+Hbgw7bSbXr4QORO6NNcin7YUNVf
	decFbwx5cVNOh+dqm21EPPzFIiy+oKs3ErG+QGLJqPX3cgCP1smsX8fK
X-Gm-Gg: ASbGnctjIBth7mmNvJSCDKRdnkBpUPoI2infdGo64Uqpr2NHR17cIkz07WE65fFmPiI
	++pyzSzi4EFUMGjZMSjgbQL+r5PbURGCQ30pAcjHoLFyGCR+kbltk1hohE9eyZUW+o3JjIRAJKw
	Xlau9pLrpDy1X7/f8vae58l5pa2Qpc6hA9oNEoj3UgVtxpR5fCs7jUU1mikQenqnWOcD0hv76VT
	oJvrajpMermOr3KhZ2SeXlcve8tQLZTIg550hY1AcdHMXpnQBKrI5xqFISxEX5V3b6fXK8CS+Vv
	QYLfHQK9XgHTkwIQ9TuEJbgeFnjAVlbExK8xeLf3FjhmyQSRbGxCJXUqmUxmp3wA8F7Q/TOnZLa
	pBYH0tuDi4wKTzt50YLGRu55Uy9s=
X-Google-Smtp-Source: AGHT+IHKk1C6demLZSfQaSYDHM7x+46+mgzS0jEkowBppkgliAtg1CGYcuMNU68VKc1FYbdwa1S6tA==
X-Received: by 2002:a05:6a20:7d8b:b0:243:b089:9fbe with SMTP id adf61e73a8af0-284681cabeemr14558643637.31.1758306712226;
        Fri, 19 Sep 2025 11:31:52 -0700 (PDT)
Received: from gmail.com ([157.50.36.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b552fa85110sm538758a12.45.2025.09.19.11.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:31:51 -0700 (PDT)
From: hariconscious@gmail.com
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com,
	HariKrishna Sagala <hariconscious@gmail.com>
Subject: [PATCH net RESEND] net/core : fix KMSAN: uninit value in tipc_rcv
Date: Sat, 20 Sep 2025 00:01:46 +0530
Message-ID: <20250919183146.4933-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna Sagala <hariconscious@gmail.com>

Syzbot reported an uninit-value bug on at kmalloc_reserve for
commit 320475fbd590 ("Merge tag 'mtd/fixes-for-6.17-rc6' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux")'

Syzbot KMSAN reported use of uninitialized memory originating from functions
"kmalloc_reserve()", where memory allocated via "kmem_cache_alloc_node()" or
"kmalloc_node_track_caller()" was not explicitly initialized.
This can lead to undefined behavior when the allocated buffer
is later accessed.

Fix this by requesting the initialized memory using the gfp flag
appended with the option "__GFP_ZERO".

Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
Fixes: 915d975b2ffa ("net: deal with integer overflows in
kmalloc_reserve()")
Tested-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> # 6.16

Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---

RESEND:
	- added Cc stable as suggested from kernel test robot

 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..2308ebf99bbd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -573,6 +573,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
+	flags |= __GFP_ZERO;
 	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
 	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
 		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
-- 
2.43.0


