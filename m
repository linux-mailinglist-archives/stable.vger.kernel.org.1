Return-Path: <stable+bounces-48211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D438FCDC2
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8A8285B5D
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C31D0062;
	Wed,  5 Jun 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7qU8FC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811471CF8BB;
	Wed,  5 Jun 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589147; cv=none; b=Huy43m0U0bnHFO1sTpTo8g6LgpYmpwUNBHDRoYGtKOC6BzbQcJjt/XZ7F+kMwBcGxeOy04D0jBnyfOitN6ppCiRRpfcjgvQ5EPePVwPDsNYI6To9x/zDSbFOGIkLczXlCzEbX/vintZsOxvCEjsCE5/6+a7hbAB6VW4FAqrdtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589147; c=relaxed/simple;
	bh=Ki0uOE9OVNhemVSk0RYDvPVVhdi998Yhw6Tvj9L3ZUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSSmJJdqOlEfKpGwSFnlILgtSQrZkwRCEmugdNva/sbLDmK46HCvtoZMVrN/iLTj2ydJebuRen5/7loo+VtkSL2W/GWPRHvhrL+BMIDCoj7HPZC4B0Bb7PlboF8pgkHzv7NsVozP1pmZftVQcTQV7X7A+DCy8DZhADV/fO1wb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7qU8FC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D7CC3277B;
	Wed,  5 Jun 2024 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589147;
	bh=Ki0uOE9OVNhemVSk0RYDvPVVhdi998Yhw6Tvj9L3ZUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7qU8FC9CyUB6FJqfoMGSvOn+KwubGl+Sta5WSAVCIAlpEvg6DAfcLGe/0INuvCAl
	 +TzlLEtmCOa8msafE6IxLIvjWW6Yz1Nn4R8xEKenL2FzeleW7dRa8FCF0NIdveJX5o
	 MhUAla6ZM640BiPYKrweqHf6LFH4v2hcNv6CRgVEW702fXBhS6G1E0BGseynBDyOX8
	 jgVuz9oeVIf2HGTln9PQ8xpTGu576kPD+LAiH74ZgMF5LR+b01tQrfb0U+bGuLHq8F
	 ENY8NIGBiPlzg21ndbAESnrm3B25CKHGKgkHQXIdbArHhtFgW6H6qBaaUjk30UvRgN
	 ldpdVu82Xd79A==
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
Subject: [PATCH AUTOSEL 5.15 11/12] nfc/nci: Add the inconsistency check between the input data length and count
Date: Wed,  5 Jun 2024 08:05:21 -0400
Message-ID: <20240605120528.2967750-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120528.2967750-1-sashal@kernel.org>
References: <20240605120528.2967750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 6317e8505aaad..09d4ab0e63b1a 100644
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


