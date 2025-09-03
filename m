Return-Path: <stable+bounces-177576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16FB41784
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD1B3B6587
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 07:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F882E9EC9;
	Wed,  3 Sep 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="OjuPMrOB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922552E9721
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886338; cv=none; b=PBxFAIAuqT3zcZxs+hI48KzHiwy7zh1h9rg7XHc8ViWaY+fIWqVPsWhuF8ltt2gw7jh6StfSwHVGDXooyNFd25fHIJrYm2f2qYZwqtqpC7BQWGR83deQCsgTJAD1TIAma06ePz/ft7bgBoCsczIhLBZ0hyalsHaiatvpeYeGZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886338; c=relaxed/simple;
	bh=CCP6XV16ghSvc5+TmzW6tBCOJI6kcdghqrOqpvfv0TA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU/wjTomrJ3/SnRSBu50s/Mg1CeDA6hIEtwfV62hWdRmOyD/IwaCUFTpQkm4M6i8kfQQRiVnlyZ2kC/vf3uXUh5IJLjhWpxDyVdFqbYhlFujfqnpZgUbwbg1rbyPCyrOftx0EmBCHID2tJCam/eozkN/hIhlySi9Snz6yqKZuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=OjuPMrOB; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5835Ah9O3495252;
	Wed, 3 Sep 2025 00:58:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=snGzp4jJgIFQH1DMnuVjHH89f925UJDpthNlRRxLLpU=; b=
	OjuPMrOBxMm2lsucZ70Fz75MotVUkLs4+yAc9QuYUL/QuN6eEhS/WecZNac1h9QU
	HgW+mNKF79LvOqPQzuYvlNXhN1wpKCw3YLS6ezq/RZz4z+3A+nkdKWpKOx8GNmCZ
	0XgsPn7e2RNo2d+jcD3TGv4c0XgT5eaXRUFN/BDiAJZBgXyD8vWxNk0pqb1o6WmJ
	up/nJ0raXLlbLENxpdd2NXrTUOaFgHLPPDmmeGvrSev9lQF4Sel+AESpHW56pwTB
	op+WJjBwF1vM8x2jPsY2avzZGWu4Jvy6b8xTM1gJWmrzYaj40+g/071KHVC/Jg1v
	wpCasIWA7yoFEaAw+ElAcQ==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48v0tfkh3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 03 Sep 2025 00:58:32 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 3 Sep 2025 00:58:33 -0700
Received: from pek-lx-s14.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 3 Sep 2025 00:58:36 -0700
From: <jinfeng.wang.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <d-gole@ti.com>, <ronald.wahl@legrand.com>
CC: <broonie@kernel.org>, <matthew.gerlach@altera.com>,
        <khairul.anuar.romli@altera.com>, <stable@vger.kernel.org>
Subject: [PATCH 6.6 2/2] Revert "spi: spi-cadence-quadspi: Fix pm runtime unbalance"
Date: Wed, 3 Sep 2025 15:58:15 +0800
Message-ID: <20250903075815.1034962-2-jinfeng.wang.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250903075815.1034962-1-jinfeng.wang.cn@windriver.com>
References: <20250903075815.1034962-1-jinfeng.wang.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Q4qTHufLZNiiq4YOJmTwu1ZhQE6KA20K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA3OSBTYWx0ZWRfXw93/szThcbtn
 W0DBdhkBYnyo7k0pDMqcTDbW3mt/Em9zW8Mm4Rt80STk5ko06JW3Oxlkbs9x7j8oKcmbK7JjVGt
 MBIc5U94Jcmd0N3wfVhLCuQ7aH5BHhb/dH55IiHUemYx/TqayBH5yZYPrTz7s1QhmtAJRcnUp5k
 Rpb+JguwZe0z+PZpZj6wxdYQpS8C9MenYWaIe1IRnMG42bpeWM/yxrGAeEic3cF6eQxJKfOG5C6
 1nWqzdl/uRH7uBN5wKYz2Xn0w4g8U5BRJVynVZ7UFA14fDGqvyvt9vfJHdzfciyO9Lj8MDgFbTB
 DSjisl+2MZsZhBfUYs7WJS3UyZ2/bb+GPzE/GcW/Jp5sJggF5yKHpsQ+ckj3mg=
X-Authority-Analysis: v=2.4 cv=XJ0wSRhE c=1 sm=1 tr=0 ts=68b7f528 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=h2D0im4ymrUyw4qnnrMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Q4qTHufLZNiiq4YOJmTwu1ZhQE6KA20K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

From: Jinfeng Wang <jinfeng.wang.cn@windriver.com>

This reverts commit cdfb20e4b34ad99b3fe122aafb4f8ee7b9856e1f.

There is cadence-qspi ff8d2000.spi: Unbalanced pm_runtime_enable! error
without this revert.

After reverting commit cdfb20e4b34a ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
and commit 1af6d1696ca4 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"),
Unbalanced pm_runtime_enable! error does not appear.

These two commits are backported from upstream commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths").

The commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths")
fix commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance").

The commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance") fix
commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings").

The commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings") fix
commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support").

6.6.y only backport commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"),
but does not backport commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
and commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings").
And the backport of commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
differs with the original patch. So there is Unbalanced pm_runtime_enable error.

If revert the backport for commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"), there is no error.
If backport commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support") and
commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings"), there
is hang during booting. I didn't find the cause of the hang.

Since commit 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support") and
commit 86401132d7bb ("spi: spi-cadence-quadspi: Fix missing unwind goto warnings") are
not backported, commit b07f349d1864 ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
and commit 04a8ff1bc351 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths") are not needed.
So revert commits commit cdfb20e4b34a ("spi: spi-cadence-quadspi: Fix pm runtime unbalance") and
commit 1af6d1696ca4 ("spi: cadence-quadspi: fix cleanup of rx_chan on failure paths").

Signed-off-by: Jinfeng Wang <jinfeng.wang.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Kernel builds successfully with patch.
Test enviroment overview:
Branch linux-6.6.y
Tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
Hardware: compiled on X86 machine
GCC: gcc version 11.4.0 (Ubuntu~20.04)
commands: make clean;make allyesconfig;
no building error is seen

gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04.2)
Hardware: compiled on socfpga stratix10 board
verified by check the dmesg log and bind/unbind spi 
and no Unbalanced pm_runtime_enable! error is seen any more.
cmds:
dmesg | grep "Unbalanced pm_runtime_enable"
echo ff8d2000.spi > /sys/bus/platform/drivers/cadence-qspi/unbind
echo ff8d2000.spi > /sys/bus/platform/drivers/cadence-qspi/bind
---
 drivers/spi/spi-cadence-quadspi.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 9285a683324f..bf9b816637d0 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1868,13 +1868,6 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	pm_runtime_enable(dev);
-
-	if (cqspi->rx_chan) {
-		dma_release_channel(cqspi->rx_chan);
-		goto probe_setup_failed;
-	}
-
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
@@ -1884,7 +1877,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
-	pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1906,8 +1898,7 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_disable(cqspi->clk);
+	clk_disable_unprepare(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
-- 
2.25.1


