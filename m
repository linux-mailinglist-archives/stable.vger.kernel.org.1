Return-Path: <stable+bounces-18299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448BD84822C
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E711C23894
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44AF1A28C;
	Sat,  3 Feb 2024 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nj5Gklpx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FA12E54;
	Sat,  3 Feb 2024 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933696; cv=none; b=KcUrLabyySthbmNWZxMxBJCOp+G6kDHPoohwUkqxGn/snd09osdCZNtfYKC1uaOGVLNM9XzdqexTT2493+J0fQkMUH+vDdht+RB0VoJpJ5OsdwP9jU8C8Rzcc5QzTKyETLg/DHq4EcA0ftglEMJ402V9PNTS2l3GGiLcvR3Lgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933696; c=relaxed/simple;
	bh=B4cq2f0mAdt9VvyrMA7keQyXp8w8dDokdfAwmpMxyoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BazMbUSWkeNRl5arz35ZLKP6lbfmUEh1ogYLbAbA8ncCdgTjjwNbSVQDo/fZv1ld9M3FXLssAAWkTHFCx6/VH9X9TTLOmq+MyGia44GKh8y4J95TgGSr9g5GRUwB4uOFKVjf1jMFv3+91NkV0uHIjDIb2I7Ur9J2zFeMs1fEMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nj5Gklpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF4EC433F1;
	Sat,  3 Feb 2024 04:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933696;
	bh=B4cq2f0mAdt9VvyrMA7keQyXp8w8dDokdfAwmpMxyoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nj5GklpxUWrN3dB9y+tW64KSz9fGEVuJKfeU2YgKyDq5JxtAYc6IqhziQf1gXyEdN
	 XpGzSf+OOl5qoX4VAsy8Oy0EARX8nqwBkmZbSZcm/vJaCDPYa7qKhpR6eDNTCXVRD1
	 VcZ9z3Pb0TT/I9I2GoRENdpWnh0yD8jYkl5Ireso=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 270/322] selftests: net: explicitly wait for listener ready
Date: Fri,  2 Feb 2024 20:06:07 -0800
Message-ID: <20240203035407.840983689@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 4acffb66630a0e4800880baa61a54ef18047ccd3 ]

The UDP GRO forwarding test still hard-code an arbitrary pause
to wait for the UDP listener becoming ready in background.

That causes sporadic failures depending on the host load.

Replace the sleep with the existing helper waiting for the desired
port being exposed.

Fixes: a062260a9d5f ("selftests: net: add UDP GRO forwarding self-tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/4d58900fb09cef42749cfcf2ad7f4b91a97d225c.1706131762.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 5fa8659ab13d..d6b9c759043c 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source net_helper.sh
+
 BPF_FILE="xdp_dummy.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
 readonly SRC=2
@@ -119,7 +121,7 @@ run_test() {
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 8000
 	ip netns exec $NS_DST ./udpgso_bench_rx -C 1000 -R 10 -n 10 -l 1300 $rx_args &
 	local spid=$!
-	sleep 0.1
+	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC ./udpgso_bench_tx $family -M 1 -s 13000 -S 1300 -D $dst
 	local retc=$?
 	wait $spid
@@ -168,7 +170,7 @@ run_bench() {
 	ip netns exec $NS_DST bash -c "echo 2 > /sys/class/net/veth$DST/queues/rx-0/rps_cpus"
 	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 1000 -R 10  &
 	local spid=$!
-	sleep 0.1
+	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC taskset 0x1 ./udpgso_bench_tx $family -l 3 -S 1300 -D $dst
 	local retc=$?
 	wait $spid
-- 
2.43.0




