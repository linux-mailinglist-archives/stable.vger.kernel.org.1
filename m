Return-Path: <stable+bounces-127332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E3A77C3F
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15AC16A67D
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEEA204592;
	Tue,  1 Apr 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hnz0mJo/"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B2203712;
	Tue,  1 Apr 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514609; cv=none; b=gelPTzIPLB24vDEe9Hmqhct2q6/CRlju9BUamrC0NXLLOiv8/KvYZmNCPjHWgQNojIoDRc08JO3j7uWY5rzuh38Ql+sqSQfzKCzsvjXxF9cohMvmO3Yv4hkoFJvEypNV80mbd12LAh/8apew9ASKBDg75y2OtiyHSlThjZ4kIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514609; c=relaxed/simple;
	bh=0QQv84WvRKICQ8s2yWYlDhCq2ZcAAWm+Hges6yoMfKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUF5sc2HQ78b9Aez/vxAq63VgH6xI4BXwuY78Yi45k9fZ1/hRVXo6upILZefYxSdvATsY0y03heO+MqxNhs9g3fMtLGhcssKEeES9+asg6R8UKOQcLtXlvw7ofVFtnr+0yVuoWcUEge8QBEQ/CL7/HYSWy5+BDdtcxVGA59Chxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hnz0mJo/; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7ADF442E0;
	Tue,  1 Apr 2025 13:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743514605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G2Qh5l+gyOSzaVUsPnabujSE4kp0M+Vr17QUqK8IMGo=;
	b=hnz0mJo/FtIuiTNZ17CpcKyWM2FhblLFMK+45rDewbz8BbFWIwv8s1qZ+3EPC0scP/O5hn
	QS84C8zf56ouOgI4zlSLDcw7WxHMPntOkmrqBaHJkomASPBwWlCfTO+og0I5fH3bQn0yNz
	eOQ+mx204PtGiZy8L8y3rXIVaw9yQAUiOca/dpCN42P+KVYSkQ1Jkz96vs056aGj7xL5m5
	T+EllEztzlrwhY4NREW3J85uWfEs0ZzFCWOyTm05gYfVviCg0p2AmM4fUsh9/gnQa0waqZ
	B7THuwJgijtQQlWJZYJLZXihmgGQoEsb9c8iG2FxZzO76ecPXOKVLZ76S9f4eQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <michael@walle.cc>,
	<linux-mtd@lists.infradead.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	<linux-kernel@vger.kernel.org>,
	Steam Lin <stlin2@winbond.com>,
	Jean Delvare <jdelvare@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: spinand: Fix build with gcc < 7.5
Date: Tue,  1 Apr 2025 15:36:37 +0200
Message-ID: <20250401133637.219618-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueeileelteeggffhfeevhfeihfeffedvtddvgfelvdejleejveelueeggeevleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledvrddukeegrdduuddtrdduleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleefpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepthhuughorhdrrghmsggrrhhusheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhrrghthihushhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghls
 eifrghllhgvrdgttgdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

__VA_OPT__ is a macro that is useful when some arguments can be present
or not to entirely skip some part of a definition. Unfortunately, it
is a too recent addition that some of the still supported old GCC
versions do not know about, and is anyway not part of C11 that is the
version used in the kernel.

Find a trick to remove this macro, typically '__VA_ARGS__ + 0' is a
workaround used in netlink.h which works very well here, as we either
expect:
- 0
- A positive value
- No value, which means the field should be 0.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503181330.YcDXGy7F-lkp@intel.com/
Fixes: 7ce0d16d5802 ("mtd: spinand: Add an optional frequency to read from cache macros")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/spinand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 83301ef11aa9..0bb06aeffa62 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -67,7 +67,7 @@
 		   SPI_MEM_OP_ADDR(2, addr, 1),				\
 		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
 		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
-		   __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
+		   SPI_MEM_OP_MAX_FREQ(__VA_ARGS__ + 0))
 
 #define SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(addr, ndummy, buf, len) \
 	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
-- 
2.48.1


