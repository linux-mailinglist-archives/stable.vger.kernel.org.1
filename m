Return-Path: <stable+bounces-175054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C1B36694
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE53BF87F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9053134AAFE;
	Tue, 26 Aug 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EnXbGAfS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C23A350D70;
	Tue, 26 Aug 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216019; cv=none; b=JXIyfpfO2K/TAYlheqXKsX+Zsp2LS+PtlW+TpxSS/zM0uGmY/jfB3zA5iET2jBh6aXmspwCVTnfRrlrikdnw6wxLJdI0QOGYN01PTXQeP4EF5VPMvI1ZrMyw6vcrdDirPqgXsvvDv2kjdI4mLynIejhc3/A0E7B2kw2tTyMjsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216019; c=relaxed/simple;
	bh=jcHpWAHVFf4BDUokns77d4aUMcM4S1oW/0Ro6zbGeb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAYB50GVwrBoy5NFgEm43g0c0CU25SkTRBI0qPF1VDm2ID7y+13jOKz1kZ9C6wTG6nN+E9X93dx7P4McDfFMFyqFzYRR6CTIlhqJaHF0IJWssfqbAN7mD5L8yJ6kTNvDnQ+zkpYxSe+atSplOgdGcAxye7qOftSUjYc0OBj1yqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EnXbGAfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D287CC4AF09;
	Tue, 26 Aug 2025 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216019;
	bh=jcHpWAHVFf4BDUokns77d4aUMcM4S1oW/0Ro6zbGeb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EnXbGAfStFk0SD7c33+nzO7qBsizILlHlfi8HGWf+X/CYlXyHiMkLZ2LWKKUJOq3f
	 WIc4xiGR8XKEOkPPSKLlTE6+J9To7AMixj7+w1HU6LjbB/20op2XG9z4JCur+/muUO
	 VX1VWc0masePOWVwqmaNp1ndYvrFq5bcFfFHzTgo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Armando Budianto <sprite@gnuweeb.org>,
	Simon Horman <horms@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 5.15 253/644] net: usbnet: Fix the wrong netif_carrier_on() call
Date: Tue, 26 Aug 2025 13:05:44 +0200
Message-ID: <20250826110952.653619105@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

commit 8466d393700f9ccef68134d3349f4e0a087679b9 upstream.

The commit referenced in the Fixes tag causes usbnet to malfunction
(identified via git bisect). Post-commit, my external RJ45 LAN cable
fails to connect. Linus also reported the same issue after pulling that
commit.

The code has a logic error: netif_carrier_on() is only called when the
link is already on. Fix this by moving the netif_carrier_on() call
outside the if-statement entirely. This ensures it is always called
when EVENT_LINK_CARRIER_ON is set and properly clears it regardless
of the link state.

Cc: stable@vger.kernel.org
Cc: Armando Budianto <sprite@gnuweeb.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com
Closes: https://lore.kernel.org/netdev/CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com
Closes: https://lore.kernel.org/netdev/0752dee6-43d6-4e1f-81d2-4248142cccd2@gnuweeb.org
Fixes: 0d9cfc9b8cb1 ("net: usbnet: Avoid potential RCU stall on LINK_CHANGE event")
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/usbnet.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1118,6 +1118,9 @@ static void __handle_link_change(struct
 	if (!test_bit(EVENT_DEV_OPEN, &dev->flags))
 		return;
 
+	if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
+		netif_carrier_on(dev->net);
+
 	if (!netif_carrier_ok(dev->net)) {
 		/* kill URBs for reading packets to save bus bandwidth */
 		unlink_urbs(dev, &dev->rxq);
@@ -1127,9 +1130,6 @@ static void __handle_link_change(struct
 		 * tx queue is stopped by netcore after link becomes off
 		 */
 	} else {
-		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
-			netif_carrier_on(dev->net);
-
 		/* submitting URBs for reading packets */
 		tasklet_schedule(&dev->bh);
 	}



