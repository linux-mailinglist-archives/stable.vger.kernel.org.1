Return-Path: <stable+bounces-154395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56FADDA3D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DA85A36DE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90F2E92AD;
	Tue, 17 Jun 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="POwLTWIV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96762E88B1;
	Tue, 17 Jun 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179056; cv=none; b=Ofk5J3aQ5yQ3+R/C53CS8wbPQ62fwYzmmr8G1L9oBFfayge0B/6YzSgTam1syVK6OZfhxKeLWJUFzy12PioyGXhAzjQiUR8IrW73juDcyFTEKeQSwRnjVuwTlQ4r7yIVIAmDfc4x5GgwAe/56YXXRUMPC500xevrY+ZroGt7jl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179056; c=relaxed/simple;
	bh=DFJLeNdhsVOb01R/5Yg8XiSDlLoXhon0Mx6qQhqKh6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICpB4xJ9efO8f7tfGNhO6fNjgZveAySs8pOLXlSGLgcvGBLNdajKRVSx8Zq+Ul/wRQpmAwFKzVMM5iPydtcn5nNW/3+5jG/BiVCEsWScd7lyMShUXEDVxn5MaZs2+oMXpKSCKELkJOFk2+HoHB2/uAnL/q1JVYJH3F6MauX1/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=POwLTWIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C77EC4CEF1;
	Tue, 17 Jun 2025 16:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179056;
	bh=DFJLeNdhsVOb01R/5Yg8XiSDlLoXhon0Mx6qQhqKh6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POwLTWIVFB6Y3fsWcfgwIqDBC7Xus2ovwt9c8vUEeEs7HRrDdfaZRekBhhMXkvL3G
	 bwlqNOPRGhJiXn2GSKCNQqY9ru3G4nZU2LYSuRvzA8+yWQCzXxbNt/Ibcv22lmsTHG
	 StSOFPL3Vleq3JX40TDRTT9+wsIbdMvtdeDfZrzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 634/780] scsi: ufs: qcom: Prevent calling phy_exit() before phy_init()
Date: Tue, 17 Jun 2025 17:25:42 +0200
Message-ID: <20250617152517.290717525@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nitin Rawat <quic_nitirawa@quicinc.com>

[ Upstream commit 7831003165d37ecb7b33843fcee05cada0359a82 ]

Prevent calling phy_exit() before phy_init() to avoid abnormal power
count and the following warning during boot up.

[5.146763] phy phy-1d80000.phy.0: phy_power_on was called before phy_init

Fixes: 7bac65687510 ("scsi: ufs: qcom: Power off the PHY if it was already powered on in ufs_qcom_power_up_sequence()")
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Link: https://lore.kernel.org/r/20250526153821.7918-2-quic_nitirawa@quicinc.com
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/host/ufs-qcom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 2b000c1708ce4..31649f908dd46 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -454,10 +454,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	if (ret)
 		return ret;
 
-	if (phy->power_count) {
+	if (phy->power_count)
 		phy_power_off(phy);
-		phy_exit(phy);
-	}
+
 
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
-- 
2.39.5




