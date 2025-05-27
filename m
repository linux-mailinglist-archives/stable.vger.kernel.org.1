Return-Path: <stable+bounces-147885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDDEAC5C11
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 23:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD614A0E10
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669EA2116E7;
	Tue, 27 May 2025 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mikaelkw.online header.i=@mikaelkw.online header.b="FqgwUhoh"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6FD7260B;
	Tue, 27 May 2025 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.181.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380422; cv=none; b=Bzx++KSL3SLhiH9MIwM9r3YRTjmPdryYE5qtNYj/IAjs94wf5UxpHZ+GvjZsiuPnv0PqYDlEC62WHv0W4nOnbKLfhNJCIj9t8t62BPlNxS21wKEk3H6Fbs/gpV3/9dlbAiC4iHfQ0+Txz66hobBgmNIU1UUde8G7WZ3/y7fHyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380422; c=relaxed/simple;
	bh=Nl3slm3ORyXM24Jp136yutmN0T+7Y9mG0+TrxTs37VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itggiVpe94oXhWsbTHut9FDT9TY7QQrRCtS5BOqhKd3RQ7oAPdhuI7yE/R7gADa2L8nk60aBtODTzG/8vaQGq2uRHw3ANfNIzkc7G/G8yXlAAJkxoUoFR4aspsCj7XpmeTBa8TP25dxvVt6bFSowm+qxkhTUleFkoaVlP2akTdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mikaelkw.online; spf=pass smtp.mailfrom=mikaelkw.online; dkim=pass (2048-bit key) header.d=mikaelkw.online header.i=@mikaelkw.online header.b=FqgwUhoh; arc=none smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mikaelkw.online
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikaelkw.online
Received: from engine.ppe-hosted.com (unknown [10.70.45.172])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2B536200A3;
	Tue, 27 May 2025 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mikaelkw.online;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:date:date:from:from:message-id:message-id:mime-version:mime-version:subject:subject:to:to;
 s=pp-selector; bh=lwjcejsgwEmNYg9nHk4XBk4Rx/Y1yysKSIvGN1YC2j4=;
 b=FqgwUhohgsOkn4WR3lqS0LrQ7GIsqQrMYaREKDemPQ8N7Zsmds+g0D8VI19XEjK+MZtD96LFPcBYOGF2dHecLUIKsiQtU8NXTBaJW29U8qwY5xCC28kEKdadKhIboZxQm4wZYOFGQV0Y66dIirfp4lCjc4l2lAwFSDn7l6ER8r6d5RZapoiXkz9DEerO5cXufTlVedPjuZ1JJI+CR6lNm1CSwxU+rF8Kq+BCbTtcptfFYmsqPwP/aPt0C9hQQnJAnfF9NXS1KycPc4kBQppWLOjVlDXjqcoszlCV7Ilt/ao2yCZuI8fI+LIrpjC82AuS8OnWr3T25rgXOp6ZhXeF9Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from test-ubuntu-rev3.. (78-26-16-15.network.trollfjord.no [78.26.16.15])
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2FD35B0005D;
	Tue, 27 May 2025 21:13:35 +0000 (UTC)
From: Mikael Wessel <post@mikaelkw.online>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	torvalds@linuxfoundation.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	security@kernel.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Mikael Wessel <post@mikaelkw.online>
Subject: [PATCH] e1000e: fix heap overflow in e1000_set_eeprom()
Date: Tue, 27 May 2025 23:13:32 +0200
Message-ID: <20250527211332.50455-1-post@mikaelkw.online>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1748380417-IY5a2VRwpn3R
X-PPE-STACK: {"stack":"eu1"}
X-MDID-O:
 eu1;fra;1748380417;IY5a2VRwpn3R;<post@mikaelkw.online>;7544ea0f74a3697a45f5192d6efff48c
X-PPE-TRUSTED: V=1;DIR=OUT;

The ETHTOOL_SETEEPROM ioctl copies user data into a kmalloc'ed buffer
without validating eeprom->len and eeprom->offset. A CAP_NET_ADMIN
user can overflow the heap and crash the kernel or gain code execution.

Validate length and offset before kmalloc() to avoid leaking eeprom_buff.

Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently for ICH9 devices only)")
Reported-by: Mikael Wessel <post@mikaelkw.online>
Signed-off-by: Mikael Wessel <post@mikaelkw.online>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 98e541e39730..d04e59528619 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -561,7 +561,7 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		return -EOPNOTSUPP;
 
 	if (eeprom->magic !=
-	    (adapter->pdev->vendor | (adapter->pdev->device << 16)))
+		(adapter->pdev->vendor | (adapter->pdev->device << 16)))
 		return -EFAULT;
 
 	if (adapter->flags & FLAG_READ_ONLY_NVM)
@@ -569,6 +569,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 
 	max_len = hw->nvm.word_size * 2;
 
+	/* bounds check: offset + len must not exceed EEPROM size */
+	if (eeprom->offset + eeprom->len > max_len)
+		return -EINVAL;
+
 	first_word = eeprom->offset >> 1;
 	last_word = (eeprom->offset + eeprom->len - 1) >> 1;
 	eeprom_buff = kmalloc(max_len, GFP_KERNEL);
@@ -596,9 +600,6 @@ static int e1000_set_eeprom(struct net_device *netdev,
 	for (i = 0; i < last_word - first_word + 1; i++)
 		le16_to_cpus(&eeprom_buff[i]);
 
-        if (eeprom->len > max_len ||
-            eeprom->offset > max_len - eeprom->len)
-                return -EINVAL;
 	memcpy(ptr, bytes, eeprom->len);
 
 	for (i = 0; i < last_word - first_word + 1; i++)
-- 
2.48.1


