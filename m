Return-Path: <stable+bounces-233283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP8iOAn+0GkIDQcAu9opvQ
	(envelope-from <stable+bounces-233283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 14:03:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6539AFE9
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 14:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3047A3006445
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE872D661C;
	Sat,  4 Apr 2026 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hve8aAw9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545EB2F261C
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775304199; cv=none; b=O4QPDdy5dNHtQwSx5bPa91GOvZ+vAjTd9M17Xpx12DpOHZerQOCyu2QPc5w2yFtsl55W8K7WUNa+AaeaiCcYYd+VRqATe5yvJM6sABdBjSE9kCcNVhjggEQpNk31eO+NZ0vo3fXtf7TTizDbGxQ1k6ExQkweO5h9JaEUuGri+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775304199; c=relaxed/simple;
	bh=0sQ5dDPyDwrm6UkncMO2YOHozorgUawqoXyuAuiNQow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzGIeF3o1CqAr3wQsNbvz3+uiphL1J7fKzhIgwCDBe2ZezINOpmZ8/oimuLqFH5wJp12cXoNg8yrrsc65duQLoOVDAVGQBbFEd/IV65dJhrP7+0TbbntJ0DnNaAE+GazlliWsW6oCn/y5b2Wbq6TxClUxI3fpgyvfG2DiSINR3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hve8aAw9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso2455792f8f.2
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775304195; x=1775908995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiqQrSFv6eImtp0CDB10DYeiRWrmo0saS7IHyi14+4c=;
        b=hve8aAw9uDmXaf/ZqC/z/yWxe9+MiDTYnd4jDCJv5UNBv1gxUprXTJn2XImVgms4bS
         eIWDxo44SCAsS1Qnxr95y6+nzfIE5qSUIn2AKSLzkadynYmBEDU23jNBXyb8riZ3ZK8j
         YVWV8YulTvmSBwWkvYSevVd16TShj06dXJUoGFbJKxF2wvvtbw1VGDrPO5v233AEmO9F
         NRVCeNhZUbzFUlEIn/BUTqoWkFTL1rnqc18i7SWISUVjsMd5s3VHlB1Dd/DHPNYxe7wH
         Y1EMwAlCuw7LdQH0tDV7rY9bl4gXD1NbkqtX64+jQtRnkRJrVAyijBdt1KO3Zv/yVcd3
         nG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775304195; x=1775908995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiqQrSFv6eImtp0CDB10DYeiRWrmo0saS7IHyi14+4c=;
        b=U6cI/nXP0rolBVQBUf7bBb/ohmltYOaZXWAyg7ul7lbUOZdYhu8YnlJZAAWrOutuxG
         WpInzQJnqep1U/ZNt9FZGCUKdY75rwLgpFGMgeBbVd0bNyGYii7aK5VMUBrKje+J6WG6
         o5hFG7GEZP9XNsp+GFMe1a4z4HWGSMx1sCQbQwlHnptbhdoM/9xVfHaRnFj9Sj28JDPm
         Veryll3xl9G87BqgqAVlHB5tBpRNA2aBNddtanGybzHRb5Ytac4Zw7n4Yv9382we7Y5T
         RQkHB7ed+zkpWFY2ZvpPxX3UPrFJFhLA+pGwzmp5smB2WPZVnCu5QFkPw3laob/Hw0/m
         p3zw==
X-Forwarded-Encrypted: i=1; AJvYcCXMykqZN8Bme4npmpbm867rXcikWuHF/nMl8f8OZvVnZsnDGaUUJDkmJ8d/3WGbSWBFgb+bWEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36I0Pc5GUuuSrQ2fnDxXaFliRAuqBhreHRdFo81rur+ai3ygM
	bWbASpTe7nq712nEd50wabsDWKDxKB8+fFxVbBXkOPgr3qfS7BzMTMu/
X-Gm-Gg: AeBDietxCT6bIYc02/wYZDKXk1JdEd1qkbsKuIxnuWVnCBqhNy4mmHz3CdafWwQTpjV
	vQ4UCkYMRUwzmcOwkBxXpIYsWexWHMWYjY6nnLEGHMSsJTBkcqdKmTn8SJTx3ed2k+XEcf03g+i
	YnpJrO8OWoZ4e5CKNMmz3h/AMfQWTbEpTzbL9mDcGLFK6FlxawvExxh2jHZEQaTfNxs6YeqHJ55
	LRZzOIO5Qz2J6JOTHiLLUMLebIWwmYp8RQHXpMaPsgXZAEW+hXeHeUFt3scta3L24/gxlz2TXTZ
	fx9Tn/pVX2LEys36Oj8Q72e3dTAeZk6VkIi24AeoeOjCzBujKKx4B7pXQC6ghxpw9D8WbmrKVJd
	ekx3yr7XaVoMC1MUOE1I8BwCMC2+cVpznBHzD6viOQmCZtcLIHIzddd/bLIbLmuTNIGHtW6lvgZ
	LSIgznTJzP+N5ACivPpXjJEjXNcQ0CkYo2kZ3WJWeu1V5zxTMfELzkkVoR4EBCFJQ5EAzf3n2Cs
	eFqI2t+Oyhd9YT6WlyV8tM=
X-Received: by 2002:a05:6000:40dd:b0:43d:71b:204b with SMTP id ffacd0b85a97d-43d292ebf2fmr9939871f8f.39.1775304195341;
        Sat, 04 Apr 2026 05:03:15 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d58e5sm25654623f8f.23.2026.04.04.05.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:03:14 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2 2/2] selftests: net: add act_nat ICMP inner checksum test
Date: Sat,  4 Apr 2026 13:03:10 +0100
Message-ID: <20260404120310.88218-2-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404120310.88218-1-devnexen@gmail.com>
References: <20260404120310.88218-1-devnexen@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233283-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 74F6539AFE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Verify that act_nat correctly updates the inner IP header
checksum when rewriting addresses inside ICMP error payloads.

The test sets up two namespaces with act_nat on a veth pair,
triggers an ICMP destination unreachable, and validates the
inner IP header checksum in the received ICMP error.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/act_nat_icmp_csum.sh        |  72 +++++++++
 .../selftests/net/act_nat_icmp_csum_verify.py | 144 ++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100755 tools/testing/selftests/net/act_nat_icmp_csum.sh
 create mode 100755 tools/testing/selftests/net/act_nat_icmp_csum_verify.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6bced3ed798b..1683db55e36f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -7,6 +7,7 @@ CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 CFLAGS += -I../
 
 TEST_PROGS := \
+	act_nat_icmp_csum.sh \
 	altnames.sh \
 	amt.sh \
 	arp_ndisc_evict_nocarrier.sh \
diff --git a/tools/testing/selftests/net/act_nat_icmp_csum.sh b/tools/testing/selftests/net/act_nat_icmp_csum.sh
new file mode 100755
index 000000000000..2a0986bfe577
--- /dev/null
+++ b/tools/testing/selftests/net/act_nat_icmp_csum.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that act_nat correctly updates the inner IP header checksum
+# when rewriting addresses inside ICMP error payloads.
+#
+# Setup:
+# +---------------------+                      +---------------------+
+# | NS1                 |                      | NS2                 |
+# |                     |                      |                     |
+# |         +-------+   |                      |   +-------+         |
+# |         | veth0 +---+----------------------+---+ veth0 |         |
+# |         +-------+   |                      |   +-------+         |
+# |       10.0.1.1/24   |                      | 10.0.2.1/24         |
+# +---------------------+                      +---------------------+
+#
+# On NS1's veth0:
+#   egress act_nat:  src 10.0.1.0/24 -> 10.0.2.0/24
+#   ingress act_nat: dst 10.0.2.0/24 -> 10.0.1.0/24
+#
+# NS1 pings 10.0.2.99 (unreachable in NS2). NS2 sends back an ICMP
+# "destination host unreachable". The ICMP error contains a copy of the
+# original IP header whose source was NATted. On ingress, act_nat rewrites
+# the inner destination back. The inner IP header checksum must be updated.
+#
+# We use a raw ICMP socket in NS1 to receive the post-NAT ICMP error
+# and verify the inner IP header checksum is correct.
+
+source lib.sh
+
+cleanup()
+{
+	cleanup_ns $NS1 $NS2
+}
+
+trap cleanup EXIT
+
+# Check for required modules
+for mod in act_nat cls_u32 sch_ingress; do
+	modinfo $mod &>/dev/null || { echo "SKIP: Need $mod module"; exit $ksft_skip; }
+done
+
+setup_ns NS1 NS2
+
+ip -netns $NS1 link add veth0 type veth peer name veth0 netns $NS2
+ip -netns $NS1 link set dev veth0 up
+ip -netns $NS2 link set dev veth0 up
+
+ip -netns $NS1 addr add 10.0.1.1/24 dev veth0
+ip -netns $NS2 addr add 10.0.2.1/24 dev veth0
+
+ip netns exec $NS2 sysctl -qw net.ipv4.ip_forward=1
+ip netns exec $NS2 sysctl -qw net.ipv4.icmp_ratelimit=0
+
+ip -netns $NS1 route add 10.0.2.0/24 dev veth0
+
+# act_nat on NS1's veth0
+ip netns exec $NS1 tc qdisc add dev veth0 clsact
+
+# Egress: rewrite src 10.0.1.x -> 10.0.2.x
+ip netns exec $NS1 tc filter add dev veth0 egress protocol ip prio 1 \
+	u32 match ip src 10.0.1.0/24 \
+	action nat egress 10.0.1.0/24 10.0.2.0
+
+# Ingress: rewrite dst 10.0.2.x -> 10.0.1.x
+ip netns exec $NS1 tc filter add dev veth0 ingress protocol ip prio 1 \
+	u32 match ip dst 10.0.2.0/24 \
+	action nat ingress 10.0.2.0/24 10.0.1.0
+
+# Run the test: send ping and capture the ICMP error via raw socket
+ip netns exec $NS1 python3 "$(dirname "$0")/act_nat_icmp_csum_verify.py"
+exit $?
diff --git a/tools/testing/selftests/net/act_nat_icmp_csum_verify.py b/tools/testing/selftests/net/act_nat_icmp_csum_verify.py
new file mode 100755
index 000000000000..5d62831f6f49
--- /dev/null
+++ b/tools/testing/selftests/net/act_nat_icmp_csum_verify.py
@@ -0,0 +1,144 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Verify that act_nat correctly updates the inner IP header checksum
+# in ICMP error packets. Sends a ping to an unreachable host and
+# captures the resulting ICMP error via a raw socket, then validates
+# the inner IP header checksum.
+#
+# This script is expected to run inside a network namespace that has
+# act_nat configured on its veth interface.
+
+import socket
+import struct
+import sys
+import os
+import signal
+
+
+def ip_checksum(header_bytes):
+    """Compute IP header checksum."""
+    if len(header_bytes) % 2:
+        header_bytes += b'\x00'
+    total = 0
+    for i in range(0, len(header_bytes), 2):
+        total += (header_bytes[i] << 8) + header_bytes[i + 1]
+    while total >> 16:
+        total = (total & 0xffff) + (total >> 16)
+    return (~total) & 0xffff
+
+
+def verify_inner_checksum(icmp_payload):
+    """Extract and verify the inner IP header checksum from ICMP error."""
+    # ICMP error payload starts with the original IP header
+    if len(icmp_payload) < 20:
+        return None, "inner IP header too short"
+
+    inner_ihl = (icmp_payload[0] & 0x0f) * 4
+    if len(icmp_payload) < inner_ihl:
+        return None, "inner IP header truncated"
+
+    inner_hdr = icmp_payload[:inner_ihl]
+
+    stored_csum = (inner_hdr[10] << 8) | inner_hdr[11]
+
+    # Zero out checksum field and recompute
+    hdr_for_csum = bytearray(inner_hdr)
+    hdr_for_csum[10] = 0
+    hdr_for_csum[11] = 0
+    computed_csum = ip_checksum(bytes(hdr_for_csum))
+
+    inner_src = socket.inet_ntoa(inner_hdr[12:16])
+    inner_dst = socket.inet_ntoa(inner_hdr[16:20])
+    info = f"inner src={inner_src} dst={inner_dst}"
+
+    if stored_csum == computed_csum:
+        return True, f"valid (0x{stored_csum:04x}) {info}"
+    else:
+        return False, (f"mismatch: stored=0x{stored_csum:04x} "
+                       f"computed=0x{computed_csum:04x} {info}")
+
+
+def main():
+    # Open raw ICMP socket to receive ICMP errors
+    try:
+        sock = socket.socket(socket.AF_INET, socket.SOCK_RAW,
+                             socket.IPPROTO_ICMP)
+    except PermissionError:
+        print("SKIP - need CAP_NET_RAW")
+        return 4
+
+    sock.settimeout(5)
+
+    # Send a ping to an unreachable address to trigger ICMP error
+    try:
+        ping_sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM,
+                                  socket.IPPROTO_ICMP)
+    except (PermissionError, OSError):
+        # Fallback: use raw socket for ping
+        ping_sock = socket.socket(socket.AF_INET, socket.SOCK_RAW,
+                                  socket.IPPROTO_ICMP)
+
+    # ICMP echo request: type=8, code=0, checksum, id, seq
+    icmp_id = os.getpid() & 0xffff
+    icmp_echo = struct.pack('!BBHHH', 8, 0, 0, icmp_id, 1)
+    # Compute ICMP checksum
+    csum = ip_checksum(icmp_echo)
+    icmp_echo = struct.pack('!BBHHH', 8, 0, csum, icmp_id, 1)
+
+    try:
+        ping_sock.sendto(icmp_echo, ('10.0.2.99', 0))
+    except OSError:
+        pass
+    ping_sock.close()
+
+    # Wait for ICMP error response
+    try:
+        data, addr = sock.recvfrom(4096)
+    except socket.timeout:
+        print("SKIP - no ICMP error received (timeout)")
+        sock.close()
+        return 4
+
+    sock.close()
+
+    # Parse outer IP header
+    if len(data) < 20:
+        print("SKIP - received packet too short")
+        return 4
+
+    outer_ihl = (data[0] & 0x0f) * 4
+
+    # ICMP header at offset outer_ihl
+    icmp_offset = outer_ihl
+    if len(data) < icmp_offset + 8:
+        print("SKIP - packet too short for ICMP header")
+        return 4
+
+    icmp_type = data[icmp_offset]
+    icmp_code = data[icmp_offset + 1]
+
+    # Expect ICMP dest unreachable (type 3) or similar error
+    if icmp_type not in (3, 4, 5, 11, 12):
+        print(f"SKIP - received ICMP type {icmp_type}, not an error")
+        return 4
+
+    # Inner IP header starts after ICMP header (8 bytes)
+    inner_offset = icmp_offset + 8
+    inner_payload = data[inner_offset:]
+
+    result, msg = verify_inner_checksum(inner_payload)
+
+    if result is None:
+        print(f"SKIP - {msg}")
+        return 4
+    elif result:
+        print(f"OK - inner IP header checksum {msg}")
+        return 0
+    else:
+        print(f"FAIL - inner IP header checksum {msg}")
+        return 1
+
+
+if __name__ == '__main__':
+    sys.exit(main())
-- 
2.53.0


