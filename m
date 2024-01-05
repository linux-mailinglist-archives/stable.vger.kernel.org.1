Return-Path: <stable+bounces-9771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA28250CD
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67D12859FC
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433922F0C;
	Fri,  5 Jan 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wiM13aBN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143922F04
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBE0C433C7;
	Fri,  5 Jan 2024 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446645;
	bh=WOHeho1pN33rNmoYfgreFgKx3jUOAsKK/obb44LAsmE=;
	h=Subject:To:From:Date:From;
	b=wiM13aBNUIlkrXh1wxIfgh0OlyH7zpg6I0SsLthN2ye/Vu3JJ4HW7fPfy5XTrRYBx
	 ZYaTxMr0vItp6dPEfPhr0NpwAD4VqAH5mwrEEoczxqyRCsWQ0VeYtOlMMNcoFmf2uq
	 NTmyPvoIUBOxxZLYXqE8B1kirC7tB2UBQq+L2eOY=
Subject: patch "usb: chipidea: wait controller resume finished for wakeup irq" added to usb-next
To: xu.yang_2@nxp.com,gregkh@linuxfoundation.org,jun.li@nxp.com,peter.chen@kernel.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:22:05 +0100
Message-ID: <2024010504-tameness-animosity-df27@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    usb: chipidea: wait controller resume finished for wakeup irq

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 128d849074d05545becf86e713715ce7676fc074 Mon Sep 17 00:00:00 2001
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 28 Dec 2023 19:07:52 +0800
Subject: usb: chipidea: wait controller resume finished for wakeup irq

After the chipidea driver introduce extcon for id and vbus, it's able
to wakeup from another irq source, in case the system with extcon ID
cable, wakeup from usb ID cable and device removal, the usb device
disconnect irq may come firstly before the extcon notifier while system
resume, so we will get 2 "wakeup" irq, one for usb device disconnect;
and one for extcon ID cable change(real wakeup event), current driver
treat them as 2 successive wakeup irq so can't handle it correctly, then
finally the usb irq can't be enabled. This patch adds a check to bypass
further usb events before controller resume finished to fix it.

Fixes: 1f874edcb731 ("usb: chipidea: add runtime power management support")
cc:  <stable@vger.kernel.org>
Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
Link: https://lore.kernel.org/r/20231228110753.1755756-2-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 0af9e68035fb..41014f93cfdf 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -523,6 +523,13 @@ static irqreturn_t ci_irq_handler(int irq, void *data)
 	u32 otgsc = 0;
 
 	if (ci->in_lpm) {
+		/*
+		 * If we already have a wakeup irq pending there,
+		 * let's just return to wait resume finished firstly.
+		 */
+		if (ci->wakeup_int)
+			return IRQ_HANDLED;
+
 		disable_irq_nosync(irq);
 		ci->wakeup_int = true;
 		pm_runtime_get(ci->dev);
-- 
2.43.0



