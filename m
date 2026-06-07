Return-Path: <stable+bounces-261782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2cK2OX9QJWp8GwIAu9opvQ
	(envelope-from <stable+bounces-261782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:05:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A746504B4
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xcviOkUZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261782-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261782-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0556530469A5
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9703264F2;
	Sun,  7 Jun 2026 10:57:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10512CDA5;
	Sun,  7 Jun 2026 10:57:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829822; cv=none; b=GneT8bKy+LeHlV+wXyeUg1W3G8ZQgTjzTz4ECbpuKluTpwlQPOxhxEWWrtmybR5mE51ThEH179dKt1f9ZHNAyao0m7v4ys64A3VR/CuOP4x+0o3WC+Zb1rcgH7zWHdmRyseMHgQiiXiLMm/LE4K5gjc/1Z/yLMtGOzpXoAE+v30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829822; c=relaxed/simple;
	bh=SN839y3S77mBSiBWITG4D/o5eC9tpDWW/qPUaDiSQ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUrZRfwklvEP55vyS3a056uKuC4i+vuadTa865uSUyozoCTz5kG60nMq+5apS9qJRm9nbsNkEgBSoz9ppEmnDoGQ2S3W73vkNKhqMNUl/8kUIDjTSaRjotNbF+hC1IvMw97I6hAO6R0X+EQafrFfARYpyTiqwpv1VK1aZSa9cKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xcviOkUZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63331F00893;
	Sun,  7 Jun 2026 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829821;
	bh=VJl4CSDz3xY8JaROp5nEupmr+dRJhjAVfOnQq/4HvCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xcviOkUZjjj9vH73MlfQI72psO5fN89dqLWribVa9q4919sysXowqDp92lVfeUAaL
	 7QOfpfpR2+5dMUOxn2ZMR7o7BjBAcc7Uiflh/zhOqn0Cn4c55uyLvKiHM7rWRg4BnZ
	 r/Z9g/wDizrL8AOWsHICWEwJN7cSAHH2czBaotW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jacques Nilo <jnilo@free.fr>
Subject: [PATCH 6.18 281/315] serial: 8250_dw: dispatch SysRq character in dw8250_handle_irq()
Date: Sun,  7 Jun 2026 12:01:08 +0200
Message-ID: <20260607095737.908077042@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261782-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ilpo.jarvinen@linux.intel.com,m:jnilo@free.fr,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,free.fr];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57A746504B4

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacques Nilo <jnilo@free.fr>

commit 2e211723953f7740e54b53f3d3a0d5e351a5e223 upstream.

dw8250_handle_irq() calls serial8250_handle_irq_locked() with the port
lock held via guard(uart_port_lock_irqsave). The guard destructor is
plain uart_port_unlock_irqrestore(), so a SysRq character captured into
port->sysrq_ch by uart_prepare_sysrq_char() is dropped without ever
being dispatched to handle_sysrq().

This is the same regression pattern as in serial8250_handle_irq(),
introduced when 883c5a2bc934 ("serial: 8250_dw: Rework
dw8250_handle_irq() locking and IIR handling") moved the function to
the guard()-based locking scheme without using the sysrq-aware unlock
helper.

Switch to guard(uart_port_lock_check_sysrq_irqsave) so that captured
sysrq_ch is dispatched on scope exit, matching the fix in
serial8250_handle_irq().

Fixes: 883c5a2bc934 ("serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling")
Cc: stable@vger.kernel.org
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jacques Nilo <jnilo@free.fr>
Link: https://patch.msgid.link/ed56fcaf4af24e4ed011a7bce206e0182acb761c.1778675349.git.jnilo@free.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 94beadb4024d..2af0c4d0ad82 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -427,7 +427,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
 
-	guard(uart_port_lock_irqsave)(p);
+	guard(uart_port_lock_check_sysrq_irqsave)(p);
 
 	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
 	case UART_IIR_NO_INT:
-- 
2.54.0




