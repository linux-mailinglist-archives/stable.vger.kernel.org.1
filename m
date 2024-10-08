Return-Path: <stable+bounces-81753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DB994930
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79394B21F18
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2DB1DEFCF;
	Tue,  8 Oct 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G9YeAA6L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25C1DDA36;
	Tue,  8 Oct 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390018; cv=none; b=CF7jnf1F2Do1IAOIC0Oe31RqtwXX1h9HZtJiFHPbF8nB1Y27DY9c2NvCIRe/IdHFRdctUFTjMvrcGhD0SXQD7h8KxcwAfwYIQ6sruGxZNsW42m3pTWFPcHW8F7mk77hsBCd6tDhHl0H04/pTkKTw2VhTE8+iOgYQ3eTaRX47WCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390018; c=relaxed/simple;
	bh=XN+pdgmGMafgB3EtJ+xOotz2nws1wAXuY3hSZ9X0mJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jshhKawNNCczAIA0byw6jxN6EPmcVLPXuNjid9rE8p6S9jOml4Q51bNzz92LTPSOI7osHyyffDLa00LmzcEcupJl3jmBgz4hRKfIPDZkS7Bl4FjJWYtveg/KrAtoQMi7xYp3tNGpf2ViLHwJiWX3SGk5i4ud7YSvz1qSwbRfUmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G9YeAA6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3033C4CEC7;
	Tue,  8 Oct 2024 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390018;
	bh=XN+pdgmGMafgB3EtJ+xOotz2nws1wAXuY3hSZ9X0mJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9YeAA6LK6dHHdg4Dlw6zZKx1gZqlBHbOD1DDn53D8rVuWnSGBpEIQMWdBUTvjUgM
	 r/7UpNV65Yb3W/ck3MUHkmxSuvzl4gETXit2vSbThwGDU6Mhb3C803W53NNdFw2huI
	 2c3HeCkSux+6Ff8pKE3Z8X29k1nsOX4W3fR4iOkk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Davis <afd@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 166/482] power: reset: brcmstb: Do not go into infinite loop if reset fails
Date: Tue,  8 Oct 2024 14:03:49 +0200
Message-ID: <20241008115654.838017454@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Davis <afd@ti.com>

[ Upstream commit cf8c39b00e982fa506b16f9d76657838c09150cb ]

There may be other backup reset methods available, do not halt
here so that other reset methods can be tried.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20240610142836.168603-5-afd@ti.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/reset/brcmstb-reboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/reset/brcmstb-reboot.c b/drivers/power/reset/brcmstb-reboot.c
index 0f2944dc93551..a04713f191a11 100644
--- a/drivers/power/reset/brcmstb-reboot.c
+++ b/drivers/power/reset/brcmstb-reboot.c
@@ -62,9 +62,6 @@ static int brcmstb_restart_handler(struct notifier_block *this,
 		return NOTIFY_DONE;
 	}
 
-	while (1)
-		;
-
 	return NOTIFY_DONE;
 }
 
-- 
2.43.0




