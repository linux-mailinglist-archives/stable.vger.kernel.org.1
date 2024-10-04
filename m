Return-Path: <stable+bounces-80968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F67990D59
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6F5281812
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546F206E8A;
	Fri,  4 Oct 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWvRTNhD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D3206E80;
	Fri,  4 Oct 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066380; cv=none; b=tPPT7wUj5H2FfJnSlKQqM5faaNj9Y3kFDd/aiNqm/3NtSsODaMieyyixkll1i8geNkmZy6YkX+tyyzQ+uo19a2ihQAE9zTS61KjX0R4E+rMasw+LAZhwndncLk8lEs/x2FdoH3Ih1uztRdItaDdQzTNaZcvJ3f48bTGLTf31BN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066380; c=relaxed/simple;
	bh=6y1Q3av88C7N5VQon/GFM8fYiqt8nz6AYSQQ7E7I65w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1ZWKzgQv5Fcxx9AH17n9WKsBxff6DoZ5bzeAau3k/8Lz8LAO8eRkpjCrG7kQz0Zkc5qdeZQbtMqWLfJzJ6Rt+BdV5GyZBz0Qr+STwryBOO+ykQeO0PiqYFVY5uUQcyNDm5k0ntXXQda/jT713lXXg5C1DiV7XbamNwSTIesbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWvRTNhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133D4C4CECC;
	Fri,  4 Oct 2024 18:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066379;
	bh=6y1Q3av88C7N5VQon/GFM8fYiqt8nz6AYSQQ7E7I65w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWvRTNhD627rKbv0sEYbukN2lWTZ35O+iC3OIuFsfR+HMQXYE9JYHVEAjZuanns7d
	 LSOhwiRQ2g4SazZhBgcbaEeYBc+tM6BZQzu24QQZHqLuy/SzelT+wB+w/lmBo8LC1c
	 UFpVvfHpvMivDSS0Ld7ekHmBOScde9gEcL/9Zw9IIirB+EnX6C0ZInX0v5x34H7EHU
	 Qd8VhRG0CMZCXh2W4BbkB8tlwtFAQACK/gamuZVNDyhQjcKOjKSEoXwpylU1tLMzwA
	 cwSwoVgeQ9r3VULQv128yc+iQuC7Ct+bGohAaayeQahY/2RBCzNH0JqEJLCOFJCMVV
	 OQHc/a2u6J6+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 42/58] usb: chipidea: udc: enable suspend interrupt after usb reset
Date: Fri,  4 Oct 2024 14:24:15 -0400
Message-ID: <20241004182503.3672477-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit e4fdcc10092fb244218013bfe8ff01c55d54e8e4 ]

Currently, suspend interrupt is enabled before pullup enable operation.
This will cause a suspend interrupt assert right after pullup DP. This
suspend interrupt is meaningless, so this will ignore such interrupt
by enable it after usb reset completed.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240823073832.1702135-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/udc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 0b7bd3c643c3a..f70ceedfb468f 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -86,7 +86,7 @@ static int hw_device_state(struct ci_hdrc *ci, u32 dma)
 		hw_write(ci, OP_ENDPTLISTADDR, ~0, dma);
 		/* interrupt, error, port change, reset, sleep/suspend */
 		hw_write(ci, OP_USBINTR, ~0,
-			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
+			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI);
 	} else {
 		hw_write(ci, OP_USBINTR, ~0, 0);
 	}
@@ -876,6 +876,7 @@ __releases(ci->lock)
 __acquires(ci->lock)
 {
 	int retval;
+	u32 intr;
 
 	spin_unlock(&ci->lock);
 	if (ci->gadget.speed != USB_SPEED_UNKNOWN)
@@ -889,6 +890,11 @@ __acquires(ci->lock)
 	if (retval)
 		goto done;
 
+	/* clear SLI */
+	hw_write(ci, OP_USBSTS, USBi_SLI, USBi_SLI);
+	intr = hw_read(ci, OP_USBINTR, ~0);
+	hw_write(ci, OP_USBINTR, ~0, intr | USBi_SLI);
+
 	ci->status = usb_ep_alloc_request(&ci->ep0in->ep, GFP_ATOMIC);
 	if (ci->status == NULL)
 		retval = -ENOMEM;
-- 
2.43.0


