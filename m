Return-Path: <stable+bounces-76861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481A497E222
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 17:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259B91C20DF6
	for <lists+stable@lfdr.de>; Sun, 22 Sep 2024 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64788BE6F;
	Sun, 22 Sep 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfjoVmp9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418D2581;
	Sun, 22 Sep 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017504; cv=none; b=UwshVBGuDGG0QLptB7zjosUF1Aqz/pzIkwtiDP1DU1otm8vnEt0LoGTrMyrijdc6HX5RVarwU6rXEEqNCt/02tARs3xx6cgca9BwyCglOvFL7NIgy+OJBjsnz/oW1JE3M9KFQytFynw9XnYjcZPc5kD+eA4QO266RIUID7qo4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017504; c=relaxed/simple;
	bh=+k2SjZRGY0ozZ7F4XM42YKdPWrSiaX8hITQTpUGjDdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cR6iW0S+S3LiPo+FMa2u8fR24Z94hGj08P9NXlMw7yNpxC7xfEGalHSpTpCRAfklj+UG92T6+Ljy3YrrfWAwvzZ6rdmV4n2+zoOQ6zrl446+fWWALCknGf5fyEy2dDR/u394SsJ5lEDPRFow2cZWVs40I6D5AwAkZzMolV0TPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfjoVmp9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a99fd0535bso306689385a.3;
        Sun, 22 Sep 2024 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727017501; x=1727622301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wivG4xlKvMf9GPBdKEiwWTA0aL9stoHxh4+K/4k7PQ=;
        b=FfjoVmp9n9xRAqg3cX5/U9NLuLmqO9UBlPy0CodKTmjLtIi1UcZmxttOq4MAmr5TRV
         Nn3LpeynnZfuROJbJIUZcWlnot9B2rmXwaQuttBbcMC3CJPH0vcJVV2Nac9W5tVmwLcb
         YnfhEUhSCeqGfZ4QHAejqIUsbZSVeut12GlJN6fh04tvEtXf6oW1EklijR0p7+z6+GOm
         722UPjKGAJNAA3wOog9GK1Fe/t82jaKfJsaIp3raiHTwZ6LrPKdcQxvPUAUba95rWyzn
         u0PNCMogHR34YSlyNyG+sUZnmKGW0xPkRlaR4T6JUzsLyEQ8e3z01iG7eZ9zQUCiLp8E
         7k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727017501; x=1727622301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wivG4xlKvMf9GPBdKEiwWTA0aL9stoHxh4+K/4k7PQ=;
        b=bno8ulYF4DSw6VInPx07mczRzozvI7qedoa1Ys0qSj6vVFPIXRYH/UIBw03CAvHmYX
         hQ+RD8owr1WisfGWESFbLWN8TsDmAz4hs37s8gmm3kD+rXjhdgknaVTSgBTrtVBEIX8e
         LadjNRU0h8UMuZIaPjFe9DgQri1sKXUJbAhN+jDxk9EccW28x1wPboDzTHUW58uuLl1J
         VpNQ0n9XyiS5CTp5M/lqlELa6q79FaIlRWvquXqubuaHnNlfzjGexIRh1X0qF2fpSHf9
         GF4OgzHo712MjcTuEbiXB6PSGCuXV5DdXHSWbBz+4tOHwD69U/oGZbleSQ46yO9Bc+QL
         hgFw==
X-Forwarded-Encrypted: i=1; AJvYcCVNgdDi5BISNhcPu44QSoaqJaB0y7tDolo9CrcwUQQwH5XxGg5+4QIz4KoVwPJ/dYjS8NG1HqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOn34pv5kVW1+zBmrj8DcnajLZcKnQvMBvLMLjqMw/XyjI5fPh
	vZbxBlfPEs3uSpiPIpMr+fuwbb0X3onGhDkVBi1ontqQOFmTcFazuOE+f6cZ
X-Google-Smtp-Source: AGHT+IEPt7AMLGJprkhtvhW0ZVRg/FKxWuAdxID0i8MPE/VzEhhv6Zhg0BHWd6DkTyRKwGFlXCIFGw==
X-Received: by 2002:a05:620a:1aa9:b0:7ac:a10e:4e5d with SMTP id af79cd13be357-7acb7ff1a4cmr1566436285a.0.1727017501308;
        Sun, 22 Sep 2024 08:05:01 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08d96a3sm386781285a.107.2024.09.22.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 08:05:00 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	maze@google.com,
	shiming.cheng@mediatek.com,
	daniel@iogearbox.net,
	lena.wang@mediatek.com,
	herbert@gondor.apana.org.au,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net] gso: fix gso fraglist segmentation after pull from frag_list
Date: Sun, 22 Sep 2024 11:03:45 -0400
Message-ID: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Detect gso fraglist skbs with corrupted geometry (see below) and
pass these to skb_segment instead of skb_segment_list, as the first
can segment them correctly.

Valid SKB_GSO_FRAGLIST skbs
- consist of two or more segments
- the head_skb holds the protocol headers plus first gso_size
- one or more frag_list skbs hold exactly one segment
- all but the last must be gso_size

Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
modify these skbs, breaking these invariants.

In extreme cases they pull all data into skb linear. For UDP, this
causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
udp_hdr(seg->next)->dest.

Detect invalid geometry due to pull, by checking head_skb size.
Don't just drop, as this may blackhole a destination. Convert to be
able to pass to regular skb_segment.

Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org

---

Tested:
- tools/testing/selftests/net/udpgro_fwd.sh
- kunit gso_test_func converted to calling __udp_gso_segment
- below manual end-to-end test:
  (which probably repeats a lot of udpgro_fwd.sh, in hindsight..)
  (won't repeat this on any resubmits, given how long it is)

  #!/bin/bash

  ip netns add test1
  ip netns add test2
  ip netns add test3

  ip link add dev veth0 netns test1 type veth peer name veth0 netns test2
  ip link add dev veth1 netns test2 type veth peer name veth1 netns test3

  ip netns exec test1 ip link set dev veth0 up
  ip netns exec test2 ip link set dev veth0 up

  ip netns exec test2 ip link set dev veth1 up
  ip netns exec test3 ip link set dev veth1 up

  ip netns exec test1 ip addr add 10.0.8.1/24 dev veth0
  ip netns exec test2 ip addr add 10.0.8.2/24 dev veth0

  ip netns exec test2 ip addr add 10.0.9.2/24 dev veth1
  ip netns exec test3 ip addr add 10.0.9.3/24 dev veth1

  ip -6 -netns test1 addr add fdaa::1 dev veth0
  ip -6 -netns test2 addr add fdaa::2 dev veth0

  ip -6 -netns test2 addr add fdbb::2 dev veth1
  ip -6 -netns test3 addr add fdbb::3 dev veth1

  ip netns exec test2 sysctl -w net.ipv4.ip_forward=1
  ip netns exec test2 sysctl -w net.ipv6.conf.all.forwarding=1

  ip -netns test1 route add default via 10.0.8.2
  ip -netns test3 route add default via 10.0.9.2

  ip -6 -netns test1 route add fdaa::2 dev veth0
  ip -6 -netns test2 route add fdaa::1 dev veth0
  ip -6 -netns test2 route add fdbb::3 dev veth1
  ip -6 -netns test3 route add fdbb::2 dev veth1

  ip -6 -netns test1 route add default via fdaa::2
  ip -6 -netns test3 route add default via fdbb::2

  ip netns exec test1 ethtool -K veth0 gso off tx-udp-segmentation off
  ip netns exec test2 ethtool -K veth0 gro on rx-gro-list on rx-udp-gro-forwarding on
  ip netns exec test2 ethtool -K veth1 gso off tx-udp-segmentation off

  ip netns exec test2 tc qdisc add dev veth0 clsact
  ip netns exec test2 tc filter add dev veth0 ingress bpf direct-action obj tc_pull.o sec tc

  ip netns exec test3 /mnt/shared/udpgso_bench_rx & \
  ip netns exec test1 /mnt/shared/udpgso_bench_tx -l 5 -4 -D 10.0.9.3 -s
  60000 -S 0 -z

  ip netns exec test3 /mnt/shared/udpgso_bench_rx & \
  ip netns exec test1 /mnt/shared/udpgso_bench_tx -l 5 -6 -D fdbb::3 -s
  60000 -S 0 -z

With trivial BPF program:

  $ cat ~/work/tc_pull.c
  // SPDX-License-Identifier: GPL-2.0

  #include <linux/bpf.h>
  #include <linux/pkt_cls.h>
  #include <linux/types.h>

  #include <bpf/bpf_helpers.h>

  __attribute__((section("tc")))

  int tc_cls_prog(struct __sk_buff *skb) {
  	bpf_skb_pull_data(skb, skb->len);
  	return TC_ACT_OK;
  }
---
 net/ipv4/udp_offload.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index d842303587af..e457fa9143a6 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -296,8 +296,16 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return NULL;
 	}
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
+		 /* Detect modified geometry and pass these to skb_segment. */
+		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
+			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
+		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
+		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
+		gso_skb->csum_offset = offsetof(struct udphdr, check);
+		gso_skb->ip_summed = CHECKSUM_PARTIAL;
+	}
 
 	skb_pull(gso_skb, sizeof(*uh));
 
-- 
2.46.0.792.g87dc391469-goog


