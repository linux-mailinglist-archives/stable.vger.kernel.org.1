Return-Path: <stable+bounces-88690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4859B2710
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84011C214C4
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814218E35B;
	Mon, 28 Oct 2024 06:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bi2F0rXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E418E743;
	Mon, 28 Oct 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097902; cv=none; b=PwkCrkhmFMENPrEJXrRwXHKw+WLDp10eYUQ5lCQ4AE3TaEULA1GmIm6abDd7RUHycrwiNAqThGbvkGBPp/sJyQ7i/cMd9XpzrIRFlm7vGdjMK6cBFBWe/Zwe7VD+r3uWo0OWn5wKbNFKKVDNeZcv20f9o+jeNf0IlCluq/vwNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097902; c=relaxed/simple;
	bh=J6snH/5xi0Rx2pJ/4cS7h+ztFL3HQZZw0pSjBLoWnM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvHk16wY6mhafApkbEaMQJZZsruN3joJikzArN5C8ssyV7/HDRUh29jedfdARYJK2lGe6aqW0nE5so+16/fq2JIiosPNZuywLSHMTlCgLkrcE6pPrOoK/vMeC4Xv/fHOkkF7bv4MkBjwZ0QKpvdHCtTWuRKDcUpT9jWNpv8/rHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bi2F0rXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AA8C4CEC3;
	Mon, 28 Oct 2024 06:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097902;
	bh=J6snH/5xi0Rx2pJ/4cS7h+ztFL3HQZZw0pSjBLoWnM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bi2F0rXMDIlqad45AWWUQd+gGkvXFRnwjxDdJ7MKU1hbIkPW6GHM+w3JHZbmaZ5S/
	 47paudLhxfJWsnbetuDXoWSS3nq74jqJkgwmkbyrmejh0w36PEUCtdVPH1chh1JmS7
	 FSHInGuxT4RR1/oqRWzN/ooimmikRcxbQd1pGqIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Michel <alex.michel@wiedemann-group.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 6.6 198/208] net: phy: dp83822: Fix reset pin definitions
Date: Mon, 28 Oct 2024 07:26:18 +0100
Message-ID: <20241028062311.512198892@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

From: Michel Alex <Alex.Michel@wiedemann-group.com>

commit de96f6a3003513c796bbe4e23210a446913f5c00 upstream.

This change fixes a rare issue where the PHY fails to detect a link
due to incorrect reset behavior.

The SW_RESET definition was incorrectly assigned to bit 14, which is the
Digital Restart bit according to the datasheet. This commit corrects
SW_RESET to bit 15 and assigns DIG_RESTART to bit 14 as per the
datasheet specifications.

The SW_RESET define is only used in the phy_reset function, which fully
re-initializes the PHY after the reset is performed. The change in the
bit definitions should not have any negative impact on the functionality
of the PHY.

v2:
- added Fixes tag
- improved commit message

Cc: stable@vger.kernel.org
Fixes: 5dc39fd5ef35 ("net: phy: DP83822: Add ability to advertise Fiber connection")
Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Message-ID: <AS1P250MB0608A798661549BF83C4B43EA9462@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/dp83822.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -40,8 +40,8 @@
 /* Control Register 2 bits */
 #define DP83822_FX_ENABLE	BIT(14)
 
-#define DP83822_HW_RESET	BIT(15)
-#define DP83822_SW_RESET	BIT(14)
+#define DP83822_SW_RESET	BIT(15)
+#define DP83822_DIG_RESTART	BIT(14)
 
 /* PHY STS bits */
 #define DP83822_PHYSTS_DUPLEX			BIT(2)



