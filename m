Return-Path: <stable+bounces-192942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F3C466FC
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586EC3BE88D
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3593231329D;
	Mon, 10 Nov 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm0CFppa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B330E0E7
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775943; cv=none; b=O3yknWg/C2nA1PtyhIG6F5UPCPmrxBCroDS+JbP2+IfoTTG3HfhJzbgiC2NRp7c24wxiqX3YNAL1isUeZwUiPAg8VhP6QQ+G8gkjdWT4NK2s+8Oov54k6oDLOFhgVOUj8UEuXN1Pw+oRjgyp5fASVNPBeHbMBMzcCm9UYJHO6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775943; c=relaxed/simple;
	bh=H7rzwoVh0mlLcBhf/S12UYz9OSCGFGxMu3NA20s1pas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8QowkhdoGpOBykB6tcjqfUSp6/zOA6kw5sWOu5gZ+MmEQFvpAPcl4Ca2O+vQ6Z/ccHxoseDk4a3tDBV3D763WO5HDVxJXc2G2Pcq0liF9H2z6FXE2AGrdQufzjauFu2MYQ4tNJUqHIbln1AhZVL179heBtxzhJJsFbAM1rZH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm0CFppa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD905C19421;
	Mon, 10 Nov 2025 11:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762775942;
	bh=H7rzwoVh0mlLcBhf/S12UYz9OSCGFGxMu3NA20s1pas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fm0CFppa39Fkr7/WQov18Sux7SUGmGTWDyaafOD6qFGez+ojAHk/LP8gM8DcG+Wcd
	 J9E+Qgn64vU/9Fz7JFa7i4fwVYr8FZoa0oXAE2k6xvQXvCSnbk2XMdJugp71QBs8bs
	 qXDP/bCMuDp8FwOEUteVHI5BfcoAy5GJgEqoeGQU6wNc4g4G5aC1qM8cxmEwwJ+79Q
	 XGXBLVIHCI/dQ6w81MLcOUSZsdGAVmeoygOp57Dh3kBS8tEWzTPrt0tzUIYyJl6u7n
	 gFH8sgvokUQuOnpHHWsVxozAP7yxvml+kHrSrKbg71S+I8DVpkA9J7zxxBoOKmUsjk
	 M7HP55iAe2cpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL
Date: Mon, 10 Nov 2025 06:58:58 -0500
Message-ID: <20251110115859.651217-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110115859.651217-1-sashal@kernel.org>
References: <2025110916-yummy-cane-0741@gregkh>
 <20251110115859.651217-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit d968e99488c4b08259a324a89e4ed17bf36561a4 ]

Link startup becomes unreliable for Intel Alder Lake based host
controllers when a 2nd DME_LINKSTARTUP is issued unnecessarily.  Employ
UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE to suppress that from happening.

Fixes: 7dc9fb47bc9a ("scsi: ufs: ufs-pci: Add support for Intel ADL")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20251024085918.31825-4-adrian.hunter@intel.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ adjusted patch context line numbers from 428 to 460 due to prerequisite backport ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/ufshcd-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index c548c726e7f63..4efac5d6796e5 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -460,7 +460,8 @@ static int ufs_intel_lkf_init(struct ufs_hba *hba)
 static int ufs_intel_adl_init(struct ufs_hba *hba)
 {
 	hba->nop_out_timeout = 200;
-	hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8;
+	hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8 |
+		       UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE;
 	hba->caps |= UFSHCD_CAP_WB_EN;
 	return ufs_intel_common_init(hba);
 }
-- 
2.51.0


