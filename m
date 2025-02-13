Return-Path: <stable+bounces-115151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD8BA34159
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9897A1116
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261342222DC;
	Thu, 13 Feb 2025 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SuyrXBDN"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC6171E43;
	Thu, 13 Feb 2025 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455532; cv=none; b=fDKf9aZTLBorWmnElFM/wdTDA6IKr+618wmExj7E4Ev/rjmImZ5Vxi96dEFoT1aDMa4/ALLzxS5HmAXM2+5yzM7cRIXRJVhacWkXS9i8oBoLUKSZUxYIHGnA6XAySGOG33KSrv8s4e8HU9cr5JtLUqasOekTc1h1DdYpey/c3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455532; c=relaxed/simple;
	bh=PRazXW/kbPHtowtTsKIzPmtMu8CfBctVKjuE3JfV5iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bJ77aykb7eA2y0VJW8W/UGpsfiFmULChJO3PlkUM+Rk178SzBUORFWJNu0K7lCrHbeAQSWQQxr0fanVbF77u6/a+YKF3U4E4Cbz0Twq1X72khNZiXALKqx6P9qNQTT9MmzGv3V9oFX/nUuwNQjc0jFRpVO+WJRxoz9TWpMeZhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SuyrXBDN; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 948F843204;
	Thu, 13 Feb 2025 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739455529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QbJppxNHduGQ+2DYZU3v7Z2KhYNzPxsOebdIfv4nVEc=;
	b=SuyrXBDNecXS47sD8IFsPb+riIglTpi2/yxQkA7eOjkqxW0B3pDgEsWTjKJe3HpudsEKo1
	rfUHpHNmO25L03hruzfpEYpHQo3LyXgsLW1jmUF6SwdYQ8MpuwWZcW82VOkJuQAouvXGPW
	qGrboTeu68aJkRs2n/mFAlMXBjN3xwhsLRrQuXqy1n+/cs/Geg6VDEY8Nl/+GezELbs4oe
	YhBac8FecgPNr+UuZCnAM4et34GPlZ8gboel4wvEOeaI3FN9aJDhJN2yQBaU8W/MfnTxid
	UKk+Wg0YCbdkY6kSgL4wZGkV+Zd4UrDWhvnHDjMRa1O/IXAe5AZmNEciEaMzrQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 13 Feb 2025 15:05:13 +0100
Subject: [PATCH v2] drivers: core: fix device leak in
 __fw_devlink_relax_cycles()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-fix__fw_devlink_relax_cycles_missing_device_put-v2-1-8cd3b03e6a3f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABj8rWcC/52OTQ6DIBCFr2JYl0aoBtNV79EYQsdRJ1UwYKnGe
 PeiR+jyey/vZ2MBPWFg92xjHiMFcjaBvGQMemM75NQkZjKXZS6F5C0tWrdf3WAcyL61x8EsGlY
 YMOiRQiDbHSYB6ukz85sCg2VbGAM5S62Tx1RxLj7rxD2F2fn1PBDFof6/FQUXvBCVqEA1Skn5e
 Dk3p+gV3Mjqfd9/c5/VnvAAAAA=
X-Change-ID: 20250212-fix__fw_devlink_relax_cycles_missing_device_put-37cae5f4aac0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdeuleetffeutdfhvedvjeffuddtteejtdfhffdvhedvleevteekjeejgfejgfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdduudekngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoo
 hhglhgvrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Commit bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize
cycle detection logic") introduced a new struct device *con_dev and a
get_dev_from_fwnode() call to get it, but without adding a corresponding
put_device().

Closes: https://lore.kernel.org/all/20241204124826.2e055091@booty/
Fixes: bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize cycle detection logic")
Cc: stable@vger.kernel.org
Reviewed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v2:
- add 'Cc: stable@vger.kernel.org'
- use Closes: tag, not Link:
- Link to v1: https://lore.kernel.org/r/20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com
---
 drivers/base/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5a1f051981149dc5b5eee4fb69c0ab748a85956d..2fde698430dff98b5e30f7be7d43d310289c4217 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2079,6 +2079,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 out:
 	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
 	put_device(sup_dev);
+	put_device(con_dev);
 	put_device(par_dev);
 	return ret;
 }

---
base-commit: 09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
change-id: 20250212-fix__fw_devlink_relax_cycles_missing_device_put-37cae5f4aac0

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


