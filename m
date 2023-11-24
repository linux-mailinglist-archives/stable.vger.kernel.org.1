Return-Path: <stable+bounces-1185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90B7F7E6C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF28B2124B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A33A8C6;
	Fri, 24 Nov 2023 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w8zGU6z5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CE39FE7;
	Fri, 24 Nov 2023 18:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06A1C433C8;
	Fri, 24 Nov 2023 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850771;
	bh=M1s9jJawF9cO3C5ctHgLFwRWnjJ6x5oLq9h/zO5AexI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w8zGU6z5YJm0sgeAUCzsSeQARpwObscg44JmbT6n5aIzYq1YBGb50K8IlWyNRfB74
	 T6tkyDCX0Pf8HZOpJzWKoxyWVLA9ID8MeoXivA8OGKf18px1rsSFAa0WKeG4yi1GYm
	 OW2Uo5TBiFkc6TzBgvGJezLNlxv+EAZFKHhmO6HI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 182/491] net: hns3: fix VF reset fail issue
Date: Fri, 24 Nov 2023 17:46:58 +0000
Message-ID: <20231124172029.943115692@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jijie Shao <shaojijie@huawei.com>

[ Upstream commit 65e98bb56fa3ce2edb400930c05238c9b380500e ]

Currently the reset process in hns3 and firmware watchdog init process is
asynchronous. We think firmware watchdog initialization is completed
before VF clear the interrupt source. However, firmware initialization
may not complete early. So VF will receive multiple reset interrupts
and fail to reset.

So we add delay before VF interrupt source and 5 ms delay
is enough to avoid second reset interrupt.

Fixes: 427900d27d86 ("net: hns3: fix the timing issue of VF clearing interrupt sources")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 14 +++++++++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 1c62e58ff6d89..0aa9beefd1c7e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1981,8 +1981,18 @@ static enum hclgevf_evt_cause hclgevf_check_evt_cause(struct hclgevf_dev *hdev,
 	return HCLGEVF_VECTOR0_EVENT_OTHER;
 }
 
+static void hclgevf_reset_timer(struct timer_list *t)
+{
+	struct hclgevf_dev *hdev = from_timer(hdev, t, reset_timer);
+
+	hclgevf_clear_event_cause(hdev, HCLGEVF_VECTOR0_EVENT_RST);
+	hclgevf_reset_task_schedule(hdev);
+}
+
 static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 {
+#define HCLGEVF_RESET_DELAY	5
+
 	enum hclgevf_evt_cause event_cause;
 	struct hclgevf_dev *hdev = data;
 	u32 clearval;
@@ -1994,7 +2004,8 @@ static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 
 	switch (event_cause) {
 	case HCLGEVF_VECTOR0_EVENT_RST:
-		hclgevf_reset_task_schedule(hdev);
+		mod_timer(&hdev->reset_timer,
+			  jiffies + msecs_to_jiffies(HCLGEVF_RESET_DELAY));
 		break;
 	case HCLGEVF_VECTOR0_EVENT_MBX:
 		hclgevf_mbx_handler(hdev);
@@ -2937,6 +2948,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		 HCLGEVF_DRIVER_NAME);
 
 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
+	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 81c16b8c8da29..a73f2bf3a56a6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -219,6 +219,7 @@ struct hclgevf_dev {
 	enum hnae3_reset_type reset_level;
 	unsigned long reset_pending;
 	enum hnae3_reset_type reset_type;
+	struct timer_list reset_timer;
 
 #define HCLGEVF_RESET_REQUESTED		0
 #define HCLGEVF_RESET_PENDING		1
-- 
2.42.0




