Return-Path: <stable+bounces-24332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E08693F7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA91C23033
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C714533E;
	Tue, 27 Feb 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o9UAL6ut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F55145327;
	Tue, 27 Feb 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041698; cv=none; b=mcnFdA7GncAxf5q5uQvzWIRxp7zv6AX3Ncexag4uGCOcjDshamacezzC0LmupvUVfoy2GL/gP00IjqW2T4CzRNXElEb8L4di5POzl9wexG3YYcw+zuVV4i/FEd5/FTTZjPXebdXjNvEzIfVkEhPcIHgDRtu1wo97Eg3rVa6q9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041698; c=relaxed/simple;
	bh=jBlmmCuzu6c10jAVdMAntK5URkJtrJZsfFqxanKl9KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFtISu/2Eg8gvBVF8D5WGE5Q8GVL0Szx633+BC5Nsh/PcO1hUvyHLM+ENRoR2V31vVi4nqp34p3Jk0LQfkM5QEFgAwDB3AxYvKkScjSqg/4Glc0r+epsFyI6NR2nFxMT8q9sQXeA3rBhbHqhOlCFeFZq7UFrY+rOD6f/ZntOqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o9UAL6ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF12C433F1;
	Tue, 27 Feb 2024 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041698;
	bh=jBlmmCuzu6c10jAVdMAntK5URkJtrJZsfFqxanKl9KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9UAL6utPay19Z+bAPJBkB5N8g6sJ66Ws0DpjsHTiNjwyCNlgJ2L7rTDV4qLAJq9P
	 QIsKJZ5PQHHYSVtOR3Re7mMJEXK8XfQmmtHT1Sv0ig+oBjXBQ8N8lT8AY8alclqxXX
	 Gr2QSeZnZk4o1m7w95Fj3MILEyNCDQmB6//26Ly8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Huang Pei <huangpei@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 031/299] MIPS: reserve exception vector space ONLY ONCE
Date: Tue, 27 Feb 2024 14:22:22 +0100
Message-ID: <20240227131626.828243745@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

From: Huang Pei <huangpei@loongson.cn>

[ Upstream commit abcabb9e30a1f9a69c76776f8abffc31c377b542 ]

"cpu_probe" is called both by BP and APs, but reserving exception vector
(like 0x0-0x1000) called by "cpu_probe" need once and calling on APs is
too late since memblock is unavailable at that time.

So, reserve exception vector ONLY by BP.

Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Huang Pei <huangpei@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/traps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 246c6a6b02614..5b778995d4483 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2007,7 +2007,13 @@ unsigned long vi_handlers[64];
 
 void reserve_exception_space(phys_addr_t addr, unsigned long size)
 {
-	memblock_reserve(addr, size);
+	/*
+	 * reserve exception space on CPUs other than CPU0
+	 * is too late, since memblock is unavailable when APs
+	 * up
+	 */
+	if (smp_processor_id() == 0)
+		memblock_reserve(addr, size);
 }
 
 void __init *set_except_vector(int n, void *addr)
-- 
2.43.0




