Return-Path: <stable+bounces-116769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFAAA39D86
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E7417987B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B5269D0B;
	Tue, 18 Feb 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TU/WM7vC"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B41269AEB;
	Tue, 18 Feb 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885226; cv=none; b=Q7D4gRkb4ryiv7UmDchOAgOy8v9dTe7ZY71IyMzAzA1x7y0P1A2djlvZq3U74w19OONd8+DZrdcBLBV4S4dFJR57W8GOGpdMm6UhqDV39b2CumQKPb/FRmOfPkK4WU0Q33XNfnWVUsQha39yoGtiADr+dKZNNHIVNaIH2SJUSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885226; c=relaxed/simple;
	bh=Q5cq18P0XcC2Vl6wgZDytAeWL5PxK8dhgKT/ZZ+mgVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D5HaelVyOfa5AjA2rHv6dOgg+nzxtABcE3RiBRW2z3t6DeDfLU3Fqhvx4EF7QOpZBK34Vm1svA3a039FiARfqE+/NGDR1QxxQQVaa5Zcyd4cYwg7NWJM1bYFqFVeUSxip3MELaJQ29RuNN1k+Ux0UeBvZR61G+StBLtHbtacXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TU/WM7vC; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Hz+An
	7/y8BTdQCJAx4QejdOfO+/Oxf7ZYGLNn21hCHg=; b=TU/WM7vCMgmkgyV84qyI7
	CqGPLktc6rYskbyXgzIuIW0Yl96CyfRSe1IEd5A90IZhI3HiiZvrdSEBDHTI1FXS
	Ln66kaxDzj2bgWWkccwqoShjYfVop8kdAf6PnNBfdv6fK9PLuYIEj6jMoYGN3qlP
	y9/IsP86+E2ijz4aPc/T2g=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXr8iairRnR3jgMw--.2240S4;
	Tue, 18 Feb 2025 21:26:51 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] bluetooth: Add check for mgmt_alloc_skb()
Date: Tue, 18 Feb 2025 21:26:48 +0800
Message-Id: <20250218132648.2561862-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXr8iairRnR3jgMw--.2240S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr18JFy7tw48Jw18ZFW3trb_yoWfuFcEgr
	1vv3s7ur1UJa4kJF10krW3urnxJw1rCrn7WrWaq3s7C3y5Wr1DWr18ZrnxJ397ua1xCr4x
	Aws8CF4kZw48WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXBMtUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqBv3bme0hThcTwAAsX

Add check for the return value of mgmt_alloc_skb() in
mgmt_device_connected() to prevent null pointer dereference.

Fixes: e96741437ef0 ("Bluetooth: mgmt: Make use of mgmt_send_event_skb in MGMT_EV_DEVICE_CONNECTED")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f53304cb09db..1f028c5105ca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9660,6 +9660,8 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 				     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0) +
 				     eir_precalc_len(sizeof(conn->dev_class)));
 
+	if (!skb)
+		return;
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, &conn->dst);
 	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
-- 
2.25.1


