Return-Path: <stable+bounces-49643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A15768FEE40
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AC21F23C23
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B561A01CB;
	Thu,  6 Jun 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Br8+odDd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3D13B5B5;
	Thu,  6 Jun 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683637; cv=none; b=J8lzzvDV9NTSKoAGjys0IcSf6rMO6BeBBo1XaMYq3iq5Vim42PAHxqvctLDG+as0A5W89JXOC7qlkBP6lap9XUS2kejqmolVeoKllkxUa9TNbwn2ps9e6vEdbjUhQQgzH2bgFY1lS6hdJngb+QMng3onP8N/fn1H7m7OZvAkM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683637; c=relaxed/simple;
	bh=pveFQlVWUQ0RH3kXLZjRtBSla9xhJPjHstDPAyFyieA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciOSwkQyoef3JxQslY9MBDVE9hWg9HSwtuzWvyQYD2Q1tiCrJBp2/26Nfc7EVSrsB2I9QMGGv18Wuh1OjthjXBh2cKI/b3nVytJDMkLir5Snev6U0Ly5OwqpOR3VfY9KRj0F4CJB0ove8xd5FYzj1pZRFRVA5ZaS/BI/1Q9wNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Br8+odDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA3BC2BD10;
	Thu,  6 Jun 2024 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683637;
	bh=pveFQlVWUQ0RH3kXLZjRtBSla9xhJPjHstDPAyFyieA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Br8+odDd56sL3LSGOpHNeMmikCxXr5Kwt0IoJxTknX4U4pgyF7kaOpMhQQOQ0tVoq
	 taIt6BOQmPyaeuUliCX3zQHRfqn+uV+yWBSgkbC+5okuIDCh1sWJagohJD6xZHwVnO
	 8q4EKDLBBxwh6RMZBEi0hzqfRol+OH6xv7uZxSMw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huai-Yuan Liu <qq810974084@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 491/744] ppdev: Add an error check in register_device
Date: Thu,  6 Jun 2024 16:02:43 +0200
Message-ID: <20240606131748.188220626@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huai-Yuan Liu <qq810974084@gmail.com>

[ Upstream commit fbf740aeb86a4fe82ad158d26d711f2f3be79b3e ]

In register_device, the return value of ida_simple_get is unchecked,
in witch ida_simple_get will use an invalid index value.

To address this issue, index should be checked after ida_simple_get. When
the index value is abnormal, a warning message should be printed, the port
should be dropped, and the value should be recorded.

Fixes: 9a69645dde11 ("ppdev: fix registering same device name")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
Link: https://lore.kernel.org/r/20240412083840.234085-1-qq810974084@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ppdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index ee951b265213f..58e9dcc2a3087 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -296,28 +296,35 @@ static int register_device(int minor, struct pp_struct *pp)
 	if (!port) {
 		pr_warn("%s: no associated port!\n", name);
 		rc = -ENXIO;
-		goto err;
+		goto err_free_name;
 	}
 
 	index = ida_alloc(&ida_index, GFP_KERNEL);
+	if (index < 0) {
+		pr_warn("%s: failed to get index!\n", name);
+		rc = index;
+		goto err_put_port;
+	}
+
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
 	ppdev_cb.private = pp;
 	pdev = parport_register_dev_model(port, name, &ppdev_cb, index);
-	parport_put_port(port);
 
 	if (!pdev) {
 		pr_warn("%s: failed to register device!\n", name);
 		rc = -ENXIO;
 		ida_free(&ida_index, index);
-		goto err;
+		goto err_put_port;
 	}
 
 	pp->pdev = pdev;
 	pp->index = index;
 	dev_dbg(&pdev->dev, "registered pardevice\n");
-err:
+err_put_port:
+	parport_put_port(port);
+err_free_name:
 	kfree(name);
 	return rc;
 }
-- 
2.43.0




