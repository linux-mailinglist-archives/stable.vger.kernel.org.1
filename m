Return-Path: <stable+bounces-12749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB81783720C
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE271C2A70E
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A809340C1C;
	Mon, 22 Jan 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VvwydcmN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD43D991
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949354; cv=none; b=ltDjuX5QtLqekDKuOR+Ki61koRISuR85xZ6EEYJ5qTVpaBd0pByAI6Gfdao7s8sPM/2bpf16qIClObW/tcKJ1i+18ayOo7SY+bSL16lxsw+OHccNAPCUzMZi7c20RhQkvC3lskmuICcb72VDDmJoc5+DnOVl6fese3yA6qGyG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949354; c=relaxed/simple;
	bh=WikJjQXq7mIIH2eZDEftCnx/KQdgDL9/6Sd+ar5JfwE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kS8RXmDHeVa4Cd5RPBJyIm0X7yGl/Y7mniGbh25YOCwFRkT3aFELfyaf4oi1ejsip8feoBMpbmsSqGEK6KKQh3kfDHxaLyqoMh7LLIM+ljs+b9Txr8/HfiJ7hEMANd5/Bco6l94ZnMVfnzJ1cVgQeHoHxi5tEalcW+rp05Wy6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VvwydcmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB2AC43390;
	Mon, 22 Jan 2024 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705949354;
	bh=WikJjQXq7mIIH2eZDEftCnx/KQdgDL9/6Sd+ar5JfwE=;
	h=Subject:To:Cc:From:Date:From;
	b=VvwydcmN7r0tQBTqaCwXjIz0Yj+eW2BP2mImTPmxgbLxaOSYdkFpocLnImxhjoSFF
	 B9q/z5rKgUI9Lot3qFYh3gF7HjhgxeQtlGAyCrkVt3vE2ut4Yt5JiMScKmvZAWcoTT
	 l5zaEvqtttpLLE3yLD7QY6TRBED+LCZhBjiXXru4=
Subject: FAILED: patch "[PATCH] serial: 8250_bcm2835aux: Restore clock error handling" failed to apply to 5.15-stable tree
To: wahrenst@gmx.net,florian.fainelli@broadcom.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:49:03 -0800
Message-ID: <2024012203-blurt-ravage-cfa3@gregkh>
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
git cherry-pick -x 83e571f054cd742eb9a46d46ef05193904adf53f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012203-blurt-ravage-cfa3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

83e571f054cd ("serial: 8250_bcm2835aux: Restore clock error handling")
fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83e571f054cd742eb9a46d46ef05193904adf53f Mon Sep 17 00:00:00 2001
From: Stefan Wahren <wahrenst@gmx.net>
Date: Wed, 20 Dec 2023 12:43:34 +0100
Subject: [PATCH] serial: 8250_bcm2835aux: Restore clock error handling

The commit fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
dropped the error handling for clock acquiring. But even an optional
clock needs this.

Fixes: fcc446c8aa63 ("serial: 8250_bcm2835aux: Add ACPI support")
Cc: stable <stable@kernel.org>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20231220114334.4712-1-wahrenst@gmx.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index b5760f914a8c..beac6b340ace 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -119,6 +119,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 	/* get the clock - this also enables the HW */
 	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(data->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
 
 	/* get the interrupt */
 	ret = platform_get_irq(pdev, 0);


