Return-Path: <stable+bounces-119653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C05A45B6B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B490188A96F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B224DFEB;
	Wed, 26 Feb 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S+MHqDdN"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E05F226D02;
	Wed, 26 Feb 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564813; cv=none; b=hcftKkIxgNuq/k2c3C7fn+Td4PEb9EPd8+LHiBKHWcnikRwTebXCVQXkxHBo2tXdNcIl6VZL/jYv1ip64wEq9iLOjE/x7xgQ5gb96UFf0vpT1ajoI78efYjX0aLMJLQZLbi9lnznQRAHJagpYm5YkPxYZ9ZSLRHOG1GtkYOt1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564813; c=relaxed/simple;
	bh=wX6dPQiYKQr65TtTejA4CV3J0CpQjoNYdCwxgXtX9lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W+ZzwWONlKU/s/7k/snzqmWgT2JdGpMHJ66iEMFw4SbS5P6LaNpqtE+SxjcHb3cy6IYzNq+wZTdCWsJAWJvcYdIxKUB53zeCxZYUKnTGfOpswBnVVnJYkvgSBbGu9g5AJZ3R5wOoKMnWDsEVnjvrX5K6hSzELb+JGGp5vrtMGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S+MHqDdN; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CbQtw
	XuFlmtrkGlidPFjKUyUoT7NfEQyjqPCU9PcbW4=; b=S+MHqDdNo8tNjl0Tk3ECj
	UaoradQplO9Owt4n8BkgmMx/NtMU8uowdGH0uViQyZ45b8z/4SoOCDNKzlJgu/Fe
	7/OtLI/7AuXraEg6AgTsdsW58SeihKFcoW/MUwp7yk5Y5RkOtqxQlrMZWXmuRvVn
	lQeA8+ON/1K6I1LJFglFhk=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn70UA6b5nShOUOw--.3815S4;
	Wed, 26 Feb 2025 18:12:17 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andy@kernel.org,
	geert@linux-m68k.org,
	u.kleine-koenig@pengutronix.de,
	erick.archer@outlook.com,
	haoxiang_li2024@163.com,
	ojeda@kernel.org,
	w@1wt.eu,
	poeschel@lemonage.de
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] auxdisplay: hd44780: Fix a potential memory leak in hd44780.c
Date: Wed, 26 Feb 2025 18:12:13 +0800
Message-Id: <20250226101213.3593835-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn70UA6b5nShOUOw--.3815S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyxKr1UGr4xWF1UAFykuFg_yoW8Ar1xpF
	srWa4Fka18JF1vga4DGw1xXFyYkan7A34jgr9Fk3sa9ry3JFWIy34Yyryq9w47WrWfG3WY
	v3W2vrWSyFsrAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pimhF7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0hb9bme8gkvYZQADs7

At the 'fail2' label in hd44780_probe(), the 'lcd' variable is
freed via kfree(), but this does not actually release the memory
allocated by charlcd_alloc(), as that memory is a container for lcd.
As a result, a memory leak occurs. Replace kfree() with charlcd_free()
to fix a potential memory leak.
Same replacement is done in hd44780_remove().

Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v3:
- modify the patch description.
Thanks for the review! I think Fixes-tag should be added because
the previous version causes a memory leak. I modified the patch
description to illustrate it. Thanks again!
Changes in v2:
- Merge the two patches into one.
- Modify the patch description.
Sorry Geert, I didn't see your reply until after I sent the
second patch. I've merged the two patches into one, hoping
to make your work a bit easier! Thanks a lot!
---
 drivers/auxdisplay/hd44780.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 0526f0d90a79..9d0ae9c02e9b 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -313,7 +313,7 @@ static int hd44780_probe(struct platform_device *pdev)
 fail3:
 	kfree(hd);
 fail2:
-	kfree(lcd);
+	charlcd_free(lcd);
 fail1:
 	kfree(hdc);
 	return ret;
@@ -328,7 +328,7 @@ static void hd44780_remove(struct platform_device *pdev)
 	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
-	kfree(lcd);
+	charlcd_free(lcd);
 }
 
 static const struct of_device_id hd44780_of_match[] = {
-- 
2.25.1


