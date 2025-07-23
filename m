Return-Path: <stable+bounces-164363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0ECB0E96A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C06916A6D9
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0638157E99;
	Wed, 23 Jul 2025 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY+84U8B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8681C27
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243483; cv=none; b=OYefnqTg8qJjVT+tIAzRrUYUU+NTYE3UKQ3uACaWiOeAhEmDDU10xQkRMTb4Sl1r/DGs+It7PHcXtnkBG2tlZubeJIWe+0JbkfvZspVEfdc6DKAbkYjSpKM9p3ztQAnLaorFqykd4Ime+VZQor0cqDQ5AMT1el5EHFRK8L0wcMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243483; c=relaxed/simple;
	bh=2BlrtkI5OIXI7IpAKLq0wYy3v+13NorGFAZ6xx/HtvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISDCTTj324IIDuKTgXuniGzniIYu4sSVx/oXXlU3LLc6xQg27OxFRc53IuyavG5bj5SjBXnALsHyOY3/H+9pomV9xOKM5JyJ/JFttJREOFyvMlJp3i+bhMdW0peaNI/482Q7bIlRwyHBX0iQLWRe2E+/lv6BhkXgmdU6SoDmsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY+84U8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FD3C4CEE7;
	Wed, 23 Jul 2025 04:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753243483;
	bh=2BlrtkI5OIXI7IpAKLq0wYy3v+13NorGFAZ6xx/HtvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kY+84U8B5L+ErQMJqzMqqKfdX5LR47p0SGbC+5zQn+3OB0XtJuT3QmvkunB6qgUtE
	 TzJ/QS4c8orq6TAu5CQljDEcNcJ3KTU/j6KqvQAQiF7XQGliZ3q3X53OvUNlkL05vt
	 kRZC54HXM5utrpLW5UYEiZaNWD4kuRCfXKlZxsvZTJXJIuBkD8dqCHiysZmjntZ7ir
	 lXfdREnEPnxp72AXaHlbSSVklKWk0QBNc6jKWSFCAILEDAFWRymnxV0fekIN5fCWHf
	 yDdQfT8vctvqhIfidP5MODyxt39RCI8iVP4E8x67G1JBRC8ewm149Aeb79sIy4nhL4
	 jKTw7GCc6Doug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] x86/mce/amd: Add default names for MCA banks and blocks
Date: Wed, 23 Jul 2025 00:04:37 -0400
Message-Id: <20250723040437.1045199-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071201-coping-motto-1a12@gregkh>
References: <2025071201-coping-motto-1a12@gregkh>
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
[ adapted get_name() function signature ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/amd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index c011fe79f0249..2bd22090a159d 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1215,13 +1215,20 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
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


