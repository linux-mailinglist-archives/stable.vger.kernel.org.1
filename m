Return-Path: <stable+bounces-18011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3376848103
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65731C2455B
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6415410A22;
	Sat,  3 Feb 2024 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bG+0Lje8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF241B95C;
	Sat,  3 Feb 2024 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933482; cv=none; b=YRmknFuGm+AzJIEAtsSOLHVvN7b0SpgOd8bD082+2mhQ/5ZwRJJ1/qWw2pL8zm8qDaQGj2NsbZ0p6fciAEBM6f3sX+srO6qD+djWaYAGC2E1XjKBYf5V+wkgy4VF3rjFh33vOnkop4O4jdtKprET/lhZZHbvBs3D3NbqDahcT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933482; c=relaxed/simple;
	bh=Wj+/2Xre/oPItel+cjWIY3yhe+TMN+QZzQuDKUDAR0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4TL92HHrIHjcFOIMcu5HB6+saxc2f2BrZ34CuPbqTxi1UmkJx11OVw+JhZiIdQyZ56zHTsLCx/hWUzvwmy6x2AoYZYG606CmbMB7szsA23PTvSUsEdiamAwvKY0o4/Wm8aBWaVZTbtxBHCcZfwqQ1T8cZWx976V8cTyKMfJPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bG+0Lje8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76C2C43390;
	Sat,  3 Feb 2024 04:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933481;
	bh=Wj+/2Xre/oPItel+cjWIY3yhe+TMN+QZzQuDKUDAR0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bG+0Lje8yfZ2o0eP7z6ztHwJx+m19DiMpDH5OKQk8cHub4GHWN2pd+83Y9oUm247D
	 FGfFxNgk90uBVfnerTb+PBqf1sagGo3a5+2aj9AucF4GCf50jfzxQAKQF2Kldysk2v
	 LgFV9cKZKh8hef6g/EFUZXNzGQoTLcSKKelgzF5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Guillaume Nault <gnault@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 209/219] selftests: net: fix available tunnels detection
Date: Fri,  2 Feb 2024 20:06:22 -0800
Message-ID: <20240203035346.289423089@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit e4e4b6d568d2549583cbda3f8ce567e586cb05da ]

The pmtu.sh test tries to detect the tunnel protocols available
in the running kernel and properly skip the unsupported cases.

In a few more complex setup, such detection is unsuccessful, as
the script currently ignores some intermediate error code at
setup time.

Before:
  # which: no nettest in (/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)
  # TEST: vti6: PMTU exceptions (ESP-in-UDP)                            [FAIL]
  #   PMTU exception wasn't created after creating tunnel exceeding link layer MTU
  # ./pmtu.sh: line 931: kill: (7543) - No such process
  # ./pmtu.sh: line 931: kill: (7544) - No such process

After:
  #   xfrm4 not supported
  # TEST: vti4: PMTU exceptions                                         [SKIP]

Fixes: ece1278a9b81 ("selftests: net: add ESP-in-UDP PMTU test")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/cab10e75fda618e6fff8c595b632f47db58b9309.1706635101.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/pmtu.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 0d705fdcf3b7..1b6e484e586d 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -713,23 +713,23 @@ setup_xfrm6() {
 }
 
 setup_xfrm4udp() {
-	setup_xfrm 4 ${veth4_a_addr} ${veth4_b_addr} "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 4 4500
+	setup_xfrm 4 ${veth4_a_addr} ${veth4_b_addr} "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 4 4500
 }
 
 setup_xfrm6udp() {
-	setup_xfrm 6 ${veth6_a_addr} ${veth6_b_addr} "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 6 4500
+	setup_xfrm 6 ${veth6_a_addr} ${veth6_b_addr} "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 6 4500
 }
 
 setup_xfrm4udprouted() {
-	setup_xfrm 4 ${prefix4}.${a_r1}.1 ${prefix4}.${b_r1}.1 "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 4 4500
+	setup_xfrm 4 ${prefix4}.${a_r1}.1 ${prefix4}.${b_r1}.1 "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 4 4500
 }
 
 setup_xfrm6udprouted() {
-	setup_xfrm 6 ${prefix6}:${a_r1}::1 ${prefix6}:${b_r1}::1 "encap espinudp 4500 4500 0.0.0.0"
-	setup_nettest_xfrm 6 4500
+	setup_xfrm 6 ${prefix6}:${a_r1}::1 ${prefix6}:${b_r1}::1 "encap espinudp 4500 4500 0.0.0.0" && \
+		setup_nettest_xfrm 6 4500
 }
 
 setup_routing_old() {
-- 
2.43.0




