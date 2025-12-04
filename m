Return-Path: <stable+bounces-200021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 740DFCA3CC3
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 14:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41330305FAAC
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E63340A7A;
	Thu,  4 Dec 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PONcNKLr"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF682E2EEE;
	Thu,  4 Dec 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854506; cv=none; b=kXH7GYhJwy7y6TgEa04MTkLeA4JqcDfUAACkBRZyQWvgug8hofMiZJebA6TLqgd+v7ZwCZ/+HfS8WggGLDMP3TMsWaW2ZAqqpZ3rwdTk9N9uM5+RAQghqQPLaMmKXMAHe8ljx9eqm/wD7wDzGDC1i1sUSCDroK7hWqpHNMGbQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854506; c=relaxed/simple;
	bh=bzz0Z6DlTyXiigHgemprkU5O2lR9T56OJSKOt035fi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JbS0jK6ZZxXVNsPLmrptvP+1DWPWst/HFkkHilSxf/JE6v1O2KEvIh/5iGlwsAYgkWQKPQ5je77VhdIWADvN25jPifrcK2W9Y2LCn/lLOwIe3OgaGM4lgFE7A21PkU+i4HQaBZjD1n9lffWrpMuzHIbFWVd69oRp/SzM8pH0hu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PONcNKLr; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lv
	Qc1rXcigKPfnEJkPS4F/wygNXYiWV4BtgNrmuO7Js=; b=PONcNKLroaPMptL7l1
	kUZXd0cMIMte7JJJ6H+gsKBVgKj89TPX4Mq1FsAsp1pE6vjWKltO3IigtkiNLeQV
	dofiQyf1Mx6YatZibECzeQjuHxyAk3e6uEeJaSU6HVFqfzFAVE2OtWKmth3s11QL
	M0EakpPgqdnDpxfCrWRBvEFxE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAHwWrbijFp3tKbDw--.62377S4;
	Thu, 04 Dec 2025 21:21:32 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: gregkh@linuxfoundation.org,
	haoxiang_li2024@163.com,
	kuninori.morimoto.gx@renesas.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: renesas_usbhs: Fix a resource leak in usbhs_pipe_malloc()
Date: Thu,  4 Dec 2025 21:21:29 +0800
Message-Id: <20251204132129.109234-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHwWrbijFp3tKbDw--.62377S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr47ZFy3CF1fJw45Cw17KFg_yoWDtrb_Cr
	1UArnrJr9rAryfKF1xJr43XFW09ws5XF1fGF1kKw4fAryj9rnF9wsFvFWrJr1UKF1IyrZ0
	yws7Ar97A34xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAAwIUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxR2A7mkxit2H5wAA3Z

usbhsp_get_pipe() set pipe's flags to IS_USED. In error paths,
usbhsp_put_pipe() is required to clear pipe's flags to prevent
pipe exhaustion.

Fixes: f1407d5c6624 ("usb: renesas_usbhs: Add Renesas USBHS common code")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/usb/renesas_usbhs/pipe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/pipe.c b/drivers/usb/renesas_usbhs/pipe.c
index 75fff2e4cbc6..56fc3ff5016f 100644
--- a/drivers/usb/renesas_usbhs/pipe.c
+++ b/drivers/usb/renesas_usbhs/pipe.c
@@ -713,11 +713,13 @@ struct usbhs_pipe *usbhs_pipe_malloc(struct usbhs_priv *priv,
 	/* make sure pipe is not busy */
 	ret = usbhsp_pipe_barrier(pipe);
 	if (ret < 0) {
+		usbhsp_put_pipe(pipe);
 		dev_err(dev, "pipe setup failed %d\n", usbhs_pipe_number(pipe));
 		return NULL;
 	}
 
 	if (usbhsp_setup_pipecfg(pipe, is_host, dir_in, &pipecfg)) {
+		usbhsp_put_pipe(pipe);
 		dev_err(dev, "can't setup pipe\n");
 		return NULL;
 	}
-- 
2.25.1


