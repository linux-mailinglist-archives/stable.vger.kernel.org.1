Return-Path: <stable+bounces-182452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BAFBAD908
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E2964E0F04
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2890306486;
	Tue, 30 Sep 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CU/uxMvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3F23506A;
	Tue, 30 Sep 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244992; cv=none; b=QO+eghoXrHl4iTWuq044C+Sq7SEZ5zOl9Ks8G6I+NtAsU1oq85Q9NWXDyOYL4jjEz41vcY5klxVNhBRT3sAsprFBcJCptjPm4hWVaxMATAVcHyfbM/7t4IUHUmeHPxEFWvUeuFSpsnaT9VS5/vRWYoAwXY/A5RSaPR9JYUhhwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244992; c=relaxed/simple;
	bh=7oVkLpbuJzXdQstuU9Tnx0uest3drC18TiHmeuAAS2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgU+wMb2lzaaDRFy9k5yUDT9Y2DP2YzlC7VHoZmSKewTY0sGEh6KDTkEgOvsHJwkC+djdZ/7nuR8d6XGabfgfqv7Ra9gS3B2Kf4/h20DJnjKnb0ZSa0bKeevvdmYB4IyTFm2HQlAgMPebwfGJVZhIG/qfhxNPSxpDU4U/SQ/4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CU/uxMvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FD2C4CEF0;
	Tue, 30 Sep 2025 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244992;
	bh=7oVkLpbuJzXdQstuU9Tnx0uest3drC18TiHmeuAAS2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CU/uxMvJHs+y9i4PLj5x1Gq+s2Arv/FXq4N1gLAdmJYTu/3QiYeah+0bYx0o6FSaP
	 NzqQF1Qjwbmlp26AGyGlxfXgoPknO8Xsfu8yav/KRVKoKQ+gRlmzAR+3nnihLh3U2g
	 uK3YD9KD6WBdsslVIXBnZ02HOdkkCOl1E3c3xV9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.15 033/151] Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk table
Date: Tue, 30 Sep 2025 16:46:03 +0200
Message-ID: <20250930143828.936050726@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Christoffer Sandberg <cs@tuxedo.de>

commit 1939a9fcb80353dd8b111aa1e79c691afbde08b4 upstream.

Occasionally wakes up from suspend with missing input on the internal
keyboard. Setting the quirks appears to fix the issue for this device as
well.

Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250826142646.13516-1-wse@tuxedocomputers.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/serio/i8042-acpipnpio.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1147,6 +1147,20 @@ static const struct dmi_system_id i8042_
 		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
 					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxHP4NAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
 	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
 	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,



