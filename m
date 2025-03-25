Return-Path: <stable+bounces-126493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF4A70104
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB025176A6A
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F055426E158;
	Tue, 25 Mar 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jIgY40fo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0C25D55A;
	Tue, 25 Mar 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906327; cv=none; b=ebGOUJ2ipz7gkarXhKciCsT/WPZK2kKRB0PZIfCnm9RUWsqjBIozh3+yn50EZpuEv2GsEJxeIayEAOZwWxov4MmC8Pfe7g6r9egjkF0lN6iIfJGtik3fAKxb9ET2xfapnqmWmcCXlH0Qr9nhkMZFKrwl9M3vgI9Kr9YnfM26TfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906327; c=relaxed/simple;
	bh=J8eviI9mqACx2HUrQfjPPm7/PS2OQl1jKgl2gPlIK8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9dmNdksEbk6Jp0pjNvtXUUQMnsDJG7XYaXHMLlsYhYT7GO6CMWBr2UC5XjXwufQAQLl5bGFP1L5mf4JiAjG+NwyYLzv0WrU3gIdZndk3UAdoQbcvFhGFJwz/OrfwVdVvnhYIyrGRU7qFhn/D9UUMvH+fjpkIAbAOX7qIAXlYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jIgY40fo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36757C4CEE9;
	Tue, 25 Mar 2025 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906327;
	bh=J8eviI9mqACx2HUrQfjPPm7/PS2OQl1jKgl2gPlIK8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jIgY40fogeSY+yf1SjPBovyZC7rLUtgymdRgHILByf4Cn+v0P1Mw2RC1o8exxHAp+
	 +FMvwWEjGBhIHsW9W+ERVf62DLAl9KdTP/JFTj7655Vd/D+8oTj4554h05mQY7przu
	 6R2vvCXZQqWkJHplCxEmfFOAssM7e4Yz7rSZ4fCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <frank.li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12 058/116] can: flexcan: disable transceiver during system PM
Date: Tue, 25 Mar 2025 08:22:25 -0400
Message-ID: <20250325122150.693559462@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
References: <20250325122149.207086105@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
 



