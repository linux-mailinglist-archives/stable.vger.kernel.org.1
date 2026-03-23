Return-Path: <stable+bounces-229225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gANSLypcwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:28:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B02F655E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31534307DC8F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F843B7763;
	Mon, 23 Mar 2026 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mt7kfP9V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE79250BEC;
	Mon, 23 Mar 2026 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278452; cv=none; b=Zcgc/9YZ0AkQjoHdXbV7EprdBQplIgZNUvv6lwfULT5JTx6KDSRWPrEgq8fs68xEjIF/Dc3SiCkqeFo0bmirsHwN424YYVws0Sf9Y+3d4gcxhCbKwuN6JzjBoajGAlQNjU9L4tnuEAsc7e0gmduFi5y/QBsTTYrPnkR0csy0StU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278452; c=relaxed/simple;
	bh=lO+mjftZh1qJ2JFUc8I+DDzSSUs1EHAb5FPm19qZWIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM2H4k5y0gfTGgtwvp6RlZf+SlJPnBWzBlJ5SYQYDNMPDvPNDIQCMugrzoWCE71Pyi5svlly013tzFsJiVVGhb923ScRyVRDNdTVpgnyWSU9XSwTcbstbS37HI+hjffKrYKNeDlXt8PxBVzqC3QDtUzoIaxIjlngy9VWg5178vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mt7kfP9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A224C4CEF7;
	Mon, 23 Mar 2026 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278452;
	bh=lO+mjftZh1qJ2JFUc8I+DDzSSUs1EHAb5FPm19qZWIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mt7kfP9VGR+j5ZwhiAQ77N6XWIJSfLY+f39lF4YZ9GbLiJsvjx8jjbOMEWMbbeaAX
	 UquDbMIXnCCYUFEii3Pw7bTTrxsBgp6SWbvZS7jqXQVgr9L3zuYFS7K3f8uHlsZ5lO
	 6lWsrjkE7oRAmPuyOrJU++mK0HlC6ePUhCrjhhVs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 6.6 311/567] irqchip/gic-v3-its: Limit number of per-device MSIs to the range the ITS supports
Date: Mon, 23 Mar 2026 14:43:51 +0100
Message-ID: <20260323134541.517967698@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229225-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 387B02F655E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <maz@kernel.org>

commit ce9e40a9a5e5cff0b1b0d2fa582b3d71a8ce68e8 upstream.

The ITS driver blindly assumes that EventIDs are in abundant supply, to the
point where it never checks how many the hardware actually supports.

It turns out that some pretty esoteric integrations make it so that only a
few bits are available, all the way down to a single bit.

Enforce the advertised limitation at the point of allocating the device
structure, and hope that the endpoint driver can deal with such limitation.

Fixes: 84a6a2e7fc18d ("irqchip: GICv3: ITS: device allocation and configuration")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260206154816.3582887-1-maz@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v3-its.c   |    4 ++++
 include/linux/irqchip/arm-gic-v3.h |    1 +
 2 files changed, 5 insertions(+)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3402,6 +3402,7 @@ static struct its_device *its_create_dev
 	int lpi_base;
 	int nr_lpis;
 	int nr_ites;
+	int id_bits;
 	int sz;
 
 	if (!its_alloc_device_table(its, dev_id))
@@ -3414,7 +3415,10 @@ static struct its_device *its_create_dev
 	/*
 	 * Even if the device wants a single LPI, the ITT must be
 	 * sized as a power of two (and you need at least one bit...).
+	 * Also honor the ITS's own EID limit.
 	 */
+	id_bits = FIELD_GET(GITS_TYPER_IDBITS, its->typer) + 1;
+	nvecs = min_t(unsigned int, nvecs, BIT(id_bits));
 	nr_ites = max(2, nvecs);
 	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
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



