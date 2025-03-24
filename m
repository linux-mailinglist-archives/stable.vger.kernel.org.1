Return-Path: <stable+bounces-125913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D6A6DEB4
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7800E3B14B9
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DBC25F980;
	Mon, 24 Mar 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zQYTpZ0q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3125D55A
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830129; cv=none; b=RuuypIjvY9YT4gWPfW5bSzusmxAMdmRQLkdMb6oh24y91EfxOMRbzfVfqW7yeLDKxxzP5ae565Px2EkaTUf7Fdd4wqRCd05el0ttGGjHgnTtU+X0y6DU4s5Vh/2hUYxO4SIK9o+h2YJYNRZlBWCNFyAIJ7G90Xy3Al+5P6umgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830129; c=relaxed/simple;
	bh=vC1S3lKmEs45XOf1LOhHmxCCuMS7FfiDU1n7Hiq1a1E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sC+6hJEj6cy00dJR5rUAIp1DSnq1W9mUVTxu64tofcym6cyJCrqQtI3mKjvNi/w1+IYer2DssDLx7U6wEMQB3ddbntjofBiP0KKUswGeeZJraIEpqpedVH+8YkjF0RPuOeUsxhpUuHPUPR3XcRupWuDr/EhCetJIwzkoO9Vhwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zQYTpZ0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3F9C4CEDD;
	Mon, 24 Mar 2025 15:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830128;
	bh=vC1S3lKmEs45XOf1LOhHmxCCuMS7FfiDU1n7Hiq1a1E=;
	h=Subject:To:Cc:From:Date:From;
	b=zQYTpZ0qzQ3k8W3gcmzMqe5yxedAjcfd+vwPE97HdM4BhOykeBluB38xkqqm3h72M
	 Ap5rTD6D5IMeP1taI0QhY1QGd87USh2HJ5asFmQj5g1nJC0nOCqWQSyV10EhC6uOUa
	 zgS5HZ00eeVZK8YBVb3r2J+1PLmGfX/lw5TTCkxo=
Subject: FAILED: patch "[PATCH] can: flexcan: disable transceiver during system PM" failed to apply to 5.4-stable tree
To: haibo.chen@nxp.com,frank.li@nxp.com,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:27:21 -0700
Message-ID: <2025032421-underhand-jujitsu-4b1e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5a19143124be42900b3fbc9ada3c919632eb45eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032421-underhand-jujitsu-4b1e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a19143124be42900b3fbc9ada3c919632eb45eb Mon Sep 17 00:00:00 2001
From: Haibo Chen <haibo.chen@nxp.com>
Date: Fri, 14 Mar 2025 19:01:45 +0800
Subject: [PATCH] can: flexcan: disable transceiver during system PM

During system PM, if no wakeup requirement, disable transceiver to
save power.

Fixes: 4de349e786a3 ("can: flexcan: fix resume function")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://patch.msgid.link/20250314110145.899179-2-haibo.chen@nxp.com
[mkl: add newlines]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 3a71fd235722..b080740bcb10 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2260,6 +2260,10 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 
 			flexcan_chip_interrupts_disable(dev);
 
+			err = flexcan_transceiver_disable(priv);
+			if (err)
+				return err;
+
 			err = pinctrl_pm_select_sleep_state(device);
 			if (err)
 				return err;
@@ -2292,10 +2296,16 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			if (err)
 				return err;
 
-			err = flexcan_chip_start(dev);
+			err = flexcan_transceiver_enable(priv);
 			if (err)
 				return err;
 
+			err = flexcan_chip_start(dev);
+			if (err) {
+				flexcan_transceiver_disable(priv);
+				return err;
+			}
+
 			flexcan_chip_interrupts_enable(dev);
 		}
 


