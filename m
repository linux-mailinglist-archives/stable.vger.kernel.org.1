Return-Path: <stable+bounces-72299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C32967A15
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F641C212ED
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4E183CA3;
	Sun,  1 Sep 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2u7zyr0e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA421DFD1;
	Sun,  1 Sep 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209474; cv=none; b=g5CfCZJ6oARWFcVi2cmgSdXPlTwbeLWI8rc+bOBjuEY6x+UEKlKX+xdZkRJ3BhsiRLFdZ1dv8RHS5/jiDE8hWxjqycL+weWuDZq3EcGJv4Tg0SHHH4QsEubby9iR0exwVCRgKAQISLKle+qMGhfvH0Prt+rzwnjV3sg1ZiEiRsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209474; c=relaxed/simple;
	bh=X7bvlI9En/HSGeyWE5TnT7Ij1aJMKpbNKTUQDlkNTws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bX6wPH4fWULX+NWMX41k65wwko0pI+pRRhvIlgZbU7oiKvBaiafGYkVTksgbC5zK5SUnHzeuRLfAo1rUUEmWiJMoZ/UuA7q0d2/3piVNAsxpwHnoLM+ElcR05Rgpg2sVU3ZF4Web0jpNL1XqpyMuZ41jAsQXQAnbbFV48OG1awo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2u7zyr0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE776C4CEC9;
	Sun,  1 Sep 2024 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209474;
	bh=X7bvlI9En/HSGeyWE5TnT7Ij1aJMKpbNKTUQDlkNTws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2u7zyr0e3xZZ/u8jx//sJ1LVDpmrbv8YGN9J9XyFkXF5ssHT3OjOHDMFgzdhNEKFn
	 U9pEWdQSgWpDbzttVWEv9/249WnTprb+XE2XhWvphEHdv3oMJ5EbiMcVAJ9/k11N5w
	 NofTsOTo9NI+gXzjlXx5PekmSCJpboigYwbqmQ24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 047/151] powerpc/xics: Check return value of kasprintf in icp_native_map_one_cpu
Date: Sun,  1 Sep 2024 18:16:47 +0200
Message-ID: <20240901160815.878649990@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 45b1ba7e5d1f6881050d558baf9bc74a2ae13930 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231122030651.3818-1-chentao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/xics/icp-native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 7d13d2ef5a905..66de291b27d08 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -235,6 +235,8 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 	rname = kasprintf(GFP_KERNEL, "CPU %d [0x%x] Interrupt Presentation",
 			  cpu, hw_id);
 
+	if (!rname)
+		return -ENOMEM;
 	if (!request_mem_region(addr, size, rname)) {
 		pr_warn("icp_native: Could not reserve ICP MMIO for CPU %d, interrupt server #0x%x\n",
 			cpu, hw_id);
-- 
2.43.0




