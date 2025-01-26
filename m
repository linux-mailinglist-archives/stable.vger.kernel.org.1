Return-Path: <stable+bounces-110785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F2AA1CC67
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DC81885042
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DEB248181;
	Sun, 26 Jan 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrRFSiDU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCF124817A;
	Sun, 26 Jan 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904171; cv=none; b=j7R344ia+ayS/LXukqgjkVcPRjuCFbnq2CjmwxBSGyMWVCSL210bEYTw3q2g05dc6QBgG//XBizBpRjwwz9hwB7jA8sjGxtRwHMa8HEHGOXF2fricz1dWoP9uOtEClgOUlzpbFyaAFgFYfmkBPl3OV/Z7axMPTYW7jQl02G67tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904171; c=relaxed/simple;
	bh=OerpSP185xebxhE/qOsOtyWzvkg5Fq4iSO69ExcvLog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isfuPhKYanlf6Xj50sONpxUn1PMNsNpWHNvrpKacRRjmfnZ4qduBVJ4aJQ1FUP+0xon7Gk/TP0MEz/s0fkSTtiRIuIwPw8sGnda+1TeQf/X3uyiNgnKhl28EVJF6hBRCmHzqrxOQuwUiHZf54iD6xfLG20M4VA1vLH0uj8Okft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrRFSiDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DD3C4CED3;
	Sun, 26 Jan 2025 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904171;
	bh=OerpSP185xebxhE/qOsOtyWzvkg5Fq4iSO69ExcvLog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrRFSiDULm5Bv+y6fkwEoj+ILdTEJeWKAxoHJRx3u0cgm9wVM6XZw1yaKOqXUvOf5
	 y+zkhXtfWdh93jjDd0uA64f3UpwgdpTb3ave9JoQT3Ca2gUMrOtTV+pjchGjnjTbEL
	 e9gyfk4bCaxsgI8mEcapbsB2rZmoNjkkcQxE/PCxoeDu5lgLm632Z1YnN1XI3tNZjh
	 bhXTw0/AtVjpU99TcsZ7EOvT5L3SHhFitci+ucwRbCnP2oOraMI9yojeD1bIXcHCxH
	 n/r2jYf/Jeqq7cTqJOycksyu0J10rKDmK0INhZlEPy7qasgzioo3R4RwekjtvkrIhf
	 r0xtjig+ZOwkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Farhan Anwar <farhan.anwar8@gmail.com>,
	Rayan Margham <rayanmargham4@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/3] platform/x86: acer-wmi: Ignore AC events
Date: Sun, 26 Jan 2025 10:09:22 -0500
Message-Id: <20250126150923.962963-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150923.962963-1-sashal@kernel.org>
References: <20250126150923.962963-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit f6bfa25c6665f8721421ea94fe506cc22f1d4b43 ]

On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
AC connect/disconnect. Ignore those events to avoid spamming the
kernel log with error messages.

Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b8-120c8e7afec8@gmail.com
Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20250119201723.11102-2-W_Armin@gmx.de
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 82516796a53b0..7ef80f517e76e 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -88,6 +88,7 @@ enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT = 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
+	WMID_AC_EVENT = 0x8,
 };
 
 static const struct key_entry acer_wmi_keymap[] __initconst = {
@@ -2067,6 +2068,9 @@ static void acer_wmi_notify(u32 value, void *context)
 		if (return_value.key_num == 0x4)
 			acer_toggle_turbo();
 		break;
+	case WMID_AC_EVENT:
+		/* We ignore AC events here */
+		break;
 	default:
 		pr_warn("Unknown function number - %d - %d\n",
 			return_value.function, return_value.key_num);
-- 
2.39.5


