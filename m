Return-Path: <stable+bounces-214005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPkIMn5mg2nQmQMAu9opvQ
	(envelope-from <stable+bounces-214005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:32:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF1E8CE6
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B592E310AAC6
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC94219EB;
	Wed,  4 Feb 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xrGnh3na"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8D4219E7;
	Wed,  4 Feb 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218240; cv=none; b=OzgK93uQiYxNSJE1sTxJsJEPS1GkZFJYTsyk/TZJYSfNJeSW3ya1hXi2m3E6vFIAF6G54C4ONiySPE79NiW7xmZemHdKP3zwGXw2vOn/yaU8w5B6Y455W5UyQgEI76zZQDPN0wt8mwv5/YqTbXzWV9bJ1SaSK4amIqP09mC9wYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218240; c=relaxed/simple;
	bh=TYF2FIvox7a3qkRnKbs9uNvJdpnJXDZScHYTry6fzzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idQictXVSgfmpxGHxJFYqXaCnuKeSJX8pfnGGeoI6d6m/mXlUsuVaVDUKOSkyC6hPCySeV/DrlaiZIYuA4rUR1uG6sxz64EYxHyPjj4UfeiWfZCgXiHC0P767Coj5IrtiGR7ZzqS8xx95RAPBQuchIiZcU1rmiV8Zt80C/7F2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xrGnh3na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271B7C4CEF7;
	Wed,  4 Feb 2026 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218240;
	bh=TYF2FIvox7a3qkRnKbs9uNvJdpnJXDZScHYTry6fzzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xrGnh3na94uvZVSDMWCDOu1WdOusNTxcVK/k5z8LqA+Y7yrV7/Atefn87lwRaJrR4
	 CvtD+eWHGkOmQkwj21WgVWJgWW6MRQagg6GwphoFdasJsNQxa9YvqMjBGFoEpNvywR
	 bsKx5/VTovv1hnL1PRYpZR7i1b11MUIASaKviZUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gyeyoung Baek <gye976@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1 253/280] genirq/irq_sim: Initialize work context pointers properly
Date: Wed,  4 Feb 2026 15:40:27 +0100
Message-ID: <20260204143918.750879253@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214005-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linutronix.de,163.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 8DCF1E8CE6
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gyeyoung Baek <gye976@gmail.com>

[ Upstream commit 8a2277a3c9e4cc5398f80821afe7ecbe9bdf2819 ]

Initialize `ops` member's pointers properly by using kzalloc() instead of
kmalloc() when allocating the simulation work context. Otherwise the
pointers contain random content leading to invalid dereferencing.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250612124827.63259-1-gye976@gmail.com
[ The context change is due to the commit 011f583781fa
("genirq/irq_sim: add an extended irq_sim initializer")
which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/irq_sim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -166,7 +166,7 @@ struct irq_domain *irq_domain_create_sim
 {
 	struct irq_sim_work_ctx *work_ctx;
 
-	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
+	work_ctx = kzalloc(sizeof(*work_ctx), GFP_KERNEL);
 	if (!work_ctx)
 		goto err_out;
 



