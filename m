Return-Path: <stable+bounces-162654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6ACB05EFD
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C6A503345
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311082ED868;
	Tue, 15 Jul 2025 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBKSkBMf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37532EBBA7;
	Tue, 15 Jul 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587124; cv=none; b=f8Y339+T2WRlHpTezr/pCTW6/I8nblYT3gSyioyJ/DvCW80drqTQ5X2w6/0fPCVgmnYaDf09If6Bzx/4fVWHvy4l2CGS8vMFyyi5UU/nfNikMsNWOXgVR4TNnUVbYwJzI0F3nCvNah/oodY3j6QXGMXHSHQfYDoGYE6jLXcRakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587124; c=relaxed/simple;
	bh=alBjTIaspklzKaHDtIlFvZN/51S1g8Phb+Gcgz8roSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZDl2B6UtOxBflR4yhyq6ku4B20InqYqXu9F+wnL8OKkOuYm08Qgp5/uW6duX3vtbvtl//U/oTCq3YKJ4YtcqTEVun+G5u1RIvi/TKVUjCcLHdu3j7H2myrJukc4Am/Hz1Lily7YUTP3w21M0dNOIQ7nPZgAhlbb0tY+egPRz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pBKSkBMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F78C4CEF1;
	Tue, 15 Jul 2025 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587123;
	bh=alBjTIaspklzKaHDtIlFvZN/51S1g8Phb+Gcgz8roSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pBKSkBMfKF8/1NdW7NQMpx2FmFCUQB9nub7+ha6utUeE3LGV4p/KOwRwnPYUSkspX
	 1XJRTTzOVVU5mWZLCM13tMj8pzozXNWxKAzDfruny+k0e6c9TjjxskaR87sun+bDO8
	 t2mCFqr4aXivtPmdVmr7HmwqZ4j4xeNKRf9Hr8ss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuzuru <yuzuru_10@proton.me>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 175/192] ASoC: amd: yc: add quirk for Acer Nitro ANV15-41 internal mic
Date: Tue, 15 Jul 2025 15:14:30 +0200
Message-ID: <20250715130821.935003373@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuzuru10 <yuzuru_10@proton.me>

[ Upstream commit 7186b81807b4a08f8bf834b6bdc72d6ed8ba1587 ]

This patch adds DMI-based quirk for the Acer Nitro ANV15-41,
allowing the internal microphone to be detected correctly on
machines with "RB" as board vendor.

Signed-off-by: Yuzuru <yuzuru_10@proton.me>
Link: https://patch.msgid.link/20250622225754.20856-1-yuzuru_10@proton.me
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 723cb7bc12851..1689b6b22598e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -346,6 +346,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "RB"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.5




