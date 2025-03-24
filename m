Return-Path: <stable+bounces-125911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD06A6DEA5
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BE61667EB
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05725D55A;
	Mon, 24 Mar 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kg6ErXdO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D825E444
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830123; cv=none; b=nejBfcqkPsJU/HRRYVzs1/FYFdC3vG7sjU01faZsWuBM7dEnsuDq5PMTRgIrI/K8cfK32kpOT0Uwi5Fx3O7TabLsB6KLSbnUqIE1kJxyB7JYtLD9OKvPwDq0GKC7K4aFC88lQcgEVkZcirNZkzsDpVRmHclN1NmIHP3jag8y7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830123; c=relaxed/simple;
	bh=ehFcKmwN6t2nYkZkXj9ugNfgYfdMiZnAjUcM+lK5qWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WdMLD4hEQYPOE4EBZRKSn+ui7cMtF8J1GcTCa6J/hrdpyoJrzXOuS+KoNNfEZmIIB/sr9LrUeAbuFZD+TI+C18YOL5SA+3UBfSecIwYy2KwoN0S6DgnqVlKtIzPWVGab8/bLfCBS7QsrBrGzMi95eyHPn5nYX0HX+ECai6fD/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kg6ErXdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A23CC4CEDD;
	Mon, 24 Mar 2025 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830122;
	bh=ehFcKmwN6t2nYkZkXj9ugNfgYfdMiZnAjUcM+lK5qWE=;
	h=Subject:To:Cc:From:Date:From;
	b=kg6ErXdOxvKJdevNIeoMR+Qj2vn+4RA2XNdAik5CJ9qYPE16q0kvw8TO+k35jZe+o
	 etbg/dKhGbDIc0aAQs6pQL6lyIO0oFD3Ten3b7teheBSmdBaIpi5d9OuaG8+oNY/Rn
	 Z7mHSEQsLsxyf7EXOC39ViH27mVvLoUXMw7qFqes=
Subject: FAILED: patch "[PATCH] can: flexcan: disable transceiver during system PM" failed to apply to 5.15-stable tree
To: haibo.chen@nxp.com,frank.li@nxp.com,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:27:19 -0700
Message-ID: <2025032419-immersion-dislike-cf63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5a19143124be42900b3fbc9ada3c919632eb45eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032419-immersion-dislike-cf63@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


