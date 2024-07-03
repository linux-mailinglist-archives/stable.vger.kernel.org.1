Return-Path: <stable+bounces-57833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFEE925E8A
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9B02A0E66
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6717C9EE;
	Wed,  3 Jul 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Atko/0Ng"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4F13776F;
	Wed,  3 Jul 2024 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720006069; cv=none; b=tMJdGwDDF+gtobJyPlMBCQvlB9VhsGx0ZgDW68H1QamXhGhZy3a7YDOBlBxLwjm2gsIyxGgCrJFqSsIlZu14weahHKF2QWy02QMbgPF82namg36BwOGEioszlm7PfofU/LZNyItDRIJ0tcww3bA620vQ+19BEn8A6WK3WkgZLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720006069; c=relaxed/simple;
	bh=id3XiZryUTKLcwSNaWNboVrWnpQ/hOe6MeyYkMHAwsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1ifDR0I85H9YENlhGkQlHrTgrnPOGQJEbhD0klJ+iVuixcFI1B3R3t8Zxjxt5bIYproPRFlADF9oXLKqU4IQ/TqdiEbqW6qUQIKm6NrY3qKylYrkx+NoKBvpuuFkTuS6/sMtIYKc5X/LP8r1AALj6ndBh8d/L6N6rmAIe0DV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Atko/0Ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516D8C2BD10;
	Wed,  3 Jul 2024 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720006069;
	bh=id3XiZryUTKLcwSNaWNboVrWnpQ/hOe6MeyYkMHAwsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Atko/0Ngc+1Gn9A0W9aQBModeezs9/N/Ee6unYEhbkqa0Wgv0/JfBNhN+CB4QhLtD
	 vNP4/v2C+FaITitcA1WBzVvPXPETbJ3TMYdpnPIASOn0Rn48r+LOAr0KZ+JaGOpjZZ
	 w9mmJqaKjQFsh8dQ0a/rjblN+Nlg1to2SLKwuLfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dawei Li <dawei.li@shingroup.cn>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 291/356] net/iucv: Avoid explicit cpumask var allocation on stack
Date: Wed,  3 Jul 2024 12:40:27 +0200
Message-ID: <20240703102924.128156995@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dawei Li <dawei.li@shingroup.cn>

[ Upstream commit be4e1304419c99a164b4c0e101c7c2a756b635b9 ]

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Link: https://lore.kernel.org/r/20240331053441.1276826-2-dawei.li@shingroup.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/iucv/iucv.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 68edefed79f16..30fc78236050a 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -519,7 +519,7 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	static cpumask_t cpumask;
 	int cpu;
 
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
@@ -627,23 +627,33 @@ static int iucv_cpu_online(unsigned int cpu)
 
 static int iucv_cpu_down_prep(unsigned int cpu)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
+	int ret = 0;
 
 	if (!iucv_path_table)
 		return 0;
 
-	cpumask_copy(&cpumask, &iucv_buffer_cpumask);
-	cpumask_clear_cpu(cpu, &cpumask);
-	if (cpumask_empty(&cpumask))
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpumask, &iucv_buffer_cpumask);
+	cpumask_clear_cpu(cpu, cpumask);
+	if (cpumask_empty(cpumask)) {
 		/* Can't offline last IUCV enabled cpu. */
-		return -EINVAL;
+		ret = -EINVAL;
+		goto __free_cpumask;
+	}
 
 	iucv_retrieve_cpu(NULL);
 	if (!cpumask_empty(&iucv_irq_cpumask))
-		return 0;
+		goto __free_cpumask;
+
 	smp_call_function_single(cpumask_first(&iucv_buffer_cpumask),
 				 iucv_allow_cpu, NULL, 1);
-	return 0;
+
+__free_cpumask:
+	free_cpumask_var(cpumask);
+	return ret;
 }
 
 /**
-- 
2.43.0




