Return-Path: <stable+bounces-74773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3424E97315F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0401F27BFF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5B18C01F;
	Tue, 10 Sep 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAJLpBQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6118B491;
	Tue, 10 Sep 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962787; cv=none; b=SSD+jka6ODRfV73AxDTUCMxNhxLpJI/XmWR3wW4JUs7bCgeLwYNb0QLBTf1TsJ20i2b/wUAPioUeVi8kGD5i5OSRcSGuku4jWWb/Gim37J5lBWC4XzEHMxfPzF+fnIYi5W0+gwJQnwVXa49h7dSEaY3OCJuqPjFnA7sgsSLL5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962787; c=relaxed/simple;
	bh=2cdPaha8tvOjkzVeNbcwbwtRkYpkZJilQwu4rzGM7JM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkseJPGtdUasYypIPZB9mu2Q+2gVwiRELdJd1tOxb7u4MInNMN9+ON6fbbUzh5B1dLxD2eaShuqRcpkaOOxxa9+aGN2tg/WxluZxGXPKKXpixmLiGDrGdlqGGSJiVIQRbhb0ufkLHc19La9VxQyfZnleE1i6vU29/Lf2Ox6nUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAJLpBQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A999C4CEC3;
	Tue, 10 Sep 2024 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962787;
	bh=2cdPaha8tvOjkzVeNbcwbwtRkYpkZJilQwu4rzGM7JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAJLpBQLRg5BM5mhk1IRswiyiUTUHBLF3uqp9GS+jf6e2mBUJ74qWijcxe4rWz/L+
	 k5n7ivmmG19G4E22IVEJKxQE4jiNHBzuZMhJ+9qbFgieg4KkA4F45PCpL+PrslZa2C
	 j9O+CSGA3YRZi4W3f0sZZu9AfjJJdcfeHaz9dXkg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Arlott <simon@octiron.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1 030/192] can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open
Date: Tue, 10 Sep 2024 11:30:54 +0200
Message-ID: <20240910092559.192256351@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Arlott <simon@octiron.net>

commit 7dd9c26bd6cf679bcfdef01a8659791aa6487a29 upstream.

The mcp251x_hw_wake() function is called with the mpc_lock mutex held and
disables the interrupt handler so that no interrupts can be processed while
waking the device. If an interrupt has already occurred then waiting for
the interrupt handler to complete will deadlock because it will be trying
to acquire the same mutex.

CPU0                           CPU1
----                           ----
mcp251x_open()
 mutex_lock(&priv->mcp_lock)
  request_threaded_irq()
                               <interrupt>
                               mcp251x_can_ist()
                                mutex_lock(&priv->mcp_lock)
  mcp251x_hw_wake()
   disable_irq() <-- deadlock

Use disable_irq_nosync() instead because the interrupt handler does
everything while holding the mutex so it doesn't matter if it's still
running.

Fixes: 8ce8c0abcba3 ("can: mcp251x: only reset hardware as required")
Signed-off-by: Simon Arlott <simon@octiron.net>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/4fc08687-1d80-43fe-9f0d-8ef8475e75f6@0882a8b5-c6c3-11e9-b005-00805fc181fe.uuid.home.arpa
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/spi/mcp251x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -753,7 +753,7 @@ static int mcp251x_hw_wake(struct spi_de
 	int ret;
 
 	/* Force wakeup interrupt to wake device, but don't execute IST */
-	disable_irq(spi->irq);
+	disable_irq_nosync(spi->irq);
 	mcp251x_write_2regs(spi, CANINTE, CANINTE_WAKIE, CANINTF_WAKIF);
 
 	/* Wait for oscillator startup timer after wake up */



