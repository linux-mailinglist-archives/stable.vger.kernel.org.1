Return-Path: <stable+bounces-49322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68728FECCA
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CAD28281B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F21B29C7;
	Thu,  6 Jun 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u3RgtIC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD481B29C5;
	Thu,  6 Jun 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683409; cv=none; b=J3AGaA7JCKJu5JGunmcyWE8TAG+wdH8/p9vpvPQLYMnflaO5XaGvlbLmTkd8RkQ/srpSG39wqM+Y9Jr8JElDvEmzn5X9KUl7Cs1VOuXVF4M1sVoPMpAoflMIzeiHC7ifyLircL3s11kiHaCAoaFhZ5En7O8YQB4Po/7NQBqyyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683409; c=relaxed/simple;
	bh=44Zw2rUKsTqH4jJwpOIl51AkttAyR0COMs+IQvBqFj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0phZKtm1kGf3IPOvkeXLnWDDZRa+7cItO8mVBdInXxZD8s2dud+4mhT8KPcwtj4DwPXUjd5jWYYEP03BeqjiUO2iYo1c2MNQ6VDtx/ln4erLFy7wc5O1cECtvLG/ksioiHACz6LY4+gKQYMUcUZD0kx4iOZea1ba7RBEcqI4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u3RgtIC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372BDC2BD10;
	Thu,  6 Jun 2024 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683409;
	bh=44Zw2rUKsTqH4jJwpOIl51AkttAyR0COMs+IQvBqFj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3RgtIC0y7JF1CJL3zA/NlfPLW5DDFlYLgtTam+GVANiE20XM1oC3mB56GqJDvYP3
	 igZvIfHbmVRqlMRktxoYaXHeM6N3TSdt6TgcPRm+ZrAGEEYyk9agQ1yosGZLWTmYkS
	 ZBDfCdQuR3YfD3fDPgRnOyeYP/q86T7giXQKH13I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 292/473] serial: max3100: Fix bitwise types
Date: Thu,  6 Jun 2024 16:03:41 +0200
Message-ID: <20240606131709.535011579@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit e60955dbecb97f080848a57524827e2db29c70fd ]

Sparse is not happy about misuse of bitwise types:

  .../max3100.c:194:13: warning: incorrect type in assignment (different base types)
  .../max3100.c:194:13:    expected unsigned short [addressable] [usertype] etx
  .../max3100.c:194:13:    got restricted __be16 [usertype]
  .../max3100.c:202:15: warning: cast to restricted __be16

Fix this by choosing proper types for the respective variables.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240402195306.269276-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max3100.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index b71676e1f612f..5d8660fed081e 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -45,6 +45,9 @@
 #include <linux/freezer.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
 
 #include <linux/serial_max3100.h>
 
@@ -191,7 +194,7 @@ static void max3100_timeout(struct timer_list *t)
 static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 {
 	struct spi_message message;
-	u16 etx, erx;
+	__be16 etx, erx;
 	int status;
 	struct spi_transfer tran = {
 		.tx_buf = &etx,
-- 
2.43.0




