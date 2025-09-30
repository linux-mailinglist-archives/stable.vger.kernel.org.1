Return-Path: <stable+bounces-182029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCA0BABA5B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF81480BDD
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFA291C11;
	Tue, 30 Sep 2025 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="pXV1Q2o8"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta224.mxroute.com (mail-108-mta224.mxroute.com [136.175.108.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE4296BC8
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213094; cv=none; b=J8166KGDLb2QycI4/ZgfvcmkzHo2Cxexi64DW52OaDrPDr/JR0hKme+B7US5l6dNyCiFEdTYYRtBCqo/aqo0NrJ6GuGagHPBe5qm3RgchztrTykRAJS6NbJukSLNsYbicGpffOm5ZC6hOt0L71tGOkXvmYz6aNGGmxW9C4L4nc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213094; c=relaxed/simple;
	bh=dpICyBHPRCxjWmSuVtCtTn1alIoifSzTBEBrRAcu3fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BN/6DkQlNfoK4i/T38V2DUtUxjRauLb95qNzaU/dkOFSrtQIzTu3o8YSEIM7Ch4xBvNmc+EXY9kC02vq2Yi0W281dgoKkKinZGMCa6RuUeWXFZQx8EnkbNewP+ezQTVrjI5nBriG2psvvGZOU1hGPOkLl35k/rvDOzCZPuqCHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=pXV1Q2o8; arc=none smtp.client-ip=136.175.108.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta224.mxroute.com (ZoneMTA) with ESMTPSA id 1999940c127000c244.00f
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 30 Sep 2025 06:13:01 +0000
X-Zone-Loop: d941e5b6d4cd3b3cae7cb4f34369810a85f91a5c4783
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DnyW1ICbNiJMwuErPJysjSsC9vAQzV1lxyrmXFHhQ8I=; b=pXV1Q2o88gqzMHoNTP5l9CrNU6
	vEMEywhZmTVBaccy86Adc3rmsDfQmURCy2z4NlCSonMp7JwtSf47SQbYeJej7r6xeyCOWm2zrW+hT
	+d7xo/DJPsvtnrG/BUfAtiCvcZy1ABnTpPLv1ANy17xAAA7GipH+TxcMq+updDxgQrnYN6ZmFiiCp
	GOJ9g8BSroInmdoScFl/6+X1Kv+vaoB8l9c3Q4Ic5LJeT10cVcHclK+PpzZuYkQbylPhSoikP3MvG
	2kjQOfZAMUxIjCoil4rVJfsk7UfPJTrGo15fp2y6na+JKIa1PU50V6/Q0lyNLiQ/YPXiGph21yD1l
	XvmouwqQ==;
From: Bo Sun <bo@mboxify.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: sbhatta@marvell.com,
	hkelam@marvell.com,
	horms@kernel.org,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	sumang@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] octeontx2-vf: fix bitmap leak
Date: Tue, 30 Sep 2025 14:12:35 +0800
Message-ID: <20250930061236.31359-2-bo@mboxify.com>
In-Reply-To: <20250930061236.31359-1-bo@mboxify.com>
References: <20250930061236.31359-1-bo@mboxify.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: bo@mboxify.com

The bitmap allocated with bitmap_zalloc() in otx2vf_probe() was not
released in otx2vf_remove(). Unbinding and rebinding the driver therefore
triggers a kmemleak warning:

    unreferenced object (size 8):
      backtrace:
        bitmap_zalloc
        otx2vf_probe

Call bitmap_free() in the remove path to fix the leak.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Cc: stable@vger.kernel.org

Signed-off-by: Bo Sun <bo@mboxify.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 7ebb6e656884..25381f079b97 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -854,6 +854,7 @@ static void otx2vf_remove(struct pci_dev *pdev)
 		qmem_free(vf->dev, vf->dync_lmt);
 	otx2vf_vfaf_mbox_destroy(vf);
 	pci_free_irq_vectors(vf->pdev);
+	bitmap_free(vf->af_xdp_zc_qidx);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
 }
-- 
2.50.1 (Apple Git-155)


