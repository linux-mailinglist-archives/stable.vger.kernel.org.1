Return-Path: <stable+bounces-177575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F400FB41782
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675FE1BA35EA
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704102E92D9;
	Wed,  3 Sep 2025 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XX/rFOBL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20992E7F3E
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886336; cv=none; b=HUnmQOo4KlWcr1mDze5I17QJmtR65xXXIxV9EihvYimG0xYYDHEJeDedyXt0ne/H3jY9Bh9VpOgvevzg5heFL6S/AsO0wtiLnoGx8hIEGKQIZArZPniRaQ5HzgFi5VdMfzRNVMTiG/iB0Nm2K7VlkBVhPaIozbipo1iWNryOmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886336; c=relaxed/simple;
	bh=ZQsY+ZOxIG3Ef2NlniG+o+ne/TfKRIcgYThKgwABNLE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4Lu1uv0MvfH9eEG7cPT7DEm38u7Ril0d0kWHqvP7/931NAVc+rIVGRCAjQzezarEA9XWoMf3OWdGkdbFo+CpwBL4dlM62+uNOTAku/fFJJivT3mbqHZlQMaeHz/S7Xvi4ZQG4AAlRKohtLso4FphNTVlDFGUt21bEkZZil3Sp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XX/rFOBL; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5833o98j3288944;
	Wed, 3 Sep 2025 07:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=BDn7YO629
	r3lTFBi8KPHQdOpwAkwsql28xZe/dAlZ4M=; b=XX/rFOBLioX0XV38SlVVZj7NF
	OHUxF97MUmaNyuGqQ5Iqo0PL1jPDqUtIdOyIQp12osdF7pojRjnNrPpTTVVVMklI
	PTCLvPY3cwQ+gFxE5Yf5WPO4mRSyqXXUqosee9PxKgxqlRF642PuHdAEKZRcA8HT
	c1FVU3wmAqlZrxuo4Caflnq9RVH0XHOi2lxRYoVvpCxRGVUBv5TnbjhcVXbmTg1e
	K8abIn5xBmU+VYMoznGEEQJau9dUVlzZiGq0PhGtHQYjZdEf5rhb4xhF5Zl4Xv/D
	tc6K9uNzYT3IPkW42Cjqcl36Hz8tgEyrH/+jD7u0uy+zAuBxu+AuQjpz59taA==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48ur99us11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 03 Sep 2025 07:58:31 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 3 Sep 2025 00:58:31 -0700
Received: from pek-lx-s14.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 3 Sep 2025 00:58:34 -0700
From: <jinfeng.wang.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <d-gole@ti.com>, <ronald.wahl@legrand.com>
CC: <broonie@kernel.org>, <matthew.gerlach@altera.com>,
        <khairul.anuar.romli@altera.com>, <stable@vger.kernel.org>
Subject: [PATCH 6.6 1/2] Revert "spi: cadence-quadspi: fix cleanup of rx_chan on failure paths"
Date: Wed, 3 Sep 2025 15:58:14 +0800
Message-ID: <20250903075815.1034962-1-jinfeng.wang.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FqYF/3rq c=1 sm=1 tr=0 ts=68b7f527 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=h2D0im4ymrUyw4qnnrMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: EO_pUwJX78NP99h6g05TfC1QlO6N4QGI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDA3OSBTYWx0ZWRfX6VA6708kKrZO
 sBPvXNQquRfB4gjZ7IxbXIenpcmCPhUMAoW2VtkxofcY/j6+RNP4fNtEymJdqotubkscK4YekAb
 fhBYC6Ryp8YTfOb2LUFV/ziXOe8ZyBLOVCRhvxMbMho8ZKdzOfEGWY5mp5kuEglixkBcb48NDgj
 WvMI0DtpMHLLcy7NzzNw69t9YFFeVPlTUrno8M3E0ce8xnDk73QafixbzE2LD4TrpQKs0CHNE58
 NE4gWPwnhiGdlyzpOxcrdyuMmXakdHlT+Dz45wy+8/Fszzsa2PZBzIuz29Q4ugUNjREdQJbMVe+
 jqriogIonQFlJrbInpR2oFjkF6K2tgifWFbJS46MUjccGn2mqk1J6zZ1GGTksk=
X-Proofpoint-ORIG-GUID: EO_pUwJX78NP99h6g05TfC1QlO6N4QGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun

From: Jinfeng Wang <jinfeng.wang.cn@windriver.com>

This reverts commit 1af6d1696ca40b2d22889b4b8bbea616f94aaa84.

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
 drivers/spi/spi-cadence-quadspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 7c17b8c0425e..9285a683324f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1870,6 +1870,11 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	if (cqspi->rx_chan) {
+		dma_release_channel(cqspi->rx_chan);
+		goto probe_setup_failed;
+	}
+
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI ctlr %d\n", ret);
-- 
2.25.1


