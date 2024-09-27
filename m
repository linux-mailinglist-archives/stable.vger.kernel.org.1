Return-Path: <stable+bounces-77925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F8398843A
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195AC281029
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61C18BC1D;
	Fri, 27 Sep 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q33XraU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5C1779BD;
	Fri, 27 Sep 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439936; cv=none; b=bJd1HkCm0sFK9IszsUAP13i5E8bB7PMLBVx0YMKc7MJDwka+G5X8YNVPKtetmjHpLdYGL38VlfR0M2h6x1dNl01GjBr6etVEjj2xGtJurwcPo8RcWPm9uis4ZlAmxWn7DwOpra2aOmqCUuFZDwANKzYK2SvWi2/vCwSIxRK37lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439936; c=relaxed/simple;
	bh=kkBfkbHx5qK7JTVmT1mF/AIsBnf8dUlGAJgte0JezF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AgseUOiVm+E8n+C0Ec1a5LqdFxtGfcKAiFJzJjLaEegYx3iAwRMNGYIR1FojnBqDXMUmG5+jk1ndiIoeOqryvwtBv+AaSnN3Fn3cUywFvROSBX6B1ttuVrfuHQ5Yy7Rm3JTKUtReHREmd2ZNCizbYOjnQi/SdEIgBlODigBxGH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q33XraU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14F4C4CEC4;
	Fri, 27 Sep 2024 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727439936;
	bh=kkBfkbHx5qK7JTVmT1mF/AIsBnf8dUlGAJgte0JezF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q33XraU5aULFf1TJz0fQlN1tBxPmQyBa8GgwE1b7jATK0aBkqoOrYyZsQcUVqQRsD
	 qAl2S4me9q8L+hvseTOXz6tjmT6ED44fK2kxl02S3O+bNmP8oGDoNM5sHXGQuLXbfs
	 MQbfL5ix2MgGIXvaje7eLRe99v46cduDPStloDI4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markuss Broks <markuss.broks@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 28/54] ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)
Date: Fri, 27 Sep 2024 14:23:20 +0200
Message-ID: <20240927121720.868889109@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
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

From: Markuss Broks <markuss.broks@gmail.com>

[ Upstream commit 283844c35529300c8e10f7a263e35e3c5d3580ac ]

MSI Bravo 17 (D7VEK), like other laptops from the family,
has broken ACPI tables and needs a quirk for internal mic
to work.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Link: https://patch.msgid.link/20240829130313.338508-1-markuss.broks@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index f6c1dbd0ebcf5..248e3bcbf386b 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -353,6 +353,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7VF"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 17 D7VEK"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0




