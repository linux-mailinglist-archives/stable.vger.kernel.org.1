Return-Path: <stable+bounces-162530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BBB05E41
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4982D172466
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056902E7F3B;
	Tue, 15 Jul 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HyIrADmx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82412E49B2;
	Tue, 15 Jul 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586798; cv=none; b=lihahJL5oH2znxtYa8XrakQWHPfUpVClc4tjfM8ex0TtcFUcVWrqocoLS4EoGKUylDZBHKWKFWEV2AqtxFXjS7S8K+jTMD/hGShbveU1jWaxouGXRKyKSUUUbHMrf7s0PxdhvFcmgg60D2l+mFydzPmh58OY7nv1wR3NfKXiINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586798; c=relaxed/simple;
	bh=od6FwcrzyMcCoTOsuPSulkXBpeiRLfmXdEgtFup/GpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vATBK/HEVsKwDTfx2kZpGxPMeXM679ecb19116dIAEZP4ChOmozeQFMxppcdFi/YSUD/cMKbeF7PidFZT90Tkyt8jdr9DX72uAFwBLILXydk1W3u/L4tYEHxJa8DNQf6JG9Xm5YvzDA/7v1lWAoTPsDmZh9ApH9IKrwFmK2JCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HyIrADmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484F1C4CEE3;
	Tue, 15 Jul 2025 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586798;
	bh=od6FwcrzyMcCoTOsuPSulkXBpeiRLfmXdEgtFup/GpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyIrADmxysfwIvuwsqikL7eMfS+ZgZagT2qDlo1gRGSFHy+0dwNDhwlvUFLRf9rxB
	 6E02p75HNMAPjUaNhdMqPLLMgW+bpPtyJuA/uf8Sr0yJHYw946j7CK32eYiZlMklCq
	 UUT72Vk2+kk7yVQvJduOoDETAlSUYLYaceySon4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.15 051/192] x86/mce/amd: Add default names for MCA banks and blocks
Date: Tue, 15 Jul 2025 15:12:26 +0200
Message-ID: <20250715130816.894201157@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit d66e1e90b16055d2f0ee76e5384e3f119c3c2773 upstream.

Ensure that sysfs init doesn't fail for new/unrecognized bank types or if
a bank has additional blocks available.

Most MCA banks have a single thresholding block, so the block takes the same
name as the bank.

Unified Memory Controllers (UMCs) are a special case where there are two
blocks and each has a unique name.

However, the microarchitecture allows for five blocks. Any new MCA bank types
with more than one block will be missing names for the extra blocks. The MCE
sysfs will fail to initialize in this case.

Fixes: 87a6d4091bd7 ("x86/mce/AMD: Update sysfs bank names for SMCA systems")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-3-236dd74f645f@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mce/amd.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1113,13 +1113,20 @@ static const char *get_name(unsigned int
 	}
 
 	bank_type = smca_get_bank_type(cpu, bank);
-	if (bank_type >= N_SMCA_BANK_TYPES)
-		return NULL;
 
 	if (b && (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2)) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-		return NULL;
+	}
+
+	if (b && b->block) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_block_%u", b->block);
+		return buf_mcatype;
+	}
+
+	if (bank_type >= N_SMCA_BANK_TYPES) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_bank_%u", bank);
+		return buf_mcatype;
 	}
 
 	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1)



