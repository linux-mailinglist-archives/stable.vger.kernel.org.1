Return-Path: <stable+bounces-270536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Nw5IypzRmo0VQsAu9opvQ
	(envelope-from <stable+bounces-270536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:18:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ADC6F8CC9
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 16:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IWq9ghV9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270536-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270536-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A465E300CF2B
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB5270EC3;
	Thu,  2 Jul 2026 14:16:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492A4DA550;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001772; cv=none; b=eW2My9OqaLqxLVtR3asKJ5wYC+zm9GeWn9PmHFbEM4/QjTJl/bSxcrYQWpz+IIrb5VzTRPrr75oO67vZKjhnw8ljamQX/EP85ixM6oRR1O06pDMabyxiepyR2cA2hHUjhtN/TyyS9xQEEI5fBeqPLP4YvkbqgL3hTvYIxkmGPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001772; c=relaxed/simple;
	bh=rt+hTQljtmTKZB3seaFCTOOiXTvilEYPyHN5EZGxnKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1vjkY0cYGm8oBd4Of8XkkC6jkUhrA5g6rXywHQgJfl3N1Gm1lmhY+8PFJpx/k3LngS2ueUSo9m25NNxyS7Hmi/tHyBGkepjPsm4j/zxC6Eeq22rt8VU/PimJdpZ/phY4i2p7pb4lR/vCeZOYzbyzwwCKyazJnlAPJBUZ4hPEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWq9ghV9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0751F00A3E;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001769;
	bh=MhBTAqbX+6ddORWh3uOqJPTx4/35gVXV/hnc5cvGL/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWq9ghV9ePdP6Jv1QTUqpDdm/5QFTr7+Be5rrPQUiptDgFHFD9Gl9PR9JhKsdnoyT
	 tzfxxQHEVO3WAqvmaeswEZjQgnjX7+4/+I5ulGvR2dw0CekZ83mIrdtxtoncdXkz3/
	 CFmpmBuDRvmbpfPZNTQ/tBS0p9QGkYKBqmW03QwEBzWTswsjH7iL0IvZUbHRxLQZdI
	 svZHG1tIRsiEPOyc4zMM1OGqzUoc4quVUzIQx3KOUaPDk37MvEvrnhn2oZKCvDtpNp
	 bnT1HxvVeVJuVAzMyInZOfqMta4HF3CbkxZO/ngoUDhXx+roSdST9tEsgIuANrHbqN
	 pywL2OgZVBRNQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfID0-00000000Nea-2lTM;
	Thu, 02 Jul 2026 16:16:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] USB: gadget: fsl-udc: fix device name leak on probe failure
Date: Thu,  2 Jul 2026 16:15:33 +0200
Message-ID: <20260702141536.90887-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702141536.90887-1-johan@kernel.org>
References: <20260702141536.90887-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270536-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:johan@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82ADC6F8CC9

The gadget device name is set by UDC core when registering the gadget
and must not be set before to avoid leaking the name in intermediate
error paths (e.g. on dma pool creation failure).

Fixes: eab35c4e6d95 ("usb: gadget: fsl_udc_core: let udc-core manage gadget->dev")
Cc: stable@vger.kernel.org	# 3.10
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 600ce8cc0fef..8c5b2f42ff44 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2474,7 +2474,6 @@ static int fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.name = driver_name;
 
 	/* Setup gadget.dev and register with kernel */
-	dev_set_name(&udc_controller->gadget.dev, "gadget");
 	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
 
 	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
-- 
2.53.0


