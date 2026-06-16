Return-Path: <stable+bounces-265333-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P0dZDWaIMWp7lwUAu9opvQ
	(envelope-from <stable+bounces-265333-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:31:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3369336E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:31:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=PI2+kcml;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265333-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265333-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF7B3078F4E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B43147A0B0;
	Tue, 16 Jun 2026 17:24:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6B478E26;
	Tue, 16 Jun 2026 17:24:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630669; cv=none; b=aRbTw3JdPXP7lG2jiLlrlMVtpN1a3hftC8WGn9oYhLin+0u60xjizmhpoVYojh/PRBcFkNqmSggoe6R8GD4NGvZKIrH4MXr4+Q1SVgxomCzTIuo/GQyZ9RfueTg983Y3podiRr3vuTgPWkDSeDHaedAnaZeiIf9bQrk7E7d914c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630669; c=relaxed/simple;
	bh=jv9QqnvL2zGmbAWQgOUFgJmLqK2AJ911nWLDBfVc9pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtE48gZ2nMcx1agoLfIKj8zq77S9Dom7a1b2YErGyLXy6DxblR6g2uCAAW4B4uDkuSRnhTQYMTAbJ2FoZODONTp7Rq0cYtekXih+OeM/gXhaHUDhs9Le0FBxyZFuyAQgIAHz6VIVRTdX8oTtTL+EvQx1X075DYc18hO2hB3vG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PI2+kcml; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29C41F000E9;
	Tue, 16 Jun 2026 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630667;
	bh=SzIGnI6/zyUQNzUcec+oEH24BkiNtRMpZtaswPfcMUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PI2+kcmlIKQsnvISI1glKyIeQ3obcFl2agVJamMXKU3VOAgK7W6G43dQHQK8ROglf
	 O+SIga3YsYgxWe8YHEBYtqcUqlQF7KcSIc+rYNSv+8W6cXB4cUSDmfJeG5NKTuOWkj
	 JhFBjk/ToGN8vgQH6R83RKCTrGApybgdZhR/W2tI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Hutchings <benh@debian.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 074/522] Revert "RDMA/rxe: Fix double free in rxe_srq_from_init"
Date: Tue, 16 Jun 2026 20:23:41 +0530
Message-ID: <20260616145129.304548397@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265333-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:benh@debian.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DD3369336E

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <benh@debian.org>

This reverts commit d286f0d4e3ad3caf5f0e673cdad7bf89bf37d947, which
was commit 0beefd0e15d962f497aad750b2d5e9c3570b66d1 upstream.  The
backported version did not move but duplicated the problematic
assignment, so it did not fix the bug.  A proper backport will follow.

Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_srq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 115ff5428f6cfb..02b39498c370d2 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -87,9 +87,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 		}
 	}
 
-	srq->rq.queue = q;
-	init->attr.max_wr = srq->rq.max_wr;
-
 	return 0;
 }
 
-- 
2.53.0




