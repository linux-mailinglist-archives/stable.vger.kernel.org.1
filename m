Return-Path: <stable+bounces-224525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCqYA1xQsGmBiAIAu9opvQ
	(envelope-from <stable+bounces-224525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:09:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CDF2554DA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8576630745C2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143F3CCFD1;
	Tue, 10 Mar 2026 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE80cUBM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF6321445
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162466; cv=none; b=oysT0+HX38j0hBAJwVIcL8DDN1qxkzsgce4QNQ581dwk8kE20WQbcsM6yiG4jw+ralom/T82bNNBiiwm+lpxOm0KYf2c0i9YiJd2BnDhrl1ZVUoVNNWA7LDzHl3LI9vmKOoGpK1aR0xNriLpPGiOfvQybZ9hZqgyZtyVppp4D7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162466; c=relaxed/simple;
	bh=WbbQzFfNash0ak6vvZ8JHHiDHuWiqvb6G0aj2KzAHH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbhCdA4rSkDYXz5HFSy/zDHbM2ygSUgL2hoSU0qkjn/8oBBbo1fivaZNxW74JqITxvvDSaw+V7s88GD4oHGtDAg9NUf379QNx+eHfCDaJug6YolYKRaSB2szVBu3DeNPAUdvy1L+8L5HnBgNIErvL1PYSlTQv3ASZYy4Tga8sLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE80cUBM; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c9cabfe5dso185668d50.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162463; x=1773767263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsE/wJoZGbLF5L8GTMnDOMdqAYhi1A4RQQKPiPPW3gA=;
        b=LE80cUBMMhejDveZZ4so4bJ28DUCDiH1wCRsy+EN3UR6TGbho6Wsjzhn6CpC70Agrk
         +QQg90Z9QXw73IHJeVNENUMz4vezd04VKGqLFIFT3y3hp/ZEj+B5bP/0UHKpn6CyocW9
         5mTNe6xbIcSCvkOcu6dKsUvpPWiYBKmOfzFffJJiCQ1lK7TlS2bp5/GfPoAAmccoBrLc
         br8EP1Mh9m+6Q/EDp63nbD9KXSViiFFlzH2TTrf/NZqtHzTVtmO1YJ8yg1WQw/o8DbmV
         YnL1KENepScbUkWFGYW7Q09fDJ+aJbqUyqPUKiLBHlFaN6qIxBJ3msntHqFZKmj2QNAm
         FiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162463; x=1773767263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsE/wJoZGbLF5L8GTMnDOMdqAYhi1A4RQQKPiPPW3gA=;
        b=gZDBkJuJc92I84sUny0+YhuiOQbYImADuWBHDTgoOGY8dMkk74aRDFLbQ3v9Uv0PU/
         nNbmWyN4tIANFd8FWXOQ7Ve9lS0DLrL8UHqQN3oPnjLEgQMORmDAWckqEYbfXSwsO6bM
         H6DzHsqkJ0ujF/X8ca7hFmWSgSD7/DVaqwcBkS1PVyeEeYoco30nqdh/RGL00PDiGNBG
         LV2eWsCgyka+E1NbJWoPi7V1MSNtZl0fZuIMDoAqtBdFPbwFCbCPmW0XLs5tKnhEpK9q
         3KJzWZnb9byrslQF27OvQdr/dYWK92vHMdWrZPmwpPleZDup4pgqAXrswdw7Nlmi6nkw
         F+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXtNBiDQtOts+rvOiGxWxv/i/xzVs31+zmGUkbjEjSZh2qMJZZ2KErmL5XjWqG2ZtBEryVnizs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PJgjolay/oAGdebODX+036Y74HLq8EvEMXqMPYF7fWdJljqk
	QMW6C3dFK9oZjvlS8PvRczVUQ8ic937Yvx0Lan8zvnwf/tYxFIY5CeWU
X-Gm-Gg: ATEYQzwUeaSMBDcZTdV6ywshpox+SO7NUUusay932s6fe2YtI2yrGMMYmXoJtbmC8di
	uqclGGkKA8uFmQgZuVRszys0iJdpvGcHtOGqnKygWy2zAaRbNL2dfMorl04qBadr+BzVZRnerKA
	my1PnrSd6hH6PY2N/tLRRIiu9ao6eHVXweOC/7CwM2EpjyfSqSnlKWVvBwfxLLDwAp3mRLnzVHj
	whGzqK5PuZKRrBret+lYl204jXbvt54XQgQPJh0sONgmLLP2q4Nq1HZiZcQOQ30vxktgFEv4dr/
	8ZHKGUUL6RgFzjKL5ZEVw2s+6pbOPSREEtyxZm7D8cCwc1bUBUjN4tcGSTZhZufo66Xx/dVZipD
	k10yufSRTtavhTCS0XrlcwfOng99UIdVqHzHf9avXTgt/iFB2YPsW6VwaFl5hCsh++ql1bCrSu+
	VK3UOL5xXSekIquq6/Ir2D1mGPon7QfRi09XyOn/YXIyh8QXHYSLaP+4/bt+JeRv7w2gE=
X-Received: by 2002:a53:ee42:0:b0:64a:ce57:cac4 with SMTP id 956f58d0204a3-64d5a13e158mr2992719d50.24.1773162463385;
        Tue, 10 Mar 2026 10:07:43 -0700 (PDT)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d175d32cdsm6930041d50.2.2026.03.10.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:07:42 -0700 (PDT)
From: Mehul Rao <mehulrao@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ying.xue@windriver.com,
	tung.q.nguyen@dektech.com.au,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH net v3] tipc: fix divide-by-zero in tipc_sk_filter_connect()
Date: Tue, 10 Mar 2026 13:07:30 -0400
Message-ID: <20260310170730.28841-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63CDF2554DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,windriver.com,dektech.com.au,vger.kernel.org,lists.sourceforge.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-224525-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mehulrao@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

A user can set conn_timeout to any value via
setsockopt(TIPC_CONN_TIMEOUT), including values less than 4.  When a
SYN is rejected with TIPC_ERR_OVERLOAD and the retry path in
tipc_sk_filter_connect() executes:

    delay %= (tsk->conn_timeout / 4);

If conn_timeout is in the range [0, 3], the integer division yields 0,
and the modulo operation triggers a divide-by-zero exception, causing a
kernel oops/panic.

Fix this by clamping conn_timeout to a minimum of 4 at the point of use
in tipc_sk_filter_connect().

Oops: divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 119 Comm: poc-F144 Not tainted 7.0.0-rc2+
RIP: 0010:tipc_sk_filter_rcv (net/tipc/socket.c:2236 net/tipc/socket.c:2362)
Call Trace:
 tipc_sk_backlog_rcv (include/linux/instrumented.h:82 include/linux/atomic/atomic-instrumented.h:32 include/net/sock.h:2357 net/tipc/socket.c:2406)
 __release_sock (include/net/sock.h:1185 net/core/sock.c:3213)
 release_sock (net/core/sock.c:3797)
 tipc_connect (net/tipc/socket.c:2570)
 __sys_connect (include/linux/file.h:62 include/linux/file.h:83 net/socket.c:2098)

Fixes: 6787927475e5 ("tipc: buffer overflow handling in listener socket")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
Changes in v3:
- Decode stack trace symbols (Eric Dumazet)
- Link to v2: https://lore.kernel.org/netdev/20260306185005.22120-1-mehulrao@gmail.com/

Changes in v2:
- Clamp conn_timeout at the point of use in tipc_sk_filter_connect()
  instead of rejecting small values in tipc_setsockopt()
- Link to v1: https://lore.kernel.org/netdev/20260305215336.645186-1-mehulrao@gmail.com/
---
 net/tipc/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 4c618c2b871d..9329919fb07f 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2233,6 +2233,8 @@ static bool tipc_sk_filter_connect(struct tipc_sock *tsk, struct sk_buff *skb,
 		if (skb_queue_empty(&sk->sk_write_queue))
 			break;
 		get_random_bytes(&delay, 2);
+		if (tsk->conn_timeout < 4)
+			tsk->conn_timeout = 4;
 		delay %= (tsk->conn_timeout / 4);
 		delay = msecs_to_jiffies(delay + 100);
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + delay);
-- 
2.53.0


