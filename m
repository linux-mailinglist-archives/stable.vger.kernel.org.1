Return-Path: <stable+bounces-73174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A094F96D38E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBDC28AFCE
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274919755A;
	Thu,  5 Sep 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qp3nP6Q8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDBD1925AA;
	Thu,  5 Sep 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529385; cv=none; b=I5/GMHcl0o5N1/k2PdcRffrxvWcoAqwpdvpkPlDzo2t4PyQZkDTOapTb5z6lkqQIDY4RH1kheApqIeeHZspWuPVsIC3KKtv0bHHFpF7PD/X8CfEu1Zx8odz+B3DRPBVEoTajc6CI+ngHCOSMc4zbWdidUFRzg7/KM1AmYqdbvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529385; c=relaxed/simple;
	bh=ugCjcOPLvgMl3/aUjJNeFKAwwkfTrgLpdoRCHv9gm/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLbOsR2RliAArJJLMUIqHG+vKAl3SzySRoapObrd2KvpXzKuDP2WrlEota+YOsh80fgcjATSnNDNxTIrVWL97hm7oWC/E+z5aBxi5pcfs9pjeX3VxRZ3Kx/vA58yRRkni5ANnMKf+FF1dMvsMvdkllfHgkjWg2EHYTaiy+r13W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qp3nP6Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E543C4CEC3;
	Thu,  5 Sep 2024 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725529384;
	bh=ugCjcOPLvgMl3/aUjJNeFKAwwkfTrgLpdoRCHv9gm/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qp3nP6Q8/q+EVAkzO1S1uH0QmoZM7vpU5ym2kRRKld6N5xdr6JWV0WS102WvdALsJ
	 GdK+3DcOObsuma/9rTfbDtBEjtUHiBqKbBms5dYNViMHaA1Gf5UmP6LHCGh1XHmVYe
	 CZSOJiN3O4rZD2V8i8iwbnvX6JmHVtrAd15i8++U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bruno Ancona <brunoanconasala@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 016/184] ASoC: amd: yc: Support mic on HP 14-em0002la
Date: Thu,  5 Sep 2024 11:38:49 +0200
Message-ID: <20240905093732.880861965@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093732.239411633@linuxfoundation.org>
References: <20240905093732.239411633@linuxfoundation.org>
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

From: Bruno Ancona <brunoanconasala@gmail.com>

[ Upstream commit c118478665f467e57d06b2354de65974b246b82b ]

Add support for the internal microphone for HP 14-em0002la laptop using
a quirk entry.

Signed-off-by: Bruno Ancona <brunoanconasala@gmail.com>
Link: https://patch.msgid.link/20240729045032.223230-1-brunoanconasala@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index d597e59863ee3..e933d07614527 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -430,6 +430,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A3E"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8B27"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0




