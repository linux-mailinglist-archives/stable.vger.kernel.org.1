Return-Path: <stable+bounces-39515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF08A51F3
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD0D1F21169
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117D7A140;
	Mon, 15 Apr 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj4BktkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F878C6A
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188360; cv=none; b=NZJWRlziw0wRcp0iOau6vIrbti0RzuUTC96XMbpEW+iJmhbRhFPicDYyEadqmkctYI8nkiSALgNuGomkfryhd6DgOjCwCYr/xK2uDgFG8arJgMoaNxnMsnRQhEuIdCndo2Xv0Yj481GoFL1+FsR1IjpDMKFtDSHICofFtrBws5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188360; c=relaxed/simple;
	bh=CYAMeCMSWX24McfpPyxQR9lweOfdsQ+B7FhhQJ0nCQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaQpyLPqOcb28Zblr7/UuPJ5jC4qmLsE6nEeV/A/C3rLJMJ5IyIsCA2wScbOQxM4DBpSQxEPxnEbDuQI9zXVJwftS9p/bFouf9hclcEly+X4P+hL2uzxi1JpV5wKWZDOuwe/lawIb+WiVWX2VUfSLHzcRQHETk/uo7mYMC8Sz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj4BktkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D060C3277B;
	Mon, 15 Apr 2024 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188360;
	bh=CYAMeCMSWX24McfpPyxQR9lweOfdsQ+B7FhhQJ0nCQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dj4BktkXANeae0R/pOm8nLSa8yYUlEVFTw0luacyudpJ8aUj9I3hLhM61lTh5gYLd
	 ZxJ3p3pOhVDRsvnjBIMNszA5rzJJVRt+aTjAepO7yt4Y+kCzdRnsm5rxS+Y5oev6H1
	 ww/ftYMt6QkprEogiP5aCx1m+P4V3U1OsfJjLi5FXIZ863hILdoY2iuBEChsfUVDkA
	 yUwU6aGCQMIA77/5Hs7KklCr2xJYBlKKIgIs10h1ALPQjc+agiRYVzqYKLwrYuUE8J
	 OI0udwwTYUORMwNjmlaQLCdrldtUViXxZV8+h+Gtq4yy9d6f+qZE4Hradu57jVNzRM
	 FCwSAhBACcMYQ==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Drew Fustini <drew@beagleboard.org>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 049/190] usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling
Date: Mon, 15 Apr 2024 06:49:39 -0400
Message-ID: <20240415105208.3137874-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

[ Upstream commit b65ba0c362be665192381cc59e3ac3ef6f0dd1e1 ]

In commit 92af4fc6ec33 ("usb: musb: Fix suspend with devices
connected for a64"), the logic to support the
MUSB_QUIRK_B_DISCONNECT_99 quirk was modified to only conditionally
schedule the musb->irq_work delayed work.

This commit badly breaks ECM Gadget on AM335X. Indeed, with this
commit, one can observe massive packet loss:

$ ping 192.168.0.100
...
15 packets transmitted, 3 received, 80% packet loss, time 14316ms

Reverting this commit brings back a properly functioning ECM
Gadget. An analysis of the commit seems to indicate that a mistake was
made: the previous code was not falling through into the
MUSB_QUIRK_B_INVALID_VBUS_91, but now it is, unless the condition is
taken.

Changing the logic to be as it was before the problematic commit *and*
only conditionally scheduling musb->irq_work resolves the regression:

$ ping 192.168.0.100
...
64 packets transmitted, 64 received, 0% packet loss, time 64475ms

Fixes: 92af4fc6ec33 ("usb: musb: Fix suspend with devices connected for a64")
Cc: stable@vger.kernel.org
Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Tested-by: Drew Fustini <drew@beagleboard.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Link: https://lore.kernel.org/r/20210528140446.278076-1-thomas.petazzoni@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 9ed604ddbb585..580f4c12eada3 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1869,9 +1869,8 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 			schedule_delayed_work(&musb->irq_work,
 					      msecs_to_jiffies(1000));
 			musb->quirk_retries--;
-			break;
 		}
-		/* fall through */
+		break;
 	case MUSB_QUIRK_B_INVALID_VBUS_91:
 		if (musb->quirk_retries && !musb->flush_irq_work) {
 			musb_dbg(musb,
-- 
2.43.0


