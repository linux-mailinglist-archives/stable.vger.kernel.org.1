Return-Path: <stable+bounces-110491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27BA1C972
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3153A9CD0
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F51DC9BB;
	Sun, 26 Jan 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWAAC7Pu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE71DC9AC;
	Sun, 26 Jan 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903049; cv=none; b=nAH08DGI5BCMpNLr1UiSgQQeHc5YpF/Bz3k8kNAIczyjfc6GotV4hQCag1kSY2KSl+vaLhzhCv2AFZ9+BFPrVNmbtz87U/xSCxnVAniBsowz79uzJMj+Mziw8M/0ec8o+PwiAEB4Q/f75Q/MFeB4bS5ca/wQi1DMmuQJF1DNTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903049; c=relaxed/simple;
	bh=6um5JQDGk8szZ0P11iFIImk+WfCf4D0s+AfDHRcUu1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UIQfT4emL9vNXaqSACY/Ua/is9RqfYwRAo2zUvKEM9gHkbzY51hstwDuG0jIN+KjllfZs0J1IyMpR7SPx0LbI2zSYlURfkNRKTDiQGQvbLnMH4vlTyC0CTuxg4raobRMuzyPtlt57Yzb8+wgNh4M2upgsYZW5htqhZPrpDYDHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWAAC7Pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2306DC4CED3;
	Sun, 26 Jan 2025 14:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903049;
	bh=6um5JQDGk8szZ0P11iFIImk+WfCf4D0s+AfDHRcUu1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWAAC7PuK8tsx7Shcv5w6GBjhSxyHnNc7gsoRx0VPXT02rN+I8dTBRsTu3bx7yMLP
	 2mG0OmVL2b4nnLjLmjEoxywBhEtXTJOrQfaKv6Vp2ZlzJwGTsh7b3cPgHcb7fx/hsK
	 fqJjuP7UUWQI2507QPX7EDmEyhI3RmF+WIKGYC4nsOswgSCSq4o/5MiL4WQ9/AwHg2
	 0zNSMWMYd8EM6wB4g+UGQETH62+WXBybkg8yQG6zwFuv6VdSt5gKWsjZZQeR3GNEWB
	 8sIawRwUBlNPFoTgfk6Bl7+GjCAn7SDqnzR+sUpDp9Wlqs7yLzdeBFwnd901RxXI0r
	 uMi6iX6nriEnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	Shyam-sundar.S-k@amd.com,
	mario.limonciello@amd.com,
	richard.gong@amd.com
Subject: [PATCH AUTOSEL 6.6 3/3] x86/amd_nb: Restrict init function to AMD-based systems
Date: Sun, 26 Jan 2025 09:50:42 -0500
Message-Id: <20250126145043.925962-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145043.925962-1-sashal@kernel.org>
References: <20250126145043.925962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit bee9e840609cc67d0a7d82f22a2130fb7a0a766d ]

The code implicitly operates on AMD-based systems by matching on PCI
IDs. However, the use of these IDs is going away.

Add an explicit CPU vendor check instead of relying on PCI IDs.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241206161210.163701-3-yazen.ghannam@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/amd_nb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 6dabb53f58a44..b6d5fc396f88c 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -537,6 +537,10 @@ static __init void fix_erratum_688(void)
 
 static __init int init_amd_nbs(void)
 {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
+		return 0;
+
 	amd_cache_northbridges();
 	amd_cache_gart();
 
-- 
2.39.5


