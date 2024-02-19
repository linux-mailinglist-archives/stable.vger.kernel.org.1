Return-Path: <stable+bounces-20662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE8B85AAD6
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FB1282918
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD82481DB;
	Mon, 19 Feb 2024 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j8q4ZMp8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A7481CC
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366887; cv=none; b=XugYDIbBabGgLHVfDJYDKkxlpQwaEpQaLT6BPDcOgBrg+BIr69UkUuxjZH1p/Zbg4QyGOXelF+Q5pzQKnoyQ3sQmrC2CybmOGXMbQXNLb3RHpDOJfPXi7cDE+ED1bv2Eh7e9DhuCPL01XDgK9cfLRjcTnDGmAUnqGz62m0EG9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366887; c=relaxed/simple;
	bh=tEzXva7m1JI+nzZs56ZJwb1lASuDUKHJ2LyRYCIGgkY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QIFoA0s5etDGTLVCoXA6S14ZfDgoknhdWk4XpyO6I6xDIUnMuokJ62HgBsvJZu7t2dc+OcROvrxBie6DNW1pm8/pOEIayYJ9c0YUc5WwLLy4NvpGZaIw0G2mPn/TXJJJXyPuB9IGSMTnKBwbt1d5YzYIUYy3OZYImZq6QjhCkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j8q4ZMp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47293C433F1;
	Mon, 19 Feb 2024 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366886;
	bh=tEzXva7m1JI+nzZs56ZJwb1lASuDUKHJ2LyRYCIGgkY=;
	h=Subject:To:Cc:From:Date:From;
	b=j8q4ZMp89YE2tu0BCZqcIpu34E0bONLBfroigB1Wu8ybOGVuJYlO6NyrPec6Hhgk2
	 NlAE/Yxkja6B4ghIuJ+YH7Lqx+PzNjzLX0ciYAugFT/ZtKDfCEN9xK91afrUVsufsT
	 UKrCv/nwZCdMmIS8NbrQKVLi/vdhPLq2AxUXlFsQ=
Subject: FAILED: patch "[PATCH] serial: max310x: fail probe if clock crystal is unstable" failed to apply to 4.19-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,jan.kundrat@cesnet.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:21:13 +0100
Message-ID: <2024021913-outmatch-nuclear-240b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8afa6c6decea37e7cb473d2c60473f37f46cea35
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021913-outmatch-nuclear-240b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

8afa6c6decea ("serial: max310x: fail probe if clock crystal is unstable")
93cd256ab224 ("serial: max310x: improve crystal stable clock detection")
0419373333c2 ("serial: max310x: set default value when reading clock ready bit")
d4d6f03c4fb3 ("serial: max310x: Try to get crystal clock rate from property")
974e454d6f96 ("serial: max310x: Use devm_clk_get_optional() to get the input clock")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8afa6c6decea37e7cb473d2c60473f37f46cea35 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 16 Jan 2024 16:30:00 -0500
Subject: [PATCH] serial: max310x: fail probe if clock crystal is unstable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A stable clock is really required in order to use this UART, so log an
error message and bail out if the chip reports that the clock is not
stable.

Fixes: 4cf9a888fd3c ("serial: max310x: Check the clock readiness")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Link: https://www.spinics.net/lists/linux-serial/msg35773.html
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240116213001.3691629-4-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c0eb0615d945..552e153a24e0 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -587,7 +587,7 @@ static int max310x_update_best_err(unsigned long f, long *besterr)
 	return 1;
 }
 
-static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
+static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned long freq, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
@@ -657,7 +657,8 @@ static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 		} while (!stable && (++try < MAX310X_XTAL_WAIT_RETRIES));
 
 		if (!stable)
-			dev_warn(dev, "clock is not stable yet\n");
+			return dev_err_probe(dev, -EAGAIN,
+					     "clock is not stable\n");
 	}
 
 	return bestfreq;
@@ -1282,7 +1283,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 {
 	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
-	u32 uartclk = 0;
+	s32 uartclk = 0;
 	bool xtal;
 
 	for (i = 0; i < devtype->nr; i++)
@@ -1360,6 +1361,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	}
 
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
+	if (uartclk < 0) {
+		ret = uartclk;
+		goto out_uart;
+	}
+
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
 	for (i = 0; i < devtype->nr; i++) {


