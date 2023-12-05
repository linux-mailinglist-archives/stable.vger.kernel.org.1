Return-Path: <stable+bounces-4327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B29804707
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50DE281599
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B88BF2;
	Tue,  5 Dec 2023 03:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ml4XTwYb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C4D6FB1;
	Tue,  5 Dec 2023 03:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723F1C433C8;
	Tue,  5 Dec 2023 03:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747245;
	bh=S8WfseovMWxhjYv3x5QSbf9LwpA3NEWC/RdiIRMcde4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ml4XTwYbXwT0rrMbyUKlYyUCQRiVfteq7ZoikKhD77S6ZnspwdEjqBErLzT4qCtk/
	 KhJNwYcnt71kGwn8Swq1wIZ0Rj5S47TlU68LQvnOf42FsAW9Q6C/rwpO6db8zXdvcL
	 T4BJQpFLfPrF9tmM8sOCdVuw00D+YSKp2lgQb/Mo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 095/107] drm/amd/pm: fix a memleak in aldebaran_tables_init
Date: Tue,  5 Dec 2023 12:17:10 +0900
Message-ID: <20231205031537.669045426@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
References: <20231205031531.426872356@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 7a88f23e768491bae653b444a96091d2aaeb0818 ]

When kzalloc() for smu_table->ecc_table fails, we should free
the previously allocated resources to prevent memleak.

Fixes: edd794208555 ("drm/amd/pm: add message smu to get ecc_table v2")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index d30ec3005ea19..cd8b0ab0112ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -258,8 +258,11 @@ static int aldebaran_tables_init(struct smu_context *smu)
 	}
 
 	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERNEL);
-	if (!smu_table->ecc_table)
+	if (!smu_table->ecc_table) {
+		kfree(smu_table->metrics_table);
+		kfree(smu_table->gpu_metrics_table);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.42.0




