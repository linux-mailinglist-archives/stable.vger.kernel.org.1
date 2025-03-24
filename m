Return-Path: <stable+bounces-125912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575FDA6DEAF
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E456A188E860
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187725F7B2;
	Mon, 24 Mar 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NldV4eNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C11CD1E4
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830127; cv=none; b=qJv94PIS482UwXP0f5r5V+BwVYupeGex0Q1275BbxRA+/dXOlpT04P2dnkBjM9S8AXDHaigo4ctAjtUUathtSxrjvMnc1JAHURa9Q4+3B8CT+nscA+gWlH/Hw/zWM0i0LMyJlx5LdlWYkQPdKugVmvn6/dLfW1hfomDFGbkzRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830127; c=relaxed/simple;
	bh=f9P+8dxApOzA2t/qk6F87tCFQ6IuEcmTNHKXCDx+LnU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qGPCqRnDvqB8yAYvfg9NI5gRBJCfoVHSZDb7PJBLulcesPj0xYXpdlSyzntqcrgyeKiLqJKc2NNkb6Mhbx48fIih34B19DZnILsYzuHtd0UrE61SJ+JImtzBfvpvLa36AwY+g3yYYq6rg8wgcR7TCfG9aywRj0FAVSc3SAu9IDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NldV4eNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947CEC4CEDD;
	Mon, 24 Mar 2025 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830126;
	bh=f9P+8dxApOzA2t/qk6F87tCFQ6IuEcmTNHKXCDx+LnU=;
	h=Subject:To:Cc:From:Date:From;
	b=NldV4eNMQMEpR2gIeStgvgaeybYgYXg2uUiQ8gZ/7NwiRqPAURz2TUOc3itlgTqxV
	 Y7nhC8fEtnVpL688TkiAeXH8zs2AAh7LIXxss82LLZjyEI4BQ8YuXYXqkJFoqkLcX5
	 azzPkPG7/Nx9dzTkHnpZT1+rJDxqbqEqS6p04JRQ=
Subject: FAILED: patch "[PATCH] can: flexcan: disable transceiver during system PM" failed to apply to 5.10-stable tree
To: haibo.chen@nxp.com,frank.li@nxp.com,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:27:20 -0700
Message-ID: <2025032420-overstuff-legged-67d6@gregkh>
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
git cherry-pick -x 5a19143124be42900b3fbc9ada3c919632eb45eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032420-overstuff-legged-67d6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


