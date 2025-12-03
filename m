Return-Path: <stable+bounces-199202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AEACA0021
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A02343018771
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009BD33890D;
	Wed,  3 Dec 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQOj0MTd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDD3277B8;
	Wed,  3 Dec 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779025; cv=none; b=iGvRY7jAsIu8+PUrnln4+XNuMUi2g172q7Wdml75fyZ3jL0sAB90LF0bkTg4ugsYhmxE+N1Th6vnNXodo2vIbGweuKrz6jM6Q0MXDDSDLXFmaS1P4+umjVvCbIyJGvINvTx9habx7YzboflipcB2th16jmK/CSrXpdDW36dlyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779025; c=relaxed/simple;
	bh=SUs4FYnKfmbcsv8Qrhc5XvdQhwqSBS/rVV7P1rPnUXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usJq5A8tvOlBZ1JZo5JxPYvwIyk+E2MhqPDCCFS910hq/g2MB0n14VNEGgg4R4aBXH1fzxR2KtK/awlp3LJC5NHnnW4h5qmY0Gnja2XF0MKSAA4JVBt6kFc6XpVRorAR+9EmA+YCB/E165vIbT41qZL9Ao+o7g6IEkhJYTm3HLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQOj0MTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1670CC16AAE;
	Wed,  3 Dec 2025 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779025;
	bh=SUs4FYnKfmbcsv8Qrhc5XvdQhwqSBS/rVV7P1rPnUXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQOj0MTdYVUW53yoGxexCnDPbQ27/Ggmlk2Lj+gpIcw7VPYRgXLSqrJDFyENB6CIY
	 yXOp8TU6ILm5SdxkqeHDRosOa6TmLst7U+Z1f2HmhlgcPuzk/HPs4GeoHpKFTQomnY
	 48ad0U1STwU2lEMQSB3STCKmNaP9GzTPiMgTyQNM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 131/568] mfd: madera: Work around false-positive -Wininitialized warning
Date: Wed,  3 Dec 2025 16:22:13 +0100
Message-ID: <20251203152445.526800731@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 364752aa0c6ab0a06a2d5bfdb362c1ca407f1a30 ]

clang-21 warns about one uninitialized variable getting dereferenced
in madera_dev_init:

drivers/mfd/madera-core.c:739:10: error: variable 'mfd_devs' is uninitialized when used here [-Werror,-Wuninitialized]
  739 |                               mfd_devs, n_devs,
      |                               ^~~~~~~~
drivers/mfd/madera-core.c:459:33: note: initialize the variable 'mfd_devs' to silence this warning
  459 |         const struct mfd_cell *mfd_devs;
      |                                        ^
      |                                         = NULL

The code is actually correct here because n_devs is only nonzero
when mfd_devs is a valid pointer, but this is impossible for the
compiler to see reliably.

Change the logic to check for the pointer as well, to make this easier
for the compiler to follow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20250807071932.4085458-1-arnd@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/madera-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index a2abc0094def7..87797d77c9f0c 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -457,7 +457,7 @@ int madera_dev_init(struct madera *madera)
 	struct device *dev = madera->dev;
 	unsigned int hwid;
 	int (*patch_fn)(struct madera *) = NULL;
-	const struct mfd_cell *mfd_devs;
+	const struct mfd_cell *mfd_devs = NULL;
 	int n_devs = 0;
 	int i, ret;
 
@@ -671,7 +671,7 @@ int madera_dev_init(struct madera *madera)
 		goto err_reset;
 	}
 
-	if (!n_devs) {
+	if (!n_devs || !mfd_devs) {
 		dev_err(madera->dev, "Device ID 0x%x not a %s\n", hwid,
 			madera->type_name);
 		ret = -ENODEV;
-- 
2.51.0




