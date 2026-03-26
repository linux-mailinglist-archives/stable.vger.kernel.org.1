Return-Path: <stable+bounces-230487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EXfDDNSxWmD9QQAu9opvQ
	(envelope-from <stable+bounces-230487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:35:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB592337A86
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF01A30F81A8
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948F405AD0;
	Thu, 26 Mar 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VjPaf40o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+B3a94I0"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43420405AB0;
	Thu, 26 Mar 2026 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538526; cv=none; b=Bf//RbudBN+218Pm2hbFUWWtdUX3fYIDUli/kKLU1TkSfrCxgFdXAVBpUyNjCbsVFSBDcZfki4YdRRIEMllcTKStak4NDzowEb0rAZ5oZd1JqLHK4d9sz05qUhTZhJ1g5m3RamDuyOmLLDR/U8Z1fQk4BR80X97wLWInMjS3SN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538526; c=relaxed/simple;
	bh=RvEG6GjzGJXKKLKHclqRLVkzUMXEgBNiaGZyyG+1DlU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nye+4fHVrdBOwWwks2S44VmvOyWV/DQquL7r1ViVMaDNRoex4YrPOkJs9jirox8/NqICstfs4Jjs/Whwkwj+8O6SKVlfLIkZHlvYL+ULAnrXpg75D0FMkxP3PwV0Ta/uv7+pg9F01pnUJIHTYji03nhms3XtzK4rOuBGV6AToYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VjPaf40o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+B3a94I0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Mar 2026 15:22:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774538524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPTl5hzREaz3PJK20XgBhSJ+ViPcqT7uDCUd+Nl43PI=;
	b=VjPaf40oGO2vXV+MIZ1iqRtc5eB33WeDyPOs+Xm8lZix0iPacZBm/B3m8o2lfHAlciwNTH
	vVvvgaA7w+cJsDoTq14DUs+as9qLH1423ny9k1j5ksl3DaDdpA+ftbKyMum1iI2E9ojCPU
	CM97+pol2U2JvtCvWhLjwL1SJ7amIUEjZaXJeOJVK38El8gGvnImy0frF5iBOpnajEYP31
	YvX6vS4xru+6o22EsI1dkjT6t94UoPDKxUvUz03wTofl7OJYj15zklDoc2nlEzviT9tdhJ
	pbNsy1Gs8x+84hy9nlBQxcBPt1+ubmmIuDNQ+lHoLczHUX95SdBOhsgloFVlJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774538524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPTl5hzREaz3PJK20XgBhSJ+ViPcqT7uDCUd+Nl43PI=;
	b=+B3a94I0zc2s9pb3AffVbqgM01z9JgTsACWsMaTFZ2IxJk7M9OdPao4txsJApUNBvTtUMk
	ZJdheJXCXT78liBg==
From: "tip-bot2 for Jassi Brar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/qcom-mpm: Add missing mailbox TX done
 acknowledgment
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260322171533.608436-1-jassisinghbrar@gmail.com>
References: <20260322171533.608436-1-jassisinghbrar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177453852274.1647592.3165689758762688077.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-230487-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: DB592337A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     cfe02147e86307a17057ee4e3604f5f5919571d2
Gitweb:        https://git.kernel.org/tip/cfe02147e86307a17057ee4e3604f5f5919=
571d2
Author:        Jassi Brar <jassisinghbrar@gmail.com>
AuthorDate:    Sun, 22 Mar 2026 12:15:33 -05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 26 Mar 2026 16:11:53 +01:00

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

