Return-Path: <stable+bounces-118725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D58DA41A2C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898E8189099C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C98B24C67F;
	Mon, 24 Feb 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e01OUvCH"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18B9253331;
	Mon, 24 Feb 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391274; cv=none; b=JWOv9t8CD1EBGUnf7lignXFtce4z37+nFbSmw6s9o9wbv6PlgAG+VF5eTxIZFRSdPG0Jo9iYdhPSXkEK+OT7oyghSjTR5852ZlptC89AeE3j30cX2XL343K+OC9e7Hr4HlAsTRYlh6ngqXUWGyjklWcDK9Gr6M3ZKXeBoXZMwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391274; c=relaxed/simple;
	bh=TCvVXCiHDk1V9rJ9VKwPE1xm0gPbe3PuqAGQcLSGzkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upmRnW4b4LO4yF0ClF/j85a2lFZW6zd9na2GgWvFFDQx3hNJWuCFy0yxfga0TEDi0cG8U1Hj7EE6bpMy0zt05jO2TqmFXUSf6aR5Sf/Pvi7aUESaQio2lZ2uhKK5Il4acBqVKrhnivlJo4KqCyLlXUER9Ai+6RJw4JZT2zPMEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e01OUvCH; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+p/OR
	7YcspT2G+MDz+AMaNq8fZXBgvWQLH5OgUJixfo=; b=e01OUvCHWfx+0hTSnwyHC
	abvo8HqBNPWEJCgEMIN7h+Xp0JIzjHRuEHlneqMs1IOKscVLlxM17Q8hWx5db/nA
	CBbREVRkKyr1rJdnc76gg9PbCo5ijjRg4r7EC0l/XKHvpKtU8upBWWBZKTfmNHsa
	ly4DaOt28XAJtUUFAgfQsM=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3V0IrQ7xnddvNOQ--.893S4;
	Mon, 24 Feb 2025 18:00:12 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andy@kernel.org,
	geert@linux-m68k.org,
	haoxiang_li2024@163.com,
	u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com,
	ojeda@kernel.org,
	w@1wt.eu,
	poeschel@lemonage.de
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] auxdisplay: hd44780: Fix an API misuse in hd44780_remove()
Date: Mon, 24 Feb 2025 18:00:09 +0800
Message-Id: <20250224100009.2968190-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V0IrQ7xnddvNOQ--.893S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4xtw4rJryxXw45WF45Jrb_yoW3XrX_C3
	Wrurs7GF4UAr1Fqwn5tFsxury8t3W2qrn3Z3ZFva93XryUuFsFqry7Xwn5Gas8ZFWIyr9x
	A3Z5WFWDCa17ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRApnDUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkBn9bme8O3-B8AAAs0

Fix this by using charlcd_free() instead of kfree().

Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/auxdisplay/hd44780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 0526f0d90a79..fcd3780ce5d1 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -328,7 +328,7 @@ static void hd44780_remove(struct platform_device *pdev)
 	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
-	kfree(lcd);
+	charlcd_free(lcd);
 }
 
 static const struct of_device_id hd44780_of_match[] = {
-- 
2.25.1


