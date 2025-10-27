Return-Path: <stable+bounces-189930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B964C0C1E4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B93BD483
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ADA2DE70A;
	Mon, 27 Oct 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKg4i6z+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B772DC32E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549951; cv=none; b=pnKlgXDtvwqTqs+QE0BRPbi3U94a2F+kb0PH9CTsfsZXRn89YqG0f33hCEQqYOhhJH4bLVKRUQpaz80dDdXTTb22ugr+9kEztjX3ErvAkFIGkvrx9ablYvJ0/gP3B+6i4AHAjucl9gK7YSmWkQ9EAMnMEd0dfzarNLcgqJBo6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549951; c=relaxed/simple;
	bh=DL6CapESvFZvh/Q4qC+k6zqolKWwHywYpo1WXdjs5sE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TL1Mw4MtKiCozKW5/kbVnKa+IZoY5NNbw4cZm9K4kaAHCnDvdpsI8MNQ5qVJrV+WGiemn39rVuxwsuowhvgCsLqLUV3nMnXF/Gd+sbFFVrzn2V91FBLA7ab26nHv68chi58hTtKbDBRLCwn+i62hHMgsLqTTQXPvTUexBWgOWLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKg4i6z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF47C4CEF1;
	Mon, 27 Oct 2025 07:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761549950;
	bh=DL6CapESvFZvh/Q4qC+k6zqolKWwHywYpo1WXdjs5sE=;
	h=Subject:To:Cc:From:Date:From;
	b=dKg4i6z+357JppDXwGI+HWY1wCYWqo7FIt0G34os5lUH5TZDzJHMaisBSLeH2By1H
	 6u6ZakxvtITnHoKeMiLpuvabzuv/3wqqaCTnfS/k5asyGOThiRb9gjD3/1aPcPG6uw
	 F4ITIcw/PRv9RXYw2u8+ci02dED9tbCEO8fW2r3E=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: remove useless enable of enhanced features" failed to apply to 6.1-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Oct 2025 08:25:39 +0100
Message-ID: <2025102739-fable-reroute-e6a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1c05bf6c0262f946571a37678250193e46b1ff0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102739-fable-reroute-e6a6@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


