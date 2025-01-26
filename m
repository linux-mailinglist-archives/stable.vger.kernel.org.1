Return-Path: <stable+bounces-110759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DBEA1CC89
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B303B26A7
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D7233D97;
	Sun, 26 Jan 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufHG8HGf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6D1F91ED;
	Sun, 26 Jan 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904107; cv=none; b=B+ikc/uez3Jcxi9/018nuvo4OfMoJ0howBCLW9LhOiEG9CkqHoLivreRa9FdyA7gUEzGYar1D8KwhnjuF2790KuYJbJ29R1sSzvJNjc18xmAFyqsEm44kMgzDOGDwPATZGCmqy0GAK5AE6qCK+torFybECbk0a3tVx0qoeYeAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904107; c=relaxed/simple;
	bh=4EEkYC8RfrXsn6PfoJlp1U3L509s8rsmM7MazMtyP50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKMIOZZhBoFY1irnmEtcof28HpSmKtVBpu+VE2TQ1O9WAxTPx0lFLK5Q60Dr3NK8iJsWg0JQ6lSLy7uz3ci7KPoL9qX/FS5KgoZ4Syfmir2jMIV1RAatDpLmANQiolor8DIE0IWp0XmN6zXfNQjPSMkak3biKgN0XvYfrg0K+vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufHG8HGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8774C4CEE9;
	Sun, 26 Jan 2025 15:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904107;
	bh=4EEkYC8RfrXsn6PfoJlp1U3L509s8rsmM7MazMtyP50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufHG8HGfoLjjBovXDFycI4eEyGWHhO9mgXvKgnkz5zyIfZ7AYmjV15ECqdysLF1/R
	 uCRDprmMWVOxsRECctWjv6NjHVgRVot05lMCUTb9VcuwgYFe8Nj5v3ox8EBim6qKA6
	 SqjXOX576vnTTm7Qv0W0gxxKxCT5oES0HW2/mdEjbwUeUPD9E17ITh5MmuK2zoTlx4
	 V3nb/+muWTRF5hkOq6MOJfYYjHoh2Kjwxc6jvSG8Xnb10V6/eBCQB2zleHJ8flErOh
	 STybfmzmqz59nV3aG+5cKqO/AvYSoEyi9g8PQgmcODE29cOAT6aTcAmSBGDnsQ/Okr
	 h6n8c8Akp5+PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Rayan Margham <rayanmargham4@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 08/14] platform/x86: acer-wmi: Add support for Acer PH14-51
Date: Sun, 26 Jan 2025 10:07:55 -0500
Message-Id: <20250126150803.962459-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150803.962459-1-sashal@kernel.org>
References: <20250126150803.962459-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 9741f9aa13f6dc3ff24e1d006b2ced5f460e6b6f ]

Add the Acer Predator PT14-51 to acer_quirks to provide support
for the turbo button and predator_v4 hwmon interface.

Reported-by: Rayan Margham <rayanmargham4@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/CACzB==6tUsCnr5musVMz-EymjTUCJfNtKzhMFYqMRU_h=kydXA@mail.gmail.com
Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20241210001657.3362-2-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 7169b84ccdb6e..844e623ddeb30 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -398,6 +398,13 @@ static struct quirk_entry quirk_acer_predator_ph315_53 = {
 	.gpu_fans = 1,
 };
 
+static struct quirk_entry quirk_acer_predator_pt14_51 = {
+	.turbo = 1,
+	.cpu_fans = 1,
+	.gpu_fans = 1,
+	.predator_v4 = 1,
+};
+
 static struct quirk_entry quirk_acer_predator_v4 = {
 	.predator_v4 = 1,
 };
@@ -605,6 +612,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_predator_v4,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Predator PT14-51",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PT14-51"),
+		},
+		.driver_data = &quirk_acer_predator_pt14_51,
+	},
 	{
 		.callback = set_force_caps,
 		.ident = "Acer Aspire Switch 10E SW3-016",
-- 
2.39.5


