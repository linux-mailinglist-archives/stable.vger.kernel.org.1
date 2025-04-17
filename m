Return-Path: <stable+bounces-133448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB2A925CD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F433188FEBD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26962257AE7;
	Thu, 17 Apr 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2WMjzsEH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADF257AC6;
	Thu, 17 Apr 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913107; cv=none; b=RWloteD2uu9fwDbzbHqSMjYzDHOlsqTIETHd6BJ0fvhxTIUkV+5dqUSF8dNhr3rT48C53uRJNU+owjCDzxOhEOQx9tv39g3JacE/5YVZld1REzg2iqbXu5X9yfuz0C2r0S+7lUJQjHZJ0/VbvJZlMCjVVYt6IcLmCdFITA56UCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913107; c=relaxed/simple;
	bh=EsCsPPYzEMcOUK9lYErQLs8rDTUzIE91iXWsuFeml7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KT1G9PdffCtduukqALIahGnOuacl277AUoPBSJHwTac2sEwLUzhEM93WoHj74iVJBW9Xy6fB5dvwoSJKtR4h0610FiTYKuRentXwkR5r2x3UWto079VNLhF3af7QYxYc5sO+TTmVX2r4yE5Kglvo94FVEjGbd/x61QhmLougBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2WMjzsEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CC8C4CEE4;
	Thu, 17 Apr 2025 18:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913107;
	bh=EsCsPPYzEMcOUK9lYErQLs8rDTUzIE91iXWsuFeml7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2WMjzsEHZ4A8GdKnilo+XdrcGMiv/8FU2dmJRCegyTCtwBjCYS3DnpoPPFbIcl7MS
	 0xOXg1Va4SZnE9rnPSsS0RP3mq1BuKehgUZPyslQWbirXrYkSCg66ys49/0xqfMwUv
	 OcWgOQBln8eOa3bDdddkn+rCgnS6pS278Q3M1d1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>,
	Paul Dino Jones <paul@spacefreak18.xyz>,
	=?UTF-8?q?Crist=C3=B3ferson=20Bueno?= <cbueno81@gmail.com>,
	Pablo Cisneros <patchkez@protonmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 199/449] HID: pidff: Simplify pidff_upload_effect function
Date: Thu, 17 Apr 2025 19:48:07 +0200
Message-ID: <20250417175125.982877234@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit e4bdc80ef14272ef56c38d8ca2f365fdf59cd0ba ]

Merge a bit of code that reqeusts conditional effects upload.
Makes it clear, that effect handling should be identical for
SPRING, DAMPER, INERTIA and FRICTION.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Reviewed-by: Michał Kopeć <michal@nozomi.space>
Reviewed-by: Paul Dino Jones <paul@spacefreak18.xyz>
Tested-by: Paul Dino Jones <paul@spacefreak18.xyz>
Tested-by: Cristóferson Bueno <cbueno81@gmail.com>
Tested-by: Pablo Cisneros <patchkez@protonmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 54 ++++++++++------------------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 99b5d3deb40d0..42c951a1d65bf 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -770,48 +770,26 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 		break;
 
 	case FF_SPRING:
-		if (!old) {
-			error = pidff_request_effect_upload(pidff,
-					pidff->type_id[PID_SPRING]);
-			if (error)
-				return error;
-		}
-		if (!old || pidff_needs_set_effect(effect, old))
-			pidff_set_effect_report(pidff, effect);
-		if (!old || pidff_needs_set_condition(effect, old))
-			pidff_set_condition_report(pidff, effect);
-		break;
-
-	case FF_FRICTION:
-		if (!old) {
-			error = pidff_request_effect_upload(pidff,
-					pidff->type_id[PID_FRICTION]);
-			if (error)
-				return error;
-		}
-		if (!old || pidff_needs_set_effect(effect, old))
-			pidff_set_effect_report(pidff, effect);
-		if (!old || pidff_needs_set_condition(effect, old))
-			pidff_set_condition_report(pidff, effect);
-		break;
-
 	case FF_DAMPER:
-		if (!old) {
-			error = pidff_request_effect_upload(pidff,
-					pidff->type_id[PID_DAMPER]);
-			if (error)
-				return error;
-		}
-		if (!old || pidff_needs_set_effect(effect, old))
-			pidff_set_effect_report(pidff, effect);
-		if (!old || pidff_needs_set_condition(effect, old))
-			pidff_set_condition_report(pidff, effect);
-		break;
-
 	case FF_INERTIA:
+	case FF_FRICTION:
 		if (!old) {
+			switch(effect->type) {
+			case FF_SPRING:
+				type_id = PID_SPRING;
+				break;
+			case FF_DAMPER:
+				type_id = PID_DAMPER;
+				break;
+			case FF_INERTIA:
+				type_id = PID_INERTIA;
+				break;
+			case FF_FRICTION:
+				type_id = PID_FRICTION;
+				break;
+			}
 			error = pidff_request_effect_upload(pidff,
-					pidff->type_id[PID_INERTIA]);
+					pidff->type_id[type_id]);
 			if (error)
 				return error;
 		}
-- 
2.39.5




