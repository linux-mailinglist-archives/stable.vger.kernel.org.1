Return-Path: <stable+bounces-225802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDuAJvUquWmVtQEAu9opvQ
	(envelope-from <stable+bounces-225802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:20:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 101442A7BF7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4985305B597
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB613A4F37;
	Tue, 17 Mar 2026 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRoEmxVM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IHDUxvmp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D7E3A2576;
	Tue, 17 Mar 2026 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742738; cv=none; b=pvIvAg/EKeev5Tz+hxfHvKseYEb5FHCBjCb1JFb+CpgJuLbs60IHgqMUz2Qz+zkmdsH8zfn/UwzEiU2xKpHspz5k4RfzuTrbByuAapnZ0SxErlpjqV8Ks2P7emaYSn3o5ur7M7oQVFt3LEvhAJVLegsiawwUC3wma83cv+Zfr1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742738; c=relaxed/simple;
	bh=jPnYWUdNEjc9kUZMOXRUxrepSYhE+tXXV3PPmUEzhts=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IpPQNbcadzqRegYyMTQaQxVDsU9lJHXIaSgrzDPYhmhe+oo0n2GTsYbUnWFY1tPHEiKa0jf6bXeATJ5vDMQbe9zTCTxhqgmmhz90h7SlBH83yUggz0f3IRwnnpXkPimYTL/O+HxBXkktFIETGdxaMpQY+4lCPjnrjUJq50J6C7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRoEmxVM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IHDUxvmp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Mar 2026 10:18:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773742733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwtexRlYAbh2H4NdKQSY59V2rxetHEziyTG51wy+FcA=;
	b=yRoEmxVMOhf5tixRI9lK/V3B6grfVnSgNNO9h1zMdrSwhX9vYXYkuGRtb5fw7EfxzbQZw6
	RenloPS5y+IfyY/XdHystIS1pbrl3NXpKOIU41cdsQmmMmtGgNd6azZzwYt7snYqofwEb0
	wSPUlBEHZBcLwqZPwNPKml0TV9vvACOUUJaTM15hll1unFn3y5D5ILYy1FqJXExPd6cgzt
	ty6Ic0KFtiApqOzbWCE8ECfQ1uc7OQDB+jnaelM5Y+VkoaJgof/iujj4D/Omhokg15m0vb
	1jRtwPZsmu0+yh3JCf9jEbQlsVfWySIqL6VHzkEwuiq4nKL++ySRHz+GNi2ozA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773742733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwtexRlYAbh2H4NdKQSY59V2rxetHEziyTG51wy+FcA=;
	b=IHDUxvmp6CLePqKJB1+xAH/kb2DLdo95kS67rNcmkwp/4vliD2/toSJ0Wb1FudwKAGkOL+
	e3T00oj26NufBOAQ==
From: "tip-bot2 for Felix Gu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-rpmi-sysmsi: Fix mailbox channel leak
 in rpmi_sysmsi_probe()
Cc: Felix Gu <ustc.gu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, Rahul Pathak <rahul@summations.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260315-sysmsi-v1-1-5f090c86c2ca@gmail.com>
References: <20260315-sysmsi-v1-1-5f090c86c2ca@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177374273228.1647592.6158346179399854363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225802-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,summations.net];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto,summations.net:email]
X-Rspamd-Queue-Id: 101442A7BF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     76f0930d6e809234904cf9f0f5f42ee6c1dc694e
Gitweb:        https://git.kernel.org/tip/76f0930d6e809234904cf9f0f5f42ee6c1d=
c694e
Author:        Felix Gu <ustc.gu@gmail.com>
AuthorDate:    Sun, 15 Mar 2026 15:17:54 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 17 Mar 2026 11:16:15 +01:00

irqchip/riscv-rpmi-sysmsi: Fix mailbox channel leak in rpmi_sysmsi_probe()

When riscv_acpi_get_gsi_info() fails, the mailbox channel previously
requested via mbox_request_channel() is not freed. Add the missing
mbox_free_channel() call to prevent the resource leak.

Fixes: 4752b0cfbc37 ("irqchip/riscv-rpmi-sysmsi: Add ACPI support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Reviewed-by: Rahul Pathak <rahul@summations.net>
Link: https://patch.msgid.link/20260315-sysmsi-v1-1-5f090c86c2ca@gmail.com
---
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c b/drivers/irqchip/irq-ri=
scv-rpmi-sysmsi.c
index 5c74c56..612f397 100644
--- a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+++ b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
@@ -250,6 +250,7 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 		rc =3D riscv_acpi_get_gsi_info(fwnode, &priv->gsi_base, &id,
 					     &nr_irqs, NULL);
 		if (rc) {
+			mbox_free_channel(priv->chan);
 			dev_err(dev, "failed to find GSI mapping\n");
 			return rc;
 		}

