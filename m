Return-Path: <stable+bounces-210830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KyGLt8jcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:07:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 837065BD51
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CACFC54BEA8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A942C375E;
	Wed, 21 Jan 2026 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qNFugZEM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987F37BE9C;
	Wed, 21 Jan 2026 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019526; cv=none; b=LsKlki+fvzpxytRN2EecxA+kdqSBgaZGeroqAE5bf4OwkJ1jOpuwuJD62+Me8H4+DVkxCcLoWaDFzfudnfQaBFAETCmhpoH/q2C0rpPSJZ4bCI/vgIsH3nf0/CTMqv6QaTrz7eObWsOxOWl1RaN1Ii9HgGz7m9JH/5VDfxXJ9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019526; c=relaxed/simple;
	bh=N26JsVb7RjvSHB+rOXE1rq7lvHnJVX6YL/QdFAY6W/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI9OMG0GTp8PsebTmXNruOKmICnHMhn8l2+T3UnnJVVTjXW5YbO8aaYixPLokkH+vF/kc9LfK9F3Qkd7exrUJRoeeVQhpPZR2+0fE3Md5+gs57sNyy4I/q8RMmKCBscxA5KudGt5Z1pd7kLDzPz+9fdbEj/6/QpiBU4B2h8oc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qNFugZEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652B0C4CEF1;
	Wed, 21 Jan 2026 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019525;
	bh=N26JsVb7RjvSHB+rOXE1rq7lvHnJVX6YL/QdFAY6W/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNFugZEMzCZlnwizDmYfV8vYPb45Y6rd7LTZdnNWDy5s55Z5qXmfu92alS3itkiPm
	 HI3Apxh5ZMpAwNliQRkCaeIUS7LCc5yrsmZGPoHBJ9LhqJzqZvecRz0ypIpfAhG379
	 ezpL3l8eMEVXog9z5s8NYOScWmd6EDc3ul0EMSbE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 032/139] ALSA: hda/cirrus_scodec_test: Fix incorrect setup of gpiochip
Date: Wed, 21 Jan 2026 19:14:40 +0100
Message-ID: <20260121181412.610842520@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210830-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 837065BD51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit c5e96e54eca3876d4ce8857e2e22adbe9f44f4a2 ]

Set gpiochip parent to the struct device of the dummy GPIO driver
so that the software node will be associated with the GPIO chip.

The recent commit e5d527be7e698 ("gpio: swnode: don't use the
swnode's name as the key for GPIO lookup") broke cirrus_scodec_test,
because the software node no longer gets associated with the GPIO
driver by name.

Instead, setting struct gpio_chip.parent to the owning struct device
will find the node using a normal fwnode lookup.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2144833e7b414 ("ALSA: hda: cirrus_scodec: Add KUnit test")
Link: https://patch.msgid.link/20260113130954.574670-1-rf@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cirrus_scodec_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/cirrus_scodec_test.c b/sound/pci/hda/cirrus_scodec_test.c
index e925ebe21ccba..140b2a6be8dca 100644
--- a/sound/pci/hda/cirrus_scodec_test.c
+++ b/sound/pci/hda/cirrus_scodec_test.c
@@ -92,6 +92,7 @@ static int cirrus_scodec_test_gpio_probe(struct platform_device *pdev)
 
 	/* GPIO core modifies our struct gpio_chip so use a copy */
 	gpio_priv->chip = cirrus_scodec_test_gpio_chip;
+	gpio_priv->chip.parent = &pdev->dev;
 	ret = devm_gpiochip_add_data(&pdev->dev, &gpio_priv->chip, gpio_priv);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add gpiochip\n");
-- 
2.51.0




