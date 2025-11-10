Return-Path: <stable+bounces-192879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D661CC44AE6
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 01:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DE6A4E04E9
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0211C4A24;
	Mon, 10 Nov 2025 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvoTxmbW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA4D2AD1F
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762735681; cv=none; b=hggrxn1DxhiRBD5rwd/SFy5+KTWhQqbI+vz6w80XVda2jjlZgbg1bqg2QCc0QMSXyD3OIyNwRoLmv9hmupH+GsZNbW8BxNrkt0qWk9ulFyWUGmYzBeCuz2QNNzV0XbYhJiMMX24KCMIaqfIzkgy27zgUCuDRBl3EhzXs9GtLRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762735681; c=relaxed/simple;
	bh=vMR3KnjUI/hmMBmXjS/GZkoxYoL3OAciUxpz30qmy7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTsVsO9+Bs63MYMGUMbsFe+kfe32ioNx4HL8GVjZgzu3hSvV4DiVpwcmpfF8x6eAmdFEysexjfbCm3o4xFDVz1K17O1f2NYQdLfXk9mGp0WA4Kb2o5WJ8hXSJH35U3bDmdIU9gBXpDC/FdSggNLPwLh3o70F4edowOMNZofMVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvoTxmbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974B1C2BC87;
	Mon, 10 Nov 2025 00:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762735680;
	bh=vMR3KnjUI/hmMBmXjS/GZkoxYoL3OAciUxpz30qmy7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvoTxmbWs+gEE3o/5wpvhK/ayX4yxkUFCA8+p9IAgSLlJcz4C2H1xI97JN0OSQ4ko
	 8Z4cz9GxEWTkUyHi9sx9duMaoyx6+G757w1XoqoEjxgXkE4S86GIf1cSHnjV/JAXj2
	 3a0WxdOvvxI73c1hQcfQD06GuqzI+ofX0pjaoKlMH5Of6Oaher0AhnwSF7/2uEYDL/
	 N3TgflqB9SF3DschOUwIETmHLDG7ZgwvLMzX6fDFan6KAqbAtGfz4GpdnF60ErVFc2
	 YXNhLtYonUIh8VgdxaevLc08MFB1Df2Wyf/8oKL9akK8weINZTNFPAuPIXuBXxe2VC
	 bcvmF16XWpGGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 8/8] scsi: ufs: ufs-pci: Set UFSHCD_QUIRK_PERFORM_LINK_STARTUP_ONCE for Intel ADL
Date: Sun,  9 Nov 2025 19:47:50 -0500
Message-ID: <20251110004750.555028-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110004750.555028-1-sashal@kernel.org>
References: <2025110940-control-hence-f9a8@gregkh>
 <20251110004750.555028-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/ufshcd-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index c38ea3395b2c1..5412855d6832e 100644
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


