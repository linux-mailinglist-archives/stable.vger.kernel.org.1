Return-Path: <stable+bounces-118386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2157A3D2F1
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 09:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D9518936F1
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202F1EB185;
	Thu, 20 Feb 2025 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S3MuI+AH"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E541DE2BB;
	Thu, 20 Feb 2025 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039474; cv=none; b=LL97imnOJ9bCRLD0gG/QGGChBU72FlaeGCEcgd3lVkRHvbKjhDMPVI1pmKj6OumnaTbIjnpwaYjMhFSfCP1P5GNBw9O6qSO/OU2ZXoAg+/SgfERIbltMXURtfaNs+wvlgH0w3MGPMatLRD7cctRPBzySoIxtR9MAKfcX7hctOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039474; c=relaxed/simple;
	bh=oCazgK2J+JQNRdaJ2W40CLpySIyip95iAnugNazXwnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k+MGo8jFejGYtQCPl8UBKx+qUDjZ8PsJbCDy2CfgWYbLyuF76jeUQDlxcf285dFg2SMcFUzVPoMwv6Hs9wPnFAotP+Lyqn6SEEhj2U6dRJ4wE8RxxbLjTbVHwJiZNHl7kaQE07It+BU2xrHtTC5nAnw5h3NbhpxYjgrflbMktOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S3MuI+AH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=i7pov
	A4zdsdkdu9JehhxCixgUWiQ2gMIpi3PyPSESfA=; b=S3MuI+AH5uSmisdho40my
	VkE3DOD0f5E6FypOnjiCpzowpK9HyoAR/mGCc+yqJOTCFB3ItGQ9FG8sdZWJ6CkI
	RJivdpcGs58jy/ziTVGhljMQCNG0SX+nhqE7EyaoaE6E0XEWJ6y4qbNsQJ+FgbN2
	GEn0BvMXBoEl4lIL+Y8rX0=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBnjX8O5bZnl9BpMw--.6425S4;
	Thu, 20 Feb 2025 16:17:19 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: zhuyinbo@loongson.cn,
	arnd@arndb.de,
	zhoubb.aaron@gmail.com
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	soc@kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] soc: loongson: loongson2_guts: Add check for devm_kstrdup()
Date: Thu, 20 Feb 2025 16:17:14 +0800
Message-Id: <20250220081714.2676828-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnjX8O5bZnl9BpMw--.6425S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFykGF17tr1DXF4kAFWrKrg_yoW8JrWUpF
	ZIy348WFWUXF1fZ3s8Ja48XFyYka45WasrXF4xXwnrWFykA3WUW343JFy0vw4fZry8Ga4j
	qFykKrW3CFy5CrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE6pBsUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0gf5bme2z+Ai3QABsC

Add check for the return value of devm_kstrdup() in
loongson2_guts_probe() to catch potential exception.

Fixes: b82621ac8450 ("soc: loongson: add GUTS driver for loongson-2 platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- modify the check position. Thanks, Binbin!
- modify the title description.
---
 drivers/soc/loongson/loongson2_guts.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/loongson/loongson2_guts.c b/drivers/soc/loongson/loongson2_guts.c
index ae42e3a9127f..16913c3ef65c 100644
--- a/drivers/soc/loongson/loongson2_guts.c
+++ b/drivers/soc/loongson/loongson2_guts.c
@@ -114,8 +114,11 @@ static int loongson2_guts_probe(struct platform_device *pdev)
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
 	of_node_put(root);
-	if (machine)
+	if (machine) {
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		if (!soc_dev_attr.machine)
+			return -ENOMEM;
+	}
 
 	svr = loongson2_guts_get_svr();
 	soc_die = loongson2_soc_die_match(svr, loongson2_soc_die);
-- 
2.25.1


