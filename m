Return-Path: <stable+bounces-118726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8AA41A9B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5085188FB30
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E786E24BC11;
	Mon, 24 Feb 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TIj9PGJi"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D661A0BCD;
	Mon, 24 Feb 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392202; cv=none; b=l2ny6jLHLIlVam2gw2I31afypjxLqL3/tDybE8OANnHau5gCyleNuApVwYvtmE0GXu5BoJvLGH+qvJ7PsaPidhwmBqtgldYUXIiIY4Stmn6YFsQYnd1KiMckNfJ9TFR78MUGEEe8MDP/kHRL7m160rCaUnzrrLWYd34TCIanlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392202; c=relaxed/simple;
	bh=bmzP7DZYL5PU6Z8gYL3j8sFt9WnzcGSW4w4BWbHWCNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tqUebHw80yo9Cb7EDWRXjoelum0YDGJx/3jH6n1Qv8ntw6YRwwhDVFaxvL6HaREyuL3TbXSE+Uf4cURNgg1+TOCXDMZqiJwd8RUYdLuNvaVW8NfmOduC0VLq+s2QLfPH2xrqejmqVRYrbBcvPsnpmx5LmPT03yYaZFlZm90ITbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TIj9PGJi; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2oNUH
	JB8g4nEbc2gNF1Ap4/gs+R1vgOD/JaR77WeBAY=; b=TIj9PGJifE7aVbz93cRvx
	Ts90s4p4h6HSqsagsDQqZprmZ4Eu39a70Jw2Y7M+NjImctrmzZ29Gmup8PIzgk94
	pkUWl6ZzDXj+mBZQ6wf83xzfO5bmsrgxTfFTOJojIyHkqRwJ9OdTidMIvJnZ4gUk
	zkEYYw6CnMGS1jdx+QyQ7c=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHzCnBRrxnlq0pOQ--.38564S4;
	Mon, 24 Feb 2025 18:15:30 +0800 (CST)
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
Subject: [PATCH v2] auxdisplay: hd44780: Fix an API misuse in hd44780.c
Date: Mon, 24 Feb 2025 18:15:27 +0800
Message-Id: <20250224101527.2971012-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzCnBRrxnlq0pOQ--.38564S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4xWFW3Jr4fKF1fXw4ktFb_yoW8JFy8pF
	srWayFka18JF1UWa4DKw1xXFy5G398Aa4q9ry2k3s3ury5JF97tw15AryjgrsIgFyfW3W2
	qFnFqrWIyFs7AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREoGPUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0gn9bme8PuRYhAADsW

Variable allocated by charlcd_alloc() should be released
by charlcd_free(). The following patch changed kfree() to
charlcd_free() to fix an API misuse.

Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
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


