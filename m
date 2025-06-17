Return-Path: <stable+bounces-153983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF3ADD7CB
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD902C17BE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D4D28506C;
	Tue, 17 Jun 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wRZrwqNz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE61FBEA8;
	Tue, 17 Jun 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177727; cv=none; b=ToiTWEsIiHq4JELhfqwalEWLklFciOqfi6C0FaxxBMCVZsjG39jiPeq8jbcxqDVgF4QpSigSkm1rQpqgwIbDD5/+VIQzYxnIPy44z25MkuMVpC9DpfQYmR18McrUQ81xKUGsMwB9ByK+dgHY8uPQNyNBEjFrkvm+ati98u/j1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177727; c=relaxed/simple;
	bh=4CqVdLAlhzdUJRoFy6KXsjhOTn4m6INoUHlnZQ8bbKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7akPhm7SV3Pqwm62fyxEh+WACCc9liX+naipOidympg2IW2WCpCfbkq52y2dPKeiQsHWMmOS3kAahA1nDpVxilhYKxSOiX2zkxOnulr6ixRDgsIYpfJzgdjaECobkdN7BO8mvyaIesVAebxWEJMNCM5og4f9kiNaB1G8E1fp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wRZrwqNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58A2C4CEE3;
	Tue, 17 Jun 2025 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177727;
	bh=4CqVdLAlhzdUJRoFy6KXsjhOTn4m6INoUHlnZQ8bbKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wRZrwqNzV31qCyIPt+pgpznFftKa7pky81gBLC7KbyIxiJr+y+ho72u6O5EGe/KOq
	 6Vfa5YjTpCjsqF9R61BBodcF/VvzSjwg/1DHsQVhZWhCzy1EO1jeQ5VxcWY0fruZkI
	 tgBI57p0255NTv+UiPX3OOT15Fo9XLt1ISo6RoJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 387/512] scsi: ufs: qcom: Prevent calling phy_exit() before phy_init()
Date: Tue, 17 Jun 2025 17:25:53 +0200
Message-ID: <20250617152435.261816512@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 4557b1bcd6356..a715f377d0a80 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -366,10 +366,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
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




