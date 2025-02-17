Return-Path: <stable+bounces-116539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B73A37DC8
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 10:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794FB188B9CB
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7537619ABAC;
	Mon, 17 Feb 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VLEnq//Q"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A3155316;
	Mon, 17 Feb 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782952; cv=none; b=RAiZi4EPSc4ypo0PdDSVs3Ev0XqFF7TWsURnxSIT0hJOaKPcTw6+pkEy59GPuSBDhmPDunEW7JuwM9YmAhUFM2ZUQJAZYJZlPaeNGi7hcC40E3nJkh9FbgxZj2YIWq6A2W8D5I6Hi482GdoNYr4nGjFSS+Y/sEGjY+XRjo6RVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782952; c=relaxed/simple;
	bh=1++UtJ/x4fYcljqobaSvICMiESEAey2qNTq0v65tYIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZbeiHLNEvSJH013qg8D/kAMP96lQzUJHwTje1WkZCq/8xblUHWC9Epj8Jdd0Upi5ChQfpPI/JP8Xu+mDrvjsrfgw8yZJXU8gctuEYMIsPWVLkCYfV+OD7mCbfD1pZOBvqMWupmp7F+vUYAplmgdP3YSFvTc1wDNhScfX6KU5Lgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VLEnq//Q; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xip++
	Y+wP8cdm9eHLHgn2+Hxo2dOyBCVc1sz06DsCjw=; b=VLEnq//Qc7xkdMS7Hkd8q
	CxMjBy7ZcQZcr+FX2zQP+DpkZ3L4W2kBaHHE+k8aedTUFHmb9bGfswNTqSc/sqNS
	rDuJY5L8K2VP/BYzee/aBDsMakw2zVEGp8JDeP0KKviCxxpTsWccpKotvvbLD0TD
	bgHfgJZDr2u8IZOQ9Wmp5k=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnj_AT+7JnGrzSMg--.36548S4;
	Mon, 17 Feb 2025 17:02:12 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: linux@dominikbrodowski.net,
	haoxiang_li2024@163.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pcmcia: Add check for pcmcia_make_resource()
Date: Mon, 17 Feb 2025 17:02:08 +0800
Message-Id: <20250217090209.2339321-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj_AT+7JnGrzSMg--.36548S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4xKr1rur45Jr45Zw17trb_yoW3AFc_ur
	10gryxGrWUtr4Ikw13trsavrySvrn5Wr1kuFn5t3Z3ur9F9w4SqFnxAr98W34xJryfAF1k
	AryDJrnrCasxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_O6pDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0gz2bmey5vIHlQABsU

Add check for the return value of pcmcia_make_resource()
to prevent null pointer dereference.

Fixes: 49b1153adfe1 ("pcmcia: move all pcmcia_resource_ops providers into one module")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/pcmcia/rsrc_iodyn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pcmcia/rsrc_iodyn.c b/drivers/pcmcia/rsrc_iodyn.c
index b04b16496b0c..2677b577c1f8 100644
--- a/drivers/pcmcia/rsrc_iodyn.c
+++ b/drivers/pcmcia/rsrc_iodyn.c
@@ -62,6 +62,9 @@ static struct resource *__iodyn_find_io_region(struct pcmcia_socket *s,
 	unsigned long min = base;
 	int ret;
 
+	if (!res)
+		return NULL;
+
 	data.mask = align - 1;
 	data.offset = base & data.mask;
 
-- 
2.25.1


