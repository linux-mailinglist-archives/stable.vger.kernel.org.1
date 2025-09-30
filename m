Return-Path: <stable+bounces-182030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B37BABA62
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D2BA4E22BD
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E81C84DF;
	Tue, 30 Sep 2025 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="RiEAj8n1"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta189.mxroute.com (mail-108-mta189.mxroute.com [136.175.108.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2100D28DEE9
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213104; cv=none; b=r7IilJxRfOEEEgux/yX+kxJqR0dlVrzAIIFEo8sUnAKtLAQ6MOoMpovVy53gmU5rgMTNrAXjnL7abms/hFYt0oegHSGBRIhEMH5cQDsEyyB36WiOY1CBc9aYdsI4VriADLeobI+eLB/dDSsIYA/K2gVSQFp6CY0K2Yj5iQJtyvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213104; c=relaxed/simple;
	bh=iTIyUmMwogLjx6J4uwkS7qq4zRHdgk+CzEH6UASouPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlN4tYbNKzEzMjSWc2pKoj70iPyu3TO7ri8j3pwvudRHmdl0vdOWsQWPD3uT7mMGz2NLnpA3cW21iNTpA98Ya4X9inkJNLOlnwNi/EQO0GBKjF+Pc6NOiFz6iyX5eXz0JEqSNtE97QGXnJzhZr+OV5xcBhQ0we5igjFdKlDRZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=RiEAj8n1; arc=none smtp.client-ip=136.175.108.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta189.mxroute.com (ZoneMTA) with ESMTPSA id 1999940e3ea000c244.00f
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 30 Sep 2025 06:13:10 +0000
X-Zone-Loop: 59c83dad8a541ab445842f1253f43adf1423d62844c9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XE4oTWPSDq1xZF1cjbUhrR4nwFe0BvbSHj5iVns/uvg=; b=RiEAj8n1yc5j7h6W3MR5smM7Ug
	jix76IubG7NWB+ocwsyH5SL3KoRAA0wlK0JVAYJ0zBVzRWchhbynVaYFhGErvQN53ybtAlqRtfnGV
	84xT5OWYAyHSVw7qDSJbYkVkpbw6YkrCjXFkMMnS4h6r7YgG/WBc6Hca+0eViNnxTJW2gTlzGiXsC
	6LMYIxJSPGsfMmyfElWesBqfttfob4Q8069RGe3ojNicbjZjScvEyPmKwbvAp9zClxSRr3pmGYwlS
	g8yNJn8IrUcAVthekmSJSs7JPnIJbB4mZ/PmWDJQT+G4T7hSsKP+HIY4Nussi45nnMqpnq/Ylt4dd
	qN933lSg==;
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
Subject: [PATCH net v2 2/2] octeontx2-pf: fix bitmap leak
Date: Tue, 30 Sep 2025 14:12:36 +0800
Message-ID: <20250930061236.31359-3-bo@mboxify.com>
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

The bitmap allocated with bitmap_zalloc() in otx2_probe() was not
released in otx2_remove(). Unbinding and rebinding the driver therefore
triggers a kmemleak warning:

    unreferenced object (size 8):
      backtrace:
        bitmap_zalloc
        otx2_probe

Call bitmap_free() in the remove path to fix the leak.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Cc: stable@vger.kernel.org

Signed-off-by: Bo Sun <bo@mboxify.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 5027fae0aa77..e808995703cf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3542,6 +3542,7 @@ static void otx2_remove(struct pci_dev *pdev)
 	otx2_disable_mbox_intr(pf);
 	otx2_pfaf_mbox_destroy(pf);
 	pci_free_irq_vectors(pf->pdev);
+	bitmap_free(pf->af_xdp_zc_qidx);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(netdev);
 }
-- 
2.50.1 (Apple Git-155)


