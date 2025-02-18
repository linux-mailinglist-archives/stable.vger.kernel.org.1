Return-Path: <stable+bounces-116771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC08A39DD1
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DA216665B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E2269895;
	Tue, 18 Feb 2025 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RbheBNR7"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8E661FF2;
	Tue, 18 Feb 2025 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885885; cv=none; b=ZQuxkZSsPzVuTfzwI1X7dE6H+MlkwnWx+mb3UEWQc9ikcR6DatfcFts4FtuxwpvDg759BpCaDv2pEev1TKlxUm30uoufb88Lb90vt6/OfJqS2ClmzKuCsmZHNHr5RlWlQwAXBwnHE3vz91oUZyOtka4GSUvUTa42entCdO2QMUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885885; c=relaxed/simple;
	bh=TwgMB7T3xrklH/XcTQFISwEV9IVITK4a2JBNyBtOMhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJyXeO0rJinETh3G/7qSkhgn2uxtx66g/CYnk3vySvcdGijStq/5iVgLBl89bS/pybWowc0OLj5NzSnnKXOgCSLQCNhH1Fm/APnnNdH+95zfLf9jS83CS4sSquNPDjmar5445Xm6WUDHG2L/NH6yOYP+0c6duDQ5+xsrI9p0TDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RbheBNR7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Ij4g2
	0YFPTl6kiG9pCgMNJFmTxK0iuXkJSFpOeNRl70=; b=RbheBNR7r6JBhK/A9ltUr
	pYtrYXZ+0pA9IhRZPgHCdQinKQvzxbxyvBy1u4EN0OxsfPwQLipILaKnAtFjI/WH
	aSf/vCCRCPBJ7l/lFJBXz5V/YtoUzU6WJ7wXgq2P6AKMoTGaKJJH8HSOrjpNe2Aa
	kKqiwxMh+7imtsGrrCyV3g=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3r6q2jLRnc3EEMg--.34170S4;
	Tue, 18 Feb 2025 21:35:51 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	mm@semihalf.com,
	rad@semihalf.com,
	acz@semihalf.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] bluetooth: Add check for mgmt_alloc_skb()
Date: Tue, 18 Feb 2025 21:35:48 +0800
Message-Id: <20250218133548.2564549-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3r6q2jLRnc3EEMg--.34170S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr15JrW5Zry5XrWUGryUKFg_yoWftFcEgF
	1Iv34fuFWUJFyDAFs8uFW7WwnIkw1rAF1IgF4a9F93ZrZ8Ww1UJr18urnxA397W3WUCrWx
	CFWDCFs5Za10qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNtxhDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkAb3bme0hTGQpAAAsc

Add check for the return value of mgmt_alloc_skb() in
mgmt_remote_name() to prevent null pointer dereference.

Fixes: ba17bb62ce41 ("Bluetooth: Fix skb allocation in mgmt_remote_name() & mgmt_device_connected()")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f53304cb09db..8383e5ae95be 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10413,7 +10413,8 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
 			     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0));
-
+	if (!skb)
+		return;
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, bdaddr);
 	ev->addr.type = link_to_bdaddr(link_type, addr_type);
-- 
2.25.1


