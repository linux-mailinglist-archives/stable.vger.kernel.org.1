Return-Path: <stable+bounces-216773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO2XCxI9lGmTAwIAu9opvQ
	(envelope-from <stable+bounces-216773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:04:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE3514AA61
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 11:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B606F3019BA9
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65B320A0D;
	Tue, 17 Feb 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="et0N0IO1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="syJaosc4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB893203B6;
	Tue, 17 Feb 2026 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322577; cv=none; b=MsiuLwyIbjfgIjaL1Sgdk7nYhj8cAZbg0VFbrmBveVs0syAzKcVaiKWtKT8N1r8S8DNM8L3XCPXrigQxyfD045CrDB2N9L41ToZNQQ4mupfey/4iqTTpA5FkBTE8xHt77FcZaIWS5Qubb3Dr2yBPSBlEWH5PW+r8Jg1ST3huaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322577; c=relaxed/simple;
	bh=MgnBL94bxY9U9GLLXWSR9DilnmY3dR23Z3dSVOtxSfk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lP5DtV4U2Sw0HPwoS4HjTRkb8crrEGkmE4hmx2UZvEdMbNNTq+yxkzOjWKpFjYg0R2IN8rHS7ooPC6RiMQP0QTfp+SDk7QfujW3CYd+bW3eMVWNZfI6i7AH7AMo1rOlsS0DXDAXkKV5cPD984WXegMfXt0Vstep4AUArJbsVXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=et0N0IO1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=syJaosc4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Feb 2026 10:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771322574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDh1/BBH3Iu8px0I1Zge1iKEBif9YBXmGehJvtxYseM=;
	b=et0N0IO1Flx48QgSYCU9TXioi6d7BA5vXSejaBQoZ5QnstDAfi/9/LNNofvvr1A4hCjmKN
	iNjO1btrGzDFRs5UR9pJPRwm2MuaOqd9XGY/97VQowG0HSdP3JJLqtT9TOXZ8618WK7sL7
	atERf+tZ0/sY53gBpHCKBzCgptkec5z7QKmAaqdvss/PDbsq7tI6vYn7ZlQ5OvM6oUoh7L
	m73v+mE0hsBOokS5tqFQz85a/N1X8uypVVPO4mvXo7kvjyksXGxzEDdtm+VN6L2u0MqBuS
	N3FeqYxjaWjgSz0or/NbH2K3PBm5qzjnijHQ+AoS2O+c0cDMrMGFJfMBNVmcuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771322574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDh1/BBH3Iu8px0I1Zge1iKEBif9YBXmGehJvtxYseM=;
	b=syJaosc4vLGLZ9nlI+38iakrWzvNaIQJi9jQvkgMsDm+2lo9CAy/QmGhj3O18cKrx8tOoE
	TKrQ4Y9ieYBN8HCQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Limit number of per-device MSIs
 to the range the ITS supports
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Zenghui Yu <zenghui.yu@linux.dev>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260206154816.3582887-1-maz@kernel.org>
References: <20260206154816.3582887-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177132257280.542.645556472830907489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216773-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,linutronix.de:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto,linux.dev:email]
X-Rspamd-Queue-Id: 7DE3514AA61
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ce9e40a9a5e5cff0b1b0d2fa582b3d71a8ce68e8
Gitweb:        https://git.kernel.org/tip/ce9e40a9a5e5cff0b1b0d2fa582b3d71a8c=
e68e8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 06 Feb 2026 15:48:16=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 17 Feb 2026 11:00:43 +01:00

irqchip/gic-v3-its: Limit number of per-device MSIs to the range the ITS supp=
orts

The ITS driver blindly assumes that EventIDs are in abundant supply, to the
point where it never checks how many the hardware actually supports.

It turns out that some pretty esoteric integrations make it so that only a
few bits are available, all the way down to a single bit.

Enforce the advertised limitation at the point of allocating the device
structure, and hope that the endpoint driver can deal with such limitation.

Fixes: 84a6a2e7fc18d ("irqchip: GICv3: ITS: device allocation and configurati=
on")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260206154816.3582887-1-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c   | 4 ++++
 include/linux/irqchip/arm-gic-v3.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 2988def..a51e8e6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3475,6 +3475,7 @@ static struct its_device *its_create_device(struct its_=
node *its, u32 dev_id,
 	int lpi_base;
 	int nr_lpis;
 	int nr_ites;
+	int id_bits;
 	int sz;
=20
 	if (!its_alloc_device_table(its, dev_id))
@@ -3486,7 +3487,10 @@ static struct its_device *its_create_device(struct its=
_node *its, u32 dev_id,
 	/*
 	 * Even if the device wants a single LPI, the ITT must be
 	 * sized as a power of two (and you need at least one bit...).
+	 * Also honor the ITS's own EID limit.
 	 */
+	id_bits =3D FIELD_GET(GITS_TYPER_IDBITS, its->typer) + 1;
+	nvecs =3D min_t(unsigned int, nvecs, BIT(id_bits));
 	nr_ites =3D max(2, nvecs);
 	sz =3D nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
 	sz =3D max(sz, ITS_ITT_ALIGN);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-g=
ic-v3.h
index 70c0948..0225121 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -394,6 +394,7 @@
 #define GITS_TYPER_VLPIS		(1UL << 1)
 #define GITS_TYPER_ITT_ENTRY_SIZE_SHIFT	4
 #define GITS_TYPER_ITT_ENTRY_SIZE	GENMASK_ULL(7, 4)
+#define GITS_TYPER_IDBITS		GENMASK_ULL(12, 8)
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS		GENMASK_ULL(17, 13)

