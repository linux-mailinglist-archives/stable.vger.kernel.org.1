Return-Path: <stable+bounces-48143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E0E8FCCEC
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013A52887E0
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4B91A0DD1;
	Wed,  5 Jun 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrJxvW0O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513C1A0DC7;
	Wed,  5 Jun 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588969; cv=none; b=hhAUDh2no4B39qkydBXSTW2lqcGaZK7IfrSFYB2ojO2hkCRYzUgK7RMoAJdEKJN3uJOp+4G5J+3J8sJ/jCB3cTRuFbSnoWQGP/Tcx4JwStKeN84twzrp0EOFKae44/yRIqhciHNrJaU1AU/Qp6bMspA0ap6mc7DHtJyILUCOH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588969; c=relaxed/simple;
	bh=m3CfvU2t8e740CAdb6g+m9jKiMWSdqG1ZUq+ET575AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asWR0NqN2DxzOlwTzVkHGAHmg2AbkzeKVlsjETsvbx+pxdmBvXatorYSQ70ITMxFLPUpsQTmP6aIFdJhUmD7Wj2gkDL3Yg8k64Y6t3TqNGVgVa6AKakwsDyNYzCT1ivrEXkokFMgMBIKd4MbTRmwV62+jzE0FhlS3zWFZJ5cEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrJxvW0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA0AC3277B;
	Wed,  5 Jun 2024 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588969;
	bh=m3CfvU2t8e740CAdb6g+m9jKiMWSdqG1ZUq+ET575AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrJxvW0OAmkYrykbUtSD/4tBYKvA8KiyFfw732zHdrvIQLFIwUvuUnmzo6ATQ1yz/
	 C7wepcOsMjdQe2HlGsf+8y8gEBJDzNPgQFzna5JguVnJbT6aDrpo5bX9aNfG5Mv4+d
	 foTE1noOc5Fqyqqv279OVjML5NLLrlNWaSSTt/ljqG0rbTvLTl1P1MeLCfRpfBZSlG
	 z4ai0sWnECL9yDk5dBPHYjZoK1uMQJuj05pymc32P4Nq8OixObn2Ip4OsfjHkV3vdx
	 uyfhm3Vnvkhz2vmdSLIqARtLBILCLL/W0Pwwfcs6wFUE9Cyr46ho5Tu0U3wIe1AJPu
	 lMcD7WXkuJf8Q==
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
Subject: [PATCH AUTOSEL 6.9 16/23] nfc/nci: Add the inconsistency check between the input data length and count
Date: Wed,  5 Jun 2024 08:01:59 -0400
Message-ID: <20240605120220.2966127-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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


