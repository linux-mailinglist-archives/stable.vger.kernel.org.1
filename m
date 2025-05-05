Return-Path: <stable+bounces-140459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7AAAA8E9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5C3167660
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C2298993;
	Mon,  5 May 2025 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXEVexpH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D9356E6F;
	Mon,  5 May 2025 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484906; cv=none; b=t7OabUw9UD30pYJWnrBSrGVpezfM54Iw8MgbBYdcdgCxufaqNVxS6ft39aQc74Og51E8+PF8fQZCfVmdRSO9Cw9DOA80aBXTNDinu2X5wVLj3aebprbiQKkiw7IEX8rZJ2qqKLDG5Dk44g2xI2LQjzAqpmbWjntw27mhPstLXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484906; c=relaxed/simple;
	bh=QtQv3X+lPsoDtfdQq6HuEskCPyP8I2gQ4J+aw3KQrV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQAvi9mNxaC9AAEntP0Yy9ycXDlnMKwRFI3oYLVRxgX1sKRLxGRlOiifqzuOg0vr1ijJ2QlqLlzSaR+stjuSyVI6nID0jFwVk5ZFjn7f9nBo3D9U3MY8Ag6lCI112zcTptJIXuxqmJ2brVFSsnuTuCaaL9w9RzBBc60gx7lXK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXEVexpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C439C4CEED;
	Mon,  5 May 2025 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484905;
	bh=QtQv3X+lPsoDtfdQq6HuEskCPyP8I2gQ4J+aw3KQrV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fXEVexpHuN8IV8jfhqxgoGvnyDI3YbjeeAs4u+EWtpe5aXUEylq9aHvga6g5FZ+tL
	 TxdP7X/cFrugSnU3QDHSESDzXzqmh0pzGhv2YagqyLS9ciLKc+IXWGsgm03aAfDfLS
	 AecWdo4yYiSLb2tqnU5b/jNvS73YQXI5jRPrbx4DTqmH6Ty5nV2O9EWNNKatOJEd2J
	 MA4me6SmQr47TlL01X6wtYC5rJpEenHps0lispTeT2YQaATXiKVto4OF0yvmVGss+2
	 On/+DH98w/ls2RARr0tvtq1Kf8IVIuEmVPgrmk8fKr49vgNtZOjBJh3GW+xI2LKgdd
	 MF0qg8aQkpxYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	gautham.shenoy@amd.com,
	peterz@infradead.org,
	brgerst@gmail.com,
	patryk.wlazlyn@linux.intel.com,
	kprateek.nayak@amd.com
Subject: [PATCH AUTOSEL 6.12 067/486] x86/smpboot: Fix INIT delay assignment for extended Intel Families
Date: Mon,  5 May 2025 18:32:23 -0400
Message-Id: <20250505223922.2682012-67-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

[ Upstream commit 7a2ad752746bfb13e89a83984ecc52a48bae4969 ]

Some old crusty CPUs need an extra delay that slows down booting. See
the comment above 'init_udelay' for details. Newer CPUs don't need the
delay.

Right now, for Intel, Family 6 and only Family 6 skips the delay. That
leaves out both the Family 15 (Pentium 4s) and brand new Family 18/19
models.

The omission of Family 15 (Pentium 4s) seems like an oversight and 18/19
do not need the delay.

Skip the delay on all Intel processors Family 6 and beyond.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250219184133.816753-11-sohil.mehta@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f1fac08fdef28..2c451de702c87 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -681,9 +681,9 @@ static void __init smp_quirk_init_udelay(void)
 		return;
 
 	/* if modern processor, use no delay */
-	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON && boot_cpu_data.x86 >= 0x18) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD   && boot_cpu_data.x86 >= 0xF)) {
 		init_udelay = 0;
 		return;
 	}
-- 
2.39.5


