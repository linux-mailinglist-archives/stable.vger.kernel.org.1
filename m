Return-Path: <stable+bounces-79613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0664B98D95E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C032893F4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E01D0E3E;
	Wed,  2 Oct 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkcdMuvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B291D07AD;
	Wed,  2 Oct 2024 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877954; cv=none; b=W8of0C/ot3XoORYf1ntW2lblkH9s4bbyrEjVHwrP2GwJnUWhPwKyJ9Z2AOOEE4TE/L4aHJdBRoTXkdthhAErH0iOjCheAhQCnZ26huNAlGfysGgi3W/5k9V4WnuhKCIkP3chAbPUAwdnFhmastAdcyrD0w3/jidUjA6YpW0Ma/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877954; c=relaxed/simple;
	bh=4AXtpsKfJ9ekXafRsbFneUptTDnUoBfLlgMbEboKGrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E71RWrmDKDu1Q+UtyCztdyukzJnSLPa3nDmjtejVdRAfccSuHJfs8gsqTQ9LyixJTV3UjHd3B2n/9AAM1aV8+57O9QBbXQjfl5Qp7cs8NzquRf1oB5ntkkcEPaG7AoWIjBWpUA4etlkypI+GAumjxQJxSyHeGCdVe1ULJQTPDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkcdMuvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744AAC4CEC2;
	Wed,  2 Oct 2024 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877954;
	bh=4AXtpsKfJ9ekXafRsbFneUptTDnUoBfLlgMbEboKGrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkcdMuvpmEx3eyDiIN+rjpsAYnlWyby37Q+eiWZLdpLk+OhpwdFrKZsAxgyreKO7K
	 knYCO6EYR1bH3gbBMlz3rlYa3SwkCZ1qdpReVWopYxSYgAPhszksV/4+26w1oGWjAX
	 MEuv+h6yJxn6coqmEdRQ/lkD2rDMG+6o7nA6ERRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 252/634] selftests/bpf: Fix errors compiling crypto_sanity.c with musl libc
Date: Wed,  2 Oct 2024 14:55:52 +0200
Message-ID: <20241002125821.044251390@linuxfoundation.org>
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

[ Upstream commit 9822be702fe6e1c3e0933ef4b68a8c56683d930d ]

Remove a redundant include of '<linux/in6.h>', whose needed definitions are
already provided by 'test_progs.h'. This avoids errors seen compiling for
mips64el/musl-libc:

  In file included from .../arpa/inet.h:9,
                   from ./test_progs.h:17,
                   from prog_tests/crypto_sanity.c:10:
  .../netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
     23 | struct in6_addr {
        |        ^~~~~~~~
  In file included from crypto_sanity.c:7:
  .../linux/in6.h:33:8: note: originally defined here
     33 | struct in6_addr {
        |        ^~~~~~~~
  .../netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
     34 | struct sockaddr_in6 {
        |        ^~~~~~~~~~~~
  .../linux/in6.h:50:8: note: originally defined here
     50 | struct sockaddr_in6 {
        |        ^~~~~~~~~~~~
  .../netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
     42 | struct ipv6_mreq {
        |        ^~~~~~~~~
  .../linux/in6.h:60:8: note: originally defined here
     60 | struct ipv6_mreq {
        |        ^~~~~~~~~

Fixes: 91541ab192fc ("selftests: bpf: crypto skcipher algo selftests")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Link: https://lore.kernel.org/bpf/911293968f424ad7b462d8805aeb3baee8f4985b.1721713597.git.tony.ambardar@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
index b1a3a49a822a7..42bd07f7218dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -4,7 +4,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <net/if.h>
-#include <linux/in6.h>
 #include <linux/if_alg.h>
 
 #include "test_progs.h"
-- 
2.43.0




