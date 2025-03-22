Return-Path: <stable+bounces-125803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C66A6CA3D
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 14:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2C9482848
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98CB1FA164;
	Sat, 22 Mar 2025 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="L+3p6cJa"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD91DF26B
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649379; cv=none; b=kJo/xIwCMho+XcFdftL23OY4qVvlP8ZhuxMN42uNswv6fgUPZspf5prN1MSmvEY2ikENFEAoeuHHgGO/FCvX9j0CVRzbMXnna6RJNOxcZQFsVeQgyBVKoNoXL91hNnzstIPR8dCkn4dN/6VDV5XFuKqOQjf1N5EDw1b7RFBQ70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649379; c=relaxed/simple;
	bh=0m9TqFXfvPXrSoNM7TwFXNHjnozUNUhF6Sx9m/kLHr4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=r1xAzmvgpf1CW6a7h0I8ef1XMjVXhTZUDRsVbIEk3A0+qHc5iunU9LA4STk5NXLChpXJoq+E5I86WqlOuRI/K9Mh2j4Fw3cQGC6jiSwS+vg3vzh+7UoG1eVOJ+QmSPtHhQR5d5Lgm2+8FiH6PtDj3WOY/oS8MXxgYixI26C8rZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=L+3p6cJa; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1742649370;
	bh=uvnR+cSkNvxVtWAjYeZRzWL0evuLpodcYJIA7Risvz0=;
	h=From:To:Cc:Subject:Date;
	b=L+3p6cJa9xFsPslhEtl9PJ3DIo57Kz/gUCfQYm9YLVGkTqH2cYHp3LcEnmUCZULZs
	 0WJ3uM8QojyIXNb40fm+VwcpzVFQcshx4GTOk+dqC/15NTRqtC3UUHONIWMWX0Werr
	 M/PLr6Zdjvft7NzNYYrk4ECrc+mVZw6AC+4F/2do=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.128])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 278A8899; Sat, 22 Mar 2025 21:09:56 +0800
X-QQ-mid: xmsmtpt1742648996t1za7j7dk
Message-ID: <tencent_AEDE0F1C493C6B7F1C1E18D586255ACD9A07@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOc5DnyoKBNOmzfIqz+WNamUKhehHSl61x7V0aEzKNY3iWEpxerp
	 OMLJsB/oYuROlS8bV1Pyc282hbHKDT/q3KJNgRjIZlSTE7FJ9OTjBiyKUjFV+zoPIZLCy63oH2NV
	 UIVhPWFyy8HvYF0hZ5R8It1ikSFgq2lcLV4J1KM/ju96EA6wxXlWZPRNydo+CetExEHT1vvEbNKS
	 XZAOzXKunQ5/Ry7876DzsJUX7kNL8Iby40COb7gUrvio4EC1lXZm/6Bh8zQxRmSFO/tGx1W0wc4F
	 0ixHI0Dl95dGWyU4l1z5Ck/b6ZnyB9CM7AYopMDu50m2CLsWTaIp/Q1NPUGAkwQg6KOJ4qS7sd/L
	 n24Qi9kwe1IPHvKAW6UgyySYBmGBWcl5Ij8Mdy/go4GlWoJSkofS+LKGGKnciQIBJD4hJmplUf1A
	 VEJSj/AMJrzm12/+k6nnOKlO60eO0Z89ER+Qu+kham6ft21J85MQqqDcSCYCNpjyY+xGNtbeBdCb
	 yl7ElkdlDscn8Mtlh5tZTsLooE7dtAmpMDJVBxtolT6ug0UwgJ6KpsVND4x1HglG+2UrhZnt/MMy
	 11BIcJ8kKx/8hAGeRoAxuawKAGksjCAjjElXSz0OrOy28OdpoQZhguBzu2JQJyeF+T7Q9RyG/2Z2
	 yDZB4mM1NRkTIZ3xPCOiYm4sUKMjpm73cQlS/GhinYc3S4IyZBRg/7p9PP6LzRYpMxvPsUVoTX2N
	 AEcSnzVEqOUSoqzCX4wGnLjRXoP2kYIbt3AYjq1RfbJcJUJBz01J1hlrzyCohEfpdcz2+7ds94V9
	 FajT1dtdetQdj/Q0uhfU4hvHB0N/I1Xh/ek/HTx6/n/71eTBg9a+QcR7ZG5707OgOaJtKTYiZE2W
	 CcW2oQVXvHfQNRkWM8ZggjVerSrxXgZs3QyO5lkJO9/XxEGXfUOy7h7TK0MVMnUTCS8iodrvnCrw
	 IkIlmeMlfV8+/eDZKxonO3c+GG8K39/QDq4ldKSyM=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Vinod Koul <vkoul@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
Date: Sat, 22 Mar 2025 21:09:29 +0800
X-OQ-MSGID: <20250322130929.843-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 045a31b95509c8f25f5f04ec5e0dec5cd09f2c5f ]

callers of tegra_xusb_find_port_node() function only do NULL checking for
the return value. return NULL instead of ERR_PTR(-ENOMEM) to keep
consistent.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20211213020507.1458-1-linmq006@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/phy/tegra/xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index bf7706bf101a..be31b1e25b38 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -455,7 +455,7 @@ tegra_xusb_find_port_node(struct tegra_xusb_padctl *padctl, const char *type,
 	name = kasprintf(GFP_KERNEL, "%s-%u", type, index);
 	if (!name) {
 		of_node_put(ports);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 	np = of_get_child_by_name(ports, name);
 	kfree(name);
-- 
2.34.1


