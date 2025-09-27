Return-Path: <stable+bounces-181806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027CFBA5A2E
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 09:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33A9620F54
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 07:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA932BFC73;
	Sat, 27 Sep 2025 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b="ZAP6voQV"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta57.mxroute.com (mail-108-mta57.mxroute.com [136.175.108.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122461DED52
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758957682; cv=none; b=tGnHfC6XgBVj39gi20sVukqiPlsZ5RIwErUXeK8cRmnpAmyvtbENxwtrDemoUyUqIcBVXVnbSRhwUgPniH+rPim+ByT9QexnVrgTSItKVEdGyYP85ftK9B77ZDuzAvsmKLgi8obg4Op4hG71RgP1RBd8LyO03HmGR4tF3UjfK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758957682; c=relaxed/simple;
	bh=09A9hbR16OyBQLolGd1O5YJPEFbjbEDcN+A9olYvQ1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhwDiTsWtp/XBjVf+9coApx9JxZApvN+jXoxatEsLT9Nrl1kalOOSX1rtFil+IegOyzfW2ZJ/Hq9hvhPx3zabFrdPD4ooPbrO5Nw/EqC3ybY5Mr+f9Lg6FFglXeo4BF8oCT31RCipZUe65MnKWWqqo5UW+81c/kPhn5Kz0Q+upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com; spf=pass smtp.mailfrom=mboxify.com; dkim=pass (2048-bit key) header.d=mboxify.com header.i=@mboxify.com header.b=ZAP6voQV; arc=none smtp.client-ip=136.175.108.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mboxify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mboxify.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta57.mxroute.com (ZoneMTA) with ESMTPSA id 1998a07584f000c244.007
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 27 Sep 2025 07:16:01 +0000
X-Zone-Loop: c392e4a12fa0a7956abe6c3c440274ba485282649f3b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mboxify.com
	; s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RdtLXx1P8B/01/srC1DNykDSLnh15MCseAF+aY7h/LI=; b=ZAP6voQVo8lpLS80rWY6J1KYkl
	h01SfdJrPNxVRHLP/uVNDvQE4F9Xoj0TIjpgQX4C+tRuSxFipoHYNM8yLArBfln6eEYMid7b72cZD
	2n3lIwrqwuqkh4rHLAV4O9ePj5CWIVffLXMQOjPErb65qNypZKie+a1en8zgFHX0PgDcIb88Ipj3X
	uGSJC19ORFhg3tAMoq2HpN4Zg/F5jLZbwCMiNbd58qagDFe8kghXhJT265LVNefF2+FOmnInQmtml
	qJPMdW8E6gxStIs+iyZKghAL+zumv1SJyR0Q0dkdlRAy7pmDXhhW5fzIzxNsOUFN7Fcyip1xs1ok/
	pGJnXAMg==;
From: Bo Sun <bo@mboxify.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bo Sun <bo@mboxify.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] octeontx2-pf: fix bitmap leak
Date: Sat, 27 Sep 2025 15:15:05 +0800
Message-Id: <20250927071505.915905-3-bo@mboxify.com>
In-Reply-To: <20250927071505.915905-1-bo@mboxify.com>
References: <20250927071505.915905-1-bo@mboxify.com>
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

