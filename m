Return-Path: <stable+bounces-2978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EEE7FC6F7
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A68B24BB9
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F044C6F;
	Tue, 28 Nov 2023 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp1b/mMH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581E44367;
	Tue, 28 Nov 2023 21:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C88C43395;
	Tue, 28 Nov 2023 21:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205645;
	bh=q4zuJqnRTMKFKpaQD3b9M8K0vV9uChLcAW1eHYiIYr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gp1b/mMHfw4pShS6Zc5WQlygErjHMMwmTADMvGhP8GD0hhtz0ZOSbllcwKMF+EyvW
	 WWH/gR0nEpTazByZExORqhU4bxsEULpshdJJmXPo+8M4OchMyRX7reDbdbWUCOBGdk
	 s6nmsz+XJGa5E2a4+IA3OreKsqc7o5ynI17kk5X3L9BgSKBqqNZP7X5EkRrTILJ7Ca
	 KM4OhIpf44wLHWvAwdvDsR1uEiLRfgTT7uV388KdP6JQxPkXR9jFaAP4xxGl6Wnt1S
	 8JYV2Hy3QxvrjbWbu7xM4f3PzaiHvoDS2qZL35HJx5WImKWelhHJMILAMwnji1Jn56
	 y+MY5tFFV70Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	bongsu.jeon@samsung.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 32/40] nfc: virtual_ncidev: Add variable to check if ndev is running
Date: Tue, 28 Nov 2023 16:05:38 -0500
Message-ID: <20231128210615.875085-32-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Nguyen Dinh Phi <phind.uet@gmail.com>

[ Upstream commit 84d2db91f14a32dc856a5972e3f0907089093c7a ]

syzbot reported an memory leak that happens when an skb is add to
send_buff after virtual nci closed.
This patch adds a variable to track if the ndev is running before
handling new skb in send function.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
Reviewed-by: Bongsu Jeon
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/virtual_ncidev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index b027be0b0b6ff..590b038e449e5 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -26,10 +26,14 @@ struct virtual_nci_dev {
 	struct mutex mtx;
 	struct sk_buff *send_buff;
 	struct wait_queue_head wq;
+	bool running;
 };
 
 static int virtual_nci_open(struct nci_dev *ndev)
 {
+	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
+
+	vdev->running = true;
 	return 0;
 }
 
@@ -40,6 +44,7 @@ static int virtual_nci_close(struct nci_dev *ndev)
 	mutex_lock(&vdev->mtx);
 	kfree_skb(vdev->send_buff);
 	vdev->send_buff = NULL;
+	vdev->running = false;
 	mutex_unlock(&vdev->mtx);
 
 	return 0;
@@ -50,7 +55,7 @@ static int virtual_nci_send(struct nci_dev *ndev, struct sk_buff *skb)
 	struct virtual_nci_dev *vdev = nci_get_drvdata(ndev);
 
 	mutex_lock(&vdev->mtx);
-	if (vdev->send_buff) {
+	if (vdev->send_buff || !vdev->running) {
 		mutex_unlock(&vdev->mtx);
 		kfree_skb(skb);
 		return -1;
-- 
2.42.0


