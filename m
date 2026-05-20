Return-Path: <stable+bounces-251160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN5PLaYVDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-251160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:12:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF8A599420
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93016319CD4C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6763277C88;
	Wed, 20 May 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jLQzrrHL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9756B3F23D5;
	Wed, 20 May 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297255; cv=none; b=WEgoKSitgFuLa645zEKhTGQwWuLaAmw0xTwGSklUjfeCdGko1xVT7b3tOMpJa2pwONTRN/1s/RDuWnKV/6FyNkxIl7mcs4gHGgxZuQKOIBaWJLnmZMtFphFom//jf51A9fhfxBfLzLr+72wmUWm/Qwv80nLb0rB137+E96clxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297255; c=relaxed/simple;
	bh=wyvc/ssxtaNeeHsg0mrT1OpINQB6xK0gNjFg+faLeiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StRzWbFu9V9urAQ6VT6w4IePfMjUkWs5pNfLMfe5uVy6cwCkmULsUq3f4MfB1gduZt8tVNJyZeW105t67JoUNJaANjMMIWlwV4MwS8W7Er32pEDtcMtGU/J/qj0mkEnm7DCgXTZv+bbKJPOe2pFdC4PALlvtRnANxNL98Nxweto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jLQzrrHL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087EB1F000E9;
	Wed, 20 May 2026 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297254;
	bh=meYMvZsQYilu7mkM0bpgjG6W1QwzUXeBgZuCemwwhNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jLQzrrHLS0knnPwqW97hzUGur85hqk+cdx7NrpAKxtTcnBhJmbwFOsZboE6Uf15jp
	 S97v8h9qxHEDYe4q1b47TPhA9VsAM3HVjZj0wZzlPfpzNM2nzEV72M27fNXkr37ZKY
	 qhezwhfHMFPqoJN35pDawfm/lUpFWTbMiouCztOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH 7.0 1109/1146] irqchip/riscv-imsic: Clear interrupt move state during CPU offlining
Date: Wed, 20 May 2026 18:22:39 +0200
Message-ID: <20260520162213.343065074@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251160-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1AF8A599420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

commit cefafbd561402b0fe6447449364a30315b9b1570 upstream.

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

Fixes: 0f67911e821c ("irqchip/riscv-imsic: Separate next and previous pointers in IMSIC vector")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260508-imsic-v2-1-e9f08dd46cf5@sifive.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-riscv-imsic-early.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -158,6 +158,8 @@ static int imsic_dying_cpu(unsigned int
 	/* Cleanup IPIs */
 	imsic_ipi_dying_cpu();
 
+	imsic_local_sync_all(false);
+
 	/* Mark per-CPU IMSIC state as offline */
 	imsic_state_offline();
 



