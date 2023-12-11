Return-Path: <stable+bounces-6257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C5380D9A3
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C7C1C21510
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32C951C47;
	Mon, 11 Dec 2023 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Klinf3Kp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFE321B8;
	Mon, 11 Dec 2023 18:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C16C433C7;
	Mon, 11 Dec 2023 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320937;
	bh=QG1t8f95iIAvTDvwDDPXkdBJHIWvfitY2tdoSTEU7FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Klinf3Kp1SJr8aVruCYEYsWn0apeXTzuEgSOgsi/pW8USvgXaj6/Qk1xFWJgZ6Nj7
	 H6ajIcBg69cqBXvwcoGrjo/5F52aEpUnO2LdHQgP5wrPYW7mxWFhQ260+9AGN3XxaG
	 lVy75Q2X8NrLWBrFZacUZ00kidxO+rcVZdTkckbY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 033/141] net: bnxt: fix a potential use-after-free in bnxt_init_tc
Date: Mon, 11 Dec 2023 19:21:32 +0100
Message-ID: <20231211182027.988965946@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit d007caaaf052f82ca2340d4c7b32d04a3f5dbf3f ]

When flow_indr_dev_register() fails, bnxt_init_tc will free
bp->tc_info through kfree(). However, the caller function
bnxt_init_one() will ignore this failure and call
bnxt_shutdown_tc() on failure of bnxt_dl_register(), where
a use-after-free happens. Fix this issue by setting
bp->tc_info to NULL after kfree().

Fixes: 627c89d00fb9 ("bnxt_en: flow_offload: offload tunnel decap rules via indirect callbacks")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Link: https://lore.kernel.org/r/20231204024004.8245-1-dinghao.liu@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 1471b6130a2b9..b3473883eae6b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -2075,6 +2075,7 @@ int bnxt_init_tc(struct bnxt *bp)
 	rhashtable_destroy(&tc_info->flow_table);
 free_tc_info:
 	kfree(tc_info);
+	bp->tc_info = NULL;
 	return rc;
 }
 
-- 
2.42.0




