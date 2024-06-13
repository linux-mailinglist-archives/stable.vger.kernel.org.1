Return-Path: <stable+bounces-50566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B74BA906B45
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D201C248B1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB1DDB1;
	Thu, 13 Jun 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2ULwFtFq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23151428FC;
	Thu, 13 Jun 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278739; cv=none; b=nDoALqQ0V0Rgxkksu0GKhtBvByo1zc01NIiOsEQO3JRlxX6b8VyfEPRW9mOVxT2+8dg6jaxjn4IL6FN4eKRfhpq97+6HuECyCUqNJL9ufxwVrPaTy4HF4/r/nsdSzGUpItvXuEzeg6EeoxfLtAD5mQlVlOPQRcm0m75v6KfQ2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278739; c=relaxed/simple;
	bh=VBo6xwlPwOc9TaNPXwCzCJetqt8GgQrwhha0pqniKbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8eF+XmSJtY55tR9mvuhyjJwftKtwMt9/85YD8RPSqlH7T2pPCeO7g9ZP5ZFRRMFaz6aWND+8UG4pkVajyYH3aHXosBjLcX/pGhx+4Zz5/eEVUtfuZSHj82wzG854TrSK+OFFExrcbUbuVLvsqoCUDHBn7pFyyQWDlWFnbw4bAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2ULwFtFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B477C2BBFC;
	Thu, 13 Jun 2024 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278739;
	bh=VBo6xwlPwOc9TaNPXwCzCJetqt8GgQrwhha0pqniKbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2ULwFtFqCcd2P7xW699JwsLTgzwJNQLBxPCqJCAHsfFfw146rUdGBr3M9eDagjNlo
	 FlxTVvGCA6l1tnrC2SpkM/AuqVdoAMIpmooC/1sJW5XXTGhumhj1ekTfKxaK+r6aC4
	 U7aw2gTzzj4izqsgFzKQTXZIS6PJ2QIzTraU+oC8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Finn Thain <fthain@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/213] macintosh/via-macii: Fix "BUG: sleeping function called from invalid context"
Date: Thu, 13 Jun 2024 13:31:34 +0200
Message-ID: <20240613113229.782880669@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@linux-m68k.org>

[ Upstream commit d301a71c76ee4c384b4e03cdc320a55f5cf1df05 ]

The via-macii ADB driver calls request_irq() after disabling hard
interrupts. But disabling interrupts isn't necessary here because the
VIA shift register interrupt was masked during VIA1 initialization.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/419fcc09d0e563b425c419053d02236b044d86b0.1710298421.git.fthain@linux-m68k.org
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/macintosh/via-macii.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 177c3ef59c875..107f529a8e466 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -135,24 +135,19 @@ static int macii_probe(void)
 /* Initialize the driver */
 int macii_init(void)
 {
-	unsigned long flags;
 	int err;
 
-	local_irq_save(flags);
-
 	err = macii_init_via();
 	if (err)
-		goto out;
+		return err;
 
 	err = request_irq(IRQ_MAC_ADB, macii_interrupt, 0, "ADB",
 			  macii_interrupt);
 	if (err)
-		goto out;
+		return err;
 
 	macii_state = idle;
-out:
-	local_irq_restore(flags);
-	return err;
+	return 0;
 }
 
 /* initialize the hardware */
-- 
2.43.0




