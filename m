Return-Path: <stable+bounces-79607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8AB98D958
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E5E1C2320E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352E31D0E2B;
	Wed,  2 Oct 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wmw/52N2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89741CFEA9;
	Wed,  2 Oct 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877937; cv=none; b=mVKm4UqOivpZTJhsHFCsfRrAhgTvaEgKyAZ6SppDQ6gy++Jlwzn7UDyUTDMOwNP5wFwT2pQzwY22vsW6zbVHWYnk2mMWpZ85HhCkTrbX27a5C3WAUdN9et8x5e4of4N9bhMKkDhyRo5t+2L4Bjlu+HO7dqZN+rGakGFB4ei3XGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877937; c=relaxed/simple;
	bh=WjiOD1aLur9QCDxzw8PatcPUlnEEo7R3GIJsayB0X9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eazoys6f62bCX/YJnSIygRPcfCD65rea8eekOdjoHnZZzx+eMVpjLFETQgs5xqWsZP2yv2KE8LqSgzVuvPFkP/LjMlYf56Tv+VnBNqwmYIinbTot4zffVnFj23uBeQmVMkbuwzNpEC4Fuf2WYd7AOUBSNjGp+VVSKio4By2i33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wmw/52N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F634C4CEC2;
	Wed,  2 Oct 2024 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877936;
	bh=WjiOD1aLur9QCDxzw8PatcPUlnEEo7R3GIJsayB0X9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wmw/52N2o2lsj7kHtrZrQLpzfjXHHT1yYK7iVXUXXSHyDyyfqxwaEFFIDMk1S80on
	 8SwJoZOodU8oNH2fgq8hlM1dXMRriOlHwAU9SXLxNzmml7DCQK0xhmQo5gZXtry8fL
	 DsQnpOkK6YVD/V3G2JAYjLqidLbI9bEMawaJdILo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 246/634] selftests/bpf: Fix compiling kfree_skb.c with musl-libc
Date: Wed,  2 Oct 2024 14:55:46 +0200
Message-ID: <20241002125820.808318771@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Ambardar <tony.ambardar@gmail.com>

[ Upstream commit bae9a5ce7d3a9b3a9e07b31ab9e9c58450e3e9fd ]

The GNU version of 'struct tcphdr' with member 'doff' is not exposed by
musl headers unless _GNU_SOURCE is defined. Add this definition to fix
errors seen compiling for mips64el/musl-libc:

  In file included from kfree_skb.c:2:
  kfree_skb.c: In function 'on_sample':
  kfree_skb.c:45:30: error: 'struct tcphdr' has no member named 'doff'
     45 |         if (CHECK(pkt_v6->tcp.doff != 5, "check_tcp",
        |                              ^

Fixes: 580d656d80cf ("selftests/bpf: Add kfree_skb raw_tp test")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/e2d8cedc790959c10d6822a51f01a7a3616bea1b.1721713597.git.tony.ambardar@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index c07991544a789..34f8822fd2219 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "kfree_skb.skel.h"
-- 
2.43.0




