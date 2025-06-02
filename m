Return-Path: <stable+bounces-150327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2EACB6F2
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15C1169E15
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712B23507F;
	Mon,  2 Jun 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oz2yL4nk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E99231CB0;
	Mon,  2 Jun 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876770; cv=none; b=rpPnNSRIO8gFXmgQm5mVQCDNtzj3SsVtKRGWVUzqR/VF8lA6jLfqaOYVW7VEgxe1dpfEsGtKlDLVZtBCY8mMz/CcWdlWYgyA9918FKBfpWAXZky9xTJeqMRv9RsW386xLoaRKcEZB4VIXkJ1mJgf9SUOzJiHMO1+rfiIz0qwS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876770; c=relaxed/simple;
	bh=a/36i9bWzDYinKHT3Kpiw/3jwGV+1vr+gxGDLGxJQ84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQCToJw/68gDUoSUhc/Foe4jhvrRrX+LSuUr2hLMu8pD65/pjBgiLxjHgC3a0gWD6DCtkQ020Yu39omUnXiOVY82t5pov1Qv/2gPPKhiyJp8YhKs6Vy/JvBzTTtTTbpJXkSyHLwaKA4xykhnlFS3Bi1utF0BF4x19ZiW7wcWdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oz2yL4nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D6DC4CEEE;
	Mon,  2 Jun 2025 15:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876770;
	bh=a/36i9bWzDYinKHT3Kpiw/3jwGV+1vr+gxGDLGxJQ84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oz2yL4nk4ErCUIx+7IjUtBQ/tpdeA0LzzGWoS+K1lc4k3XDSxzp7btwVrAfOelfVF
	 T2fmz/RCievyuklI7VxrGbkBP1jepNH/3N6iPabiby88HX0770xTuGBPXXtB+N9Kzm
	 x1WLxVJYUl/ODaINcPtixceuQIIQX+iZhA7eX5Kk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 068/325] rtc: rv3032: fix EERD location
Date: Mon,  2 Jun 2025 15:45:44 +0200
Message-ID: <20250602134322.551081190@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit b0f9cb4a0706b0356e84d67e48500b77b343debe ]

EERD is bit 2 in CTRL1

Link: https://lore.kernel.org/r/20250306214243.1167692-1-alexandre.belloni@bootlin.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-rv3032.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index c3bee305eacc6..9c85ecd9afb8e 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -69,7 +69,7 @@
 #define RV3032_CLKOUT2_FD_MSK		GENMASK(6, 5)
 #define RV3032_CLKOUT2_OS		BIT(7)
 
-#define RV3032_CTRL1_EERD		BIT(3)
+#define RV3032_CTRL1_EERD		BIT(2)
 #define RV3032_CTRL1_WADA		BIT(5)
 
 #define RV3032_CTRL2_STOP		BIT(0)
-- 
2.39.5




