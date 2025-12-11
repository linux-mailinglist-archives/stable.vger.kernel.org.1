Return-Path: <stable+bounces-200798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D92CB5F69
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 14:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3D22301787B
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435C35966;
	Thu, 11 Dec 2025 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqJUJKI8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6F1339A4
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765458027; cv=none; b=OO86vgrTbFxMDvMb6D68mmnWk5tqe04Y5rVpk4w+bgV4ZHYZVgTEXN1pxebjPNS/wD+rRKSil2W2F1zC/cT43AFkba1wDTLYkAqcD9nYH/b4mGOWNVQrq8P4xjVfWQUbr4+E8DvaDP+ioxPjmMppXIuyZK2kMGUzYo/r7GtizDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765458027; c=relaxed/simple;
	bh=nOJrqhXprnEUUHOfBOArqXtu4GOGbhTn/RtljS8Zg9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pPLYEiQYwP+NdhFrjiWwbIPshlO8CBp0ofLHPKuUEyitBNaaALHNr0jKJT2giY7w1xKR2D10/l120j/fUduHCeqlZtnDFyksyjdOazsOFkUbE158CeQO8EJKoqgCEf4QgxfWa9XOZQFu+0ALBVItNlJ6BSeD9KgNi7XXSCA1v64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqJUJKI8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2980d9b7df5so522795ad.3
        for <stable@vger.kernel.org>; Thu, 11 Dec 2025 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765458026; x=1766062826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDAsvYkgSFLdL6xLRP+bc26z9IdaiXQyqHMp+JNzIOs=;
        b=nqJUJKI8aGjj+hhRaPizCO/5fu7HqSAQ2RkGar11M2uWgcwfDAx+/ElW5kwUGpgyZS
         50NJBDMtf/XnIoirsbBht+VHk3lZ6/HF2D7Rv1f+nb8ySsqA8WS0zQZixbqToM2y2cOH
         JAebkcxUgZWyEVG0IeNzppLpS027qFp0pBROt2IR6D/wwB1bZKGbGc0W9hw2HVcbnR6/
         j9scrFtT5NzZclMU2+NwR68/G9T3UbyP6j+ItVE77hxI7Ip7T3zQBOR4s8wK5Ag5vELZ
         mf52p99cy/I5AmLQ8yv65rcUdSKpuCseM+TJ8JEUH+CHmD+vzb63pmLEQZ20OAJFTYob
         gh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765458026; x=1766062826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDAsvYkgSFLdL6xLRP+bc26z9IdaiXQyqHMp+JNzIOs=;
        b=mxUGtX9yziVhg6Qs0YwzbPRntIA/iE4cfrXx5JLZeGhWanQMhRP13VkvK65yFyMFxE
         V5/DA0aEzJA9x55RHie86lSAgNV+ny8JKX5WcPZVwAYzA3CeIJ+q2q4sbiP0BcmqNVF2
         JVcxfKfXaJxEx2Ag1ARzOjXwo70rWFan4qks36x0s7fQAtLor7X+l4F3r9HldKT59Uf/
         YHbiWgld2YxGivl7cKHPVRd1Bz133ZV1/tMsXdAkxWOb18e15uxDXCCieqW8YF9qVStK
         X3q3TvwT4VS9ieNJRjsmqyPFscf6dftDyGpb6DTiKdsMftZYAlkws+u7ldEcxJo1BdE8
         SFlA==
X-Gm-Message-State: AOJu0YwsZMq2gnVXdLTM9WrA+jc5YGrZv5Ggzcsmkol2w3HJCT7jPQeR
	siNNxDQCI/jTBuWuOskSS0CkFZZDHAmQTbdFYs6LYaxzchqABChHbs5/
X-Gm-Gg: AY/fxX7P+aKRacuGGmnYgKNIJhprpapt4TW2fCDEeYIX6iPoigf/hWtfwUaO1iBmmFA
	zJCMj+q0csLRrCYu6T4M1FkMDrba9ecOD9T9J1ISyp6t7JkgaDUmf9YJoXiNKmvRBHpBlPtpKTn
	W8WiO+6NEFXGcU+MJntukWV3WC7hbhAuFTj0aVyC90p3fQ7qR6UHqlXUkUBZclKCCsGiz9xvrz0
	nYZEindi+oKWhZXykOtcQ9JjXnOpugGkHS7xh+XZ0KkLLh7VU1iOu+/YV17uHj2ZFKEHCEpO3W5
	Hth9+dxPuRXNmn6yARV6pfTlnPQUWfYQ+ApeCED179hLmocZ6/y/25SDYLtSKifcZ3C9ynYqIoC
	N8wBNbPqjiJa1YG+V0fSMYWHkxloq44PDlzSclN31RbNqoqS744v6DEIubyEUE58DqykwbaR2JE
	dALvr831T93hQ/RbkJ1PTNBtQ=
X-Google-Smtp-Source: AGHT+IHCGc+wX/qEdHGCPxqGaidrGfAk9+GRE4Z80gqvvl1W8SoOFEaqzM4r/56TCEwbdRiTPyGRAg==
X-Received: by 2002:a17:902:ef0b:b0:298:33c9:eda2 with SMTP id d9443c01a7336-29ec2484b8cmr62794805ad.33.1765458025622;
        Thu, 11 Dec 2025 05:00:25 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29ee9d5116dsm24766855ad.45.2025.12.11.05.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 05:00:24 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Miaoqian Lin <linmq006@gmail.com>,
	Trent Piepho <tpiepho@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Andy Fleming <afleming@freescale.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/85xx: Fix device node leaks
Date: Thu, 11 Dec 2025 17:00:10 +0400
Message-Id: <20251211130012.2404862-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing of_node_put() calls for device-tree nodes returned by
of_find_node_by_type() and of_get_cpu_node() to avoid leaking DT
node references.

Found via static analysis and code review.

Fixes: d5b26db2cfcf ("powerpc/85xx: Add support for SMP initialization")
Fixes: 563fdd4a0af5 ("powerpc/85xx: Update smp support to handle doorbells and non-mpic init")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/85xx/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 32fa5fb557c0..cc5bf097c26f 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -199,6 +199,7 @@ static int smp_85xx_start_cpu(int cpu)
 	cpu_rel_addr = of_get_property(np, "cpu-release-addr", NULL);
 	if (!cpu_rel_addr) {
 		pr_err("No cpu-release-addr for cpu %d\n", cpu);
+		of_node_put(np);
 		return -ENOENT;
 	}
 
@@ -217,6 +218,8 @@ static int smp_85xx_start_cpu(int cpu)
 	else
 		spin_table = phys_to_virt(*cpu_rel_addr);
 
+	of_node_put(np);
+
 	local_irq_save(flags);
 	hard_irq_disable();
 
@@ -485,6 +488,7 @@ void __init mpc85xx_smp_init(void)
 		smp_85xx_ops.probe = smp_mpic_probe;
 		smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
 		smp_85xx_ops.message_pass = smp_mpic_message_pass;
+		of_node_put(np);
 	} else
 		smp_85xx_ops.setup_cpu = NULL;
 
-- 
2.25.1


