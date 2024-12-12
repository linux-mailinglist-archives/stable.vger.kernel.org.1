Return-Path: <stable+bounces-102754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7189EF373
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46ED3291CED
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC252144C4;
	Thu, 12 Dec 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FNFFIAPD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784F6F2FE;
	Thu, 12 Dec 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022371; cv=none; b=VLVI2uMm3QL2Szhrlmd2iN4N+5cXnuqqLHd4zZFK+x+95fxHPU5qaRoUb3J6CTxaIxM6hMxCVP2ElzpDsyAy5OxVckUbkL0O2HqrveKf+urYCWKHIu7nYpOMjA7YnsL4wc/gEKZDmSj/UFzn1vilTmKGk5zXNsd6+3Ea8ZBPo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022371; c=relaxed/simple;
	bh=Q4f1+n+UE6PRaQX5wDCcRC+GR2V3Ufm17pOLoyXlvvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGXkzQvWiy0N7qVI9pP7gbTgfJFG+EZeglaN5mVFhrCZ9UFo8b4l8YUl+rU1j6O1r/TgAr7MUiqgma7x9apTaHpQBJZ9pxKKrQmyNH5GYKNdi/z5ka6Y9nzRAPtPUGWhH9K1xEsJQp0190TXc4YO+wkp3tQPu3gyXDosORGjcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FNFFIAPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70057C4CECE;
	Thu, 12 Dec 2024 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022371;
	bh=Q4f1+n+UE6PRaQX5wDCcRC+GR2V3Ufm17pOLoyXlvvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNFFIAPDd9yXSY1aGRUp6yfvcqfMIJENylI32UiYXYxl/jP6qPa6/GfgAMeYfzn+k
	 rHpU5D7r0zv+OBP75G22lA+8dpnZVONyp+Uy8mwhDIJo/XVLX1ZFB/mkgEdnWUiR+7
	 OBnTElfgyQzIDxthU5PTsVOZeeQBsZOqfsUlLklU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijian Zhang <zijianzhang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 192/565] selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
Date: Thu, 12 Dec 2024 15:56:27 +0100
Message-ID: <20241212144319.069613685@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijian Zhang <zijianzhang@bytedance.com>

[ Upstream commit 523dffccbadea0cfd65f1ff04944b864c558c4a8 ]

total_bytes in msg_loop_rx should also take push into account, otherwise
total_bytes will be a smaller value, which makes the msg_loop_rx end early.

Besides, total_bytes has already taken pop into account, so we don't need
to subtract some bytes from iov_buf in sendmsg_test. The additional
subtraction may make total_bytes a negative number, and msg_loop_rx will
just end without checking anything.

Fixes: 18d4e900a450 ("bpf: Selftests, improve test_sockmap total bytes counter")
Fixes: d69672147faa ("selftests, bpf: Add one test for sockmap with strparser")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20241106222520.527076-4-zijianzhang@bytedance.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_sockmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 74cfab7d5eff4..2705cd6c41143 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -602,8 +602,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		}
 		clock_gettime(CLOCK_MONOTONIC, &s->end);
 	} else {
+		float total_bytes, txmsg_pop_total, txmsg_push_total;
 		int slct, recvp = 0, recv, max_fd = fd;
-		float total_bytes, txmsg_pop_total;
 		int fd_flags = O_NONBLOCK;
 		struct timeval timeout;
 		unsigned char k = 0;
@@ -624,10 +624,14 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		total_bytes = (float)iov_length * (float)cnt;
 		if (!opt->sendpage)
 			total_bytes *= (float)iov_count;
-		if (txmsg_apply)
+		if (txmsg_apply) {
+			txmsg_push_total = txmsg_end_push * (total_bytes / txmsg_apply);
 			txmsg_pop_total = txmsg_pop * (total_bytes / txmsg_apply);
-		else
+		} else {
+			txmsg_push_total = txmsg_end_push * cnt;
 			txmsg_pop_total = txmsg_pop * cnt;
+		}
+		total_bytes += txmsg_push_total;
 		total_bytes -= txmsg_pop_total;
 		err = clock_gettime(CLOCK_MONOTONIC, &s->start);
 		if (err < 0)
@@ -771,8 +775,6 @@ static int sendmsg_test(struct sockmap_options *opt)
 
 	rxpid = fork();
 	if (rxpid == 0) {
-		if (txmsg_pop || txmsg_start_pop)
-			iov_buf -= (txmsg_pop - txmsg_start_pop + 1);
 		if (opt->drop_expected || txmsg_ktls_skb_drop)
 			_exit(0);
 
-- 
2.43.0




