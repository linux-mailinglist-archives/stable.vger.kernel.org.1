Return-Path: <stable+bounces-2135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140697F82ED
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423B51C245E3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8709F381BF;
	Fri, 24 Nov 2023 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yYPwlbnc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48708364AE;
	Fri, 24 Nov 2023 19:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A531CC433C7;
	Fri, 24 Nov 2023 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853135;
	bh=OJ64gvCh5CsxL0/DxUe1/fjMlvsQ5cLDWeY/q7kAWE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yYPwlbncyqF2auhThC6Ry3FpjUxZtontivi1h7wcxYLvnNzfAN8Q2y/F6WXv8bPs9
	 RJt9OriQi0b0IkfVS7/Iz9vu8g+zxjVB1T1hFMAT1JVA6ZX03wnkILkOBGWJoI6Ete
	 jxdNbyNKG1JBJhGX7BX6PFFDXRAdN0Nz0G/Kdk9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 067/297] i3c: master: mipi-i3c-hci: Fix a kernel panic for accessing DAT_data.
Date: Fri, 24 Nov 2023 17:51:49 +0000
Message-ID: <20231124172002.592788328@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Billy Tsai <billy_tsai@aspeedtech.com>

[ Upstream commit b53e9758a31c683fc8615df930262192ed5f034b ]

The `i3c_master_bus_init` function may attach the I2C devices before the
I3C bus initialization. In this flow, the DAT `alloc_entry`` will be used
before the DAT `init`. Additionally, if the `i3c_master_bus_init` fails,
the DAT `cleanup` will execute before the device is detached, which will
execue DAT `free_entry` function. The above scenario can cause the driver
to use DAT_data when it is NULL.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Link: https://lore.kernel.org/r/20231023080237.560936-1-billy_tsai@aspeedtech.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c | 29 ++++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
index 97bb49ff5b53b..47b9b4d4ed3fc 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
@@ -64,15 +64,17 @@ static int hci_dat_v1_init(struct i3c_hci *hci)
 		return -EOPNOTSUPP;
 	}
 
-	/* use a bitmap for faster free slot search */
-	hci->DAT_data = bitmap_zalloc(hci->DAT_entries, GFP_KERNEL);
-	if (!hci->DAT_data)
-		return -ENOMEM;
-
-	/* clear them */
-	for (dat_idx = 0; dat_idx < hci->DAT_entries; dat_idx++) {
-		dat_w0_write(dat_idx, 0);
-		dat_w1_write(dat_idx, 0);
+	if (!hci->DAT_data) {
+		/* use a bitmap for faster free slot search */
+		hci->DAT_data = bitmap_zalloc(hci->DAT_entries, GFP_KERNEL);
+		if (!hci->DAT_data)
+			return -ENOMEM;
+
+		/* clear them */
+		for (dat_idx = 0; dat_idx < hci->DAT_entries; dat_idx++) {
+			dat_w0_write(dat_idx, 0);
+			dat_w1_write(dat_idx, 0);
+		}
 	}
 
 	return 0;
@@ -87,7 +89,13 @@ static void hci_dat_v1_cleanup(struct i3c_hci *hci)
 static int hci_dat_v1_alloc_entry(struct i3c_hci *hci)
 {
 	unsigned int dat_idx;
+	int ret;
 
+	if (!hci->DAT_data) {
+		ret = hci_dat_v1_init(hci);
+		if (ret)
+			return ret;
+	}
 	dat_idx = find_first_zero_bit(hci->DAT_data, hci->DAT_entries);
 	if (dat_idx >= hci->DAT_entries)
 		return -ENOENT;
@@ -103,7 +111,8 @@ static void hci_dat_v1_free_entry(struct i3c_hci *hci, unsigned int dat_idx)
 {
 	dat_w0_write(dat_idx, 0);
 	dat_w1_write(dat_idx, 0);
-	__clear_bit(dat_idx, hci->DAT_data);
+	if (hci->DAT_data)
+		__clear_bit(dat_idx, hci->DAT_data);
 }
 
 static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
-- 
2.42.0




