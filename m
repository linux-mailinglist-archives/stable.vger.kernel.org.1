Return-Path: <stable+bounces-89026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664939B2DDC
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03195B23527
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108F01E32AB;
	Mon, 28 Oct 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSl1t6Lg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6741E2615;
	Mon, 28 Oct 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112763; cv=none; b=ks+wZSmuyYHGmBXvX+5DiJfFV1vGPEYygPT94Cj33Dlxkf6wPlQRfXvkGMBU2kn3tAxH0O4s+YZK4xRCDLYq/yJApdHFH3zg2jL+EJIYSvkmqtmpxAmutUoFtp8jUmv5GzPNKa7GsuFwz/mHSU1FO7hm09rC3LSp0gI4aItczM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112763; c=relaxed/simple;
	bh=+eeFzBLeWQ/yCXaN53gII6lkCRzdT0pvSPCz8xFZY1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phAikXmxnYXX63uOzJSu7/GqqV8vwxQMTtyPqG2SMp0TydnmxverPY/Qb17dS6KrAyLyowOkz/LckxE2S+guHmB0MUjO/YIJpjeT5TgvFd+zIdtj+1HHeDwZcl0p9I6OzuJKA8CHKSCRSL01jjDsrPm1h+glguFdz2bYzIBFsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSl1t6Lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66625C4CEE7;
	Mon, 28 Oct 2024 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112763;
	bh=+eeFzBLeWQ/yCXaN53gII6lkCRzdT0pvSPCz8xFZY1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSl1t6LgAno28Pull74Ewj8vjYVGbElcopiiAFhmOqMYYU4xgdj37XpbkNCFijPmQ
	 YsMRBUIhkWbsHpKzsK227CGrBBR9SfpFUQKxwh1HOTxAC+gi+yMRSLObMq9kYZlBnb
	 qVBFR8GnmToa3q5TTJ7Gw8PHm5pop7XVtYQDkUqZfo0nM4Blr71c3u9Ozkba1NQpMh
	 8wgaMdP6ln8iOl4/VJMY9bfGAhf2KGdoe8RI2+GiYGWPv1nFIf6BD35RUxPkX/LLdT
	 5eZF8rxfipEO0UC7/LwGUzjhjlKPk3indPJPrO1RPjKH+1A/s4hBpP3M7gxRPeoIai
	 TKn2RaNMOqdhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	siddharth.manthan@gmail.com,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	mjg59@srcf.ucam.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/15] platform/x86: dell-wmi: Ignore suspend notifications
Date: Mon, 28 Oct 2024 06:52:08 -0400
Message-ID: <20241028105218.3559888-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105218.3559888-1-sashal@kernel.org>
References: <20241028105218.3559888-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit a7990957fa53326fe9b47f0349373ed99bb69aaa ]

Some machines like the Dell G15 5155 emit WMI events when
suspending/resuming. Ignore those WMI events.

Tested-by: siddharth.manthan@gmail.com
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20241014220529.397390-1-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-wmi-base.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 502783a7adb11..24fd7ffadda95 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -264,6 +264,15 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
 	/*Speaker Mute*/
 	{ KE_KEY, 0x109, { KEY_MUTE} },
 
+	/* S2Idle screen off */
+	{ KE_IGNORE, 0x120, { KEY_RESERVED }},
+
+	/* Leaving S4 or S2Idle suspend */
+	{ KE_IGNORE, 0x130, { KEY_RESERVED }},
+
+	/* Entering S2Idle suspend */
+	{ KE_IGNORE, 0x140, { KEY_RESERVED }},
+
 	/* Mic mute */
 	{ KE_KEY, 0x150, { KEY_MICMUTE } },
 
-- 
2.43.0


