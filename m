Return-Path: <stable+bounces-210989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKNZNQY4cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-210989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:33:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA3D5D4D8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 995C5863A3D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87B33A0EA8;
	Wed, 21 Jan 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+3GK2Jx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F535E535;
	Wed, 21 Jan 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020062; cv=none; b=USa91TyaOm5IpYMWT0wQOv+dlAAh9WPKmhlEsmpv3lvWXlODoaR70bW5F956GaeGs/cDwk1rAobSOE5dl3utTSsYVkEGJGioQGh7DjtA6BO3oVpwTHcYMHgVKGHO7vEE8v4MSXEoz9sJmUk70/npSWptJnktHPPOrGbz7eK820c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020062; c=relaxed/simple;
	bh=VWQ6hCldWCHc3pnSqR2ol/CEyxwmuCBNQLwnjmB1aaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIvwi9l97Rh54icMdJ1u3iCsgBDH5SAyycGCFDgT8l1JnfrsRNCZRFHxpr7gcGlXa+avQITyD61rpaEObDHzTrFu7Ypxt3mZt8kTBMT9qSnCLHVWb4AFnpUcrj5KzzuwuVg4P3CKCc8svPD24ryn9f4Cl4RFOFYNTJsFWWB+/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+3GK2Jx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4C9C4CEF1;
	Wed, 21 Jan 2026 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020062;
	bh=VWQ6hCldWCHc3pnSqR2ol/CEyxwmuCBNQLwnjmB1aaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+3GK2JxgV0QrpXj7SFt8GS1kXu8kiklEhajPXe+R9i1chV6PIBHBEh9Kta/a35v6
	 5Gme54TXPSjq7oJZtciX/kSXD6cekk9SCu5k9K5w/SYz2Am+SOFAJIq6XekhqSVGpV
	 vRhv3JjceeRfnYwyrKlVEFZKkwn24oQTxF5Z+PV0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 048/198] ALSA: hda/cirrus_scodec_test: Fix incorrect setup of gpiochip
Date: Wed, 21 Jan 2026 19:14:36 +0100
Message-ID: <20260121181420.284319119@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210989-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.de:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8EA3D5D4D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
 sound/hda/codecs/side-codecs/cirrus_scodec_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/side-codecs/cirrus_scodec_test.c b/sound/hda/codecs/side-codecs/cirrus_scodec_test.c
index 3cca750857b68..159ac80a93144 100644
--- a/sound/hda/codecs/side-codecs/cirrus_scodec_test.c
+++ b/sound/hda/codecs/side-codecs/cirrus_scodec_test.c
@@ -103,6 +103,7 @@ static int cirrus_scodec_test_gpio_probe(struct platform_device *pdev)
 
 	/* GPIO core modifies our struct gpio_chip so use a copy */
 	gpio_priv->chip = cirrus_scodec_test_gpio_chip;
+	gpio_priv->chip.parent = &pdev->dev;
 	ret = devm_gpiochip_add_data(&pdev->dev, &gpio_priv->chip, gpio_priv);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add gpiochip\n");
-- 
2.51.0




