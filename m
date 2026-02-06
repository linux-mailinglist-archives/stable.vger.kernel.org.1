Return-Path: <stable+bounces-214667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAyRKkwNhmkRJQQAu9opvQ
	(envelope-from <stable+bounces-214667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 16:48:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6A8FFE35
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 16:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945AB302C5ED
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A11F2D8780;
	Fri,  6 Feb 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oY0vaaiG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17212882DE;
	Fri,  6 Feb 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770392903; cv=none; b=COC7CvZ6CzS3uuFUNt8R2rux95XqaH3+8R25+nascDh0ATZsAh0tnjrLkM2r348J1ZlryOV1ZLeWrHtYeuPxrrpRxqxc3r9PVvGYJjTbymyxA4jPXw9C2HDg38Du2AE9ddOGZ53Apz92LoU2Wp8nwR62wsU8QXuoguHQIlmCRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770392903; c=relaxed/simple;
	bh=u0kXhBG7RKykT4a2plJUwV+qAtS+NbaloqTIo40MoRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9SVMbGQNgclD3BmfMSFSJfT/d1swyjBYd9TgyN3nd9l5zu/pCcuPFKvgV03PmzGrxnhx+/TXZ1KKVhmktuWNJacDMcj8vhHwaSAuZ78XF6DRY4YKcaZm+UYwSmDzEmAW0MhfWpR6jexnG5M4/k3UHjW59MSTd8fn/GFHx3K2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oY0vaaiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE1C19422;
	Fri,  6 Feb 2026 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770392902;
	bh=u0kXhBG7RKykT4a2plJUwV+qAtS+NbaloqTIo40MoRc=;
	h=From:To:Cc:Subject:Date:From;
	b=oY0vaaiG77HJNetYFwAFKR1W7fx/9iZr6G410Djd7mCwWzY9pY0w6BHiW73xnVuGO
	 yHHfdUEeUSCz85Vk3pUX5QZx2te+ICxuoOoKmiaUHFoTIXZ3HoF7wN1yC4hiPMEq6Q
	 iPVG/XgcUEGHuPs0TzMPnpYyHcH0DMC9OfVWcrOx6gbx983HFT7qwnpLrKg/XuaZ2m
	 MzKfWyN3ZTnbZxa3QRfFh/jZoesgng4kJD4sESkvrBA4bgy95M/gLKhuQ1PDs/+Cbr
	 fCv7Ks5x1euNZGqEpaeqhcwN3R0biCIg9qTidgAC3h8FXKF1pV1AEKt5BpoXXL070G
	 1WmWRszSmuIgQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1voO4B-00000009Bya-1fUT;
	Fri, 06 Feb 2026 15:48:19 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3-its: Limit number of per-device MSIs to the range the ITS supports
Date: Fri,  6 Feb 2026 15:48:16 +0000
Message-ID: <20260206154816.3582887-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tglx@kernel.org, robin.murphy@arm.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214667-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maz@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF6A8FFE35
X-Rspamd-Action: no action

The ITS driver blindly assumes that EventIDs are in abundant supply,
to the point where it never checks how many the HW actually supports.

It turns out that some pretty esoteric integrations make it so that
only a few bits are available, all the way down to a. single. bit.

Enforce the advertised limitation at the point of allocating the
device structure, and hope that the endpoint driver can deal with
such limitation.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c   | 4 ++++
 include/linux/irqchip/arm-gic-v3.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2988def30972b..a51e8e6a81819 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3475,6 +3475,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	int lpi_base;
 	int nr_lpis;
 	int nr_ites;
+	int id_bits;
 	int sz;
 
 	if (!its_alloc_device_table(its, dev_id))
@@ -3486,7 +3487,10 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	/*
 	 * Even if the device wants a single LPI, the ITT must be
 	 * sized as a power of two (and you need at least one bit...).
+	 * Also honor the ITS's own EID limit.
 	 */
+	id_bits = FIELD_GET(GITS_TYPER_IDBITS, its->typer) + 1;
+	nvecs = min_t(unsigned int, nvecs, BIT(id_bits));
 	nr_ites = max(2, nvecs);
 	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
 	sz = max(sz, ITS_ITT_ALIGN);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 70c0948f978eb..0225121f30138 100644
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
-- 
2.47.3


