Return-Path: <stable+bounces-7304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD8E8171F1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E319284296
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5F142385;
	Mon, 18 Dec 2023 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkJPAXVG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CF137883;
	Mon, 18 Dec 2023 14:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2B8C433C8;
	Mon, 18 Dec 2023 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908108;
	bh=0C4cVdfyPjUld4QZWL1c/rKdGh/iwGruLYdaD8SqKG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkJPAXVGDK7Lyr325pKd2tWswA8BQgkeUuo06pbbZbTblP+TR4Gz72+M/2mxGy6RS
	 tNgagzxVTizIlgISY+dZ+NPtTrF7y2wxbI3Tm8TO+tGzeCKU6lC+X8V51evBvA/jxr
	 xMt0hs2RgBgn6u2egpBFmD/RFKN0kxY4srcyCVzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengfeng Ye <dg573847474@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 028/166] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
Date: Mon, 18 Dec 2023 14:49:54 +0100
Message-ID: <20231218135106.208068057@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

From: Chengfeng Ye <dg573847474@gmail.com>

[ Upstream commit d5dba32b8f6cb39be708b726044ba30dbc088b30 ]

As &card->cli_queue_lock is acquired under softirq context along the
following call chain from solos_bh(), other acquisition of the same
lock inside process context should disable at least bh to avoid double
lock.

<deadlock #1>
console_show()
--> spin_lock(&card->cli_queue_lock)
<interrupt>
   --> solos_bh()
   --> spin_lock(&card->cli_queue_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_bh()
on the card->cli_queue_lock under process context code consistently
to prevent the possible deadlock scenario.

Fixes: 9c54004ea717 ("atm: Driver for Solos PCI ADSL2+ card.")
Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/solos-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 94fbc3abe60e6..95f768b28a5e6 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -449,9 +449,9 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	struct sk_buff *skb;
 	unsigned int len;
 
-	spin_lock(&card->cli_queue_lock);
+	spin_lock_bh(&card->cli_queue_lock);
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
-	spin_unlock(&card->cli_queue_lock);
+	spin_unlock_bh(&card->cli_queue_lock);
 	if(skb == NULL)
 		return sprintf(buf, "No data.\n");
 
-- 
2.43.0




