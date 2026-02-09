Return-Path: <stable+bounces-215432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJfNEMf0iWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:52:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD87111243
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32D5F3006B71
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8037B409;
	Mon,  9 Feb 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mARn9Qk2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957328312F;
	Mon,  9 Feb 2026 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648772; cv=none; b=YvpfRCe926hpAjIcXrpTJubPYs8dQ8Vh0xaGyJdUse8dnIj/QOElEylJdi8GzK+K+SUCB4kNRnVEGmUM+GZszf7JE0xsNuR+5pWepMW/TZFi/a3sfOJ8ePc2aq0B/+ipKBWXY2GjCCM/ewwNDHM62zFzrCX8IuOac+hxqZ5R/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648772; c=relaxed/simple;
	bh=jAbfx3Y/Rwu5rFFEVGIvO0HJEKG+EhHVi4rXva03bV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKPLtYsE1eT9tW5BRiXoSO+9jE595/Rp0n1cVfHCxFOcqUa0fAhyRBj0g2aN/XsuK3ziQ1xfwfxmzrxIIbE05cVEw9Xd0lsxoGiTunPTI3jpEknWQhX5RE127jLyA0zwXSlnDIXLX/5RqPF30mKifxIGpaLYGPu+Aog3FwpZAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mARn9Qk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAF1C116C6;
	Mon,  9 Feb 2026 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648772;
	bh=jAbfx3Y/Rwu5rFFEVGIvO0HJEKG+EhHVi4rXva03bV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mARn9Qk2icWi12rXwxYOVy/sAa3D0+PEPiakNSjanCPauWb4D3l9CkuUlLTYNv/FR
	 VUNBBJtCs08bNqehqRTBjM1eSMYMzEXdC4oJGZkepN9Zmgy3QdN+AfZfTdkPR9tb7n
	 0QjjN3cIulB7RIa194D5rTZoXxjz4AihcxvbPf8E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 5.15 11/75] clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
Date: Mon,  9 Feb 2026 15:24:08 +0100
Message-ID: <20260209142302.248052936@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215432-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,goodmis.org,linutronix.de,roeck-us.net,intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linutronix.de:email,roeck-us.net:email,goodmis.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBD87111243
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit 6e1fc2591f116dfb20b65cf27356475461d61bd8 ]

A new "shutdown" timer state is being added to the generic timer code. One
of the functions to change the timer into the state is called
"timer_shutdown()". This means that there can not be other functions
called "timer_shutdown()" as the timer code owns the "timer_*" name space.

Rename timer_shutdown() to evt_timer_shutdown() to avoid this conflict.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lkml.kernel.org/r/20221106212702.182883323@goodmis.org
Link: https://lore.kernel.org/all/20221105060155.592778858@goodmis.org/
Link: https://lore.kernel.org/r/20221110064147.158230501@goodmis.org
Link: https://lore.kernel.org/r/20221123201624.634354813@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clocksource/timer-sp804.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -155,14 +155,14 @@ static irqreturn_t sp804_timer_interrupt
 	return IRQ_HANDLED;
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static inline void evt_timer_shutdown(struct clock_event_device *evt)
 {
 	writel(0, common_clkevt->ctrl);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	return 0;
 }
 
@@ -171,7 +171,7 @@ static int sp804_set_periodic(struct clo
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
 
-	timer_shutdown(evt);
+	evt_timer_shutdown(evt);
 	writel(common_clkevt->reload, common_clkevt->load);
 	writel(ctrl, common_clkevt->ctrl);
 	return 0;



