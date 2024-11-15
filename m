Return-Path: <stable+bounces-93301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7629CD875
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0A328160A
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6AD18734F;
	Fri, 15 Nov 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="toV0tpEu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26EEAD0;
	Fri, 15 Nov 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653463; cv=none; b=YIpnsGNQ9F9vpasydaqmWi2Es4pLkexYipBJUFWP3C9771pfTRMCMoop2gDwUmEUizJd22fnP2Fco60belcr0xvkvgO/oQq8KjP2jMuEqwoB3m4RROonL4bHw8foXN8hzc/JWpEjLAo0hw2+I7WSiWjtuqF5TVYhUQi/xKj0KuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653463; c=relaxed/simple;
	bh=cDU3964Ng2z3tmsonpoyjI0gfIdyDDzPw6Wtuaz/Gl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wiy7OISvtsHiC3xFJpvqqkSnOeX6V+u9nM58Fdf/azb6z6tIkivF/cDZxxMGSOo6En51Dwda1xRO6SaAIwNKtkQEcct1WH1nAsTewqPSO3xHN7/pk/Ue48MBRdHO5lv4yEY1qvMQCpw1QcveNC/SLR6z7/cA4sq1aO7te0pzBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=toV0tpEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B51C4CECF;
	Fri, 15 Nov 2024 06:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653463;
	bh=cDU3964Ng2z3tmsonpoyjI0gfIdyDDzPw6Wtuaz/Gl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=toV0tpEuKcWSJwUsqnZ7r4hgnPgXDoGXB+vBL6fWdQFdrgRt3adGZjgjfCyJ1iiRB
	 hEUlaOBNbrpcm68XLJDlK4Q1km2BQRSlnqMnpw35HsUQ1GX802mgS6teyF/wmjHYc5
	 FntzVdFMssenl8vjLzigIE8HDNcrbnpsjPZcJUY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Heusel <christian@heusel.eu>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 29/48] ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA
Date: Fri, 15 Nov 2024 07:38:18 +0100
Message-ID: <20241115063724.016482056@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.962047137@linuxfoundation.org>
References: <20241115063722.962047137@linuxfoundation.org>
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

From: Christian Heusel <christian@heusel.eu>

[ Upstream commit 182fff3a2aafe4e7f3717a0be9df2fe2ed1a77de ]

As reported the builtin microphone doesn't work on the ASUS Vivobook
model S15 OLED M3502RA. Therefore add a quirk for it to make it work.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219345
Signed-off-by: Christian Heusel <christian@heusel.eu>
Link: https://patch.msgid.link/20241010-bugzilla-219345-asus-vivobook-v1-1-3bb24834e2c3@heusel.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index e027bc1d35f4f..2d766d988eb2e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M7600RE"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M3502RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0




