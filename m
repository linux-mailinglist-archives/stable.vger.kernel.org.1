Return-Path: <stable+bounces-245217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBjSK9PZAWrPlQEAu9opvQ
	(envelope-from <stable+bounces-245217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:29:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A0A50EEDC
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60FCD303C65B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337A3F7AB5;
	Mon, 11 May 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q6zzcstT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWtgRT5x"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F19A3EDAA8;
	Mon, 11 May 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506033; cv=none; b=Qgg8b+3iSOHmvvfw6manMWqDLom+xAIeKpZ08ZLOI4aJ0JUTnTh5tcPglzZy6FctfHfF6XumfYECN5UatCX269uHJTRc/B+n2gMnU+YcR/ixrJd12OdZkZwdraE4BLgBSCc+HtFQ2crs+twBayaRzMS2SKfgVVKIlunXJVNzUzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506033; c=relaxed/simple;
	bh=TGMrt0CUBZC+RDkO8sr8AWJM4VCFNEo8h1ID166xi40=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sCI8zia0ozvK/SiojU+ZBeWS9wapNnJ+GE+spkUWYC2GiUUSZaaFexXowkbgucPPl3n/BF+MIiBOWMuVMdvcXlk54vuTVs6aewM03JaDs5RMx205xtgn/dmUyx5IEp7JxXOyyHbfzyzerwJUOAQS/RmoQARnVlUl//0e5bGVmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q6zzcstT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWtgRT5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 May 2026 13:27:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778506031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IB5ImmIo1UNPNo0czMHeOpt+ZMRgA1Aoa4RPcA7nnQ=;
	b=q6zzcstTvAgBlPf4qBtn+9GkgtjQp8gGla8RFspZY9aNbWNmYIru6mfQQvheuTNWAOa6WY
	hzPBR7YUTmavpktrRlK+NMZfxJmWAw+42GPDzed+a7M1YRrmX7f6dP+JTzJwvQX4NFI4Ni
	NBW+Qa8Ur3S6xr8T7+JyhrZBjUIWUSOTE3SJqtNaPkFHlyLHBP5WlOtzNrrUvBQ5PMZcd/
	ryYpD9FIWSU7bSPhPpaLbWVYTmiC9+JrGcRVKY9lw0kIMYSbv71w62MubZCGNJCRoUpOBT
	t15EDAGrdVq3xRCNjsKBBXmSJ4FeWANHjhY4qwaGLnuIpG6qUlMoQEQrBDYmBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778506031;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IB5ImmIo1UNPNo0czMHeOpt+ZMRgA1Aoa4RPcA7nnQ=;
	b=CWtgRT5xNsMQC7YFyrXU+PTtD+bb/TdfaGHo7qKJGtdXCwRl9a+R690yjmk6u7hhX2KLBq
	CO/jMrmvdlhtVrCg==
From: "tip-bot2 for Yong-Xuan Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-imsic: Clear interrupt move state
 during CPU offlining
Cc: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260508-imsic-v2-1-e9f08dd46cf5@sifive.com>
References: <20260508-imsic-v2-1-e9f08dd46cf5@sifive.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177850602951.188840.12884197698863259648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 70A0A50EEDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245217-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     cefafbd561402b0fe6447449364a30315b9b1570
Gitweb:        https://git.kernel.org/tip/cefafbd561402b0fe6447449364a30315b9=
b1570
Author:        Yong-Xuan Wang <yongxuan.wang@sifive.com>
AuthorDate:    Fri, 08 May 2026 02:31:21 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 11 May 2026 15:23:11 +02:00

irqchip/riscv-imsic: Clear interrupt move state during CPU offlining

Affinity changes of IMSIC interrupts have to be careful to not lose an
interrupt in the process. Each vector keeps track of an affinity change in
progress with two pointers in struct imsic_vector.

imsic_vector::move_prev points to the previous CPU target data and
imsic_vector::move_next to the designated new CPU target data.

imsic_vector::move_prev on the new CPU can only be cleared after the
previous CPU has cleared imsic_vector::move_next, which ususally happens in
__imsic_remote_sync().

In case of CPU hot-unplug __imsic_remote_sync() is not invoked because the
CPU is already marked offline. That means imsic_vector::move_prev becomes
stale until the CPU is onlined again.

The stale pointer prevents further affinity changes for the affected
interrupts.

Solve this by clearing the imsic_vector::move_prev pointers in the CPU
hotplug offline path.

[ tglx: Replace word salad in change log ]

Fixes: 0f67911e821c ("irqchip/riscv-imsic: Separate next and previous pointer=
s in IMSIC vector")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260508-imsic-v2-1-e9f08dd46cf5@sifive.com
---
 drivers/irqchip/irq-riscv-imsic-early.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-ri=
scv-imsic-early.c
index ba903fa..a7a1852 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -158,6 +158,8 @@ static int imsic_dying_cpu(unsigned int cpu)
 	/* Cleanup IPIs */
 	imsic_ipi_dying_cpu();
=20
+	imsic_local_sync_all(false);
+
 	/* Mark per-CPU IMSIC state as offline */
 	imsic_state_offline();
=20

