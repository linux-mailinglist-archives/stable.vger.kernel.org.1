Return-Path: <stable+bounces-238974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDo0JiQ05mmOtQEAu9opvQ
	(envelope-from <stable+bounces-238974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:11:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4E42CBD6
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE403316E45F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B436A3F166E;
	Mon, 20 Apr 2026 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6YccxFo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEF3F1643;
	Mon, 20 Apr 2026 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691537; cv=none; b=K9NLXw9sI0Hhz/haYuggitezoe1zT17NhX2GUMgWEx+6kVBnFSjktKWrr4U/MKAcd9x5I2o/Gn0rAMkZJzhoX4CnQjGWwG7xWCDL63KK6j0w8axklbaMUzBGb2BTx5C5zv7dEtseuZJ4IPhK5NzOmqR5Lxhxa/lVqw9jTYzgASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691537; c=relaxed/simple;
	bh=/lnYTBpqCE+fSTH5kiJNSBZOxdmL/SdHucyHsrDIkQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+DKikfHFtj3CTA9Gd35BMgkuJDyrxfKboqFYeh+lERubzFnddwOCFhmCbv7X/rRrL9tTf7yKD8laNvcmTzXy8/G18IzGqWfZoJFFazgct1S7usHkQSvzk/WBTGP2bYH4rs8gx0VFpLjNDVLg8b4AF76BQYYu5VPjVtw0m51KZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6YccxFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F868C19425;
	Mon, 20 Apr 2026 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691537;
	bh=/lnYTBpqCE+fSTH5kiJNSBZOxdmL/SdHucyHsrDIkQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6YccxFoib6L+gSw3XPHkRFHC59TdLj+wxV8mGTaf+m12Xvso/DXuevcsUzrqlGlU
	 sFvN1cKIpN1XcolFTIwlwTnDkQtOnsQw+DI9qSPTX/noU2Xo2A7l4a82uQBzgaV26D
	 OL93Pub3Q9ZDG8Tfa7GTG6VE9U3caX9I730DT1xenJyTBTUtpPQ0IoqXThHJW05FYj
	 7NG8EJq/Z1OJIC5VcDm8fmzczef0ITJQJIIKTPsZh7nIyoA2GTdzGTkp8dZH5MrbGI
	 2AS57Lvppejul8mn23NsaVq4UcmDCfFd7bNofQr+QReHy18BreOL4JmnpIgynRemvi
	 UR3iZ51hYa8fg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Frank Zhang <rmxpzlb@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ALSA:usb:qcom: add AUXILIARY_BUS to Kconfig dependencies
Date: Mon, 20 Apr 2026 09:18:02 -0400
Message-ID: <20260420132314.1023554-88-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org,perex.cz,suse.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238974-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CA4E42CBD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Zhang <rmxpzlb@gmail.com>

[ Upstream commit b8bee48e38f2ddbdba5e58bc54ef54bb7d8d341b ]

The build can fail with:

ERROR: modpost: "__auxiliary_driver_register"
[sound/usb/qcom/snd-usb-audio-qmi.ko] undefined!
ERROR: modpost: "auxiliary_driver_unregister"
[sound/usb/qcom/snd-usb-audio-qmi.ko] undefined!

Select AUXILIARY_BUS when SND_USB_AUDIO_QMI is enabled.

Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
Link: https://patch.msgid.link/20260317102527.556248-1-rmxpzlb@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 sound/usb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 9b890abd96d34..b4588915efa11 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -192,6 +192,7 @@ config SND_USB_AUDIO_QMI
 	tristate "Qualcomm Audio Offload driver"
 	depends on QCOM_QMI_HELPERS && SND_USB_AUDIO && SND_SOC_USB
 	depends on USB_XHCI_HCD && USB_XHCI_SIDEBAND
+	select AUXILIARY_BUS
 	help
 	  Say Y here to enable the Qualcomm USB audio offloading feature.
 
-- 
2.53.0


