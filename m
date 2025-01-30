Return-Path: <stable+bounces-111621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843BA23004
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0503D18870CD
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967781E7C25;
	Thu, 30 Jan 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZeEAZrC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8C1BD9D3;
	Thu, 30 Jan 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247271; cv=none; b=ka9vKd92Nbc9NtobPQJtiuIOYXCK7dztW5lPZGxMLdySKkAgTEul2HOiyKJrOyJNQsQElrgcV+s598G36vB9NKHhA/6sp8V3zQvUOXa7qtapdvqAOG4JyyBB6yT3mefujdUfTiBXO/PEg1dOn3JnsCW2c4HbP+AESJZfu79hAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247271; c=relaxed/simple;
	bh=WZcc9Vs1tZXUCoybRi8s/cG3G1Qg8XEQbSZRh8th4BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8GIvmiP/fJFs3AShY6wJdDpD9ECmZJXtnjkEvbXyzIpI0Z+4xjx+9EMGbFzkGBPR/Z9uBFXfwdcgXDCRdAfH/tn3KhvyxAlyKkeRYQI8eIQki12f/ktzyZvzx13r+SDSx6ewMvyc5gF73s8NZE1Og/oH2CT0Z/W8UJhPIUMaNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZeEAZrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A79C4CED2;
	Thu, 30 Jan 2025 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247270;
	bh=WZcc9Vs1tZXUCoybRi8s/cG3G1Qg8XEQbSZRh8th4BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vZeEAZrCA8e5J+DDL30NhtaLM/JoGkxjgh1Fk25JyzCjnzGngWvOLUN1HvWeEU/mK
	 xw6MU7fDBsdG2HP8QjIsgcXdnKF7OQ++XfXqYV0206u7sCrbkELgzROvoYBG1Xm1Ik
	 0m3wG3LXUPo32wIHDceCIbJySfGPep4+ByjdFWJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jack Greiner <jack@emoss.org>,
	Pavel Rojtberg <rojtberg@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.10 133/133] Input: xpad - add support for wooting two he (arm)
Date: Thu, 30 Jan 2025 15:02:02 +0100
Message-ID: <20250130140147.878786749@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Greiner <jack@emoss.org>

commit 222f3390c15c4452a9f7e26f5b7d9138e75d00d5 upstream.

Add Wooting Two HE (ARM) to the list of supported devices.

Signed-off-by: Jack Greiner <jack@emoss.org>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
Link: https://lore.kernel.org/r/20250107192830.414709-3-rojtberg@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/xpad.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -345,6 +345,7 @@ static const struct xpad_device {
 	{ 0x31e3, 0x1200, "Wooting Two", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1210, "Wooting Lekker", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1220, "Wooting Two HE", 0, XTYPE_XBOX360 },
+	{ 0x31e3, 0x1230, "Wooting Two HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1300, "Wooting 60HE (AVR)", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1310, "Wooting 60HE (ARM)", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0607, "Nacon GC-100", 0, XTYPE_XBOX360 },



