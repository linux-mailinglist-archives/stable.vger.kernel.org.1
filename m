Return-Path: <stable+bounces-164366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C5B0E993
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138041C83F72
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F1720FAB4;
	Wed, 23 Jul 2025 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJEQMFhp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA1523A
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753244696; cv=none; b=MfNRhbkZaEQgMnSCgXQR9u+ZJqoVErrF/wuNHKkLMrkN1UIUoEcazbJc3l9p79KmaEk21h8+MNsRXGA3EEOCvlBeHEGX+CtukbIZSwTeGiTUCcAKo2YemDmSyVk4TzPuz38ErddrENlAb68CYrQiehkQbJ2Jij2f+BYzOHtfTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753244696; c=relaxed/simple;
	bh=/1OxvCZhYCeBa5w0+WMFNz27Po/9UAKd5bZqjhgEoy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZvstHuYFF/uRmfYfRLNyR2F7y9jNw0RkuySNgf/aZIrP4SdkvOpwfa3o0FY4MIicOIssfLpzS8PRVMyW/4vv01zsJovB9CCuAetOYe/eAu0otfcuQWoaYHUKNqvrZnsTlRQ8LEK2JbkoLxUsk2pW6FoNSI9FMRgBJ+CLevXEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJEQMFhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977A4C4CEE7;
	Wed, 23 Jul 2025 04:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753244695;
	bh=/1OxvCZhYCeBa5w0+WMFNz27Po/9UAKd5bZqjhgEoy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJEQMFhpC5srY4fCyMZhZfhNh9bP3kHZj/nyI1lOcUKaGxKaF2k51cdba7Q0VfeYM
	 wGpngEpC4GsQNtIWJiZq+/IzU1Pptvcu7dw5Fof2Vt7zHbkRv9WuXl1rBr6QP/wdHu
	 iI1n46+gPOPkQNxhiyjjBDmobDFhg1+BLdlU5tU26USCgH22sFWXSGzNkJmwKlXMIu
	 oRy1/8p6SeuHHKv79ePZeY/shDLmV4pT0NpYMckYxeHq5a23Pfa8cw2WAyMO3ooOB0
	 3TRn+zg4YL0XZ+zQzVyROr3lxvnRVlz02rupHAPeuUpNOQaU1/Y6DHCwKAuBZ5QBHg
	 yVc+YSs918U1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] x86/mce/amd: Add default names for MCA banks and blocks
Date: Wed, 23 Jul 2025 00:24:51 -0400
Message-Id: <20250723042451.1048106-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071202-cycling-woof-6cf6@gregkh>
References: <2025071202-cycling-woof-6cf6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit d66e1e90b16055d2f0ee76e5384e3f119c3c2773 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/amd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 816b3d0512bad..ad71f5a7faf03 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1180,13 +1180,20 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 	}
 
 	bank_type = smca_get_bank_type(bank);
-	if (bank_type >= N_SMCA_BANK_TYPES)
-		return NULL;
 
 	if (b && bank_type == SMCA_UMC) {
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
 
 	if (smca_banks[bank].hwid->count == 1)
-- 
2.39.5


