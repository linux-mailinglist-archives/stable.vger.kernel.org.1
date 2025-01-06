Return-Path: <stable+bounces-107201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E8A02AAA
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC461651A9
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB55143C7E;
	Mon,  6 Jan 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wpQ7H+0o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6178F49;
	Mon,  6 Jan 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177757; cv=none; b=qfQuDm25+VzbxYWc26cxhK4foWk9rFNksB2mNjeuYI40cAHojr9ZY8RR6JZSVJcrlNT5cjTX/JLNr0Vh4whFzDMLo3Cj48io8ASop4TntWPqCeMTG9KImlNKi/uSE6bevHgNpsRAqip67GdqVkSb6EgbGox6eD6JYngUV/eUZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177757; c=relaxed/simple;
	bh=yL/qadHIa/qmPcZs8354neSdi5sGHDbKy/FbEhJzG1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhIfQdhEtSLGw7rE4rA0/MrP6c+ZZ698H7insRr4wjQswX7ItlCOLwuPIhNKUT7f/iBXZZgE96gt3US65tpEI5QhXW5+m9UmiCh0GzAL9JzoFr4WEkGdU2qAh0Gw2eCEMe6az4LBA83YAI+9VrLRF3AIj2hQ0TcmNxnb5RiursE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wpQ7H+0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9EBC4CED2;
	Mon,  6 Jan 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177756;
	bh=yL/qadHIa/qmPcZs8354neSdi5sGHDbKy/FbEhJzG1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wpQ7H+0ou+V8v1BLY78lk0+IFZ3v4Z1R4GLXyZQqzxV+F4f0y8h6j2gOXXyaoXMcB
	 LI/62Fva7h10Hz/bpuMiybM5HatVeX/g57XP4Kl/Pazr9GcHZWBQ7u8J1Kzune70Lf
	 dgAH7rUC+wUQnfeHEVWMBXxFw8rnsoUHmoGkoAOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Liang <wangliang74@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 045/156] net: fix memory leak in tcp_conn_request()
Date: Mon,  6 Jan 2025 16:15:31 +0100
Message-ID: <20250106151143.433072107@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit 4f4aa4aa28142d53f8b06585c478476cfe325cfc ]

If inet_csk_reqsk_queue_hash_add() return false, tcp_conn_request() will
return without free the dst memory, which allocated in af_ops->route_req.

Here is the kmemleak stack:

unreferenced object 0xffff8881198631c0 (size 240):
  comm "softirq", pid 0, jiffies 4299266571 (age 1802.392s)
  hex dump (first 32 bytes):
    00 10 9b 03 81 88 ff ff 80 98 da bc ff ff ff ff  ................
    81 55 18 bb ff ff ff ff 00 00 00 00 00 00 00 00  .U..............
  backtrace:
    [<ffffffffb93e8d4c>] kmem_cache_alloc+0x60c/0xa80
    [<ffffffffba11b4c5>] dst_alloc+0x55/0x250
    [<ffffffffba227bf6>] rt_dst_alloc+0x46/0x1d0
    [<ffffffffba23050a>] __mkroute_output+0x29a/0xa50
    [<ffffffffba23456b>] ip_route_output_key_hash+0x10b/0x240
    [<ffffffffba2346bd>] ip_route_output_flow+0x1d/0x90
    [<ffffffffba254855>] inet_csk_route_req+0x2c5/0x500
    [<ffffffffba26b331>] tcp_conn_request+0x691/0x12c0
    [<ffffffffba27bd08>] tcp_rcv_state_process+0x3c8/0x11b0
    [<ffffffffba2965c6>] tcp_v4_do_rcv+0x156/0x3b0
    [<ffffffffba299c98>] tcp_v4_rcv+0x1cf8/0x1d80
    [<ffffffffba239656>] ip_protocol_deliver_rcu+0xf6/0x360
    [<ffffffffba2399a6>] ip_local_deliver_finish+0xe6/0x1e0
    [<ffffffffba239b8e>] ip_local_deliver+0xee/0x360
    [<ffffffffba239ead>] ip_rcv+0xad/0x2f0
    [<ffffffffba110943>] __netif_receive_skb_one_core+0x123/0x140

Call dst_release() to free the dst memory when
inet_csk_reqsk_queue_hash_add() return false in tcp_conn_request().

Fixes: ff46e3b44219 ("Fix race for duplicate reqsk on identical SYN")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Link: https://patch.msgid.link/20241219072859.3783576-1-wangliang74@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2d844e1f867f..2d43b29da15e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7328,6 +7328,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 			if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req,
 								    req->timeout))) {
 				reqsk_free(req);
+				dst_release(dst);
 				return 0;
 			}
 
-- 
2.39.5




