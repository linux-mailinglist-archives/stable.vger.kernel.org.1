Return-Path: <stable+bounces-116977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA147A3B3D8
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4EC188D3F7
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E31CAA7D;
	Wed, 19 Feb 2025 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X8rCv6Fx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436891D47B5;
	Wed, 19 Feb 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953822; cv=none; b=ueNiimKNh4mg7oqcEg0BoRwqAVzLZ0nbg9OJeEwQC0EOs6UoS/ZVVu0JE2Ne/Qcrjqt1+N4rf5fjUQlqwYqd68Q7+xlfLQPShjoCANJiKmD912wCWD/x/OUgTBhBWW+F6vQRyBZ5xsEAuK1k2WXolv4llkCYowrbreE+yPILji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953822; c=relaxed/simple;
	bh=v15Cm43CX7HEeHbz+aEAelAjDlvv83kOQTWUdsFL5Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iI75u8tYdnWiHd8wBOTv+WORgTGAQass1iNBREPtL7b4wchapDjnr6r5LVqRyx10MdQrnuCOmHcgiHK5derzERv0XBAzksX6jxhn2z6bV4uVICWwhoMLhNTHkQ/3AGte6LzDHgV4R9RiiKuJu2QbYOW37tIoY4V0E1uu/1YYzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X8rCv6Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D529C4CEE8;
	Wed, 19 Feb 2025 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739953821;
	bh=v15Cm43CX7HEeHbz+aEAelAjDlvv83kOQTWUdsFL5Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8rCv6Fxc35hREIAii9KtONqP+6S+roFmGssL3xTPVctOOEGPxHRe8uyRbXk7hyvP
	 j66zneLNkIy8mwXt8dG15Ek1vdp9piXuw2vBE7zMzLiEenUMaL3Jq+GK8iKUSXKqth
	 B/aJ1aTOtMewyFjo43REhlL+NhlTL6WL7BtiJNgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.13 001/274] HID: corsair-void: Initialise memory for psy_cfg
Date: Wed, 19 Feb 2025 09:24:15 +0100
Message-ID: <20250219082609.595307812@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
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

From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

commit c098363828f7006ef5c5121b673bc5e26571e6c8 upstream.

power_supply_config psy_cfg was missing its initialiser, add it in.

Fixes: 6ea2a6fd3872 ("HID: corsair-void: Add Corsair Void headset family driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-corsair-void.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index bd8f3d849b58..56e858066c3c 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -553,7 +553,7 @@ static void corsair_void_battery_remove_work_handler(struct work_struct *work)
 static void corsair_void_battery_add_work_handler(struct work_struct *work)
 {
 	struct corsair_void_drvdata *drvdata;
-	struct power_supply_config psy_cfg;
+	struct power_supply_config psy_cfg = {};
 	struct power_supply *new_supply;
 
 	drvdata = container_of(work, struct corsair_void_drvdata,
-- 
2.48.1




