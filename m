Return-Path: <stable+bounces-89036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73309B2DFA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 12:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234AE1C22379
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0FD200C85;
	Mon, 28 Oct 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbW0m7EK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61961DA100;
	Mon, 28 Oct 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112787; cv=none; b=YyhU/lgwgB0CF5c/3+BKM53ByQ6ROyaXLfSlu8FDiEru+M6Q+EWhPeDuiBj62311kw0HtnEOw84fKsvZKbzX21S/ed69ZezXK5AMXCAKztCj4hFIktBpXDE35yLQTjB1Cm2PcMpzGlfc+ygzXbHjhCIfYUkYihRKHnktYEhsqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112787; c=relaxed/simple;
	bh=+eeFzBLeWQ/yCXaN53gII6lkCRzdT0pvSPCz8xFZY1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzuWgO8wr56+QW66PgnZ7ZCCm5fHN69liLvdst62uDo49liLy6NdEWpgfn/lZx0lRfnS/zFqMcLpfcew2jvzTVmCJXDAywaKVCfprM4jkRkHLpJchwYOOdGTgSGnVz+xpzS0wu8K3cm0gQPuVBKqPeKgspgs3Gx08oHFsV883Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbW0m7EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B49C4AF0B;
	Mon, 28 Oct 2024 10:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112786;
	bh=+eeFzBLeWQ/yCXaN53gII6lkCRzdT0pvSPCz8xFZY1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbW0m7EKALWoeniv7WsY5Z0uY6QKrsgPpO1eJnFTbiX5df32WnQt82sDZjAMeFyzD
	 WuP1FTjBTjKQV7jgYpm1HiSQMPhQgeL3hY5ozrUYUfauLfV02GrnuDdyzvxooDqRf1
	 SaptgEoWNY7P8KXdUE/maBh10+HMGMG0cCjN1+6iWJf15DFCnOvYn761YyB2fuOfTA
	 HUz3Vuyam7MuHSvqVquYLfvUXnpvRYp+EG9jiEgjOaahr4N/Qct5DNFdQyFP1CEvrm
	 MmtcTfVp8mTisu4fTO+Ey4pQ2uX8X8tSlBlHD/K/rLr5MwSnGqI1ajG88WMLEA8rzi
	 /Z/vXdgY7ftNg==
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
Subject: [PATCH AUTOSEL 6.1 7/8] platform/x86: dell-wmi: Ignore suspend notifications
Date: Mon, 28 Oct 2024 06:52:48 -0400
Message-ID: <20241028105252.3560220-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105252.3560220-1-sashal@kernel.org>
References: <20241028105252.3560220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
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


