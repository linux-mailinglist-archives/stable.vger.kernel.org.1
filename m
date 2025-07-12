Return-Path: <stable+bounces-161707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CCAB02B0F
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25A05622C1
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4230278754;
	Sat, 12 Jul 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L0AVUbDP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B1278750
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328511; cv=none; b=TLK85e1C5idMDZpBBTD5rgV+o3GL5bqcwEQyUuAFBLFib7kPBqgsZ1kMLEitzZElSs58dWMVj7HZqeL8pXyAevic0HaGIQSuDt8zlGQv1oafzUOTKfIoWAh7ezuzM8LbOowufmMijD3v0MFVUEfbeXtP3+L5gh5HyCcjCVzfACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328511; c=relaxed/simple;
	bh=RUxlo45ov5P5HGR/XWFbfO0lyPFBrptqngk+ybxFrBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o6LVbHX+tk0O4WBg1jR/XQ2umRnQd0dpPUXfHJJ/3ZHTFE4jNOFxIqDoqY60S3ZDSBQkH7CLTeKr1RvFpM/CzrT6itrcNJJV5D6NK2ml8IDXqdvW0bPv1cMLiR61uQD4yFgxwNbeMFsDAC6FM9sponTP9Wrb7xOsJavvtnIok9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L0AVUbDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAF5C4CEEF;
	Sat, 12 Jul 2025 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752328511;
	bh=RUxlo45ov5P5HGR/XWFbfO0lyPFBrptqngk+ybxFrBI=;
	h=Subject:To:Cc:From:Date:From;
	b=L0AVUbDPDvEb8ZAbMXR2xDUOmkyS6Fz2ywAI9M6aETsnvRxkqOBAvIJgWx9FmHQA0
	 YQ0DAfEZQrbDUof66huk/j02mvcvA5rtBTO4wJ7Rpco+P7+oo/hY6Pd+Un94R1fSpp
	 9fVbjvkfpUHKo57/06CsH5iY+cwgguRicjPNzRQM=
Subject: FAILED: patch "[PATCH] x86/mce/amd: Add default names for MCA banks and blocks" failed to apply to 5.15-stable tree
To: yazen.ghannam@amd.com,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 12 Jul 2025 15:55:00 +0200
Message-ID: <2025071200-cone-ogle-b45b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d66e1e90b16055d2f0ee76e5384e3f119c3c2773
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071200-cone-ogle-b45b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d66e1e90b16055d2f0ee76e5384e3f119c3c2773 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:15:58 +0000
Subject: [PATCH] x86/mce/amd: Add default names for MCA banks and blocks

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

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9d852c3b2cb5..6820ebce5d46 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1113,13 +1113,20 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
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


