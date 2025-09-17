Return-Path: <stable+bounces-180321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6013BB7EF6A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 204947B926F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1630CB38;
	Wed, 17 Sep 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVQTsfWk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A49183CA6;
	Wed, 17 Sep 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114090; cv=none; b=IdxtSDyrt46otIjTRFrQeBD8QU8/O+vlTtIG31MElcZYKXkjuYtY+3301fgcCiv6OhAIu71Ypi2ztqNW9LxsEQDXLM5p+oVK8o9vyOwqtZNPI4FWC74Addao8p5dRYFVXssDe0ASIL6FYukGfFiXFCRJctJFr9YRU/3vQq4W9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114090; c=relaxed/simple;
	bh=CxD1ACyY7nqIdqsfJPTKN6A8GopMiqixr3YCTAz3jlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwQj0UVC2fVgrhpfZglS5Yfo/eOd8czTio3NmcbHTTeIEmeGndSL5ASBXbsah82hLRSwnTuDnaz4U5sv3X7CwyZzewgrtWSbPwrgZerELeFAl3n8QAaNtNvrAitYh49LVtgM9Dtx9UoyfS5YyA00MWRImPdRWY+BGwqSl4nwOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVQTsfWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB4BC4CEF0;
	Wed, 17 Sep 2025 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758114090;
	bh=CxD1ACyY7nqIdqsfJPTKN6A8GopMiqixr3YCTAz3jlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zVQTsfWkvkS/cX/5dJ8tajXVytitfPHs/+LpxMSSsFXwjSoWn/sVwW6blllBDVrgZ
	 QnjPn1xalEraAs0Yg38/Pbcxeg4P9N0CY+waQscAF0df11Gp3MtNWJ0GqavGbSUxX2
	 sXlvOQPwYhlSCtSm/zGJtHM6XLQ94Rj/9eSXdCRk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.1 44/78] Input: i8042 - add TUXEDO InfinityBook Pro Gen10 AMD to i8042 quirk table
Date: Wed, 17 Sep 2025 14:35:05 +0200
Message-ID: <20250917123330.640752108@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
References: <20250917123329.576087662@linuxfoundation.org>
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
@@ -1155,6 +1155,20 @@ static const struct dmi_system_id i8042_
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
 	 * after suspend fixable with the forcenorestore quirk.



