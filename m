Return-Path: <stable+bounces-6003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1AE80D843
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB076B21401
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450EB51036;
	Mon, 11 Dec 2023 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fk1rB6Hd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423AFC06;
	Mon, 11 Dec 2023 18:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751DEC433C9;
	Mon, 11 Dec 2023 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320250;
	bh=TH4Ke3XStTzmVcG14UUFYZBTkELF1VOtZj68YeuV3kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fk1rB6HdS00lI84Xgkc31D+5WKtNV4q7ZiTxUKXyvmEor/gkM7Hjn42uo/xvrpyds
	 TAXkAd/yor7gF4ZEiC9wWV08yELvkoic0fO5t/G4nLUTkWUrsx56ZPAiVpn6VZXugi
	 orj4c0D0yHc0s0llgAgAKammjTtjA+FDu12PfG2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 31/67] scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()
Date: Mon, 11 Dec 2023 19:22:15 +0100
Message-ID: <20231211182016.401584767@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 235f2b548d7f4ac5931d834f05d3f7f5166a2e72 ]

When an error occurs in the for loop of beiscsi_init_wrb_handle(), we
should free phwi_ctxt->be_wrbq before returning an error code to prevent
potential memleak.

Fixes: a7909b396ba7 ("[SCSI] be2iscsi: Fix dynamic CID allocation Mechanism in driver")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/r/20231123081941.24854-1-dinghao.liu@zju.edu.cn
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/be2iscsi/be_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 53b33f146f825..d34c881c3f8ae 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2694,6 +2694,7 @@ static int beiscsi_init_wrb_handle(struct beiscsi_hba *phba)
 		kfree(pwrb_context->pwrb_handle_base);
 		kfree(pwrb_context->pwrb_handle_basestd);
 	}
+	kfree(phwi_ctxt->be_wrbq);
 	return -ENOMEM;
 }
 
-- 
2.42.0




