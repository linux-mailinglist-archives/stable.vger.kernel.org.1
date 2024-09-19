Return-Path: <stable+bounces-76761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C7397CADA
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B282A285562
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54C119E827;
	Thu, 19 Sep 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="R6mb2oGu"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9D1DFF0
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755529; cv=none; b=c8B260iWYpPbTTlAjl/8pOxBpcuNMYluMmLmEqQIaJJcc5tAGXU0AsKIYVggWWKmXR4mXKkxhUKSyauqBltqyci09w8zAZRlEHY0UHht/9qeXtFSVYYNDOx43VlDlyub0+8+qnDNB3KBjRP0kF7UJLM1YbQZ/epR8gkHmGXIedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755529; c=relaxed/simple;
	bh=qgMd4ThCSi8effxjeCSWVkiDs8OsQjAWiaxgn5Nd9dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwxNe1eHwnRnXiT+dSIiJxwDOVVsfSTHo60SPXIahJl/F7gF7Lt55ROJ/qao7cJ2cHx3Df87X3iYL9SlCMBjvlix77HW67htg39c27XMXN7LAwt5BFbHUbVpiNna3f5sRlN9at41SarwPJ3LkR7E2Q/WFkge8F5Gxm45x/SuMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=R6mb2oGu; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726755515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=snyx7wTJ0ORUFxkCD6kpfLUgT5IHRFn/VSM1qztSJ6Y=;
	b=R6mb2oGuleVWrqoUORjvhEiCw3x3DG6N9WVJmkOHbHhuOJYL8qGWTMiZm8AQx5RXP4pO9o
	YnCXL6ISs7gdxK3omo2PjuYjexQNq9VO5SarNWNWltvRKf40JlLya8q0ba1K7gjj+fooK3
	2k6w9MzbTXNgrmay1TAjkvuTFwPZzQw=
To: darefyev@mail.ru
Cc: stable@vger.kernel.org
Subject: [PATCH 5/10] Input: adp5588-keys - added a check key_val
Date: Thu, 19 Sep 2024 17:18:34 +0300
Message-Id: <20240919141834.100309-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this commit.

If the adp5588_read function returns 0, then there will be an
overflow of the kpad->keycode[key_val - 1] buffer.

If the adp5588_read function returns a negative value, then the
logic is broken - the wrong value is used as an index of
the kpad->keycode array.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/input/keyboard/adp5588-keys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 90a59b973d00..19be8054eb5f 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -272,6 +272,8 @@ static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
 		int key = adp5588_read(kpad->client, Key_EVENTA + i);
 		int key_val = key & KEY_EV_MASK;
 
+		if (key_val <= 0)
+			continue;
 		if (key_val >= GPI_PIN_BASE && key_val <= GPI_PIN_END) {
 			for (j = 0; j < kpad->gpimapsize; j++) {
 				if (key_val == kpad->gpimap[j].pin) {
-- 
2.25.1


