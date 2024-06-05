Return-Path: <stable+bounces-48245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCBB8FD6A6
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 21:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D04728A3F4
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712001527A0;
	Wed,  5 Jun 2024 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WWl8arl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ZAmcb96"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A314D449;
	Wed,  5 Jun 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616446; cv=none; b=aIuquaLa/Hi7AXlPPxcQKUZQ/Pr9od3H1cEMDSBHi2MzYkgaHrQh8j6gPgHqa0eJH1t5bcIvo0I7kAY27Z+ZG6ytX9y4nG4F9QYukEFOhN8PE/PhXV0JjfE5xuUjkytGe2Gs4Zj3ma0ROm6uBuoxvaL3MwB8ChgUELvB2/BYtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616446; c=relaxed/simple;
	bh=w/lL412irMpN5xx3ZjFRnT9eqdOLWHQqe/utFRXVQfw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GOExe3Jkq44YKm0RWs2NU9zswn5eZmgb48cSAUjf6qxnA2v0UlfHfnb5j5hG2G3pl8olNTiCNuz3A1D18B0sTKwtJ6+jsEoWWsB2o5L+AsFS1KGR7PBeDVLyhv8K+wqmsFEHD/Jb0IHgraVERfJB9HqsSmq29Inm+XlVHfIjbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WWl8arl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ZAmcb96; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 19:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717616442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vtGG6eouA5Y8cQaAebhdwmXmJyo0bOZBi8OpA+j2HA=;
	b=0WWl8arlnS2xT7K5r19LYljhj8j3fBPNhFb/+vVMXZQI6Ij1p54hKOxlkcNGyOOeuFOTwB
	Ij+7pKxWup+Lc/5pJGtn6ymKe8DyhpF8yJb2MyyIlpmFF0SPVbtb6rNGulQLj2u9EVjYxZ
	t7CtIjk2dI1+qtPfngfbiHlWHIWTeETc1ERsHaE9ua3VlnNFhdYyLlFQ7Alc5BPBWTdS97
	BITOSKzjOceOPgo/WXxe3PsiabV/eBc31s3A4R/7AMHYvpxT9/xMoV0CCveHbVsEekX8Ci
	I9juz3ZDXm4ETXjQ2U2cRU7tvQ8eRaDwGxbaoteKlHEU8Hu2C9a/IWaBVIYsyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717616442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vtGG6eouA5Y8cQaAebhdwmXmJyo0bOZBi8OpA+j2HA=;
	b=8ZAmcb968NbHn5PMlNZZLwjZ9oM2mXfRfWhzS922AvotF/Cpm/SFQ6VIO141YB4E7I7q3B
	e3F5/WQZLK3gE6DA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/amd_nb: Check for invalid SMN reads
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230403164244.471141-1-yazen.ghannam@amd.com>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171761644225.10875.15854801411132236549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c625dabbf1c4a8e77e4734014f2fde7aa9071a1f
Gitweb:        https://git.kernel.org/tip/c625dabbf1c4a8e77e4734014f2fde7aa9071a1f
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 03 Apr 2023 16:42:44 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Jun 2024 21:23:34 +02:00

x86/amd_nb: Check for invalid SMN reads

AMD Zen-based systems use a System Management Network (SMN) that
provides access to implementation-specific registers.

SMN accesses are done indirectly through an index/data pair in PCI
config space. The PCI config access may fail and return an error code.
This would prevent the "read" value from being updated.

However, the PCI config access may succeed, but the return value may be
invalid. This is in similar fashion to PCI bad reads, i.e. return all
bits set.

Most systems will return 0 for SMN addresses that are not accessible.
This is in line with AMD convention that unavailable registers are
Read-as-Zero/Writes-Ignored.

However, some systems will return a "PCI Error Response" instead. This
value, along with an error code of 0 from the PCI config access, will
confuse callers of the amd_smn_read() function.

Check for this condition, clear the return value, and set a proper error
code.

Fixes: ddfe43cdc0da ("x86/amd_nb: Add SMN and Indirect Data Fabric access for AMD Fam17h")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230403164244.471141-1-yazen.ghannam@amd.com
---
 arch/x86/kernel/amd_nb.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 3cf156f..027a8c7 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -215,7 +215,14 @@ out:
 
 int amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	return __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		err = -ENODEV;
+		*value = 0;
+	}
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 

