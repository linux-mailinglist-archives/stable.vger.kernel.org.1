Return-Path: <stable+bounces-105544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517F19FA47E
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C75B188743E
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324FC156243;
	Sun, 22 Dec 2024 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i5CaXZjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2855897
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734851960; cv=none; b=f/q4OJxSTrFAxTybUmZ22vkYO1qfpiF3SKQVAssCuxWemgPfRej6tiwDqH6aWmVDoZ8mUmCMolucj1dCblcIfGC2gQsfRJQ0ZfE12V8hn8/ZOa8fJ/7Sbh7OPQJV7TrGHuIsKJtiW3k1KbvBKcEbRWxRUYuTllJWzdzemwg4Y5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734851960; c=relaxed/simple;
	bh=FZebgZTPrn5vX4NeXJ8mJHa9t/fR/d64nkKHF0SRx2o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RNHb8ogRnEXYR/uPLQPHuRGreq+R78Nt3IcPBoAg5+SIRDyo19q+r0Dx3q/r8w5PFg2PvUMFedNEDMbaeWd9/WNFN9kA6hWqHBkMJuLk+5c2i2PFPKQZGQtuu4OM9legXNsZBHRT/2NIpj3uJkmgUygDqcQho++Wd50KHpJLOhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i5CaXZjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD7CC4CECD;
	Sun, 22 Dec 2024 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734851959;
	bh=FZebgZTPrn5vX4NeXJ8mJHa9t/fR/d64nkKHF0SRx2o=;
	h=Subject:To:Cc:From:Date:From;
	b=i5CaXZjAtScJg/bhxfNx3k42cpc/tVbM1DHpkFppjvJ/5pnP7mLpe/XgowtWvm6JM
	 v38bf4MP2YInqZfpSi7CWAke182ZAWIaizY/bVqDswxQZRdmQpnUkA5Q1/eXlpwzPC
	 xWpdZiS4lGTP/+CIdscp+Rzn5IWsp8PG50DLWck4=
Subject: FAILED: patch "[PATCH] EDAC/amd64: Simplify ECC check on unified memory controllers" failed to apply to 6.1-stable tree
To: bp@alien8.de,avadhut.naik@amd.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 22 Dec 2024 08:19:11 +0100
Message-ID: <2024122210-tableful-nugget-15bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 747367340ca6b5070728b86ae36ad6747f66b2fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122210-tableful-nugget-15bc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 747367340ca6b5070728b86ae36ad6747f66b2fb Mon Sep 17 00:00:00 2001
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Wed, 11 Dec 2024 12:07:42 +0100
Subject: [PATCH] EDAC/amd64: Simplify ECC check on unified memory controllers

The intent of the check is to see whether at least one UMC has ECC
enabled. So do that instead of tracking which ones are enabled in masks
which are too small in size anyway and lead to not loading the driver on
Zen4 machines with UMCs enabled over UMC8.

Fixes: e2be5955a886 ("EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh")
Reported-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20241210212054.3895697-1-avadhut.naik@amd.com

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddfbdb66b794..5d356b7c4589 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3362,36 +3362,24 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
 
 static bool umc_ecc_enabled(struct amd64_pvt *pvt)
 {
-	u8 umc_en_mask = 0, ecc_en_mask = 0;
-	u16 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
-	u8 ecc_en = 0, i;
+	bool ecc_en = false;
+	int i;
 
+	/* Check whether at least one UMC is enabled: */
 	for_each_umc(i) {
 		umc = &pvt->umc[i];
 
-		/* Only check enabled UMCs. */
-		if (!(umc->sdp_ctrl & UMC_SDP_INIT))
-			continue;
-
-		umc_en_mask |= BIT(i);
-
-		if (umc->umc_cap_hi & UMC_ECC_ENABLED)
-			ecc_en_mask |= BIT(i);
+		if (umc->sdp_ctrl & UMC_SDP_INIT &&
+		    umc->umc_cap_hi & UMC_ECC_ENABLED) {
+			ecc_en = true;
+			break;
+		}
 	}
 
-	/* Check whether at least one UMC is enabled: */
-	if (umc_en_mask)
-		ecc_en = umc_en_mask == ecc_en_mask;
-	else
-		edac_dbg(0, "Node %d: No enabled UMCs.\n", nid);
+	edac_dbg(3, "Node %d: DRAM ECC %s.\n", pvt->mc_node_id, (ecc_en ? "enabled" : "disabled"));
 
-	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
-
-	if (!ecc_en)
-		return false;
-	else
-		return true;
+	return ecc_en;
 }
 
 static inline void


