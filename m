Return-Path: <stable+bounces-54663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7390F5BE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 20:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E721C22722
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5772156F33;
	Wed, 19 Jun 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MTRYkW82"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF1156F25;
	Wed, 19 Jun 2024 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820573; cv=none; b=Yncbj20gCPg32S0ANr5ZmGLm4eyOrLiUcbIsfLHqcBn+4AS3e0IkPf894yxXceGY/3IVfn4nFZ86+BwT3JO8EN8isUF8E4n6lxFERFqqyv7wtSZ2TvBZvBugUl2H0QO0xxYG/vvLXR4kN5If4Iwj9mRs7DZ/5KdP+7eucWxXTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820573; c=relaxed/simple;
	bh=QHO0Hm4nz+6OoiwXV2uzE9uaNSgTeO8gsV8mNw2sQk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LrdwbegfAPBCFfmWPn5EIdLHvVCQkQ27TUHzXh2FYhOCmGNzO+bbW4LNOX+WcdXK+6x+bY8iQO4O1mcngg4w3Rr2+zrSOi0d77I4L7o9g9mU4Fq7so4f0v8j0nDaexYb7qsES9tDPjHIaQfGQzO/Uwn541uBlq+aUJAQRIkD66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MTRYkW82; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718820564;
	bh=QHO0Hm4nz+6OoiwXV2uzE9uaNSgTeO8gsV8mNw2sQk4=;
	h=From:Date:Subject:To:Cc:From;
	b=MTRYkW82y5wkJoPOHyrjlds/PhfImjdH1ETEttxKw8SfsmepeRiIY5HNlipumk9zY
	 EdZ9dFk8qxQ3BRqZyPs5xpQNuZKlqY5fPYjo+SjdIu4qH5Jmdub/RQnslLVgzCm0D3
	 0zhbpha2RJ8MevRm0izyGLiPRRlCkwcFGikNEBLo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 19 Jun 2024 20:09:00 +0200
Subject: [PATCH] nvmem: core: limit cell sysfs permissions to main
 attribute ones
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIALsec2YC/x3MQQqDMBBG4avIrDuQiEbaq5QuivmjA0kaMiAW8
 e4Gl9/ivYMUVaD06g6q2ETllxvso6N5/eYFLL6ZetMPxtkn5y0h8YwYWf8alAtqYju64GH8NDh
 DrS0VQfb7+/6c5wX4kgr2ZwAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718820563; l=1517;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QHO0Hm4nz+6OoiwXV2uzE9uaNSgTeO8gsV8mNw2sQk4=;
 b=fNS1904kAks/LUQ7nHftetqHDtevDkQPuOdFppCApZ+yXPGQD+SFj6QRWEASa81RN5HklfH/n
 VYzOjsWEZIsCa2zp79+sePRN8H8XYYrCRQ112NSsm8B+WAYRq35+ZVc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The cell sysfs attribute should not provide more access to the nvmem
data than the main attribute itself.
For example if nvme_config::root_only was set, the cell attribute
would still provide read access to everybody.

Mask out permissions not available on the main attribute.

Fixes: 0331c611949f ("nvmem: core: Expose cells through sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This was also discussed as part of
"[PATCH] nvmem: core: add sysfs cell write support" [0].
But there haven't been updates to that patch and this is arguably a
standalone bugfix.

[0] https://lore.kernel.org/lkml/20240223154129.1902905-1-m.felsch@pengutronix.de/
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e1ec3b7200d7..acfea1e56849 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -463,7 +463,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 						    "%s@%x,%x", entry->name,
 						    entry->offset,
 						    entry->bit_offset);
-		attrs[i].attr.mode = 0444;
+		attrs[i].attr.mode = 0444 & nvmem_bin_attr_get_umode(nvmem);
 		attrs[i].size = entry->bytes;
 		attrs[i].read = &nvmem_cell_attr_read;
 		attrs[i].private = entry;

---
base-commit: 92e5605a199efbaee59fb19e15d6cc2103a04ec2
change-id: 20240619-nvmem-cell-sysfs-perm-156fde0d7460

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


