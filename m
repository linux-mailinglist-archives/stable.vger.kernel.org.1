Return-Path: <stable+bounces-120044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973FFA4BAD4
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 10:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264783A7BF8
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 09:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53CD1EF0B6;
	Mon,  3 Mar 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e357nYO5"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67503EC4;
	Mon,  3 Mar 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994288; cv=none; b=NauoGjQwNunFwtpOdIOYCyJ0NsXVqqh4KeS4dZZk6XB3Ccj08p6TEJsPHj4pVLXU+BFcRhQULYhfGihbGyQoa1lybU6esIvvvMUGWyAFNvpbPwBx2fQ4fHlJgHTPkEUdWAfVVsbHRMWDcAYFf88MAbNAAIdrQDqLa5PmU4oRAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994288; c=relaxed/simple;
	bh=PRazXW/kbPHtowtTsKIzPmtMu8CfBctVKjuE3JfV5iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ljoNaCvtaddpnH3Y7Sb0zrnmebePO1gVzPvo3QJnOJVvbARdUGiCKQd1NOFPygNFiDqkpjtsK9FxAlRWzJwscQv1g/onltV4OxKW5mbbCiQljL4RGbY3Epbua3E2uiZEV1ExamW6S5VkdjKogyfJPZyaMHlgLvUoFIvumoP1W+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e357nYO5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB87E44188;
	Mon,  3 Mar 2025 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740994284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QbJppxNHduGQ+2DYZU3v7Z2KhYNzPxsOebdIfv4nVEc=;
	b=e357nYO5dtFfQG7Vc42IzmG9v6q4eS3fB5R79wwAjnafvXc+ejmJN6Pi7ccq0hMp6+AYpA
	Fe/YzVsng1md+nJBXjOi6dbfut2nTUbdhM8L1J+QmkFhsGmlUVkolug7YGEUO3bwcoYaqd
	cKrJ17lFXpZTcuxeNTtrIle/zYiAIuWgJT7wrDVQTtBStCnCbQFslUJh1wPE9YJ03YOeSD
	6KfbX7MTDwMU7EuceFctLzR8Q1zpZmyeWG0CBZCUimDLqhjNJGtXMsT1SZ6oVCY+GcqiRQ
	IjN9jOg/nxxjRmiM894LPrJcyXkUS+3QRf4hGZ6atNdKm6lc+9rURXZcekYKqA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 03 Mar 2025 10:30:51 +0100
Subject: [PATCH RESEND v2] drivers: core: fix device leak in
 __fw_devlink_relax_cycles()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-fix__fw_devlink_relax_cycles_missing_device_put-v2-1-3854d249d54e@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdeuleetffeutdfhvedvjeffuddtteejtdfhffdvhedvleevteekjeejgfejgfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghloheplgduledvrdduieekrddujeekrdejhegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehluhgtrgdrt
 ggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
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


