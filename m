Return-Path: <stable+bounces-203560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9ACE6E86
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13DD43005FF8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97933221FDA;
	Mon, 29 Dec 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/giitFL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55932217F31
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016229; cv=none; b=mkMs/zECj/uhFUqFvUizempSc9I1IZuFTyI1ELiK5PSD3eCLd4js1KoPGjjqgSdujwrAEcgc5w2ZoXM1Os0i303Z4e/y0zHfTmKzJTKE1v3MfPIJVoXF3+A5Rt1WyL5hHjDJxnqNRnY55BNadD1tKPN+dxh7kWDMhzrDhK/maes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016229; c=relaxed/simple;
	bh=GpgBa67EA0G91lRGezC9Ne47R4qnbfXH4ttdfhdIOZ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G44PMv0hXQAnYXEGtHFc8P/hx0VP075y8RXBOeOvqD9YUraQCqlM/osfc01W58SDvYcnTYoj4yyTJfiIZKlsI2SQvJelyUruFGk1Ks68clh2ifnESdrxKUc76XzprVZlnMTGD1t0ULJM7BBG89nF9yvUaSDSp31moB1Mgr3ZB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/giitFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFDFC4CEF7;
	Mon, 29 Dec 2025 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016228;
	bh=GpgBa67EA0G91lRGezC9Ne47R4qnbfXH4ttdfhdIOZ0=;
	h=Subject:To:Cc:From:Date:From;
	b=N/giitFLA//pdQQfPBRH+jJUwpJsma3mc9vtHQ3J/ZQkYq4L9nWxef1TK+IU6QMAK
	 4SqGpHPLrOWdllxhJGbs9yCUbK1RhGpzMea8Aju3VtkjohMq4jl5E9SU6joQLNReyG
	 AQ93N0ps5HZDGieZ14i22nbA3fIEI+OxJmEw0WeI=
Subject: FAILED: patch "[PATCH] usb: ohci-nxp: fix device leak on probe failure" failed to apply to 6.6-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,make24@iscas.ac.cn,stern@rowland.harvard.edu,vz@mleia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:50:26 +0100
Message-ID: <2025122926-cushy-unstylish-3577@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b4c61e542faf8c9131d69ecfc3ad6de96d1b2ab8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122926-cushy-unstylish-3577@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


