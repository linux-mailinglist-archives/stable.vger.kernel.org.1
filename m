Return-Path: <stable+bounces-116951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B490AA3B002
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 04:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F76516BDC1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BAE18C011;
	Wed, 19 Feb 2025 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="myHfhuMo"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4EC17BB0D;
	Wed, 19 Feb 2025 03:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935393; cv=none; b=N8Nh8x0MljuIOxIi6PcgHhogBXuwoYQZSs/A5vhKWMOcCW0G9itpX0RxtGM0AwMLhRLYVwhPj4+uPpqZCwNujGN8qaJ/FouzDT72HeakWucUfk+nyLcPntpKaxpYOcpCIobhb/yvSKm3ZKcmYXKjcYdMz1yh1wg4FJ6v05T3Opg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935393; c=relaxed/simple;
	bh=R6QV677NlQ522oBMfkLDcOEZ3lbL5Z5tMyBshHnyZXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kYX+H/H8abUK96rrvuBf5HcjPwk7OILr8uef6J7AHZI/zMUlOQmbhi98e14vXQiZ3XzUeftc0hsxGyMDvtw1P+1xYOeem4ed6duZnkzBGY7OzhOH2tkLMLH17E31YJpLEJ09onjU08QRXdPEBdUx0BizWmqC0vXd+vqC9NVbFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=myHfhuMo; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=09LR6
	ViKaxcfzfqLX5rvRGr8rmzBQTTrDelidYgzSC4=; b=myHfhuMoAYE8fXTAygDzl
	nlG7R4zQAQHCLJ5O1nltULUKWQ/mKV6gM15L5lh2fXNIEPy4DyCU8zOqFOXX7z7C
	bzUkQURrxGjcG3QLDtOnk+db/nSGsxu1NuAt2ZZNOfKhb+wnrUYtlVKWbRqz2WYQ
	xatpxTJIEtOrslNqxFx9SQ=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDHNuaNTrVnlSDSIA--.42964S4;
	Wed, 19 Feb 2025 11:22:54 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: zhuyinbo@loongson.cn,
	arnd@arndb.de
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drivers: loongson: Add check for devm_kstrdup()
Date: Wed, 19 Feb 2025 11:22:51 +0800
Message-Id: <20250219032251.2592699-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDHNuaNTrVnlSDSIA--.42964S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFykGF17tr1DXF4DKw45ZFb_yoWDJrcE9a
	9FqryrCr15CFy3t34jvr43uryI9ryFv3WYkF15t3Z3Zw42yF1SqrWUZrsxGFW3Xr4IvFn8
	Zw4vgr1xZFyIyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRXBMtUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0hv3bme0kM+oVwACsh

Add check for the return value of devm_kstrdup() in
loongson2_guts_probe() to catch potential exception.

Fixes: b82621ac8450 ("soc: loongson: add GUTS driver for loongson-2 platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/soc/loongson/loongson2_guts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
index ae42e3a9127f..26212cfcf6b0 100644
--- a/drivers/soc/loongson/loongson2_guts.c
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -117,6 +117,8 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 	if (machine)
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
 
+	if (!soc_dev_attr.machine)
+		return -ENOMEM;
 	svr = loongson2_guts_get_svr();
 	soc_die = loongson2_soc_die_match(svr, loongson2_soc_die);
 	if (soc_die) {
-- 
2.25.1


