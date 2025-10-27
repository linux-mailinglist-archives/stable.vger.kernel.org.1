Return-Path: <stable+bounces-189931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81088C0C1ED
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A01514F0827
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795B62DCF6C;
	Mon, 27 Oct 2025 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iyggeTph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFD2DCBF1
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549954; cv=none; b=sq1DMJjDlcElKjRaRrWloGUgQ+MWAJhX3MKKAKSwgU4AJ6TFtQDT2e2pFHQPaLELdc+kh5F4RPAyXv6Trmjlj3p2YwHV+bVebpX7GVOOX8BMQleet5KDGDdT8EEyY710dAPHIQNvNIXwNmzwm70C8HJaw6NxRKKZs+eTyUg1K6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549954; c=relaxed/simple;
	bh=0ZlPm43a+JJxYY27zHj3j/V5AHJYUnR5KAsj/D/i+R8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I4IqYT/1kGEqZQAO6rHRhTjrpRG9szdfHEa/JbdVBsCkB6lRYvmF3Pb7cMWb1lKPAsmnKG1CUJD5UOPX8jtKbu3TQ0Z/hYrEp3xbq3JytPfze2usSPf6+LvLKFducwKp7LihhALqW03rQOLDkTmIw3KUZ+4ijX0td/fLY8WRG1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iyggeTph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4407BC4CEF1;
	Mon, 27 Oct 2025 07:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761549953;
	bh=0ZlPm43a+JJxYY27zHj3j/V5AHJYUnR5KAsj/D/i+R8=;
	h=Subject:To:Cc:From:Date:From;
	b=iyggeTphNbeIjWKqB/yVeVKMF1lu+TKoK9AIHVIZE2oDGM8z1f/j2/0QjUMHTV4Y/
	 UNp6atUS7wMg9leGLVSuXLtBr4MWEfUDBGi42EdsGt3qg8ZFtGlJZ579OOhbvvkwU2
	 kz0kcoDi7IBfB33CIV6bhmU1p8wG3XpWGKP/eFsQ=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: remove useless enable of enhanced features" failed to apply to 5.10-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Oct 2025 08:25:40 +0100
Message-ID: <2025102740-umpire-tactile-9042@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1c05bf6c0262f946571a37678250193e46b1ff0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102740-umpire-tactile-9042@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c05bf6c0262f946571a37678250193e46b1ff0f Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 6 Oct 2025 10:20:02 -0400
Subject: [PATCH] serial: sc16is7xx: remove useless enable of enhanced features

Commit 43c51bb573aa ("sc16is7xx: make sure device is in suspend once
probed") permanently enabled access to the enhanced features in
sc16is7xx_probe(), and it is never disabled after that.

Therefore, remove re-enable of enhanced features in
sc16is7xx_set_baud(). This eliminates a potential useless read + write
cycle each time the baud rate is reconfigured.

Fixes: 43c51bb573aa ("sc16is7xx: make sure device is in suspend once probed")
Cc: stable <stable@kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://patch.msgid.link/20251006142002.177475-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 1a2c4c14f6aa..c7435595dce1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -588,13 +588,6 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 		div /= prescaler;
 	}
 
-	/* Enable enhanced features */
-	sc16is7xx_efr_lock(port);
-	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_ENABLE_BIT,
-			      SC16IS7XX_EFR_ENABLE_BIT);
-	sc16is7xx_efr_unlock(port);
-
 	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,


