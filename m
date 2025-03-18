Return-Path: <stable+bounces-124759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C5A666B4
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 04:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2C47A4B88
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 03:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3818BB8E;
	Tue, 18 Mar 2025 03:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jbT7LfI6"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B44157487;
	Tue, 18 Mar 2025 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267227; cv=none; b=shvBpK61GpHlGcLadnmdITtk8La1BFhsd1IPZCO3NhAFaa/H/Qghbb5IAjMAS2av7fqyflvP83+LxYexqOJIT4sHArcirlQW1Qho+H4Z991EjpY3zSLMqAo0ulF1MD6H8o7Q+v2ekSkRdq8ElWfpXV2DdCgfKUiY1jIimurcjFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267227; c=relaxed/simple;
	bh=YGsuhljqccKPHTYpawWHibXzqUjkIgNy6z/pL7cScYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p7+yswQKjXpAibaAlHkL+t9ror4b8ZUd2WDrsvcAytLG/RPvTLMprJG0zqJrSfUs7WxgEi4cA2G7zgVzK9B/8ggvxZOj3BmxhVdEK8ktxQ6hOTOwUVWjUJhkKqzwq0SJLCMdSXe7TDapGe2fPf8k0aRJtj+0Dek5jQmiYVFYIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jbT7LfI6; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JBeRk
	4co3+uSwf3WyPiW0R5ciRcTZIeouYHkX7tcL/M=; b=jbT7LfI6YLXA/yB/bquep
	MIveH48+rPGOj40pF0za/gsvuHmtcpGvxupndfQDTs+cbfez/cg802SfIcC5D4uD
	BBtqGNhVODF8aQuPzHOnzIYc95vNRJiWNIOUs/y1PKfn/+ANJ1r/sQKdkkQQMPg9
	2DWal+EpPiEWpRyqorrdG8=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXnt8_49hnT9OMAA--.10535S4;
	Tue, 18 Mar 2025 11:06:40 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] agp: Fix a potential memory leak bug in agp_amdk7_probe()
Date: Tue, 18 Mar 2025 11:06:37 +0800
Message-Id: <20250318030637.1572350-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXnt8_49hnT9OMAA--.10535S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4DCF47tFyktw17JF17trb_yoWDXFb_G3
	yUAr9293s5AFW8ur1akw4F9rWF9a1rXryku3ZFgwnxAFy3Zr4xXanrWFs5WF17ursrCFy7
	t34DXr4Uuw1IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWlkxJUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqAETbmfX849cAgADsF

Variable "bridge" is allocated by agp_alloc_bridge() and
have to be released by agp_put_bridge() if something goes
wrong. In this patch, add the missing call of agp_put_bridge()
in agp_amdk7_probe() to prevent potential memory leak bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/char/agp/amd-k7-agp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 795c8c9ff680..40e1fc462dca 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -441,6 +441,7 @@ static int agp_amdk7_probe(struct pci_dev *pdev,
 			gfxcard = pci_get_class(PCI_CLASS_DISPLAY_VGA<<8, gfxcard);
 			if (!gfxcard) {
 				dev_info(&pdev->dev, "no AGP VGA controller\n");
+				agp_put_bridge(bridge);
 				return -ENODEV;
 			}
 			cap_ptr = pci_find_capability(gfxcard, PCI_CAP_ID_AGP);
-- 
2.25.1


