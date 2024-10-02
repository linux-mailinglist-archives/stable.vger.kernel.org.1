Return-Path: <stable+bounces-79218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936198D729
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303221F24649
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E541D07B8;
	Wed,  2 Oct 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IM7tnkI6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26841D0164;
	Wed,  2 Oct 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876791; cv=none; b=ndB5jt652xAe3h+ez88g+l+AMhtpzlfqLQvoHP6R8jyYFEzowGWaZ7fO84f0wC63wumSD1yc1bTiacem7ADtQmpom+O6bSSbNxwbTwujusRS3CgPGQIMy7eziJCBxOks2N65kKrTH9vPeNtilRpoug2JS46yXUHjQYW4Tzo9g30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876791; c=relaxed/simple;
	bh=9Izgx9dvyULwQZmx9luCMxr7cMCJbYn/gNSZFA2ffaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTjEHKciIRYxOLUFA6uXBurqMqceiqWyEeQfmRCLcdwSj3QgjGwgCCHPkMM+ftKIo8bQ03osMmc/fGdGOkf1TTd35SrjAZVOEgtdgQ7D4xsz5xX4/uHS1tgjFIE71Orj1wWrTqrEUqJkBy+hGAz7AeTleTZJdOFFZLQrq66ubHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IM7tnkI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BDEC4CEC2;
	Wed,  2 Oct 2024 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876790;
	bh=9Izgx9dvyULwQZmx9luCMxr7cMCJbYn/gNSZFA2ffaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IM7tnkI6V3Fro8b1198a3TUt4/G7S0+NNHy8xt6YIKJWwI/mtqyU4qhCQgLP65klO
	 VYJ5AfaiR3cs1hkd3JTL4m0gp88/5hovgZ3O/hwqu9dJUrdzSQUc5eivqKrtseXZ9s
	 telS2s/CjZksf2njqxbCeMmItuZXUiN+XkmPLlfI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Werner Sembach <wse@tuxedocomputers.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.11 531/695] Input: i8042 - add TUXEDO Stellaris 16 Gen5 AMD to i8042 quirk table
Date: Wed,  2 Oct 2024 14:58:49 +0200
Message-ID: <20241002125843.696192476@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Werner Sembach <wse@tuxedocomputers.com>

commit e06edf96dea065dd1d9df695bf8b92784992333e upstream.

Some TongFang barebones have touchpad and/or keyboard issues after
suspend, fixable with nomux + reset + noloop + nopnp. Luckily, none of
them have an external PS/2 port so this can safely be set for all of
them.

I'm not entirely sure if every device listed really needs all four quirks,
but after testing and production use, no negative effects could be
observed when setting all four.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240905164851.771578-1-wse@tuxedocomputers.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/serio/i8042-acpipnpio.h |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1121,6 +1121,29 @@ static const struct dmi_system_id i8042_
 		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
 	},
 	/*
+	 * Some TongFang barebones have touchpad and/or keyboard issues after
+	 * suspend fixable with nomux + reset + noloop + nopnp. Luckily, none of
+	 * them have an external PS/2 port so this can safely be set for all of
+	 * them.
+	 * TongFang barebones come with board_vendor and/or system_vendor set to
+	 * a different value for each individual reseller. The only somewhat
+	 * universal way to identify them is by board_name.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxX"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	/*
 	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
 	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
 	 * none of them have an external PS/2 port so this can safely be set for



