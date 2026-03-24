Return-Path: <stable+bounces-230195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOV2Dpu5wmlilAQAu9opvQ
	(envelope-from <stable+bounces-230195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:19:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2C318E10
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 191773092F42
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9DC391820;
	Tue, 24 Mar 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bfmkUMtj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J51j8CZb"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0131F9A1;
	Tue, 24 Mar 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368593; cv=none; b=Y+ON50sdRrXbWjpSbMHMyYJegk1GSYTsZgK9nkfxDSIrel9VUwXWKaMitFPNL5ovEFr7/+Ba6+H3It5gTWRI6FqI2seOhuYaVWWHTfrXEoxyYZCZUnDlY0Oj6Z/cV96hunU7LVf0+JEkFyxNqRd9x49fxD9yNd0dS2SHx03ZNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368593; c=relaxed/simple;
	bh=0iAVex3HewGpzZCbgDi6IsYpcnd6c4TATUm/Qh5DItg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o1cgqILN13JTy/lfJ6vWq9g3mw+fzr/vFnOzJuilwcjp540T6oxM5XfFCbhGq3WQ65+4y3UW1o32LC2lFeya2Nj8VzO4udYtwd4r9M7FgGWI/+M+2U0PTkcIxcTeoKwyzCa1/DYn2ndIDQgnMA3NcFmuFCV+651ZwBt+HM78rog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bfmkUMtj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J51j8CZb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Mar 2026 16:09:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774368590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dA8dgedcJpGxRQ52borizebSA/4UjBKwblVYGWJioNc=;
	b=bfmkUMtj3mPA6+e0RVK+O42SPQmw8BKipx+gDTjfheAQJcppu8ZNSi4KSRCZJMOjnXxeOy
	Qsuu0HVmT55w6C0gtmSkut5wxDfXEWs5RGV8B3p36Z8/QA3beyWR2h5r1vPvT3gn7+xMAf
	in70oJ1Ji4VuK9x0YAi7ZNNejvOgG93BcCmbN6WX26WMQ0c0Zvz7/RatE2LnVNrMXItBAR
	CzKz3Ux3FQCauIKadOhl9s1dQBveiWgRV0cQmgyS0USwEc+zJ8LN9HLi7aTqUTa0tjnBYU
	5PmK52nTRsYvKQr50TMGNSH3CebbNvcKAtn1eqNXUaKY0sfwMmR05+qjn7+a5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774368590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dA8dgedcJpGxRQ52borizebSA/4UjBKwblVYGWJioNc=;
	b=J51j8CZbGSbNiNBa1I8xgogmgjkoWUG2zUNjRY2VvMMSOkPU+W8GMCuQKRMb70VLl/6G/u
	MI1VWGcAtaJYPKDQ==
From: "tip-bot2 for Jassi Brar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/qcom-mpm: Add missing mailbox TX done
 acknowledgment
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260322171533.608436-1-jassisinghbrar@gmail.com>
References: <20260322171533.608436-1-jassisinghbrar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177436858927.1647592.6531954753628943644.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230195-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,chromium.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,msgid.link:url,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: E7A2C318E10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     213a1f66341adf9e911b5c887970f209c132c4c0
Gitweb:        https://git.kernel.org/tip/213a1f66341adf9e911b5c887970f209c13=
2c4c0
Author:        Jassi Brar <jassisinghbrar@gmail.com>
AuthorDate:    Sun, 22 Mar 2026 12:15:33 -05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Mar 2026 17:03:26 +01:00

irqchip/qcom-mpm: Add missing mailbox TX done acknowledgment

The mbox_client for qcom-mpm sends NULL doorbell messages via
mbox_send_message() but never signals TX completion.

Set knows_txdone=3Dtrue and call mbox_client_txdone() after a successful
send, matching the pattern used by other Qualcomm mailbox clients (smp2p,
smsm, qcom_aoss etc).

Fixes: a6199bb514d8a6 "irqchip: Add Qualcomm MPM controller driver"
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260322171533.608436-1-jassisinghbrar@gmail.c=
om
---
 drivers/irqchip/irq-qcom-mpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 83f31ea..1813205 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -306,6 +306,8 @@ static int mpm_pd_power_off(struct generic_pm_domain *gen=
pd)
 	if (ret < 0)
 		return ret;
=20
+	mbox_client_txdone(priv->mbox_chan, 0);
+
 	return 0;
 }
=20
@@ -434,6 +436,7 @@ static int qcom_mpm_probe(struct platform_device *pdev, s=
truct device_node *pare
 	}
=20
 	priv->mbox_client.dev =3D dev;
+	priv->mbox_client.knows_txdone =3D true;
 	priv->mbox_chan =3D mbox_request_channel(&priv->mbox_client, 0);
 	if (IS_ERR(priv->mbox_chan)) {
 		ret =3D PTR_ERR(priv->mbox_chan);

