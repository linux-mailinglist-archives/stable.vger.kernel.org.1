Return-Path: <stable+bounces-7543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348FE817304
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC950B23B8B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A53A1B2;
	Mon, 18 Dec 2023 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LT41J4gH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6781D15C;
	Mon, 18 Dec 2023 14:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03695C433C8;
	Mon, 18 Dec 2023 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908752;
	bh=vB3MzPHV4C0lEC6ETjOdn7TM/2SoEZHRfO/TLtcUVMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LT41J4gHwfgcF2NBYLDSNg0bj08DWY/A9JQU50yMOL6iPaRK8XW8Pq7dvogGNE6dI
	 O0N/HtQPjLY4afE8Lkq+HiMDLWIqK40w5C5tp18tEP6caoLr7EekIR7Ijw7AXBm3y9
	 FkjmgSWcOG/8ucJg+UH/8ka2XcxMzdPXY2hJSPlM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhipeng Lu <alexious@zju.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 20/83] octeontx2-af: fix a use-after-free in rvu_nix_register_reporters
Date: Mon, 18 Dec 2023 14:51:41 +0100
Message-ID: <20231218135050.635095356@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit 28a7cb045ab700de5554193a1642917602787784 ]

The rvu_dl will be freed in rvu_nix_health_reporters_destroy(rvu_dl)
after the create_workqueue fails, and after that free, the rvu_dl will
be translate back through the following call chain:

rvu_nix_health_reporters_destroy
  |-> rvu_nix_health_reporters_create
       |-> rvu_health_reporters_create
             |-> rvu_register_dl (label err_dl_health)

Finally. in the err_dl_health label, rvu_dl being freed again in
rvu_health_reporters_destroy(rvu) by rvu_nix_health_reporters_destroy.
In the second calls of rvu_nix_health_reporters_destroy, however,
it uses rvu_dl->rvu_nix_health_reporter, which is already freed at
the end of rvu_nix_health_reporters_destroy in the first call.

So this patch prevents the first destroy by instantly returning -ENONMEN
when create_workqueue fails. In addition, since the failure of
create_workqueue is the only entrence of label err, it has been
integrated into the error-handling path of create_workqueue.

Fixes: 5ed66306eab6 ("octeontx2-af: Add devlink health reporters for NIX")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index ba7ff776760d3..40fbda152533b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -641,7 +641,7 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_dl->devlink_wq = create_workqueue("rvu_devlink_wq");
 	if (!rvu_dl->devlink_wq)
-		goto err;
+		return -ENOMEM;
 
 	INIT_WORK(&rvu_reporters->intr_work, rvu_nix_intr_work);
 	INIT_WORK(&rvu_reporters->gen_work, rvu_nix_gen_work);
@@ -649,9 +649,6 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	INIT_WORK(&rvu_reporters->ras_work, rvu_nix_ras_work);
 
 	return 0;
-err:
-	rvu_nix_health_reporters_destroy(rvu_dl);
-	return -ENOMEM;
 }
 
 static int rvu_nix_health_reporters_create(struct rvu_devlink *rvu_dl)
-- 
2.43.0




