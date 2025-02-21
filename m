Return-Path: <stable+bounces-118553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D400A3EF0C
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 09:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C307A251D
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945FE201035;
	Fri, 21 Feb 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W3Vd2e41"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D4433BE;
	Fri, 21 Feb 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127811; cv=none; b=nYl7cORSJuXfVl67akIag+gbkhRsiyyAK+tItSp+xaof6x52FDpjts2aKKNqrypuKs/16t8Jy6wnNZSbck8j4MFYtrOgz+5WmywSmCrwwojhJ2Ad0bjvt7Zui/qjmWRHYLZ9H78gzghoIVvGvl0paSoq6+yct3F1uzu4HTpTPSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127811; c=relaxed/simple;
	bh=cET2VAydaHrPR4tiVeI/VYj9jokwGPaK2EJTZppT38g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sE5QVpVFnBqU7oEctdEkEtl0y+ux4/Xfo43wg90Kik0XukQoPrzGnlVudyzryFF2al36FL+Gyl8MeJOaYuhTBJ4sRCFYuPMshZHssnidyNIIIY0OjVzgWTfy/7o6UIE7sSWfV05C4Vw3sOpLQAXCpIQQYbarPn1GX49RpzJY7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W3Vd2e41; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pf/dh
	IOA+r1jNHu2BLMVQF106XUi9CBfUXR0eDnU5Cc=; b=W3Vd2e41CKOydg8xPTwVE
	JgcVw9+cXM7rHeg2gMY5lMpoDDsTQO0WQj+KSEbsHv8PjhdpQiHJmKdWONOY7Job
	DiUedZ5Jk9W/5I9KHwdMGaqLpQNO0SSKFdOpeYW9uARMMusp87moazfYy3Vdlzf2
	+s4D/h+nurpeulOhlp2mDw=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDneyktPrhnkx91Ng--.60119S4;
	Fri, 21 Feb 2025 16:49:50 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	mm@semihalf.com,
	acz@semihalf.com,
	rad@semihalf.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
Date: Fri, 21 Feb 2025 16:49:47 +0800
Message-Id: <20250221084947.2756859-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDneyktPrhnkx91Ng--.60119S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr15JrW5Zry5XrWUGryUKFg_yoWfZrg_Kr
	n2v3yfuFWUJryDAF4jkF4xWwnIyw1FyrySgwsIgas3ZrZ8Ww1Utr1xursxA397W3WUCrZ7
	CF4DCFs5Zw10qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNvtCUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqBf5bme23pywzwAFsB

Add check for the return value of mgmt_alloc_skb() in
mgmt_remote_name() to prevent null pointer dereference.

Fixes: ba17bb62ce41 ("Bluetooth: Fix skb allocation in mgmt_remote_name() & mgmt_device_connected()")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- modify the title description.
---
 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f53304cb09db..3e0f88cd975c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10413,6 +10413,8 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
 			     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0));
+	if (!skb)
+		return;
 
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, bdaddr);
-- 
2.25.1


