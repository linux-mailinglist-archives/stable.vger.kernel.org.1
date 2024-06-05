Return-Path: <stable+bounces-48197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7358FCD92
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012B01F28522
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07E61AB914;
	Wed,  5 Jun 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLX/q/Af"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F61AB909;
	Wed,  5 Jun 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589113; cv=none; b=KbBpEHxTLxKZFHdKq/VsDqx0S5jBObdFMLHCGgy7cxP5t90X5Ach11sngTR5Zcukph3KPPxUIDMhhjxepZbUJ/YbgYzd7tlk+tKrqG0ubPEjCeljdzZ4Is7wOkO+1/AUYa45w2E1lwDbiEOaYy5UElSaVgDNg/yxl7TwIYN59RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589113; c=relaxed/simple;
	bh=iCEqVW94eFOmJrC/ldTm/SBWtD5V6IcQttdylIMUgdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRgwTgsuTcDWHBPBuhLgLRM6ITX1IikNhpRTON7/t1C+a99BXkIGkFbZaDWkbqfAZKHaXtCKMYvF9eHTw4usPHrATHn8rTqCGBO8+CZebJIl5RUZzuIs6zIwMw8cHxNyUukVEBFzsFjZNZCns8ObPRf57UMfmx6tSOudiIrUSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLX/q/Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79646C3277B;
	Wed,  5 Jun 2024 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589113;
	bh=iCEqVW94eFOmJrC/ldTm/SBWtD5V6IcQttdylIMUgdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLX/q/AfqwxNeNiPtofsZbobv5fc38ur1koEJoiwisCIwnFrnM1ZUXH34G/rLwz7T
	 Fhi2Mox6fZkS75UVRLquZ5JcOtPLMZ3NhoAn3UqqjAD62q2aQgNv3tDSCLm+y/m70p
	 RYwjtTNZ71WpM/1aSHbwmNaeQPxA4NP4RHpWg5VAa6xOsZ4e0HqBEIdT7pHHVJ9OE0
	 anLBplkTqmuWW3LltM+LwHq2qp1fzPfQ3wjzlMwMahCT8/2IwBmltqiZNbJlyWXbLs
	 bRbk3DV9has5FzCiLu240fhZGeNqCzl3KyjO4KrS6BVMV7u8A+opCihOj47PiIfOUA
	 H/eUIPOn8dLvw==
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
Subject: [PATCH AUTOSEL 6.1 11/14] nfc/nci: Add the inconsistency check between the input data length and count
Date: Wed,  5 Jun 2024 08:04:44 -0400
Message-ID: <20240605120455.2967445-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120455.2967445-1-sashal@kernel.org>
References: <20240605120455.2967445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index 85c06dbb2c449..9fffd4421ad5b 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -121,6 +121,10 @@ static ssize_t virtual_ncidev_write(struct file *file,
 		kfree_skb(skb);
 		return -EFAULT;
 	}
+	if (strnlen(skb->data, count) != count) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
 
 	nci_recv_frame(ndev, skb);
 	return count;
-- 
2.43.0


