Return-Path: <stable+bounces-36797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA889C1AF
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331291C2144D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC898003D;
	Mon,  8 Apr 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kY60gIAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABBD62148;
	Mon,  8 Apr 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582372; cv=none; b=byiAAvVQyyXkp1obJbQsn9kGh1qukkuUe3gjuhMZ5avke2qBxqtq2w7uhS16dFuQVo4XUdnm0nI9gJO9nyfpwGAoQ1wwsa/GboBampWdZWFhMu8nRg3aSsj5RCq4v651X4HUWWpSArRDRs5SVvzORONa9zMFuXQOSBvV8Za8lx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582372; c=relaxed/simple;
	bh=3Vy4hd/I8dtZB0ZxUQv0Zw6dxPPA9whZpKKfrWH+tvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZztatN9QAFlOQmIvUgC0W/mdX9j7dkHtNEaMd3I+i8SdbtzTNfQkEm/wjpjYXPhROHYcdqPsE4ge5ddu9brfkY1pr1//RYB+mY8Ewtbqpq/LIWbfp6kGDSNqqCWSAQYz3VaTnKde8frn4j4OuYUcz8OYAP7O1jDWvW+P3H5nyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kY60gIAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E21C433F1;
	Mon,  8 Apr 2024 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582372;
	bh=3Vy4hd/I8dtZB0ZxUQv0Zw6dxPPA9whZpKKfrWH+tvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kY60gIAao/ytNHLdXOFAiZb+oA4Wi5aCNREgktLwT4UFLhgpHG1pYW1gYgSX0j/qc
	 8tqhrRSj1PxUTGtfVHSC6+snNb8M+M+G7V2k7ohSqIiNvPAlvVBv43LRwuzbHu2lMs
	 5bnMNXPOIHhCtPk/H9hTGtVBASjEwEmIK9VBt9Yo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.8 069/273] r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d
Date: Mon,  8 Apr 2024 14:55:44 +0200
Message-ID: <20240408125311.445245128@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

commit 5d872c9f46bd2ea3524af3c2420a364a13667135 upstream.

On some boards with this chip version the BIOS is buggy and misses
to reset the PHY page selector. This results in the PHY ID read
accessing registers on a different page, returning a more or
less random value. Fix this by resetting the page selector first.

Fixes: f1e911d5d0df ("r8169: add basic phylib support")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/64f2055e-98b8-45ec-8568-665e3d54d4e6@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169_main.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5027,6 +5027,15 @@ static int r8169_mdio_register(struct rt
 	struct mii_bus *new_bus;
 	int ret;
 
+	/* On some boards with this chip version the BIOS is buggy and misses
+	 * to reset the PHY page selector. This results in the PHY ID read
+	 * accessing registers on a different page, returning a more or
+	 * less random value. Fix this by resetting the page selector first.
+	 */
+	if (tp->mac_version == RTL_GIGA_MAC_VER_25 ||
+	    tp->mac_version == RTL_GIGA_MAC_VER_26)
+		r8169_mdio_write(tp, 0x1f, 0);
+
 	new_bus = devm_mdiobus_alloc(&pdev->dev);
 	if (!new_bus)
 		return -ENOMEM;



