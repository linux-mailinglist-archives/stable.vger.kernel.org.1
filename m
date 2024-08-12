Return-Path: <stable+bounces-66745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88A94F176
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B622827B5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11614F9F4;
	Mon, 12 Aug 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noxVX+S1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8D450F2;
	Mon, 12 Aug 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475726; cv=none; b=YtwK55XZhhN0WwKEQwmj/f6rLWNTAEjFH9ZuQe1Tx5H7nsk1EFbpsUKk4lY8+R41cQfXHrBJehPBe3lETI6krVjUcbOyq8D3GkszdcsfrOobCBP9X+h1Ve0/juIu2Ei3k9MuemhswupzhaVHPk7S6F5ax2RjaUcH0mo1Dc9CkW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475726; c=relaxed/simple;
	bh=kn457Ewsy8AA119t2bKO1YiwRsCbIJH8Cmg6w7Ro4ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=go+HYmSMj1SPxQUBKRatCgSK5rw+waz+2ZHu/K8IoDS6utySCBAE6zSA5hBmO3XVeUMnOmDGScwLVnhyV1gio0FYq3fdlO+m7uiYNNuYMBt3pP59IVAORSz0OJ2cWOn8fweVgvuv/+DgRTM3x1F+5FteHpAZ6BZPePbd/5jqvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noxVX+S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A31FC32782;
	Mon, 12 Aug 2024 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723475726;
	bh=kn457Ewsy8AA119t2bKO1YiwRsCbIJH8Cmg6w7Ro4ZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=noxVX+S1vESBSCamSwIfUVgUD+jXE1W64LmLKxoB9fCI3d7qBHLDBTAHEQC8wRXZb
	 wWJxzSQICfc7NxVt2zhAywINl6MrD3aoBfJBi/JieTeuIIkx1E7pnDOa3MJkmW8XPY
	 8iC2IVyCDcHkrdzmoVu0NNjFqhtNO9SJw58ewlvzk0NQ7tWXH1QsgKhreSxF6aeWrO
	 UDgkjIXS44h65K24dfV62fS7XlEWFHYQxz1IbXgtVjpSWcVpvw1mSAkldMJPShj1Wu
	 C092g7qyqw2Y7/2Iv5HaJ2Y4mMGsdPb0sIdwjlmHywEx9bHAB+Hb0ZAc1qP+hQE51k
	 MnKmH6EHcVQsQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Igor Pylypiv <ipylypiv@google.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	stable@vger.kernel.org,
	Stephan Eisvogel <eisvogel@seitics.de>,
	Christian Heusel <christian@heusel.eu>,
	linux-ide@vger.kernel.org
Subject: [PATCH] ata: libata-core: Return sense data in descriptor format by default
Date: Mon, 12 Aug 2024 17:15:18 +0200
Message-ID: <20240812151517.1162241-2-cassel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3233; i=cassel@kernel.org; h=from:subject; bh=kn457Ewsy8AA119t2bKO1YiwRsCbIJH8Cmg6w7Ro4ZQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJ2qbMG5307s731B+fnZO6oliOlPWolE5e7TJ19o7/c2 +8y02bOjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEyk9Cwjw23VPc//F92VWet9 6nhK0aF9pyInebvp5HzOyHry1KkklJHhv3/zyw2HPGb8bsmpE40tYdwlOu3mVpF9EzstXtrF//d cwAAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Sense data can be in either fixed format or descriptor format.

SAT-6 revision 1, 10.4.6 Control mode page, says that if the D_SENSE bit
is set to zero (i.e., fixed format sense data), then the SATL should
return fixed format sense data for ATA PASS-THROUGH commands.

A lot of user space programs incorrectly assume that the sense data is in
descriptor format, without checking the RESPONSE CODE field of the
returned sense data (to see which format the sense data is in).

The libata SATL has always kept D_SENSE set to zero by default.
(It is however possible to change the value using a MODE SELECT command.)

For failed ATA PASS-THROUGH commands, we correctly generated sense data
according to the D_SENSE bit. However, because of a bug, sense data for
successful ATA PASS-THROUGH commands was always generated in the
descriptor format.

This was fixed to consistently respect D_SENSE for both failed and
successful ATA PASS-THROUGH commands in commit 28ab9769117c ("ata:
libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error").

After commit 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for
CK_COND=1 and no error"), we started receiving bug reports that we broke
these user space programs (these user space programs must never have
encountered a failing command, as the sense data for failing commands has
always correctly respected D_SENSE, which by default meant fixed format).

Since a lot of user space programs seem to assume that the sense data is
in descriptor format (without checking the type), let's simply change the
default to have D_SENSE set to one by default.

That way:
-Broken user space programs will see no regression.
-Both failed and successful ATA PASS-THROUGH commands will respect D_SENSE,
 as per SAT-6 revision 1.
-Apparently it seems way more common for user space applications to assume
 that the sense data is in descriptor format, rather than fixed format.
 (A user space program should of course support both, and check the
 RESPONSE CODE field to see which format the returned sense data is in.)

Cc: stable@vger.kernel.org # 4.19+
Reported-by: Stephan Eisvogel <eisvogel@seitics.de>
Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://lore.kernel.org/linux-ide/0bf3f2f0-0fc6-4ba5-a420-c0874ef82d64@heusel.eu/
Fixes: 28ab9769117c ("ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c7752dc80028..590bebe1354d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5368,6 +5368,13 @@ void ata_dev_init(struct ata_device *dev)
 	 */
 	spin_lock_irqsave(ap->lock, flags);
 	dev->flags &= ~ATA_DFLAG_INIT_MASK;
+
+	/*
+	 * A lot of user space programs incorrectly assume that the sense data
+	 * is in descriptor format, without checking the RESPONSE CODE field of
+	 * the returned sense data (to see which format the sense data is in).
+	 */
+	dev->flags |= ATA_DFLAG_D_SENSE;
 	dev->horkage = 0;
 	spin_unlock_irqrestore(ap->lock, flags);
 
-- 
2.46.0


