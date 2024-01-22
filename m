Return-Path: <stable+bounces-14544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 288118381B4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1BBB2386A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79A14A4C6;
	Tue, 23 Jan 2024 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O1bS8iTu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D814A0BF;
	Tue, 23 Jan 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972102; cv=none; b=d3TCMQX2us1EnGmCNZnjvncHls5DwCFV4POZl1zL8WYnPtRSTWn5wDy67q57CEO+q0EGCTVQs4WDNHVuc3x0zKAxpmvvFk/GVXB/0b1kgQ0zLDSdwaaXgiFg04ziHTHqmOKD+OBhbFUeMrlEuQDEW/CYUmPsWFuVDlXUJxSZwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972102; c=relaxed/simple;
	bh=8zYakxI+sTSAMJIu/z0eQOpLmAbY2BTOnTAkmwH0vNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1cDHJUNicfoTMHAk8t6+6fl2MnqwDxyTeK70txgsPCJ+T0FKRK+QyUwiva2FKndxlmiKAo3wGH/Vl57+sz0m589GcRPFi3gNC47a0QwOuLSDZuUx2MzXcmG74xfKZwbFqsF5ZsFeWzAaOwecTd2NML77Gnv0xSwh17SLVd74MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O1bS8iTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687F0C433C7;
	Tue, 23 Jan 2024 01:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972102;
	bh=8zYakxI+sTSAMJIu/z0eQOpLmAbY2BTOnTAkmwH0vNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1bS8iTunnqQE//sNyyTgk/xoipyuu9JVodRaLX3R6gZN28VYBHXw05foDkNkySEb
	 pr5r//oh5tnjN7v6HD6zmGLS6qV60ACIKresufG5MT4VoiKP/oxxJ/vpZB8SCvdDgx
	 YlOjnEtLOZq5ozZK7r1yHNeQEh6VNkj2XwRNBJ7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Esther Shimanovich <eshimanovich@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 039/374] Input: i8042 - add nomux quirk for Acer P459-G2-M
Date: Mon, 22 Jan 2024 15:54:55 -0800
Message-ID: <20240122235745.983054320@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Esther Shimanovich <eshimanovich@chromium.org>

[ Upstream commit 335fe00319e030d481a54d5e0e68d50c5e672c0e ]

After the laptop lid is opened, and the device resumes from S3 deep
sleep, if the user presses a keyboard key while the screen is still black,
the mouse and keyboard become unusable.

Enabling this quirk prevents this behavior from occurring.

Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
Link: https://lore.kernel.org/r/20231130195615.v2.1.Ibe78a9df97ecd18dc227a5cff67d3029631d9c11@changeid
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 3db87ee0b70c..6af38f53154b 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -351,6 +351,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
+	{
+		/* Acer TravelMate P459-G2-M */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate P459-G2-M"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
 	{
 		/* Amoi M636/A737 */
 		.matches = {
-- 
2.43.0




