Return-Path: <stable+bounces-167797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C569B231B0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F51D7B3413
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C02F83B5;
	Tue, 12 Aug 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BziPKHHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3872ED17F;
	Tue, 12 Aug 2025 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022022; cv=none; b=oDU7T13V36V5lTjQlTrNarjwAuRrM0DwjreAYWfiiZQ5iNlxAWSpBNOSCbbODYUDE5tU722Zj1NO6LUvfGU5NrEBGJaNiNuNuPvifAhSQIqAZj6bKECVfw0lGAJBpOAHM6eSPrrG6XYejIan38SLfM1tDYZjjX26gP2bbkdVnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022022; c=relaxed/simple;
	bh=H+OSlNqvvjMGjtUY4C85tvwmrDjUgqMAOmqvvrqUH14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoK1jfOmWGvu0Bs2fZgEuchrn+3WZE87eB214Ds4mwuPpbgprmmMx9k2rA/tbsuxPvmOlSp3Y5W7GcwH30dtxaWLopQR6Af2LK6RrrbqY6HYb54E8bt56cQYe8zKXTFggHnk8/gU3/fdseJkapdaebqZXplJeDPfddH8lbwk44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BziPKHHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77389C4CEF0;
	Tue, 12 Aug 2025 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022021;
	bh=H+OSlNqvvjMGjtUY4C85tvwmrDjUgqMAOmqvvrqUH14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BziPKHHWl5GyL9MUqhWbC27qhqor5VWQYUF772qge2iif3GRWnjbl8OHHHTerpslx
	 ef2CT81RzH5t+t6cR1sqwMKpvIZjmDOJkA7a5qzUr0yGCCmSh6kV83YywtJ3jGKK+B
	 aoJOz2TfXhjmzzG/pjOCstLWtP6Qcjr4sY4iOE7M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandru Andries <alex.andries.aa@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 006/369] ASoC: amd: yc: add DMI quirk for ASUS M6501RM
Date: Tue, 12 Aug 2025 19:25:03 +0200
Message-ID: <20250812173014.982834358@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Andries <alex.andries.aa@gmail.com>

[ Upstream commit 6f80be548588429100eb1f5e25dc2a714d583ffe ]

add DMI entry for ASUS Vivobook PRO 15X (M6501RM)
to make the internal microphone function

Signed-off-by: Alexandru Andries <alex.andries.aa@gmail.com>
Link: https://patch.msgid.link/20250707220730.361290-1-alex.andries.aa@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 4bde41663f42..e362c2865ec1 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -409,6 +409,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M6501RM"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.5




