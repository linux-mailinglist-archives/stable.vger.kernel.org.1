Return-Path: <stable+bounces-246174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COF/FDtqA2rf5gEAu9opvQ
	(envelope-from <stable+bounces-246174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:58:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E37585265FE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 475CF305E716
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91923955D7;
	Tue, 12 May 2026 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hqkRBBRC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5443EDE7F;
	Tue, 12 May 2026 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608548; cv=none; b=UGEmCarnSwEaRN7zD1SR5JeZd3skSQ6ksDtqdF7oqFAU7wal+B+x4HTyfSZVN/xmElY9pXYd5cfrGpOzgpKRUvY77Td2t1hUtdBmUEhlFB30DOATS3iLj305nUWtZswAoktmpvMug9pdpBKdLbKjP38R2rTvfiDhJIzPE5HCuPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608548; c=relaxed/simple;
	bh=t3PSzCHvALzTp7M2eVlSvx0P5h531GY/Oi24G3K2qao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzCKZ/w9Wd1Z6lwJvb/0+aK0ivqJCK6/7sShmRYA8c9PtYR6FsNY5SVRju4BPN/vASEO2Fgw8HUROH2+934P8DxnALJu4FzdyZGL5PvwzK/cJ6WSBTfXA99Oxvh7ZbAvsPgp6ioVxDRL8DPfg+E/vVCvuiysNTbwQ/y68njqndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hqkRBBRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0ABC2BCF5;
	Tue, 12 May 2026 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608548;
	bh=t3PSzCHvALzTp7M2eVlSvx0P5h531GY/Oi24G3K2qao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqkRBBRC+aHQiO70vT/Lxw3dfStxID28jVn4mEVxUgpWFUAu2fZDRX1MqORpOPUie
	 ndU5j/qSwXQGiOMf00irZo3sZ/3+vFpFwpNpo12+51oXF5zck3/iD9INfIA5lTfLFF
	 m+mYyTSbOv6Y+VMzWz3Cg+/JDxJ4gkN91WQxMP2k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.18 120/270] gpio: of: clear OF_POPULATED on hog nodes in remove path
Date: Tue, 12 May 2026 19:38:41 +0200
Message-ID: <20260512173940.983232374@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: E37585265FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246174-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

commit bbee90e750262bfb406d66dc65c46d616d2b6673 upstream.

The previously set OF_POPULATED flag should be cleared on the hog nodes
when removing the chip.

Cc: stable@vger.kernel.org
Fixes: 63636d956c455 ("gpio: of: Add DT overlay support for GPIO hogs")
Acked-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260309-gpio-hog-fwnode-v2-1-4e61f3dbf06a@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-of.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -1285,7 +1285,14 @@ int of_gpiochip_add(struct gpio_chip *ch
 
 void of_gpiochip_remove(struct gpio_chip *chip)
 {
-	of_node_put(dev_of_node(&chip->gpiodev->dev));
+	struct device_node *np = dev_of_node(&chip->gpiodev->dev);
+
+	for_each_child_of_node_scoped(np, child) {
+		if (of_property_present(child, "gpio-hog"))
+			of_node_clear_flag(child, OF_POPULATED);
+	}
+
+	of_node_put(np);
 }
 
 bool of_gpiochip_instance_match(struct gpio_chip *gc, unsigned int index)



