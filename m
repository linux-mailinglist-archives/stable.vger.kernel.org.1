Return-Path: <stable+bounces-48162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59018FCD24
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC92828CDF0
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112B1A2FBD;
	Wed,  5 Jun 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzBwDe8O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12581C451C;
	Wed,  5 Jun 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589019; cv=none; b=rjqdF7G3ggSp8weeRf2uOyKdtodlDPRUaBjE6FGse4E2R1f8EP1C/EsvsKntb/XAaIMspYkyjSp26DzX/A3lATdgsDzBLYYqFOQdkV0ZXB1D71roankOA0UjaLJhXgy+vVA3sdMA4n0L5VR2XA5ZOkGVpwEIov6yxe9m0aNfocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589019; c=relaxed/simple;
	bh=m3CfvU2t8e740CAdb6g+m9jKiMWSdqG1ZUq+ET575AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nevbl0si86ToX2dBEGHj8TR4+vW+r7t+a8xzPB5KPuvx+eGxb+qG0fRzQz4/uvzNDO5LX4Eq/BK9JGkmT0T2rh8LglEzJA06DT9Q2Fi3RLaJJxsbVjPwxmtl+PzP+uhcN9oiDzh9P+xG+Nyf2I7+0eBri7bNCHvfntfc85EPfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzBwDe8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17CCC3277B;
	Wed,  5 Jun 2024 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589019;
	bh=m3CfvU2t8e740CAdb6g+m9jKiMWSdqG1ZUq+ET575AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzBwDe8OXIMX47D8MN4A6q66RJYMYEI86hSfcvcMTyBUN/1Q5PVA/Wi/vODYaIKk/
	 4MHSP4373n9NAKm6ly7PiMW/+C1CMlODySg2lTcMx6yeni3pSUKSBxdFgbA8OUugj8
	 RTDqQaJQ5HPhQR3g8SkdneBmq59dYwI0lJBX/SlodyiIvgCJ2qCFyqoBulM41iG2/K
	 WVq7kPAp5H2UfhBAakT2CN+noazS+d7ciDMR8hbOWl1GIeoSx8ma7pr3WyuMGu5Dho
	 eLrYd04K686F/FF8w5U6+kiZIJby5cE9CvyLU98C0XolEc3uB+h9G7moCygO2uivC/
	 5PFnJ4fMLaWcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	bongsu.jeon@samsung.com,
	krzk@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 12/18] nfc/nci: Add the inconsistency check between the input data length and count
Date: Wed,  5 Jun 2024 08:03:02 -0400
Message-ID: <20240605120319.2966627-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 068648aab72c9ba7b0597354ef4d81ffaac7b979 ]

write$nci(r0, &(0x7f0000000740)=ANY=[@ANYBLOB="610501"], 0xf)

Syzbot constructed a write() call with a data length of 3 bytes but a count value
of 15, which passed too little data to meet the basic requirements of the function
nci_rf_intf_activated_ntf_packet().

Therefore, increasing the comparison between data length and count value to avoid
problems caused by inconsistent data length and count.

Reported-and-tested-by: syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/virtual_ncidev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 590b038e449e5..6b89d596ba9af 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -125,6 +125,10 @@ static ssize_t virtual_ncidev_write(struct file *file,
 		kfree_skb(skb);
 		return -EFAULT;
 	}
+	if (strnlen(skb->data, count) != count) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	nci_recv_frame(vdev->ndev, skb);
 	return count;
-- 
2.43.0


