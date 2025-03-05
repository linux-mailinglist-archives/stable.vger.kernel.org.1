Return-Path: <stable+bounces-120413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E8A4FBAA
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAEE1893F34
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCAD13AC1;
	Wed,  5 Mar 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hZOpA3k3"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0C6205E2B;
	Wed,  5 Mar 2025 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169973; cv=none; b=LtUyORVMJlfjISV567k5Pe43rLEZ+TPDx9MopLJt48y/9YlPd8/jK9mA91TuDRWxDzjVBkX6e/QJFwY/bcrprWDa3q5A0M1t94CnbreasrB5KJa+Mniv+J3Nb2lT7AuSC3qEmZLKX32xAm4aJiPS7lOj8dbfYtvR3Qv0ieUTdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169973; c=relaxed/simple;
	bh=61ymXQdkyM8TiJOiqN4HS+dcLaY0P3zrpsvRC7rw1oE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6U3d68MrAUWVFNh0w60OaxnsZGkC5kFAA58bl4TxQzBN3rviDQaRzQVpKAG7IpzedCRK+I5DRUsZaeuLpa52CLkWh3f9gwSAfIayG8Wff/AGKAkzjDzGnnj5gsrrl3M5Djrd9TKctSFDB0ZJtAWLjBEH2YpML46nkDCl6F2yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hZOpA3k3; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NNmP0
	RcY0fndOAtXq39WcaveUgBAnm+T/Ou7U5DaClg=; b=hZOpA3k39JXxEDK/0xPwy
	W+HbwClXLbYmNrcqiO2IJw2SRBa6Ccg1i7QaN7PKDzWgs/3DYUZg8wIVqQcePQ6u
	7zVeGAeK4/MWUJy3wwtIqnM4GK8G3ujevCfoXG60fYP73GTj4L9X6jcv9KE1cTmC
	uLDH3iKwyCikKzuO7kPc/w=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3nFr5JMhnCYXoPg--.46709S4;
	Wed, 05 Mar 2025 18:18:34 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: shshaikh@marvell.com,
	manishc@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiasheng@iscas.ac.cn
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] qlcnic: fix a memory leak in __qlcnic_pci_sriov_enable()
Date: Wed,  5 Mar 2025 18:18:31 +0800
Message-Id: <20250305101831.4003106-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nFr5JMhnCYXoPg--.46709S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4kAFyxXry3Jw1DtF17trb_yoWDZFb_CF
	15Zr1fX3y5CFyDKw43trnrZ342g3ZrW3WfZ3W0gay3tr4DGFW8Jr12qF93JrnrW3y09ryD
	G3Way345A34xAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNtxhDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0gAHbmfIHmKogQAAsB

Add qlcnic_sriov_free_vlans() to free the memory allocated by
qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails.

Fixes: 60ec7fcfe768 ("qlcnic: potential dereference null pointer of rx_queue->page_ring")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
index 8dd7aa08ecfb..b8a9e0e2907e 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c
@@ -598,8 +598,10 @@ static int __qlcnic_pci_sriov_enable(struct qlcnic_adapter *adapter,
 		goto del_flr_queue;
 
 	err = qlcnic_sriov_alloc_vlans(adapter);
-	if (err)
+	if (err) {
+		qlcnic_sriov_free_vlans(adapter);
 		goto del_flr_queue;
+	}
 
 	return err;
 
-- 
2.25.1


