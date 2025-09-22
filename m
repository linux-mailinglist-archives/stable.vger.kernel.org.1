Return-Path: <stable+bounces-181111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B579FB92DBB
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0032A756A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC627FB2D;
	Mon, 22 Sep 2025 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KeS4TjEy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ABE2DF714;
	Mon, 22 Sep 2025 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569718; cv=none; b=WMTM19OqKywdc6Z6GOrJMiX5VCewXa92rdElWALwpC2D0rlP9wStgrtnGJINCa1NhmUYhevEjgx8FO+o8Lhj3ylXgYR58J//V7xqmf0QCCRl+9uHEwPFPp3gZ8KZLF7Bqw1QzgPUdXyrRgeJRboqjXMVV21xiKuUIqsobpkm1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569718; c=relaxed/simple;
	bh=P/OYT8poP7Cd365orulGCGqn5M/2OnzribtcLo7geHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7KUTwoECR0TE8ywTkD4HFgxLM6ADZP0tJ5b+/gsFuD6QntxCMwlza3vTsW2hxpjHGZkwq/fWZDZ0L2Otv7DW1v0gBho6Lw/BPP3at1jjmfPY9aoNyJI9iF7rrMODWDn58yer7ardb3ZFVg4JL9TSTgZapEziUj/GsBnZLM72GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KeS4TjEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B442C4CEF0;
	Mon, 22 Sep 2025 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569717;
	bh=P/OYT8poP7Cd365orulGCGqn5M/2OnzribtcLo7geHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeS4TjEyIy3z+JQA3dQbNEHPIgaiEWNk3/2Xw2tHk7XHwbog++yDVuNw5HL707vJC
	 DQeViAhkkUjegib0e+5YuzQQTX/ZB6Vsy7eM9JfBEzRoNFPyGgTuxeY6nGODho+AUJ
	 ZNC2BJscoMgW/3QY7wb7s1+zsYaUZGKCMTM8d3q8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jerry Lv <Jerry.Lv@axis.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.6 30/70] power: supply: bq27xxx: fix error return in case of no bq27000 hdq battery
Date: Mon, 22 Sep 2025 21:29:30 +0200
Message-ID: <20250922192405.403633203@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: H. Nikolaus Schaller <hns@goldelico.com>

commit 2c334d038466ac509468fbe06905a32d202117db upstream.

Since commit

	commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")

the console log of some devices with hdq enabled but no bq27000 battery
(like e.g. the Pandaboard) is flooded with messages like:

[   34.247833] power_supply bq27000-battery: driver failed to report 'status' property: -1

as soon as user-space is finding a /sys entry and trying to read the
"status" property.

It turns out that the offending commit changes the logic to now return the
value of cache.flags if it is <0. This is likely under the assumption that
it is an error number. In normal errors from bq27xxx_read() this is indeed
the case.

But there is special code to detect if no bq27000 is installed or accessible
through hdq/1wire and wants to report this. In that case, the cache.flags
are set historically by

	commit 3dd843e1c26a ("bq27000: report missing device better.")

to constant -1 which did make reading properties return -ENODEV. So everything
appeared to be fine before the return value was passed upwards.

Now the -1 is returned as -EPERM instead of -ENODEV, triggering the error
condition in power_supply_format_property() which then floods the console log.

So we change the detection of missing bq27000 battery to simply set

	cache.flags = -ENODEV

instead of -1.

Fixes: f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
Cc: Jerry Lv <Jerry.Lv@axis.com>
Cc: stable@vger.kernel.org
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Link: https://lore.kernel.org/r/692f79eb6fd541adb397038ea6e750d4de2deddf.1755945297.git.hns@goldelico.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/bq27xxx_battery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1873,7 +1873,7 @@ static void bq27xxx_battery_update_unloc
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
 	if ((cache.flags & 0xff) == 0xff)
-		cache.flags = -1; /* read error */
+		cache.flags = -ENODEV; /* read error */
 	if (cache.flags >= 0) {
 		cache.temperature = bq27xxx_battery_read_temperature(di);
 		if (di->regs[BQ27XXX_REG_TTE] != INVALID_REG_ADDR)



