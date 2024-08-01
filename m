Return-Path: <stable+bounces-64927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F759943CA2
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901271C21F4E
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3C714D2BE;
	Thu,  1 Aug 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXhmQTJ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAD1C8FA7;
	Thu,  1 Aug 2024 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471469; cv=none; b=d3zTcQ7XbIZpYqEQE+wA/x8epnToxlcdsiuPHTJDoFK76POZT1jzZF6TAhDCE1pYnrb89kUk4a4Qu3QmQ1AkiFnpom8k0vmO1BepK58BD/HD66zmCC+CdKmEN3rKlr3La2lPkHyLNrCOIdoYzHQ0MHT9dd0JXN5v3q1l1SjIV2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471469; c=relaxed/simple;
	bh=Hw6ITTl3y/NjjKIWH7saNeWj85HAD6+zCV157PNEz6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cm3tn0laD/hQrkktwIPUXcpI+lzwlxbx10KHoCQUYeVdM418mXWhynWfTf0eZHAuH17gzGce2KmN3QvRY2qr95WX6YyC1LH6RJOqSnJ4KngBSDh4KDGaLT54hSh2tcr49d0jeCKlpqWLsIvge1K91mVveI5dIF30OYRPrJtjOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXhmQTJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E514C116B1;
	Thu,  1 Aug 2024 00:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471469;
	bh=Hw6ITTl3y/NjjKIWH7saNeWj85HAD6+zCV157PNEz6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXhmQTJ82kZm0jxwdWHTagu2MfxWPuaFSAsrrVVSzQN/aCiFM4EClkVfa+tYyXFtw
	 XUvDBN/89x12fwcuSHKtMw9oQULQHPqTnPaILPRRw2hgHSZvhGZkzLQTEFHTj1G4k5
	 t6yueq1Ct531QtixaZCO+1Zd7hPl8o4guYs7B8mJpLKyAKepHLjpDEk6Obgm3x1p/U
	 xh0Y7WLcvbo5WFyHuHvn96BDOn1QP4H5pyURNN+oZcpvzpp6MGtTHDQl4L1J9OYdVW
	 UQPW+/DSoTw4Ea3HJMqr9pK56qdJbjKC+kQIbbDeOsvNarA3xD88Jj38ezkh4sqq/m
	 ykPkW1sEFZxNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
	Breno Leitao <leitao@debian.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>,
	aneesh.kumar@kernel.org,
	mahesh@linux.ibm.com,
	hbathini@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.10 102/121] powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
Date: Wed, 31 Jul 2024 20:00:40 -0400
Message-ID: <20240801000834.3930818-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit 0974d03eb479384466d828d65637814bee6b26d7 ]

Smatch warns:

  arch/powerpc/kernel/rtas.c:1932 __do_sys_rtas() warn: potential
  spectre issue 'args.args' [r] (local cap)

The 'nargs' and 'nret' locals come directly from a user-supplied
buffer and are used as indexes into a small stack-based array and as
inputs to copy_to_user() after they are subject to bounds checks.

Use array_index_nospec() after the bounds checks to clamp these values
for speculative execution.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Reported-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240530-sys_rtas-nargs-nret-v1-1-129acddd4d89@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/rtas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8064d9c3de862..f7e86e09c49fa 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -19,6 +19,7 @@
 #include <linux/lockdep.h>
 #include <linux/memblock.h>
 #include <linux/mutex.h>
+#include <linux/nospec.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/reboot.h>
@@ -1916,6 +1917,9 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	    || nargs + nret > ARRAY_SIZE(args.args))
 		return -EINVAL;
 
+	nargs = array_index_nospec(nargs, ARRAY_SIZE(args.args));
+	nret = array_index_nospec(nret, ARRAY_SIZE(args.args) - nargs);
+
 	/* Copy in args. */
 	if (copy_from_user(args.args, uargs->args,
 			   nargs * sizeof(rtas_arg_t)) != 0)
-- 
2.43.0


