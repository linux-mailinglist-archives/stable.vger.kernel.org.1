Return-Path: <stable+bounces-665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B27F7C0A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A39A281D8F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B13A8C4;
	Fri, 24 Nov 2023 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c8i8SjEn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF30381D6;
	Fri, 24 Nov 2023 18:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B928CC433C8;
	Fri, 24 Nov 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849469;
	bh=CsqpOAMv3ixnr7u9/GBBSMP+cOy2fddimSsviLBM2zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8i8SjEnVM4rBXewwah4gWtqRiQ3wNf8fCfO+qXHIU/9b4MSUiriXPnjR53I1SVen
	 vAA/geRXgaMPs4ACzrD9g3tLp43YZsdvBkRspLRwXd8Allt2VuYAVqPb/LxVjwxuvs
	 3uTDbntFJ9cMFFtxo3gxIU6hVRErGuOcdccTWruk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 186/530] net: ti: icssg-prueth: Fix error cleanup on failing pruss_request_mem_region
Date: Fri, 24 Nov 2023 17:45:52 +0000
Message-ID: <20231124172033.732863623@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kiszka <jan.kiszka@siemens.com>

[ Upstream commit 2bd5b559a1f391f05927bbb0b31381fa71c61e26 ]

We were just continuing in this case, surely not desired.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 71d3001ec1ef8..c09ecb3da7723 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -2050,7 +2050,7 @@ static int prueth_probe(struct platform_device *pdev)
 				       &prueth->shram);
 	if (ret) {
 		dev_err(dev, "unable to get PRUSS SHRD RAM2: %d\n", ret);
-		pruss_put(prueth->pruss);
+		goto put_pruss;
 	}
 
 	prueth->sram_pool = of_gen_pool_get(np, "sram", 0);
@@ -2195,6 +2195,8 @@ static int prueth_probe(struct platform_device *pdev)
 
 put_mem:
 	pruss_release_mem_region(prueth->pruss, &prueth->shram);
+
+put_pruss:
 	pruss_put(prueth->pruss);
 
 put_cores:
-- 
2.42.0




