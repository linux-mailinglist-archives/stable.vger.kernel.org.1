Return-Path: <stable+bounces-93006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EFE9C8BD9
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 14:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA31283046
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAACEEDE;
	Thu, 14 Nov 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b="GnJWUYsT"
X-Original-To: stable@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D727713;
	Thu, 14 Nov 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591034; cv=none; b=FC8Nb8c4P/3OMcGxN/ygjzgUw3cNElFYEpB2LkHvyH9HZNaVP38XoNCteZSEPt6mPi5x5Br48vYP+FwX3zjqJzmoXiz6uk+cfKyW9uqmN8ucPpwIr/tNW0mHh0A+1/XJy6Wd4KMdqkwxFw/LmgVrKe3qXKv4WiMdYm6hPG/OmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591034; c=relaxed/simple;
	bh=N+95SUPCDeVezjIvLmSRMt9xtKwLIEKIT8yHmoXsTwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s4AHGmKLanP5qObsZJEK6h4Th/TZI3icmKr/PLbMQ48Z1rXJiIihsaDO0HJip5vgC1fKh99OpFl42j3Be74THhHn7Yr4GHHoED/fdTkWuY3+8ITLLy0G41CKoY8tfq7cFf/Od1dyd1SdizYg6EEjBOCrctn2rmrWgIYsUaEuOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru; spf=pass smtp.mailfrom=itb.spb.ru; dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b=GnJWUYsT; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itb.spb.ru
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2e9d:0:640:5e79:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id EC13A46D7F;
	Thu, 14 Nov 2024 16:30:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5UMhj7SOkOs0-Qt1Ry5e6;
	Thu, 14 Nov 2024 16:30:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
	t=1731591015; bh=gZ0+WktCY4kae80cYlBSDWycDxoMAO9lo1JSMCTl8nY=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=GnJWUYsTIi2Ty+Ei1xGBklJLAaqMyxNKPCViRssH/3GGkgxcVMGTmU9ynFNKUTTPd
	 /YYkZHGFi9+S1sEhnOjMyjxh7EwlOqBcfxDagaD8T9gostyS9CWZonhTkvsAr+2ZxI
	 9KS27V6FZ30e2Q9nUseAOo1Bxrak0AhBuYAyX+Lo=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@itb.spb.ru
From: Ivan Stepchenko <sid@itb.spb.ru>
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Ivan Stepchenko <sid@itb.spb.ru>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] mtd: onenand: Fix uninitialized retlen in do_otp_read()
Date: Thu, 14 Nov 2024 16:29:51 +0300
Message-Id: <20241114132951.12810-1-sid@itb.spb.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function do_otp_read() does not set the output parameter *retlen,
which is expected to contain the number of bytes actually read.
As a result, in onenand_otp_walk(), the tmp_retlen variable remains
uninitialized after calling do_otp_walk() and used to change
the values of the buf, len and retlen variables.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 49dc08eeda70 ("[MTD] [OneNAND] fix numerous races")
Cc: stable@vger.kernel.org
Signed-off-by: Ivan Stepchenko <sid@itb.spb.ru>
---
 drivers/mtd/nand/onenand/onenand_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index f66385faf631..0dc2ea4fc857 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -2923,6 +2923,7 @@ static int do_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
 	ret = ONENAND_IS_4KB_PAGE(this) ?
 		onenand_mlc_read_ops_nolock(mtd, from, &ops) :
 		onenand_read_ops_nolock(mtd, from, &ops);
+	*retlen = ops.retlen;
 
 	/* Exit OTP access mode */
 	this->command(mtd, ONENAND_CMD_RESET, 0, 0);
-- 
2.34.1


