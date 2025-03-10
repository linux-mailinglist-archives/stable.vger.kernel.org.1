Return-Path: <stable+bounces-122431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50960A59F8D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0224188F80D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4D923236D;
	Mon, 10 Mar 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vVroIhrg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24809230BC5;
	Mon, 10 Mar 2025 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628471; cv=none; b=FKcKdTx4sFQhIUL0bQT8/SsQhcrdZlDYR1VwOmLFSyGeGAAPVAG9G3B54JDTbpPtbM4YW/EqCGhcP7DOWvmNOfd/uA4HjDMdWlZPJC0L5zu6F0t+kCYPdZPiHmESRSkyvTwltycwJsCvmWnmcB9XhKXSWGsLUdcRuoA85f2JvRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628471; c=relaxed/simple;
	bh=8hgQ5wC09AJSmtSamIDokwYQrGu5i22Nu9R7Zu/lcNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1qyfWxI7B6KuctsWZ2aUBO5HiwXiyLvzqY9BrXCQcpol3gcDEHJJGQoiCZBKxpuDKcVoplLlVueKdrzZfCAuS3KJ0ZDsQihd/IW219Y29CavBAqsMbY1csFsyyfKmcK3/Ds+2gJIYEmsiwwjp/jJz2ztOzGhCTPJ7nXdJcj3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vVroIhrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B03C4CEE5;
	Mon, 10 Mar 2025 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628471;
	bh=8hgQ5wC09AJSmtSamIDokwYQrGu5i22Nu9R7Zu/lcNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vVroIhrgAzhNfCphyrTpg2+3mav2isf7UDgvFzOh3spfNTHQ4fkfkcxxlWrgjIhhe
	 HwkkGr2e0gIKp6rAE5/GbZRspP6L8RX1gJR0mYPkcEwSWFR+EpPA8uLmg/Pufl/jzI
	 emrtPHMUjlc5DoHsnPP0ZLT3AC6o1L0gQb5bRJI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peiyang Wang <wangpeiyang1@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 052/109] net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_get_cycle returns an error
Date: Mon, 10 Mar 2025 18:06:36 +0100
Message-ID: <20250310170429.636951378@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
References: <20250310170427.529761261@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Peiyang Wang <wangpeiyang1@huawei.com>

[ Upstream commit b7365eab39831487a84e63a9638209b68dc54008 ]

During the initialization of ptp, hclge_ptp_get_cycle might return an error
and returned directly without unregister clock and free it. To avoid that,
call hclge_ptp_destroy_clock to unregist and free clock if
hclge_ptp_get_cycle failed.

Fixes: 8373cd38a888 ("net: hns3: change the method of obtaining default ptp cycle")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250228105258.1243461-1-shaojijie@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 0f06f95b09bc2..4d4cea1f50157 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -496,7 +496,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 		ret = hclge_ptp_get_cycle(hdev);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = hclge_ptp_int_en(hdev, true);
-- 
2.39.5




