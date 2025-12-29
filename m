Return-Path: <stable+bounces-203561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE90CE6E89
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB5EF3005328
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D98221FDA;
	Mon, 29 Dec 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rBy6jQDn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36CA2B9B9
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016237; cv=none; b=EgSl0Nnw7ULaDZ1EgWINnBYvx55LFBeQ79RWNomaOB7QHjCXSdPqUZcaFvCBXsJsasNxGlfLM2P09O069U7HQgyid94MUxVPtkSyUeUr0DrJv9VeI7osSeXzXzjxgDG6OFe41HOP1xKUUN2tDG662701+NMFkAzXrBnzfCkmQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016237; c=relaxed/simple;
	bh=l6anPI8XFDMLCb/H0895JW4Wwo2V9N6N5Zwj+cikc8o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=knobMXQuO23efWt5JdqTUiOGxuOYook7seOZ64pN13KJJh00MDnCCP2FOviAUHoVS7MO0hB0KzuRzWNioCQSR0WIpVID5aazu0UTGPrCxtkTLmk09QzNhy+yBCODOBm/mt/MYVXwjXLwpLeWnOzDvPb23nFhJO1d0n+0fV2cOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rBy6jQDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B293C4CEF7;
	Mon, 29 Dec 2025 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016237;
	bh=l6anPI8XFDMLCb/H0895JW4Wwo2V9N6N5Zwj+cikc8o=;
	h=Subject:To:Cc:From:Date:From;
	b=rBy6jQDnVvO2jkBKwtTZkxUbC7vqx6RGhMVthdu2ahJ9ZhTYtWqxwxbDutHrMv/Is
	 mV6q4g6UlIxqwBwyK4MGZtMlBwtyInhg7cRqXewTHLUg5RbR1i65gol++6wDmyK+iM
	 3ilu0RqpkwQtJGXBKJSqJQO0Ihp4d3sF1Tr42bkQ=
Subject: FAILED: patch "[PATCH] usb: ohci-nxp: fix device leak on probe failure" failed to apply to 6.1-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,make24@iscas.ac.cn,stern@rowland.harvard.edu,vz@mleia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:50:26 +0100
Message-ID: <2025122926-trifocals-slept-6573@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b4c61e542faf8c9131d69ecfc3ad6de96d1b2ab8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122926-trifocals-slept-6573@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b4c61e542faf8c9131d69ecfc3ad6de96d1b2ab8 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 18 Dec 2025 16:35:17 +0100
Subject: [PATCH] usb: ohci-nxp: fix device leak on probe failure

Make sure to drop the reference taken when looking up the PHY I2C device
during probe on probe failure (e.g. probe deferral) and on driver
unbind.

Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
Cc: stable@vger.kernel.org	# 3.5
Reported-by: Ma Ke <make24@iscas.ac.cn>
Link: https://lore.kernel.org/lkml/20251117013428.21840-1-make24@iscas.ac.cn/
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Link: https://patch.msgid.link/20251218153519.19453-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 24d5a1dc5056..509ca7d8d513 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -223,6 +223,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
 fail_resource:
 	usb_put_hcd(hcd);
 fail_disable:
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 	return ret;
 }
@@ -234,6 +235,7 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	ohci_nxp_stop_hc();
 	usb_put_hcd(hcd);
+	put_device(&isp1301_i2c_client->dev);
 	isp1301_i2c_client = NULL;
 }
 


