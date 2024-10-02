Return-Path: <stable+bounces-79769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939698DA1B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D581C22761
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA91D07B2;
	Wed,  2 Oct 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8lIyuC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA21D0955;
	Wed,  2 Oct 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878414; cv=none; b=QvCcBuuqIsnYDpVIfxHZOcrFNi6ZYEajRo/jbTNmpV7GZzEnqJLKK+1VlmWbuflF/QUZpuEsFCPzO7InzUa3grHAKkCBuohn/VutOJql4blcIfBe4/q4AF1MIUB1n9w5NEp5ETlzmglFwQSS0pN9t5Vp8/DQmanw1iWpslPqqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878414; c=relaxed/simple;
	bh=EUeLEtmGPlwaYtPM1v/fMihqUB/sSa90bG5RsxEfuhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGbRKhUh4pH4n0kYckGXnWShYJEwmqYZAXDThHgVSSufWAJ8EbTNecWsHO/qhKUpHUIKggHgrUIBK2jHQIDyFNN5O2fypa5FvoW+6fveuJwxlCjMF30dkj0j9HCuvPkS5tgIeLunsGqBzE4I5XEHqhJiQJUtHetQKtN7H7rjCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8lIyuC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBDBC4CEC2;
	Wed,  2 Oct 2024 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878414;
	bh=EUeLEtmGPlwaYtPM1v/fMihqUB/sSa90bG5RsxEfuhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8lIyuC070HoaMYCE/R6o8KmeEPWHgCMn9Sp8YH6nhFuvZ95IG3fG1KmViYey73go
	 NlvIrBcbA9dj+/PMmRD2VRpfXlMUl9pjwMLqhWdH2CyzVGM369W6SPqrBfWciCzZsz
	 o3Q9UQ8GINHJ4JBIAJsh4lscOsyznSI6MLDa8HTk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wenglianfa <wenglianfa@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 374/634] RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
Date: Wed,  2 Oct 2024 14:57:54 +0200
Message-ID: <20241002125825.861185627@linuxfoundation.org>
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

From: wenglianfa <wenglianfa@huawei.com>

[ Upstream commit fd8489294dd2beefb70f12ec4f6132aeec61a4d0 ]

Currently rsv_qp is freed before ib_unregister_device() is called
on HIP08. During the time interval, users can still dereg MR and
rsv_qp will be used in this process, leading to a UAF. Move the
release of rsv_qp after calling ib_unregister_device() to fix it.

Fixes: 70f92521584f ("RDMA/hns: Use the reserved loopback QPs to free MR before destroying MPT")
Signed-off-by: wenglianfa <wenglianfa@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20240906093444.3571619-3-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index a166b476977f1..2225c9cc63661 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2972,6 +2972,9 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
 
 static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		free_mr_exit(hr_dev);
+
 	hns_roce_function_clear(hr_dev);
 
 	if (!hr_dev->is_vf)
@@ -6951,9 +6954,6 @@ static void __hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_UNINIT;
 	hns_roce_handle_device_err(hr_dev);
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
-		free_mr_exit(hr_dev);
-
 	hns_roce_exit(hr_dev);
 	kfree(hr_dev->priv);
 	ib_dealloc_device(&hr_dev->ib_dev);
-- 
2.43.0




