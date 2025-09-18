Return-Path: <stable+bounces-180519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A00DB84AE3
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912237BD278
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B899330505D;
	Thu, 18 Sep 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FauBYyuV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB422FD7A7
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199901; cv=none; b=uALjqrolNEyXbGb1OFOuEtY6tLcw2AXO/MtZYlIJOQBmlXeDwmRhXomQINq2pEudxJOOkQvjvtvsKJyzJDMM6g3JsTO02ikcxiYARNhaacH6vegLU7lvi8xy00fE1WkH2S5IwvrOzrb2Cu9IpG6ZGbjQFjpVqNp3d9fRmr8Llck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199901; c=relaxed/simple;
	bh=kQvQlJ4Ntkejel7Bjw96+PBXVk0IMsnf/Ap3QHrmNCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DvrO2JRz14oHYhMCmUgvkNbmEyuymMpmnCDoxTXPFhLECeXZf1oF6gwqfvYw1MG8ucGXEKLtk0bRgaapns8l+AG9XZFXKoYZC/h6B5ev/60+ywaoJaq/+JIkQwfjILavm8BrZqvVee1R88bviQS9PrfifaTQeXyMrbS9usNUz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FauBYyuV; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso893347b3a.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 05:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199899; x=1758804699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgi+BTeRK9OMV3Te7iHLbRBW1UdG0wv6serJphMr1ec=;
        b=jATbPenxyxHWTED7ZTifyvK6f163M8PXEYV0ZqHyqBqdU4nas5TQf9I+7PPHnD4xvD
         ohBxsZhVH5X1Tt7TwRR3Sv9t9l9Jdy1GanU1hBkBXQ0vkV5lM2Ruij7B0IugDJK+5DTK
         WIL+s6NBZgvxlbMM/NUM9sUsRc4EdZhXMfKFoZ1Q9hQttuuYDM24S09rgbmCwKRmc9Tn
         SrisNyXKg/xZ2bIP/x4sIQlxSTW749xv2pJPu/JiLUdLWcVRs9Rlx/fse5cVtVq5YyWM
         NZMEbqVa2JvCqPFHA8OglYh8MIu2p/ILFKTdG+4AMWIbnNHENUKlNm5OkgQl4xBqHyFb
         nWVg==
X-Gm-Message-State: AOJu0YxqQKpIU1zMvCR4smWXwntWhlsqQdbvRWBfYA+fQCni8huUi+da
	ZxpK3N3IymiJJLNJqhcigG2MLHX2ucE9FS1D8+Qw2vGdmUsmefmkdL1GiAMBVq7jzMPkEAMdo64
	GhdtQVWCw3UpU+SkiAyxAOsxpuUw1v4vR2OsC7DVtFo6QDjqqGAeXm6hu1JJDMf16cyCtIkMRwq
	VW3KGBhpkOC2aYMuNzWdK/JPpo3FULRNOiWwi4uuHKoox8g5MXO7tmG4MHwoDLmMIlVLIvVVg4t
	HMDFDPdEEA=
X-Gm-Gg: ASbGncti7Kn0WcqYFp2oZTzQaWqi3DP72sbJbCoWsjXtKDUVj9qxuU+2CcE2dy/N8un
	F04kflMh+RtzfRuXIKzO5D1SndEvCq3OW4vBRJc+ez8lcwtUBn5fOwqBzwn1mLBLRvK3bqhMnz3
	AbHOGshzyrKrn1eGwgx0uhgsYw8KEegHuiP3ms9QSmT8Qw52MwOPK7f5zInTDGFQP1yfKmg7Jx0
	G5DvX/Ua7dennp+HEdZsqFvf9hMBgh+pVQ4xA7KBxi7T5XjwyA1UfEuz/4Qr9bBn4FRpVIbaxbG
	wGURvbmEd44DM/5FFTub/m3yBbGr9i6IAUgn5QSKXOG9co28exy6RZCktV0AdUGdrjhXCw6Fw5C
	S4SPpIXoQCmPYCc8+GTcFWTjnHCTIiRBdPKVkLLQ7sc7g16znrKbkPuNRmRTD+2G17Ki/aszmPQ
	Q=
X-Google-Smtp-Source: AGHT+IFyz12eBrWfJRE7zi7f0qQIeOv3Nosr89M9+zbkLxtjIHxUzWkdnL/0Su9655gN9fU+2EjRRnRXok+9
X-Received: by 2002:a17:902:d511:b0:24b:11c8:2d05 with SMTP id d9443c01a7336-26813aedcbbmr79142215ad.45.1758199899226;
        Thu, 18 Sep 2025 05:51:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2698029ef16sm1846265ad.57.2025.09.18.05.51.38
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:51:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-828bd08624aso172508485a.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758199898; x=1758804698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgi+BTeRK9OMV3Te7iHLbRBW1UdG0wv6serJphMr1ec=;
        b=FauBYyuV9RU3PYdBbhT/xbRKdmsvPRJY5jeIF2P1+iA28OnnPvQOPbf5azb6HNYg1o
         RP9t3pwCs3pdwDb2SMQd961YZdOTfkLdKHfjnQW9u7IP63dgEj7F2GhfwfI9DoS+CZzS
         uNO1Q5WMPI2CmP+xTUgeh+DVYPVKYw+A1Ri/U=
X-Received: by 2002:a05:620a:2685:b0:82e:6ec8:9899 with SMTP id af79cd13be357-8310ef30b26mr617477485a.48.1758199897615;
        Thu, 18 Sep 2025 05:51:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2685:b0:82e:6ec8:9899 with SMTP id af79cd13be357-8310ef30b26mr617472985a.48.1758199896971;
        Thu, 18 Sep 2025 05:51:36 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836278b77fasm159592685a.23.2025.09.18.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:51:36 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pv-drivers@vmware.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	sankararaman.jayaraman@broadcom.com,
	ronak.doshi@broadcom.com,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6.6-v6.12] vmxnet3: unregister xdp rxq info in the reset path
Date: Thu, 18 Sep 2025 12:37:32 +0000
Message-Id: <20250918123732.502171-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>

[ Upstream commit 0dd765fae295832934bf28e45dd5a355e0891ed4 ]

vmxnet3 does not unregister xdp rxq info in the
vmxnet3_reset_work() code path as vmxnet3_rq_destroy()
is not invoked in this code path. So, we get below message with a
backtrace.

Missing unregister, handled but fix driver
WARNING: CPU:48 PID: 500 at net/core/xdp.c:182
__xdp_rxq_info_reg+0x93/0xf0

This patch fixes the problem by moving the unregister
code of XDP from vmxnet3_rq_destroy() to vmxnet3_rq_cleanup().

Fixes: 54f00cce1178 ("vmxnet3: Add XDP support.")
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Link: https://patch.msgid.link/20250320045522.57892-1-sankararaman.jayaraman@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Ajay: Modified to apply on v6.6, v6.12]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 6793fa09f9d1a..3df6aabc7e339 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2033,6 +2033,11 @@ vmxnet3_rq_cleanup(struct vmxnet3_rx_queue *rq,
 
 	rq->comp_ring.gen = VMXNET3_INIT_GEN;
 	rq->comp_ring.next2proc = 0;
+
+	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
+		xdp_rxq_info_unreg(&rq->xdp_rxq);
+	page_pool_destroy(rq->page_pool);
+	rq->page_pool = NULL;
 }
 
 
@@ -2073,11 +2078,6 @@ static void vmxnet3_rq_destroy(struct vmxnet3_rx_queue *rq,
 		}
 	}
 
-	if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
-		xdp_rxq_info_unreg(&rq->xdp_rxq);
-	page_pool_destroy(rq->page_pool);
-	rq->page_pool = NULL;
-
 	if (rq->data_ring.base) {
 		dma_free_coherent(&adapter->pdev->dev,
 				  rq->rx_ring[0].size * rq->data_ring.desc_size,
-- 
2.39.5

