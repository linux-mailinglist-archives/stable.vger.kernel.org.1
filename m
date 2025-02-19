Return-Path: <stable+bounces-116949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B3A3AF96
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 03:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E636B7A32A7
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 02:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C392A170A11;
	Wed, 19 Feb 2025 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PHNDyjnd"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217F75809;
	Wed, 19 Feb 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932107; cv=none; b=tKWCbgt1jcziIUcdT8Az1Fdjq6/vyxaAFGSzqUtcEgxFuBhBl9kw7xk6Kwz9OvL3NXApEMHY7WQElfsasqMwSNO9GFPhC3UXRk0lLnS4/0m4XxNGEDyBjXV+6edkidJrOlRC6ZxOQ6iaC0/MYIfA5pIdrcwekKCVvjOSoK61GS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932107; c=relaxed/simple;
	bh=x3wgYhUEHOmTFdi4Hi55oiZkM96y7Ebn0iiO+1hPLuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pYMPbQiX9+KF6it/Fmi4rIi9Vt+6dcVVn/JUbTfmaASkDVcSOxrgLqMQc6r4z60kze6J1PPwNwx5gGsn8NnNWltgMKHYqn9AutmAQ1I9R7FlPXE4Wfw6R9gUu6yUIMwSwYlyuN2Hyl1+eQ1+4UYn/iN1FY5wTRF6JeM9zH9qUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PHNDyjnd; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pBo7j
	VQRivz/W0NAO7F9WDyk65URdq4LaTmV4fZDwVs=; b=PHNDyjndKXmYGNLQsejRZ
	R+klePIrybvIWqxdDoaDgeJUq9xi1WqPnexEfAdDHCK5sS8fowJEbNhIHatSATzv
	1snLX1whBPFJW4AUTuKmKlaCmAc6hhgtcf6FwQ3EGyTGPJnt1OZztZ4Ax+Dy4VlM
	XeXSK6ylW6Kt/WtL2/PLXk=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBXuRirQbVnzi3zNA--.11732S4;
	Wed, 19 Feb 2025 10:27:56 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: jassisinghbrar@gmail.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	brgl@bgdev.pl
Cc: linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] mailbox: tegra-hsp: Add check for devm_kstrdup_const()
Date: Wed, 19 Feb 2025 10:27:53 +0800
Message-Id: <20250219022753.2589753-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXuRirQbVnzi3zNA--.11732S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF15uw47tw1xXFWDGFW7urg_yoW3Kwc_Ca
	15XFyrJrWUArWF9wn0ya4IvryIgw15WFyv934Dtrs3W34UXF12qry5Zrs09rWkuayDAa4D
	u3Z8Xr4kXr9xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZ8n53UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkA-4bme1QKQhPwAAsh

Add check for the return value of devm_kstrdup_const() in
tegra_hsp_doorbell_create() to catch potential exception.

Fixes: a54d03ed01b4 ("mailbox: tegra-hsp: use devm_kstrdup_const()")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/mailbox/tegra-hsp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index c1981f091bd1..773a1cf6d93d 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -285,6 +285,8 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 	db->channel.hsp = hsp;
 
 	db->name = devm_kstrdup_const(hsp->dev, name, GFP_KERNEL);
+	if (!db->name)
+		return ERR_PTR(-ENOMEM);
 	db->master = master;
 	db->index = index;
 
-- 
2.25.1


