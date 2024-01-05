Return-Path: <stable+bounces-9909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049918255F2
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C221C211CA
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059F62DF66;
	Fri,  5 Jan 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cQDiFVWd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9628DDA;
	Fri,  5 Jan 2024 14:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D5DC433C7;
	Fri,  5 Jan 2024 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465865;
	bh=wYNUn1MRAaeVKECovL20+ZwN1sA6LJAXm/sIUYKvAsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQDiFVWdvzlaXspNAEZ5iDGr427Y8RpTNxpMkaPvORSPbtk82K2WqOAbV1Md3Izqa
	 8bIv8RClVuhpXBZxYvIjJmF6Z3z9z1tLw61xTrRCEwaiyRyYrLcVw0ZOajl/0zFn6U
	 8Eabwo0+dVKsARWRkU3xA/ukOtye4Uk6iSNW+o6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julien Panis <jpanis@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 44/47] bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()
Date: Fri,  5 Jan 2024 15:39:31 +0100
Message-ID: <20240105143817.351937255@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143815.541462991@linuxfoundation.org>
References: <20240105143815.541462991@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julien Panis <jpanis@baylibre.com>

[ Upstream commit d929b2b7464f95ec01e47f560b1e687482ba8929 ]

The am335x-evm started producing boot errors because of subtle timing
changes:

Unhandled fault: external abort on non-linefetch (0x1008) at 0xf03c1010
...
sysc_reset from sysc_probe+0xf60/0x1514
sysc_probe from platform_probe+0x5c/0xbc
...

The fix consists in using the appropriate sleep function in sysc reset.
For flexible sleeping, fsleep is recommended. Here, sysc delay parameter
can take any value in [0 - 255] us range. As a result, fsleep() should
be used, calling udelay() for a sysc delay lower than 10 us.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Fixes: e709ed70d122 ("bus: ti-sysc: Fix missing reset delay handling")
Message-ID: <20230821-fix-ti-sysc-reset-v1-1-5a0a5d8fae55@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Stable-dep-of: f71f6ff8c1f6 ("bus: ti-sysc: Flush posted write only after srst_udelay")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 70339f73181ea..8d82752c54d40 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1842,8 +1842,7 @@ static int sysc_reset(struct sysc *ddata)
 	}
 
 	if (ddata->cfg.srst_udelay)
-		usleep_range(ddata->cfg.srst_udelay,
-			     ddata->cfg.srst_udelay * 2);
+		fsleep(ddata->cfg.srst_udelay);
 
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
-- 
2.43.0




