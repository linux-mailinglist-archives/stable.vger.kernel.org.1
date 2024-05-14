Return-Path: <stable+bounces-44166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C658C518C
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3131F224A9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2867413A256;
	Tue, 14 May 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jMlLl0fa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7C12BEA5;
	Tue, 14 May 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684668; cv=none; b=V1KyIZ4W1vzbnnWUPAPiX/AVj9KSolIyi1lARZMLgHF8lSlVJDW5wOTDzZIAJ3YQZmwKpqHb7SaqdX0XFSoRr6cwv8Apap3ZiCaeifGP8pohllG8IFTZC6WpABRAr2bbSTq/cxWzS0gDUpJb3MaxuKU3YJGgR/mBFb2qpFQtTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684668; c=relaxed/simple;
	bh=RNDXcPQOTQBurSoaB8PAt0lVAQAFzrl/JlZeT968BxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iavzbjV3MfaS2BwogrwEIfAZw0WRphXCY16NczyZYTHB76IPd9S6FVtTfg1BxWDsQKEQSBx630/9pczASl7fV+mOxCkHvi4lI1fKnGtSS+V+gpIwPHdMsdqOW2Ka66zxTnO2IfViq2lxcSlhXjgAjYTWkAfW044Hv9vfEG/aXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jMlLl0fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098E2C2BD10;
	Tue, 14 May 2024 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684668;
	bh=RNDXcPQOTQBurSoaB8PAt0lVAQAFzrl/JlZeT968BxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jMlLl0fag5YQnGnTAaJIgeD9ao80XHV5enwWAyaoCe0//sfGTrBe4wmgyh3w6YVmS
	 P0hVGAhdKb0ZRhXjuzNusehIiuEmu2mp2A6ZqxJPU46jG1fa0BYniUlokzTQdK1Cp1
	 BZQIfFpZh+MxP+4BC+XigYnT9txXIA3toTCHMdLo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 073/301] net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341
Date: Tue, 14 May 2024 12:15:44 +0200
Message-ID: <20240514101035.006841426@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit b9a61c20179fda7bdfe2c1210aa72451991ab81a ]

The Topaz family (88E6141 and 88E6341) only support 256 Forwarding
Information Tables.

Fixes: a75961d0ebfd ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6341")
Fixes: 1558727a1c1b ("net: dsa: mv88e6xxx: Add support for ethernet switch 88E6141")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20240429133832.9547-1-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8556502f06721..db1d9df7d47fe 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5588,7 +5588,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6141,
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6141",
-		.num_databases = 4096,
+		.num_databases = 256,
 		.num_macs = 2048,
 		.num_ports = 6,
 		.num_internal_phys = 5,
@@ -6047,7 +6047,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.prod_num = MV88E6XXX_PORT_SWITCH_ID_PROD_6341,
 		.family = MV88E6XXX_FAMILY_6341,
 		.name = "Marvell 88E6341",
-		.num_databases = 4096,
+		.num_databases = 256,
 		.num_macs = 2048,
 		.num_internal_phys = 5,
 		.num_ports = 6,
-- 
2.43.0




