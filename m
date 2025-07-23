Return-Path: <stable+bounces-164362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB4B0E961
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 05:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719B71C27738
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 03:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539A1FE44B;
	Wed, 23 Jul 2025 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5yQ22qh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244334204E
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243047; cv=none; b=QIwopl2f9c/TWUjLVGbPWglW0vhatzpAYR8qnOhuTr2ScqJr4INeOPNIxtGY/bmpVQya67J1eMkaNEx+KMX7a05+iVRRsBvjV79L8BtsUBCWi9mGlXXg0urGaOAFoWg9PlQ2Chkq3e8lCtjuJ11uYrn43DITBFmL3MYgpGHccOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243047; c=relaxed/simple;
	bh=KsCYfyUMzKlX3XjEQPMYXgf3xzBScv6qoEnm3QEtFKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwWn7BSDDxC1Y/P3nFadS63FsOFtO9Rh0686TujnimOmbNSKQnaEclWqlxEc8VCt8MvVqhhUhan+Raxi/ayOfxcj85l2LKBHynACGcijmPvpD/TRNY1cePJKYC2pvXP9tkKcnlPaZCD09AqnW/9J12tn2X2K8N3DqwSJ8iAMCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5yQ22qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B754AC4CEE7;
	Wed, 23 Jul 2025 03:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753243046;
	bh=KsCYfyUMzKlX3XjEQPMYXgf3xzBScv6qoEnm3QEtFKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5yQ22qh46oFiquwBKenDJ1M9LNrqxROmxHS+UAS6mu/VLZCgTOEY2F+z85zIi/OZ
	 YxlCnZ46tighogkJhQu9EPjwFmmSiW+VW3MAHgSrFg2oD1qEIqtLjbvjkGotoN++Et
	 rihDzSbHffpgm7y038n+2bzzJcGdAsFCz3gvhyAoskc8nN0YJO36U63N12mOeQdOts
	 h5xWi08jBu/gRuNyOKE0uBpztZwdfZ7n8rh89Yyfh5Fnx7TqxaiYIrSQl0R5QFeaGs
	 gQh+jVItedGSDSn2pd3C34BL03xuGRXu1SSb4MzL1nNiAvpCy+6qUvubxRDfA9rRdJ
	 1IdvG/FmidBBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] x86/mce/amd: Add default names for MCA banks and blocks
Date: Tue, 22 Jul 2025 23:57:21 -0400
Message-Id: <20250723035721.1044134-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025071200-cone-ogle-b45b@gregkh>
References: <2025071200-cone-ogle-b45b@gregkh>
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
index aa20b2c6881e9..ef8a28343ffb7 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1228,13 +1228,20 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
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


