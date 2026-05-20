Return-Path: <stable+bounces-251283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HEmEMMWDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:17:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB13599645
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F9E3341C739
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9E36A352;
	Wed, 20 May 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XvXPSx+Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B533F59D;
	Wed, 20 May 2026 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297580; cv=none; b=VQglFBGNMmzhsTi8nLg/4i5RuCrCKzrCFlFpf6kH5t2np+4zM2lF9Zk1nTPr/nHc9CFuZ8dVwz6eNuiumstyxvmpsls0FF+lztyvIxkSdySgU08+N1zjpeM4ALZghik8tVCADpZfVdWvcvVlHFPDrk1tGTm+C40E24/PpHC+mB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297580; c=relaxed/simple;
	bh=7/Bv/Zqx+kloyBZx8kbzGSMNhxRdjJtj3KS4hrZ/cms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcN0VABvO0foS2S7p+/iCG1gHkI7XRQqRrmrM0Un15NeJ0RYULlogrEcLOPnvPNuf/HKZcfvE45woQ7ItEqsS5lz9Prf0bOBHlx6zPG+i6REGvC7PAwrbRvaPoaTKalItkzrz2ZijaiteCNoWs+CdG8Oto1vnqoT9CEoE5baMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XvXPSx+Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E941F000E9;
	Wed, 20 May 2026 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297579;
	bh=uGQ70LmcxSkX8bOnSM4QiLIWrU/pd99vZ+Cl+EPmwIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvXPSx+QbIeVSP2O/ghbX7m6Lwqf/wNeY4rik74Vy1HZKR4lctMnWe8n9Q2Pzkemc
	 lCnOn6iiom0b4YMVBzLX1/g+6Da77wBLFQ00Sgs6gxGOE0oQMxddWcChQiOPB+mxbm
	 I0nw4rT6pFZCR5IjsVEb1C7DGdHZXUW6PW6Em3n4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh=20 ?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 043/957] scripts/gdb: timerlist: Adapt to move of tk_core
Date: Wed, 20 May 2026 18:08:46 +0200
Message-ID: <20260520162135.492813189@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251283-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 9FB13599645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>

[ Upstream commit 5aa9383813aca45b914d4a7481ca417ef13114df ]

tk_core is a macro today which cannot be resolved by gdb.

Use the correct symbol expression to reference tk_core.

Fixes: 22c62b9a84b8 ("timekeeping: Introduce auxiliary timekeepers")
Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260311-hrtimer-cleanups-v1-1-095357392669@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/timerlist.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index ccc24d30de806..9fb3436a217cc 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -20,7 +20,7 @@ def ktime_get():
     We can't read the hardware timer itself to add any nanoseconds
     that need to be added since we last stored the time in the
     timekeeper. But this is probably good enough for debug purposes."""
-    tk_core = gdb.parse_and_eval("&tk_core")
+    tk_core = gdb.parse_and_eval("&timekeeper_data[TIMEKEEPER_CORE]")
 
     return tk_core['timekeeper']['tkr_mono']['base']
 
-- 
2.53.0




