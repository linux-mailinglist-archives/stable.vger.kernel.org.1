Return-Path: <stable+bounces-126326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B93A70055
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6FC16E489
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF7269812;
	Tue, 25 Mar 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i3CS0TN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40D2571AB;
	Tue, 25 Mar 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906017; cv=none; b=sPgkV3ewyQGmEHHzz2SK1/Bo+B2+5HVltCICSNN4Ynthviy/XSarCwfZ0EXI5v2VnvCHk9BqWTepXA/XBt7BUftDmT8sRwRioT+JUQEnnJ7bYSxQkwUVrIsCtlpledAcx8CJqFzk4puJhs77DUGlKmvHeexSQWKRu4NVamps7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906017; c=relaxed/simple;
	bh=c1+0BDk/oZ4dy7RItT3G5Z5S8UD4NG9ZFMRB0z96O64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXRMIr2YUfFJd399I5ZdXO5xFdgAVdAUgNMtnWfHZph/k9gvjWHm7Xfd0hSEm2phm3SRJ9CmFVIlDZelrsWtpod29wDdLLeFRN2OqxmmEviXbhh5qGraIAKxABLQIupx0sJbC77fqr2qyjXN3LmNE2KbEmCfLRBRzPRY3EZWLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i3CS0TN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADACBC4CEE4;
	Tue, 25 Mar 2025 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906016;
	bh=c1+0BDk/oZ4dy7RItT3G5Z5S8UD4NG9ZFMRB0z96O64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3CS0TN12wjTqL+BFcY2/NEX4nxgY6S0S/1z8M+LPxLVrOL4ZUEZAlLLFg3v6BqTH
	 xQy8V784uIGSgjhj1zgwIul8pEpzhI6k7531uDRcGX4LADppOC6WwM3p9p3WhgTzjy
	 jkAA5fu2YQwp4py4tVaNSbkD9Jb3D5PeVmTmcKKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <frank.li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.13 060/119] can: flexcan: disable transceiver during system PM
Date: Tue, 25 Mar 2025 08:21:58 -0400
Message-ID: <20250325122150.587117726@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
References: <20250325122149.058346343@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haibo Chen <haibo.chen@nxp.com>

commit 5a19143124be42900b3fbc9ada3c919632eb45eb upstream.

During system PM, if no wakeup requirement, disable transceiver to
save power.

Fixes: 4de349e786a3 ("can: flexcan: fix resume function")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://patch.msgid.link/20250314110145.899179-2-haibo.chen@nxp.com
[mkl: add newlines]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/flexcan/flexcan-core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2260,6 +2260,10 @@ static int __maybe_unused flexcan_suspen
 
 			flexcan_chip_interrupts_disable(dev);
 
+			err = flexcan_transceiver_disable(priv);
+			if (err)
+				return err;
+
 			err = pinctrl_pm_select_sleep_state(device);
 			if (err)
 				return err;
@@ -2292,10 +2296,16 @@ static int __maybe_unused flexcan_resume
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
 



