Return-Path: <stable+bounces-181773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D1CBA43A1
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4AE1C0710B
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD31FF7C8;
	Fri, 26 Sep 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg0M0ffG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B927C1FCF41;
	Fri, 26 Sep 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897107; cv=none; b=mRTW8LNoUyufgXiFUNE8QXbQPJniQNxkb/FXgs+H1wWbyM5bUqlk9lPg3yUy5PUKGQy343gmlcW98E0WX0/pxwOWFvnIQ3Lsfhf+jQBjbVYLlInde2or63QlU0oK6uwuM8zDuqOGqwec1PV2mvv8XquD71yynecYq0oOaDVF9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897107; c=relaxed/simple;
	bh=Aq9/CxkxJ1lEuJYOGVr9agApTYjSiYR55JD5C1vyWH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zs6V/xcb1tgOAKUFhDrf3ZPcxWEa36pZ/XozpZ0t4c87sq00XjJzS9xlEL1rWg4fWvOx4XtAPpN/Ucr1JG2IBV0UdFUzH+NC7r33SoS3X+m0MWCk91uk+lTM+fRJyn8vgMCvsroBymJ8GJZhXgDPQ3ki5J1/EOGywTT2Xn308V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg0M0ffG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63553C116C6;
	Fri, 26 Sep 2025 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897107;
	bh=Aq9/CxkxJ1lEuJYOGVr9agApTYjSiYR55JD5C1vyWH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kg0M0ffGkOLrH6jg3YfcXemLLFeRrFY5hxC7JlBmP5rUug6wjagPACN9xhQpgZEFv
	 rql3muwPM7jrM5Gsd7IsB6yysVjBUTGilVAnvRQ9tmmrZztywdtsBHFQfbzCwoc6yg
	 TPqSCgQ2fxr3K3D/PTBGIOev8RxmdOnmMWfw1WCHoQlhLG5W//mZZNAH7wkhAuTNX8
	 uUcHggpd9C3b47tHhyJgn2TRCLiYsupIwPtYB8gvGYlTiAH6bWQMe+77P4cE3y6Wxn
	 3Hh9fZwcVASeqjSBxkLpbVAo1g/9Fz+jcwsDbCJhsM19KyqvraevBYdmrc89NXi3oa
	 MgejmwhowufxA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v29U4-000000001g2-3F6F;
	Fri, 26 Sep 2025 16:31:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] soc: apple: mailbox: fix device leak on lookup
Date: Fri, 26 Sep 2025 16:31:31 +0200
Message-ID: <20250926143132.6419-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250926143132.6419-1-johan@kernel.org>
References: <20250926143132.6419-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the mbox platform device when
looking up its driver data.

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: 6e1457fcad3f ("soc: apple: mailbox: Add ASC/M3 mailbox driver")
Cc: stable@vger.kernel.org	# 6.8
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/soc/apple/mailbox.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/apple/mailbox.c b/drivers/soc/apple/mailbox.c
index 49a0955e82d6..1685da1da23d 100644
--- a/drivers/soc/apple/mailbox.c
+++ b/drivers/soc/apple/mailbox.c
@@ -299,11 +299,18 @@ struct apple_mbox *apple_mbox_get(struct device *dev, int index)
 		return ERR_PTR(-EPROBE_DEFER);
 
 	mbox = platform_get_drvdata(pdev);
-	if (!mbox)
-		return ERR_PTR(-EPROBE_DEFER);
+	if (!mbox) {
+		mbox = ERR_PTR(-EPROBE_DEFER);
+		goto out_put_pdev;
+	}
+
+	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		mbox = ERR_PTR(-ENODEV);
+		goto out_put_pdev;
+	}
 
-	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
-		return ERR_PTR(-ENODEV);
+out_put_pdev:
+	put_device(&pdev->dev);
 
 	return mbox;
 }
-- 
2.49.1


