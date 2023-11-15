Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF47ED059
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjKOTy2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343496AbjKOTy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:54:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18F7C2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:54:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77ED0C433C8;
        Wed, 15 Nov 2023 19:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078063;
        bh=DfmCpuOLiIy4/KywrET6QN7aG58wXipS3jatPQeG4gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pUh8hAjGte/fOc+y78Tce4vOIb1Wk+9+VW9R+4RGGx486y1Ip18F0/YvYDaIyW02A
         y3HdemVTA3uk3OtHOnFiIat6hz/VHp7HyhG03LhiBPE0Gnm4KF3SWCxLmtrQQf7ouq
         hK5uE6VPO8K4oFP/4IUT+0S231NeQUU/+Jne3pPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Long <lucien.xin@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 063/379] selftests: netfilter: test for sctp collision processing in nf_conntrack
Date:   Wed, 15 Nov 2023 14:22:18 -0500
Message-ID: <20231115192648.872540459@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit cf791b22bef7d9352ff730a8727d3871942d6001 ]

This patch adds a test case to reproduce the SCTP DATA chunk retransmission
timeout issue caused by the improper SCTP collision processing in netfilter
nf_conntrack_proto_sctp.

In this test, client sends a INIT chunk, but the INIT_ACK replied from
server is delayed until the server sends a INIT chunk to start a new
connection from its side. After the connection is complete from server
side, the delayed INIT_ACK arrives in nf_conntrack_proto_sctp.

The delayed INIT_ACK should be dropped in nf_conntrack_proto_sctp instead
of updating the vtag with the out-of-date init_tag, otherwise, the vtag
in DATA chunks later sent by client don't match the vtag in the conntrack
entry and the DATA chunks get dropped.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: c4eee56e14fe ("net: skb_find_text: Ignore patterns extending past 'to'")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/netfilter/Makefile    |  5 +-
 .../netfilter/conntrack_sctp_collision.sh     | 89 +++++++++++++++++
 .../selftests/netfilter/sctp_collision.c      | 99 +++++++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
 create mode 100644 tools/testing/selftests/netfilter/sctp_collision.c

diff --git a/tools/testing/selftests/netfilter/Makefile b/tools/testing/selftests/netfilter/Makefile
index 321db8850da00..ef90aca4cc96a 100644
--- a/tools/testing/selftests/netfilter/Makefile
+++ b/tools/testing/selftests/netfilter/Makefile
@@ -6,13 +6,14 @@ TEST_PROGS := nft_trans_stress.sh nft_fib.sh nft_nat.sh bridge_brouter.sh \
 	nft_concat_range.sh nft_conntrack_helper.sh \
 	nft_queue.sh nft_meta.sh nf_nat_edemux.sh \
 	ipip-conntrack-mtu.sh conntrack_tcp_unreplied.sh \
-	conntrack_vrf.sh nft_synproxy.sh rpath.sh nft_audit.sh
+	conntrack_vrf.sh nft_synproxy.sh rpath.sh nft_audit.sh \
+	conntrack_sctp_collision.sh
 
 HOSTPKG_CONFIG := pkg-config
 
 CFLAGS += $(shell $(HOSTPKG_CONFIG) --cflags libmnl 2>/dev/null)
 LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
 
-TEST_GEN_FILES =  nf-queue connect_close audit_logread
+TEST_GEN_FILES =  nf-queue connect_close audit_logread sctp_collision
 
 include ../lib.mk
diff --git a/tools/testing/selftests/netfilter/conntrack_sctp_collision.sh b/tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
new file mode 100755
index 0000000000000..a924e595cfd8b
--- /dev/null
+++ b/tools/testing/selftests/netfilter/conntrack_sctp_collision.sh
@@ -0,0 +1,89 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing For SCTP COLLISION SCENARIO as Below:
+#
+#   14:35:47.655279 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [INIT] [init tag: 2017837359]
+#   14:35:48.353250 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [INIT] [init tag: 1187206187]
+#   14:35:48.353275 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [INIT ACK] [init tag: 2017837359]
+#   14:35:48.353283 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [COOKIE ECHO]
+#   14:35:48.353977 IP CLIENT_IP.PORT > SERVER_IP.PORT: sctp (1) [COOKIE ACK]
+#   14:35:48.855335 IP SERVER_IP.PORT > CLIENT_IP.PORT: sctp (1) [INIT ACK] [init tag: 164579970]
+#
+# TOPO: SERVER_NS (link0)<--->(link1) ROUTER_NS (link2)<--->(link3) CLIENT_NS
+
+CLIENT_NS=$(mktemp -u client-XXXXXXXX)
+CLIENT_IP="198.51.200.1"
+CLIENT_PORT=1234
+
+SERVER_NS=$(mktemp -u server-XXXXXXXX)
+SERVER_IP="198.51.100.1"
+SERVER_PORT=1234
+
+ROUTER_NS=$(mktemp -u router-XXXXXXXX)
+CLIENT_GW="198.51.200.2"
+SERVER_GW="198.51.100.2"
+
+# setup the topo
+setup() {
+	ip net add $CLIENT_NS
+	ip net add $SERVER_NS
+	ip net add $ROUTER_NS
+	ip -n $SERVER_NS link add link0 type veth peer name link1 netns $ROUTER_NS
+	ip -n $CLIENT_NS link add link3 type veth peer name link2 netns $ROUTER_NS
+
+	ip -n $SERVER_NS link set link0 up
+	ip -n $SERVER_NS addr add $SERVER_IP/24 dev link0
+	ip -n $SERVER_NS route add $CLIENT_IP dev link0 via $SERVER_GW
+
+	ip -n $ROUTER_NS link set link1 up
+	ip -n $ROUTER_NS link set link2 up
+	ip -n $ROUTER_NS addr add $SERVER_GW/24 dev link1
+	ip -n $ROUTER_NS addr add $CLIENT_GW/24 dev link2
+	ip net exec $ROUTER_NS sysctl -wq net.ipv4.ip_forward=1
+
+	ip -n $CLIENT_NS link set link3 up
+	ip -n $CLIENT_NS addr add $CLIENT_IP/24 dev link3
+	ip -n $CLIENT_NS route add $SERVER_IP dev link3 via $CLIENT_GW
+
+	# simulate the delay on OVS upcall by setting up a delay for INIT_ACK with
+	# tc on $SERVER_NS side
+	tc -n $SERVER_NS qdisc add dev link0 root handle 1: htb
+	tc -n $SERVER_NS class add dev link0 parent 1: classid 1:1 htb rate 100mbit
+	tc -n $SERVER_NS filter add dev link0 parent 1: protocol ip u32 match ip protocol 132 \
+		0xff match u8 2 0xff at 32 flowid 1:1
+	tc -n $SERVER_NS qdisc add dev link0 parent 1:1 handle 10: netem delay 1200ms
+
+	# simulate the ctstate check on OVS nf_conntrack
+	ip net exec $ROUTER_NS iptables -A FORWARD -m state --state INVALID,UNTRACKED -j DROP
+	ip net exec $ROUTER_NS iptables -A INPUT -p sctp -j DROP
+
+	# use a smaller number for assoc's max_retrans to reproduce the issue
+	modprobe sctp
+	ip net exec $CLIENT_NS sysctl -wq net.sctp.association_max_retrans=3
+}
+
+cleanup() {
+	ip net exec $CLIENT_NS pkill sctp_collision 2>&1 >/dev/null
+	ip net exec $SERVER_NS pkill sctp_collision 2>&1 >/dev/null
+	ip net del "$CLIENT_NS"
+	ip net del "$SERVER_NS"
+	ip net del "$ROUTER_NS"
+}
+
+do_test() {
+	ip net exec $SERVER_NS ./sctp_collision server \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT &
+	ip net exec $CLIENT_NS ./sctp_collision client \
+		$CLIENT_IP $CLIENT_PORT $SERVER_IP $SERVER_PORT
+}
+
+# NOTE: one way to work around the issue is set a smaller hb_interval
+# ip net exec $CLIENT_NS sysctl -wq net.sctp.hb_interval=3500
+
+# run the test case
+trap cleanup EXIT
+setup && \
+echo "Test for SCTP Collision in nf_conntrack:" && \
+do_test && echo "PASS!"
+exit $?
diff --git a/tools/testing/selftests/netfilter/sctp_collision.c b/tools/testing/selftests/netfilter/sctp_collision.c
new file mode 100644
index 0000000000000..21bb1cfd8a856
--- /dev/null
+++ b/tools/testing/selftests/netfilter/sctp_collision.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+
+int main(int argc, char *argv[])
+{
+	struct sockaddr_in saddr = {}, daddr = {};
+	int sd, ret, len = sizeof(daddr);
+	struct timeval tv = {25, 0};
+	char buf[] = "hello";
+
+	if (argc != 6 || (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
+		printf("%s <server|client> <LOCAL_IP> <LOCAL_PORT> <REMOTE_IP> <REMOTE_PORT>\n",
+		       argv[0]);
+		return -1;
+	}
+
+	sd = socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP);
+	if (sd < 0) {
+		printf("Failed to create sd\n");
+		return -1;
+	}
+
+	saddr.sin_family = AF_INET;
+	saddr.sin_addr.s_addr = inet_addr(argv[2]);
+	saddr.sin_port = htons(atoi(argv[3]));
+
+	ret = bind(sd, (struct sockaddr *)&saddr, sizeof(saddr));
+	if (ret < 0) {
+		printf("Failed to bind to address\n");
+		goto out;
+	}
+
+	ret = listen(sd, 5);
+	if (ret < 0) {
+		printf("Failed to listen on port\n");
+		goto out;
+	}
+
+	daddr.sin_family = AF_INET;
+	daddr.sin_addr.s_addr = inet_addr(argv[4]);
+	daddr.sin_port = htons(atoi(argv[5]));
+
+	/* make test shorter than 25s */
+	ret = setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
+	if (ret < 0) {
+		printf("Failed to setsockopt SO_RCVTIMEO\n");
+		goto out;
+	}
+
+	if (!strcmp(argv[1], "server")) {
+		sleep(1); /* wait a bit for client's INIT */
+		ret = connect(sd, (struct sockaddr *)&daddr, len);
+		if (ret < 0) {
+			printf("Failed to connect to peer\n");
+			goto out;
+		}
+		ret = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&daddr, &len);
+		if (ret < 0) {
+			printf("Failed to recv msg %d\n", ret);
+			goto out;
+		}
+		ret = sendto(sd, buf, strlen(buf) + 1, 0, (struct sockaddr *)&daddr, len);
+		if (ret < 0) {
+			printf("Failed to send msg %d\n", ret);
+			goto out;
+		}
+		printf("Server: sent! %d\n", ret);
+	}
+
+	if (!strcmp(argv[1], "client")) {
+		usleep(300000); /* wait a bit for server's listening */
+		ret = connect(sd, (struct sockaddr *)&daddr, len);
+		if (ret < 0) {
+			printf("Failed to connect to peer\n");
+			goto out;
+		}
+		sleep(1); /* wait a bit for server's delayed INIT_ACK to reproduce the issue */
+		ret = sendto(sd, buf, strlen(buf) + 1, 0, (struct sockaddr *)&daddr, len);
+		if (ret < 0) {
+			printf("Failed to send msg %d\n", ret);
+			goto out;
+		}
+		ret = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&daddr, &len);
+		if (ret < 0) {
+			printf("Failed to recv msg %d\n", ret);
+			goto out;
+		}
+		printf("Client: rcvd! %d\n", ret);
+	}
+	ret = 0;
+out:
+	close(sd);
+	return ret;
+}
-- 
2.42.0



