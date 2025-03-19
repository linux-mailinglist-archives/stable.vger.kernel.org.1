Return-Path: <stable+bounces-124997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6BBA69274
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FE31B62943
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29ED1CAA92;
	Wed, 19 Mar 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UEOY+KPJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2219DF99;
	Wed, 19 Mar 2025 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394880; cv=none; b=mnj2NWGIOssCmn+g6/LSfIQFHko/LwhgHcvFpsGwSuYOlLPEOKK4eqh4Wno4z4EXqg9crr7JmAbGx/KHObPn5x7wDISX+rPWxufwAfMJ83GC1cxWmEpxS0K/zBLwIoqg4A3/hVK6XCpfcfa2XI3vDmHmhLIj+BkeH4iCuy6KjE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394880; c=relaxed/simple;
	bh=Qp53RVcPYvP4NFO2YWORC5E/nfAHRmV/MY6zrgI/BYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+etyZzbOs3K6DJjCeqwyz129Q+d38wZD8oCCqj1r6G8fMbq8lM7rQeMZL5FGmdHO/fdeOxPgKu5pkQHrV9MgTpvzGQg5hTijoINf/bZ06VNkTE0jm7eLtKaBFrjhSp2zusGmcDyVBEPJA7DqY45S+lDHPzoJ5c38SEeU/G4n40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UEOY+KPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47968C4CEE8;
	Wed, 19 Mar 2025 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394880;
	bh=Qp53RVcPYvP4NFO2YWORC5E/nfAHRmV/MY6zrgI/BYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEOY+KPJxI6O1yZhysidYByLGfB+yCPH8n03/lP0+uLzs4qnLtimpGi6O5f0c2weF
	 eJYD5EsOgi365Lr40p4AvTxy4ZwOhlO3uJM2s0kopzAKGTjpxyrlAu9BpXInrrxCav
	 bVx6/u91Pc/CxJWMgI3yyzFbit2qagUldZUpuLbU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eugeny Shcheglov <eugenyshcheglov@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 080/241] HID: hid-steam: Fix issues with disabling both gamepad mode and lizard mode
Date: Wed, 19 Mar 2025 07:29:10 -0700
Message-ID: <20250319143029.711627027@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit 05c4ede6951b5d8e083b6bb237950cac59bdeb92 ]

When lizard mode is disabled, there were two issues:

1. Switching between gamepad mode and desktop mode still functioned, even
though desktop mode did not. This lead to the ability to "break" gamepad mode
by holding down the Options key even while lizard mode is disabled

2. If you were in desktop mode when lizard mode is disabled, you would
immediately enter this faulty mode.

This patch properly disables the ability to switch between gamepad mode and the
faulty desktop mode by holding the Options key, as well as effectively removing
the faulty mode by bypassing the early returns if lizard mode is disabled.

Reported-by: Eugeny Shcheglov <eugenyshcheglov@gmail.com>
Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-steam.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 03e57d8acdadf..10460b7bde1a2 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1051,10 +1051,10 @@ static void steam_mode_switch_cb(struct work_struct *work)
 							struct steam_device, mode_switch);
 	unsigned long flags;
 	bool client_opened;
-	steam->gamepad_mode = !steam->gamepad_mode;
 	if (!lizard_mode)
 		return;
 
+	steam->gamepad_mode = !steam->gamepad_mode;
 	if (steam->gamepad_mode)
 		steam_set_lizard_mode(steam, false);
 	else {
@@ -1623,7 +1623,7 @@ static void steam_do_deck_input_event(struct steam_device *steam,
 		schedule_delayed_work(&steam->mode_switch, 45 * HZ / 100);
 	}
 
-	if (!steam->gamepad_mode)
+	if (!steam->gamepad_mode && lizard_mode)
 		return;
 
 	lpad_touched = b10 & BIT(3);
@@ -1693,7 +1693,7 @@ static void steam_do_deck_sensors_event(struct steam_device *steam,
 	 */
 	steam->sensor_timestamp_us += 4000;
 
-	if (!steam->gamepad_mode)
+	if (!steam->gamepad_mode && lizard_mode)
 		return;
 
 	input_event(sensors, EV_MSC, MSC_TIMESTAMP, steam->sensor_timestamp_us);
-- 
2.39.5




