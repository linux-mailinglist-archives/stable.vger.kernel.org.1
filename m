Return-Path: <stable+bounces-228183-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKtHL6BJwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228183-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:09:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A39C2F3E8F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72AD7306114F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B13B8D75;
	Mon, 23 Mar 2026 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rVUj8JSD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE7B3B27F3;
	Mon, 23 Mar 2026 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274380; cv=none; b=b+gagN6zQe2vhkzAhoXC2dqpCZpjGwn6ntdVyAKVNeRq9lMpH9kK2PWKYj4E+6Sl8nrvgK2b0b6YWggv+Kl2/sMsQhpu6vJpBzhqnHzXVlNrJnDdq6fPVxsuMesGS6gVu/V/d8MWUf7/IyU9bVE/400M7N8nhgZIZJzwQnCc5D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274380; c=relaxed/simple;
	bh=oXa3S/dT7fjmkXwBD9syIFAIjCSbcKB13H83+p6bHT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/v4TxVh22KsFat3vKbotuUK3/JVDqHq5X4l9YVtTK6gug9mAwQ6Q2JiQvBlAS+SaggGhmgmrOnff8dRBPWz3mamEA4Her9R2u2R03ttkM17jXZlCaRsY6a6BjbsZp12l6aHcgRqYGbvRKs8t8/04WCJKgN9IckZS9bAnqr874A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rVUj8JSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CAFC2BCB1;
	Mon, 23 Mar 2026 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274380;
	bh=oXa3S/dT7fjmkXwBD9syIFAIjCSbcKB13H83+p6bHT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVUj8JSDOU1xtiUmnEXs9RLTzd2RJThk++9NLYrGIfvNsdMo8eZLS1bEj8DpWHO03
	 jElGeUtqQ8qDjzcIS/HC4FJZPD9KyASrp7TpX8VsWefQkGfpkIT3v6WCmaqLk4x4ki
	 asTHh7SLZHbf+lGcrMi3ufsrqs7QvzsbnerSsH9E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 198/220] mtd: rawnand: serialize lock/unlock against other NAND operations
Date: Mon, 23 Mar 2026 14:46:15 +0100
Message-ID: <20260323134510.841251881@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228183-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4A39C2F3E8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kamal.dasu@broadcom.com>

[ Upstream commit bab2bc6e850a697a23b9e5f0e21bb8c187615e95 ]

nand_lock() and nand_unlock() call into chip->ops.lock_area/unlock_area
without holding the NAND device lock. On controllers that implement
SET_FEATURES via multiple low-level PIO commands, these can race with
concurrent UBI/UBIFS background erase/write operations that hold the
device lock, resulting in cmd_pending conflicts on the NAND controller.

Add nand_get_device()/nand_release_device() around the lock/unlock
operations to serialize them against all other NAND controller access.

Fixes: 92270086b7e5 ("mtd: rawnand: Add support for manufacturer specific lock/unlock operation")
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: William Zhang <william.zhang@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/nand_base.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f2322de93ab41..19e3bbf42931d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4737,11 +4737,16 @@ static void nand_shutdown(struct mtd_info *mtd)
 static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
 
 	if (!chip->ops.lock_area)
 		return -ENOTSUPP;
 
-	return chip->ops.lock_area(chip, ofs, len);
+	nand_get_device(chip);
+	ret = chip->ops.lock_area(chip, ofs, len);
+	nand_release_device(chip);
+
+	return ret;
 }
 
 /**
@@ -4753,11 +4758,16 @@ static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 static int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	int ret;
 
 	if (!chip->ops.unlock_area)
 		return -ENOTSUPP;
 
-	return chip->ops.unlock_area(chip, ofs, len);
+	nand_get_device(chip);
+	ret = chip->ops.unlock_area(chip, ofs, len);
+	nand_release_device(chip);
+
+	return ret;
 }
 
 /* Set default functions */
-- 
2.51.0




