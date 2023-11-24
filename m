Return-Path: <stable+bounces-1670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5D7F80D1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4178B281141
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C44D33CCA;
	Fri, 24 Nov 2023 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mgxLann+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5497E321AD;
	Fri, 24 Nov 2023 18:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53F0C433C7;
	Fri, 24 Nov 2023 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851982;
	bh=mVWq3oO+VMtQq/YAFYZJ1v638Y0sD+mYIIIiTXumfFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgxLann+wHDjKOA2jMZGKRZUDp9chooXBuPFilaCeLVZNqrM104QLKypfN2/Lhpn4
	 Cqylt0MGALbKKmL5pAk0g4C9tE4uzioDlzcIBrjjwJRlwcVqA4FA8oEXbPAuMrIEuC
	 Pb+c4Hqvta1nTDcx0+XHu9ZBeOH3xjovx2410pxk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pu Wen <puwen@hygon.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.1 173/372] x86/cpu/hygon: Fix the CPU topology evaluation for real
Date: Fri, 24 Nov 2023 17:49:20 +0000
Message-ID: <20231124172016.243654483@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Pu Wen <puwen@hygon.cn>

commit ee545b94d39a00c93dc98b1dbcbcf731d2eadeb4 upstream.

Hygon processors with a model ID > 3 have CPUID leaf 0xB correctly
populated and don't need the fixed package ID shift workaround. The fixup
is also incorrect when running in a guest.

Fixes: e0ceeae708ce ("x86/CPU/hygon: Fix phys_proc_id calculation logic for multi-die processors")
Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/tencent_594804A808BD93A4EBF50A994F228E3A7F07@qq.com
Link: https://lore.kernel.org/r/20230814085112.089607918@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/hygon.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -86,8 +86,12 @@ static void hygon_get_topology(struct cp
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		/* Socket ID is ApicId[6] for these processors. */
-		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
+		/*
+		 * Socket ID is ApicId[6] for the processors with model <= 0x3
+		 * when running on host.
+		 */
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <= 0x3)
+			c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
 
 		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {



