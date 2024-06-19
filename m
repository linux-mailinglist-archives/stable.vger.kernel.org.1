Return-Path: <stable+bounces-53952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E439E90EC06
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922041F255CB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20383146D49;
	Wed, 19 Jun 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SR3+JiC7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10DD143873;
	Wed, 19 Jun 2024 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802157; cv=none; b=tzMqWD/WSgdGDGMDbXcKsIgBf0QeXLSPvRtKle7Uy7n9GSIqb9OBL7CHEHUMtaVFOZh0Fa1B/Q51Wq5cxvUboB/UcVkBxE1fzujGWTAY5yxXQhOGRf7i15TNQ9+E/O6CyVj1LynH9bkJDuxMg4CTykFMebnhEDFSLRDWZ7sLfm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802157; c=relaxed/simple;
	bh=qyBDvWki4JdZ0eg9T/YlNw/VkJnOA8prU+4uXPg7Pp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfsoKCUzN6A7X1nZH1SlEu5v58Yi6iYQ/QhvSKF9g5mQVTRRaazUOE0/E85wohHsPMVxPGLgd+GFMOixU2Z3IZcLSaqUN9kLnGB21QiXjw3SG8w2d7e4lVRwYMc7PaNbXafRWddGYvEOsiztYU/pIFCTn9wbDb+amNktocW23ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SR3+JiC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A2DC4AF1A;
	Wed, 19 Jun 2024 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802157;
	bh=qyBDvWki4JdZ0eg9T/YlNw/VkJnOA8prU+4uXPg7Pp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SR3+JiC7kkB7VLk7nE8RC2dhY1iu/JZuXahuyxtr3SMt5a2j/ZuwmifOCyPfJcHK5
	 RKKGJ+V01T1MYDdTPGi0COadC55CPlrZQU5SKCqYK6hw5H9qwB6yJIt0XG7RmYM9Ou
	 TH5AmLH9ga75Y94xNnphJBGG4Gv9N9U5uJbTUqzY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 6.6 084/267] mei: me: release irq in mei_me_pci_resume error path
Date: Wed, 19 Jun 2024 14:53:55 +0200
Message-ID: <20240619125609.575591255@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
References: <20240619125606.345939659@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Winkler <tomas.winkler@intel.com>

commit 283cb234ef95d94c61f59e1cd070cd9499b51292 upstream.

The mei_me_pci_resume doesn't release irq on the error path,
in case mei_start() fails.

Cc: <stable@kernel.org>
Fixes: 33ec08263147 ("mei: revamp mei reset state machine")
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240604090728.1027307-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/pci-me.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -400,8 +400,10 @@ static int mei_me_pci_resume(struct devi
 	}
 
 	err = mei_restart(dev);
-	if (err)
+	if (err) {
+		free_irq(pdev->irq, dev);
 		return err;
+	}
 
 	/* Start timer if stopped in suspend */
 	schedule_delayed_work(&dev->timer_work, HZ);



