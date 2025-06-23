Return-Path: <stable+bounces-157553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB99AE548D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F23B4C13F9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9CE221DA8;
	Mon, 23 Jun 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yg0QSgse"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3A19DF4A;
	Mon, 23 Jun 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716149; cv=none; b=lwiqTDBGjGfQ8KURk6BrK+uYgBHNEmm1MzndO0c2WweJesU84kwJgLzv5eMhyiLo+OESgrjmqd8ETONXZXvCpv3zD7zc1W0m/6KE3jDFEInDwypxRR0fDB2zTR/byrHkEV5X48lX4fy/X7F4UE/FTLQoHNkk4z3kI7rDD/R+lDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716149; c=relaxed/simple;
	bh=rXZQ1XC7CMf3DATdOMA/fWkPUBTCLQm53tC0yXCCIwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrrrIc2+zUjc7KSnFcTDwHyApHca6k2770ZuWi+ba14lhirr+cH4GuiQwoCWcRtadBFEWQBGc8D9VwQKZ64ipgOrS7LPcuwcSMy1pb9ogUnLwZBG3455nBlmFZHfN55Vc7NyWWHooW0j2/s+aMQCPvU+vjjjxceNsTTxYJJiyBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yg0QSgse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11828C4CEEA;
	Mon, 23 Jun 2025 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716149;
	bh=rXZQ1XC7CMf3DATdOMA/fWkPUBTCLQm53tC0yXCCIwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yg0QSgse4UvyTwIvxQ5oC7z2Um7y3YVdNf0Y86fCu9/VCQiMqxa5NGDjpF0uNrV9e
	 j71g4Es5Q8RxtcahEfzwi6gSOH0RUS8FzfyG0JyIgx6hPgVgIFVKlWISGmEcWqS7vo
	 HBltvO7klcHrGtiHj71E5hmXDfOSa3QszJQBXhNI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH 5.10 331/355] arm64: proton-pack: Expose whether the branchy loop k value
Date: Mon, 23 Jun 2025 15:08:52 +0200
Message-ID: <20250623130636.695592183@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: James Morse <james.morse@arm.com>

[ Upstream commit a1152be30a043d2d4dcb1683415f328bf3c51978 ]

Add a helper to expose the k value of the branchy loop. This is needed
by the BPF JIT to generate the mitigation sequence in BPF programs.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/spectre.h |    1 +
 arch/arm64/kernel/proton-pack.c  |    5 +++++
 2 files changed, 6 insertions(+)

--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -32,6 +32,7 @@ void spectre_v4_enable_task_mitigation(s
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
+u8 get_spectre_bhb_loop_value(void);
 bool is_spectre_bhb_fw_mitigated(void);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1006,6 +1006,11 @@ bool is_spectre_bhb_affected(const struc
 	return true;
 }
 
+u8 get_spectre_bhb_loop_value(void)
+{
+	return max_bhb_k;
+}
+
 static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
 {
 	const char *v = arm64_get_bp_hardening_vector(slot);



