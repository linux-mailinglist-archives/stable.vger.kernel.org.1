Return-Path: <stable+bounces-58390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D8292B6C6
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DB01F241AF
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B01591F0;
	Tue,  9 Jul 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jcACK4/s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA014EC4D;
	Tue,  9 Jul 2024 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523789; cv=none; b=VajOitl9t9njcrP9IivAErj9jNYVkc1wFwxMLOBcMoQHTdGjDGNrUxP8TERXmHsJDZ0WT7X81UU9ifWQslH2gPJEkwLeiBVAo8FVEp+dpDtrek7tYcB4Vlo/ltrs0ITl/AyAqPwfvegQyaBVabEe+XaZVbpYXNQyF4g65aNMFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523789; c=relaxed/simple;
	bh=7J7n2rvf4/Z0a74k490+uRYQGI1d4IxMMDBNM0zMGN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neIQ4/tmVDQDQcZLivbOy8Jqv35+pi/G3/ybKg0+wFIMrSrNOMG2UEI/fdeUmS0TaRN6coa61puXV9AoyxT3V1nYLGiVhSphquH/vc/ooZ1dWFplf56xY+FSSaoUcmzAcgYDmh2r/SOph0SwbUz7OfU9ocl5Rts2r6RNzRBzGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jcACK4/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61297C32786;
	Tue,  9 Jul 2024 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523789;
	bh=7J7n2rvf4/Z0a74k490+uRYQGI1d4IxMMDBNM0zMGN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcACK4/sXSNFqsfK/8qO6s397Td03GJ13lV4UGI2ecsKNAwKp8kmxD8YCanckfuHR
	 kz9JYfd9HehRpVTaVi1pC4Gji8ynzUl/aUeGj6z3aKfAVpKd7u9GVRxyzRUQ6YjsLd
	 LQgfFS9eExnE+UWQOv69gVv+S0EPVQRX7swDG79k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zijian Zhang <zijianzhang@bytedance.com>,
	Xiaochun Lu <xiaochun.lu@bytedance.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 082/139] selftests: fix OOM in msg_zerocopy selftest
Date: Tue,  9 Jul 2024 13:09:42 +0200
Message-ID: <20240709110701.345903532@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zijian Zhang <zijianzhang@bytedance.com>

[ Upstream commit af2b7e5b741aaae9ffbba2c660def434e07aa241 ]

In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
until the socket is not writable. Typically, it will start the receiving
process after around 30+ sendmsgs. However, as the introduction of commit
dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is
always writable and does not get any chance to run recv notifications.
The selftest always exits with OUT_OF_MEMORY because the memory used by
opt_skb exceeds the net.core.optmem_max. Meanwhile, it could be set to a
different value to trigger OOM on older kernels too.

Thus, we introduce "cfg_notification_limit" to force sender to receive
notifications after some number of sendmsgs.

Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20240701225349.3395580-2-zijianzhang@bytedance.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/msg_zerocopy.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e85..926556febc83c 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -85,6 +85,7 @@ static bool cfg_rx;
 static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
+static int  cfg_notification_limit = 32;
 static bool cfg_zerocopy;
 
 static socklen_t cfg_alen;
@@ -95,6 +96,7 @@ static char payload[IP_MAXPACKET];
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
+static uint32_t sends_since_notify;
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -208,6 +210,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		error(1, errno, "send");
 	if (cfg_verbose && ret != len)
 		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
+	sends_since_notify++;
 
 	if (len) {
 		packets++;
@@ -460,6 +463,7 @@ static bool do_recv_completion(int fd, int domain)
 static void do_recv_completions(int fd, int domain)
 {
 	while (do_recv_completion(fd, domain)) {}
+	sends_since_notify = 0;
 }
 
 /* Wait for all remaining completions on the errqueue */
@@ -549,6 +553,9 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
+		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
+			do_recv_completions(fd, domain);
+
 		while (!do_poll(fd, POLLOUT)) {
 			if (cfg_zerocopy)
 				do_recv_completions(fd, domain);
@@ -708,7 +715,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -736,6 +743,9 @@ static void parse_opts(int argc, char **argv)
 			if (cfg_ifindex == 0)
 				error(1, errno, "invalid iface: %s", optarg);
 			break;
+		case 'l':
+			cfg_notification_limit = strtoul(optarg, NULL, 0);
+			break;
 		case 'm':
 			cfg_cork_mixed = true;
 			break;
-- 
2.43.0




