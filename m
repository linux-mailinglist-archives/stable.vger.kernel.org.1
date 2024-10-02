Return-Path: <stable+bounces-79741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DACB98D9FC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EABCB23167
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EAA1D0DE6;
	Wed,  2 Oct 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ms30U3OI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810871D042F;
	Wed,  2 Oct 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878337; cv=none; b=KxvBM63r1egzEHbKCXkeL6tjBiKj6rRtkcVI6FiFyHaJHRoNbtwiPREInp5dVjpEwS8AAuHGETg4CMtsoafO14goTiMAmc1UlM0wth+h9EaVkrJCLu878c2ekhHMJeu4artxp4f5v7777oLcPgYObhdi99F3uuWRF4WGezZ5qTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878337; c=relaxed/simple;
	bh=0xe8bwdUpvalwVBUAEGB9mCZ7wtRWcOhWIN2GIZhI8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4OOxgySucqtWYIPCkqStLu9j7cVYP4USyjMPcU1BETFb7hDiQV12Tt1qkKMFjQnD+qlJauEPpX3o1VlCIudu9wRslmRgrIsMkkeO4QV4gm9X+pIeCe/h9C8WoYLRjOn9WYXRKrHhogoyI/qsUknu0XAgrRbRG87N30rnd3Sk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ms30U3OI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACF4C4CEC5;
	Wed,  2 Oct 2024 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878337;
	bh=0xe8bwdUpvalwVBUAEGB9mCZ7wtRWcOhWIN2GIZhI8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ms30U3OIwdyuVEkeR2MpqtgQ4ye1Si7mmuYf7WXAmodhW3m+aSwfS3ZBRCLemQzc5
	 FIo++YS24R0s8YTZRiXbz0yyNNg7ZG2JgG85HuiUTUooAS8ywLZ+19tccMXBYWpABu
	 K6OJP3o5ve9OvdNaGpzdnAAoawSfdTL41BhE7n0k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 380/634] RDMA/hns: Fix restricted __le16 degrades to integer issue
Date: Wed,  2 Oct 2024 14:58:00 +0200
Message-ID: <20241002125826.099037183@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxian Huang <huangjunxian6@hisilicon.com>

[ Upstream commit f4ccc0a2a0c5977540f519588636b5bc81aae2db ]

Fix sparse warnings: restricted __le16 degrades to integer.

Fixes: 5a87279591a1 ("RDMA/hns: Support hns HW stats")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409080508.g4mNSLwy-lkp@intel.com/
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20240909065331.3950268-1-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 349b68d7e7db6..24e906b9d3ae1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1681,8 +1681,8 @@ static int hns_roce_hw_v2_query_counter(struct hns_roce_dev *hr_dev,
 
 	for (i = 0; i < HNS_ROCE_HW_CNT_TOTAL && i < *num_counters; i++) {
 		bd_idx = i / CNT_PER_DESC;
-		if (!(desc[bd_idx].flag & HNS_ROCE_CMD_FLAG_NEXT) &&
-		    bd_idx != HNS_ROCE_HW_CNT_TOTAL / CNT_PER_DESC)
+		if (bd_idx != HNS_ROCE_HW_CNT_TOTAL / CNT_PER_DESC &&
+		    !(desc[bd_idx].flag & cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT)))
 			break;
 
 		cnt_data = (__le64 *)&desc[bd_idx].data[0];
-- 
2.43.0




