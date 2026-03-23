Return-Path: <stable+bounces-228211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPzlNtFLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D94F2F428B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C416331B2996
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF873BADA8;
	Mon, 23 Mar 2026 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8LcWA1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED03BADAB;
	Mon, 23 Mar 2026 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274461; cv=none; b=R3RS43dqzXojWvMe5T6ritGw6pCmQdLNt6ut2ef5uvdK5ouHvI13Bm8xKaeqb5fOB/NgsK5aJIfAKHYF6rgyoapYsDfm7HZX7xGmn/Bjie78feHY+5bFfoco//PPFkSQyuPgCn8rHDi4+c80k8oramQmAMo+m3tIud/gYQ1746U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274461; c=relaxed/simple;
	bh=0yIOgovWR6VYVrtTyHP1tbTVMtQta0O6QpKP8ywjnuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ4vkPXjyZmC4uRJqjaP6/nAP//LKRvNKN3oByPNHNYbw/QQIfTfCl3Ln/lNnl/4IuFXJCb0rOQkzss/Tapb3yS0eCX518sZA7yKMKuxaqhocA3oAwz8erktE+7dTWjlqhGCkSp2FvfvT3djqPjQNT5zT5LsO+xctJU3zi2KEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8LcWA1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A56C2BC9E;
	Mon, 23 Mar 2026 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274461;
	bh=0yIOgovWR6VYVrtTyHP1tbTVMtQta0O6QpKP8ywjnuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8LcWA1SwxW3Ms6zHTeAHGVQZvWXzCtqdoV6G7DMSp6H538H8T5LqplH5EqV9jryv
	 ugr3C66771cpvK7VWE7DECOTgxSOLWlgixkCd4SbfVv7xLJ+b+WWvytUg2s/8+VGDa
	 pF6JzT/ULj8L4y+bFameygc6pOJGPPkTEjh1wqMo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Steven Price <steven.price@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 218/220] arm64: realm: Fix PTE_NS_SHARED for 52bit PA support
Date: Mon, 23 Mar 2026 14:46:35 +0100
Message-ID: <20260323134511.394565416@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228211-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2D94F2F428B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 8c6e9b60f5c7985a9fe41320556a92d7a33451df ]

With LPA/LPA2, the top bits of the PFN (Bits[51:48]) end up in the lower bits
of the PTE. So, simply creating a mask of the "top IPA bit" doesn't work well
for these configurations to set the "top" bit at the output of Stage1
translation.

Fix this by using the __phys_to_pte_val() to do the right thing for all
configurations.

Tested using, kvmtool, placing the memory at a higher address (-m <size>@<Addr>).

 e.g:
 # lkvm run --realm -c 4 -m 512M@@128T -k Image --console serial

 sh-5.0# dmesg | grep "LPA2\|RSI"
[    0.000000] RME: Using RSI version 1.0
[    0.000000] CPU features: detected: 52-bit Virtual Addressing (LPA2)
[    0.777354] CPU features: detected: 52-bit Virtual Addressing for KVM (LPA2)

Fixes: 399306954996 ("arm64: realm: Query IPA size from the RMM")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/rsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index c64a06f58c0bc..9e846ce4ef9ca 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -12,6 +12,7 @@
 
 #include <asm/io.h>
 #include <asm/mem_encrypt.h>
+#include <asm/pgtable.h>
 #include <asm/rsi.h>
 
 static struct realm_config config;
@@ -146,7 +147,7 @@ void __init arm64_rsi_init(void)
 		return;
 	if (WARN_ON(rsi_get_realm_config(&config)))
 		return;
-	prot_ns_shared = BIT(config.ipa_bits - 1);
+	prot_ns_shared = __phys_to_pte_val(BIT(config.ipa_bits - 1));
 
 	if (arm64_ioremap_prot_hook_register(realm_ioremap_hook))
 		return;
-- 
2.51.0




