Return-Path: <stable+bounces-264502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9Hj8ELN4MWrRkAUAu9opvQ
	(envelope-from <stable+bounces-264502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:24:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994746920B4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:24:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=luGJwVrM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264502-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264502-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11248326DDD8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED13A16AC;
	Tue, 16 Jun 2026 16:10:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ECA33688F;
	Tue, 16 Jun 2026 16:10:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626231; cv=none; b=tZ+u8Tt7u7jZCj4LdrYVDCOvHtAVlUaMG+H03mAF4Qs2W1yyw0FLblHdZAT4MJmXyrg+g8KQxB8ecXv3suUvQ3A6p4J9RqR+jWCx4AMmy/OIIygIqKLEmz5JlUUpJPP6tWjqOR+hANKy4TFrhvF3Xi7HCRx524hYi/sHWzZC1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626231; c=relaxed/simple;
	bh=WBBUOAtnVe/F6A2e2LRQVnR7OWpEOphKOdbPuHQYboY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuLgtYHQec9zMmmW3nTJVdYCIddMn94z5lg50eTwsZ3LVl+aU/D5bR2CKbej2hJxdjJ0RBKWtpBeIjG1Yh72kYpDjmwJtJFuryGIGYRQHzsEPNsf0YG8GP75KW8UN/k1VKFJLTSC7EOUizoOwFeKHDxxmx9PqlpMntY+gthbKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=luGJwVrM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4132A1F000E9;
	Tue, 16 Jun 2026 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626230;
	bh=W9ql1PgQ96gYG/QtqeVfJT1k4jWf+Ollopx6+IqCPXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=luGJwVrMRP9WPIsVhHPQXZ3NY6a7gPaRtitR1I34xhrb/qZuSyOYrbfesA3V8PCyS
	 0AhIiBhfXa/arlRGwnVUAXuojqxcKRliTWvf0CARG9c5u/Z0Cs69J9k0bp/XPiuAsj
	 vTP06q4Sg/H52YufU/3VqHW/zA7ouB/cgTrobClI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Zilin Guan <zilin@seu.edu.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.18 245/325] octeontx2-af: fix memory leak in rvu_setup_hw_resources()
Date: Tue, 16 Jun 2026 20:30:41 +0530
Message-ID: <20260616145110.687848302@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264502-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dawei.feng@seu.edu.cn,m:zilin@seu.edu.cn,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 994746920B4

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dawei Feng <dawei.feng@seu.edu.cn>

commit 09a5bf856aa759513afc4afd233d15bcc711b84e upstream.

If rvu_npc_exact_init() fails in rvu_setup_hw_resources(), the function
returns directly instead of jumping to the error handling path. This
causes a resource leak for the previously initialized CGX, NPC, fwdata,
and MSI-X states.

Fix this by replacing the direct return with goto cgx_err to ensure
proper cleanup.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still present in
v7.1-rc6.

An x86_64 allyesconfig build showed no new warnings. As we do not have
access to Marvell OcteonTX2 RVU AF hardware to test with, no runtime
testing was able to be performed.

Fixes: 3571fe07a090 ("octeontx2-af: Drop rules for NPC MCAM")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Link: https://patch.msgid.link/20260604143756.1524482-1-dawei.feng@seu.edu.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1135,7 +1135,7 @@ cpt:
 	err = rvu_npc_exact_init(rvu);
 	if (err) {
 		dev_err(rvu->dev, "failed to initialize exact match table\n");
-		return err;
+		goto cgx_err;
 	}
 
 	/* Assign MACs for CGX mapped functions */



