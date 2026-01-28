Return-Path: <stable+bounces-212622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI9QIhY0eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880CA518B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27B8830492A0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F52DB791;
	Wed, 28 Jan 2026 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oG2Q8B+w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D5285C8D;
	Wed, 28 Jan 2026 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616139; cv=none; b=rfVPfny+wMrh+y5J0vj5ITpcj9NE8m3nLkMCSnM8pGjaQYIuLiwllywXfsShWYiMeiaxzDO90r9uKQ9HlHIIkvwyZrYVZ7zj5nhxNGhyfXz2snw9GMDjMxer+z3ENgj+Ujwf/eNmNTP7lK+b5RhnjGgzbjDCZGzDowzrld5+BrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616139; c=relaxed/simple;
	bh=ECNYry+I+ctakyeQ1OEUoQKGGou1GNt6pVlU3HU0PrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArNdAv1xtH1LEQMV+J9raxS5fE39WV7NGUW05+cztYAu7Be3YWV3R0PXWFokXKZtfVXuLxK4068IwsTAmrilu/ta31qVHByCLfSIHuZJFE4GZQMpIvVGECOU7XTNfQXAylXSeI2XOmz8GfPV5YnqK5DnjcA4NDAu9oyV8RkiWg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oG2Q8B+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF57C4CEF7;
	Wed, 28 Jan 2026 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616139;
	bh=ECNYry+I+ctakyeQ1OEUoQKGGou1GNt6pVlU3HU0PrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oG2Q8B+wqh4QhQX5jqiAhNxRhMwgbQAbC1pNhmmTv4VmqANDzpLOCUMUQbdrwtJPg
	 xUgvg93pBsU0FNLQCT4ySk+luEiQrjx8H8ojL9wja0bbdq2pUwmP8BET9m6NzF2GNr
	 0lNwl1NxPv23T/i3S1mloXZfom3XEmH1wqjmY/T0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.18 218/227] gpio: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
Date: Wed, 28 Jan 2026 16:24:23 +0100
Message-ID: <20260128145352.276855826@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212622-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 2880CA518B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tzung-Bi Shih <tzungbi@kernel.org>

commit 8a8c942cad4cd12f739a8bb60cac77fd173c4e07 upstream.

On error handling paths, gpiolib_cdev_register() doesn't free the
allocated resources which results leaks.  Fix it.

Cc: stable@vger.kernel.org
Fixes: 7b9b77a8bba9 ("gpiolib: add a per-gpio_device line state notification workqueue")
Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20260120092650.2305319-1-tzungbi@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-cdev.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2821,13 +2821,18 @@ int gpiolib_cdev_register(struct gpio_de
 		return -ENOMEM;
 
 	ret = cdev_device_add(&gdev->chrdev, &gdev->dev);
-	if (ret)
+	if (ret) {
+		destroy_workqueue(gdev->line_state_wq);
 		return ret;
+	}
 
 	guard(srcu)(&gdev->srcu);
 	gc = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!gc)
+	if (!gc) {
+		cdev_device_del(&gdev->chrdev, &gdev->dev);
+		destroy_workqueue(gdev->line_state_wq);
 		return -ENODEV;
+	}
 
 	gpiochip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
 



