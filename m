Return-Path: <stable+bounces-218936-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCQFBb5WnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218936-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:56:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DAB1903BD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B85B31F62CF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DAD274B3B;
	Wed, 25 Feb 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fb8mmFWX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE924677D;
	Wed, 25 Feb 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983834; cv=none; b=QUDS0W3LFB2r9LEvn1y93yjx1jr4d04yIm6mG6Y9Chtgmg8dDHTa6byvhO2YJ5SzkEWPOzt6XYHIRzbayUJW9o/LqAgo40CureI9DrvDWaVO4oI8zAXgxVTgv67MmPh1br7psWURylhf55YfgPDM9/QUeEllrSw4YIypEbL59xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983834; c=relaxed/simple;
	bh=09qKpXl0t+e4P0ebd0zTWm6cXaPOB32fz2frDjlnQwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUqU0jmYkcHEXHfkV5Jm733LWWNMbnmBennUJhyj2w08VBfTAP0hco86DUAuhZHpoQQcz600xIrbLYU9dK2HW56uF90cKud2NqWgk4dzhOfQt86465w+w1/u2C9P5E92b2h5jMOz/QQrlh/h4WxNIAXf5Gf8+JAtrLRUwuuKKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fb8mmFWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68BEC116D0;
	Wed, 25 Feb 2026 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983834;
	bh=09qKpXl0t+e4P0ebd0zTWm6cXaPOB32fz2frDjlnQwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fb8mmFWXRuDzTuqSogaqgmdj6eKj3eCQZONh1bFcHfy4EABcls0RS6aaioL3jRR3v
	 UoyOsmVWJ9gZcAF3HD58HlRkIzb+WIwgzleY+lkZkHB3EEeSiMpQfDk6IAaUaVkVtA
	 6OQm99bGyTL7PVzAsvhKJv/hQwulUwGnVGINiU08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 114/641] media: pci: mg4b: Use IRQF_NO_THREAD
Date: Tue, 24 Feb 2026 17:17:20 -0800
Message-ID: <20260225012351.889478854@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218936-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: A2DAB1903BD
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit ef92b98f5f6758a049898b53aa30476010db04fa ]

The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke other
interrupt handlers and this supposed to happen from hard interrupt context.

Use IRQF_NO_THREAD to forbid forced-threading.

Fixes: 0ab13674a9bd1 ("media: pci: mgb4: Added Digiteq Automotive MGB4 driver")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-21-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
index d7dddc5c8728e..10c23f0c833d5 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -114,7 +114,7 @@ static int probe_trigger(struct iio_dev *indio_dev, int irq)
 	if (!st->trig)
 		return -ENOMEM;
 
-	ret = request_irq(irq, &iio_trigger_generic_data_rdy_poll, 0,
+	ret = request_irq(irq, &iio_trigger_generic_data_rdy_poll, IRQF_NO_THREAD,
 			  "mgb4-trigger", st->trig);
 	if (ret)
 		goto error_free_trig;
-- 
2.51.0




