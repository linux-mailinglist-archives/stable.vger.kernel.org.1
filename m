Return-Path: <stable+bounces-584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E77F7BB2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63700B2114B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75439FEA;
	Fri, 24 Nov 2023 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KeplUDi3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE339FE1;
	Fri, 24 Nov 2023 18:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3F8C433C8;
	Fri, 24 Nov 2023 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849264;
	bh=DZfFuVuBh58XD7aRaoqSG2fekZJ4WdnxghNz4Gby3Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeplUDi3BhFIPcD7Zc4ROdxAt2Uz4I7FDSR7bQinpUHKJPIb5zVcwzcrZSrHMXmt2
	 ecb1a2UhzOqmCq1jqVI+D/46VimdinfxBgRIzpknA8rxlTJMEH9CVNNQofkzkRyUIv
	 J5ahEk9AKrE+zKivT5ID7o5UgOyBMl3gqvyqS2qU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenchao Hao <haowenchao2@huawei.com>,
	Simon Horman <horms@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 105/530] scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()
Date: Fri, 24 Nov 2023 17:44:31 +0000
Message-ID: <20231124172031.327024270@linuxfoundation.org>
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

From: Wenchao Hao <haowenchao2@huawei.com>

[ Upstream commit 4df105f0ce9f6f30cda4e99f577150d23f0c9c5f ]

fc_lport_ptp_setup() did not check the return value of fc_rport_create()
which can return NULL and would cause a NULL pointer dereference. Address
this issue by checking return value of fc_rport_create() and log error
message on fc_rport_create() failed.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Link: https://lore.kernel.org/r/20231011130350.819571-1-haowenchao2@huawei.com
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_lport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index 9c02c9523c4d4..ab06e9aeb613e 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -241,6 +241,12 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
 	}
 	mutex_lock(&lport->disc.disc_mutex);
 	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
+	if (!lport->ptp_rdata) {
+		printk(KERN_WARNING "libfc: Failed to setup lport 0x%x\n",
+			lport->port_id);
+		mutex_unlock(&lport->disc.disc_mutex);
+		return;
+	}
 	kref_get(&lport->ptp_rdata->kref);
 	lport->ptp_rdata->ids.port_name = remote_wwpn;
 	lport->ptp_rdata->ids.node_name = remote_wwnn;
-- 
2.42.0




