Return-Path: <stable+bounces-48180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEEA8FCD69
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E7E2863E1
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598841C89E9;
	Wed,  5 Jun 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9DY2sg2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB81C7D68;
	Wed,  5 Jun 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589069; cv=none; b=XU1iCseXY+Jd6U4lVQD4/Lexdah+rySqpkXscCapNOjoDOdA2uH6HsR/Zi1sGKJJ1kppI8FpJI2n4Za59gR7rRdKjopmneyx8EN8h+QhbUmP3h6ufYkaksHPm101Hko5xVIrbvI24vQ4nSpJUGgI01eaXolDKELGXtI1hwNWcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589069; c=relaxed/simple;
	bh=m3CfvU2t8e740CAdb6g+m9jKiMWSdqG1ZUq+ET575AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqAPjq6eY9ZrEWegZ6FkQQFMMWuL6t4zuDsAnAYodB4tNCIq7DKR12R7uajF0F2TIv9Xi44U+qvbhx+MxF9K4pCrOgNAXwXI6cOTdY7V3cmQ75b03+cg/+xayFXNo+36xlyGROJ24kV/8uj1J3+03GOAkXob4YGosesZSCLRV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9DY2sg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CC4C32781;
	Wed,  5 Jun 2024 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589068;
	bh=m3CfvU2t8e740CAdb6g+m9jKiMWSdqG1ZUq+ET575AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9DY2sg2juvtB3XTrr5kBw7zs9+KibBI/GN+dDZwAyEUT4x7QhdE25ZV2RPm64j4t
	 KIUT/molg5LAu7/SUk9EHxxos8vvdg2n71/+l68fyH9eS36150ETXusZfOyIabI0F8
	 1Ot7Gzh4UqXqpc4fRhnsWlD8B3rKbS0Br1DXNSMfnWwtVqcz9uF40IeEetAFRnW5Vr
	 GnpzA7nyyRNPnpVfSF2sbXTq3f1ORHYoNcmfDoExmVH9bS5Tqkm5KCZwulm2VEKJCv
	 8qRO0/vfqmj9ND6297u9N/7XUqywPwqhgOHxAC7BTLduscBC9QW1yoJ8bBhdkSwZmf
	 ED91tp9r2u6pw==
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
Subject: [PATCH AUTOSEL 6.6 12/18] nfc/nci: Add the inconsistency check between the input data length and count
Date: Wed,  5 Jun 2024 08:03:51 -0400
Message-ID: <20240605120409.2967044-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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


