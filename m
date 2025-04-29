Return-Path: <stable+bounces-137474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D5AA13B5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A8D984C20
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA880251780;
	Tue, 29 Apr 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4lhT3jt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C971FE468;
	Tue, 29 Apr 2025 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946173; cv=none; b=BYg+HmsQSCfySZu8rSOcFhGx0EHzADlyjKmb7+CknN4OpGZUc297ndRa8l7pItHZ+EjzDBITS7nCNfzkVU+2FIwtCjRk2wlqXcxJs71zBLc/q83Xzv9wY/wYR/qxgqddl5pfSs223VAZoGjY0nqn6rfOSDzqH69esyNaNTOOZ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946173; c=relaxed/simple;
	bh=rAgK4h0fFLvXRg02B0nLuDd3TgbVR46G1OjjpsGIwLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnyVMxh55WYHbsQtkvzl+p7cudCQMbBDvQNzTBU+Hyr4PNmj9LKR1saoiB4MtveV5qgkbbmu7vlhOay29NiAMY0iDD5qRXKKXok95smx6T5Vmr9acXAWpPPUEEhX4kgNPkC1rm9+n2A85NDkLo+SnuvKhNbAg+1q0hSUqukfDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4lhT3jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4E4C4CEE3;
	Tue, 29 Apr 2025 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946173;
	bh=rAgK4h0fFLvXRg02B0nLuDd3TgbVR46G1OjjpsGIwLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4lhT3jt82zrYYoipGuQ4pVz2aCwlLXPolJz3o44P9t5J3P8WSt4BtCutUc3+iUK6
	 IMrVKndE4jB1jp5o4B4pLo9ymLtNtZFYxNs7fckZ2uHlap5VJ2+J+c0vaDF/rMohKy
	 AdCAfsrAp2oj9xcOEzl3ghFSBOfCcxNOHaRu8Flw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 178/311] selftests/bpf: Fix stdout race condition in traffic monitor
Date: Tue, 29 Apr 2025 18:40:15 +0200
Message-ID: <20250429161128.319280502@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amery Hung <ameryhung@gmail.com>

[ Upstream commit b99f27e90268b1a814c13f8bd72ea1db448ea257 ]

Fix a race condition between the main test_progs thread and the traffic
monitoring thread. The traffic monitor thread tries to print a line
using multiple printf and use flockfile() to prevent the line from being
torn apart. Meanwhile, the main thread doing io redirection can reassign
or close stdout when going through tests. A deadlock as shown below can
happen.

       main                      traffic_monitor_thread
       ====                      ======================
                                 show_transport()
                                 -> flockfile(stdout)

stdio_hijack_init()
-> stdout = open_memstream(log_buf, log_cnt);
   ...
   env.subtest_state->stdout_saved = stdout;

                                    ...
                                    funlockfile(stdout)
stdio_restore_cleanup()
-> fclose(env.subtest_state->stdout_saved);

After the traffic monitor thread lock stdout, A new memstream can be
assigned to stdout by the main thread. Therefore, the traffic monitor
thread later will not be able to unlock the original stdout. As the
main thread tries to access the old stdout, it will hang indefinitely
as it is still locked by the traffic monitor thread.

The deadlock can be reproduced by running test_progs repeatedly with
traffic monitor enabled:

for ((i=1;i<=100;i++)); do
  ./test_progs -a flow_dissector_skb* -m '*'
done

Fix this by only calling printf once and remove flockfile()/funlockfile().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20250213233217.553258-1-ameryhung@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/network_helpers.c | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 80844a5fb1fee..95e943270f359 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -771,12 +771,13 @@ static const char *pkt_type_str(u16 pkt_type)
 	return "Unknown";
 }
 
+#define MAX_FLAGS_STRLEN 21
 /* Show the information of the transport layer in the packet */
 static void show_transport(const u_char *packet, u16 len, u32 ifindex,
 			   const char *src_addr, const char *dst_addr,
 			   u16 proto, bool ipv6, u8 pkt_type)
 {
-	char *ifname, _ifname[IF_NAMESIZE];
+	char *ifname, _ifname[IF_NAMESIZE], flags[MAX_FLAGS_STRLEN] = "";
 	const char *transport_str;
 	u16 src_port, dst_port;
 	struct udphdr *udp;
@@ -817,29 +818,21 @@ static void show_transport(const u_char *packet, u16 len, u32 ifindex,
 
 	/* TCP or UDP*/
 
-	flockfile(stdout);
+	if (proto == IPPROTO_TCP)
+		snprintf(flags, MAX_FLAGS_STRLEN, "%s%s%s%s",
+			 tcp->fin ? ", FIN" : "",
+			 tcp->syn ? ", SYN" : "",
+			 tcp->rst ? ", RST" : "",
+			 tcp->ack ? ", ACK" : "");
+
 	if (ipv6)
-		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d",
+		printf("%-7s %-3s IPv6 %s.%d > %s.%d: %s, length %d%s\n",
 		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
-		       dst_addr, dst_port, transport_str, len);
+		       dst_addr, dst_port, transport_str, len, flags);
 	else
-		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d",
+		printf("%-7s %-3s IPv4 %s:%d > %s:%d: %s, length %d%s\n",
 		       ifname, pkt_type_str(pkt_type), src_addr, src_port,
-		       dst_addr, dst_port, transport_str, len);
-
-	if (proto == IPPROTO_TCP) {
-		if (tcp->fin)
-			printf(", FIN");
-		if (tcp->syn)
-			printf(", SYN");
-		if (tcp->rst)
-			printf(", RST");
-		if (tcp->ack)
-			printf(", ACK");
-	}
-
-	printf("\n");
-	funlockfile(stdout);
+		       dst_addr, dst_port, transport_str, len, flags);
 }
 
 static void show_ipv6_packet(const u_char *packet, u32 ifindex, u8 pkt_type)
-- 
2.39.5




