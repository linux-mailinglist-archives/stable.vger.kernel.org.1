Return-Path: <stable+bounces-220499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FrpBBVMo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:12:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B51C8011
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 144373135282
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C93C8F46;
	Sat, 28 Feb 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MirafwV2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EC481A81;
	Sat, 28 Feb 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300384; cv=none; b=VOHIOgoDn6AINVRucoTyx77nFLHqXeRilWOylJhhKIsrFnm3QbvtQOsPzjARIJH7uobgK9JhPMuXHNzNwzg3WR2ER4upk8acDD9s5bHz+UH1aDDpx4ItjI1h/4G7GhdXEJs5b252EqgUgKHnqJKR1bmmqm5CFSy7GOQ7hSqbZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300384; c=relaxed/simple;
	bh=DnlNZrpKdXMCrmj9gg1iXz58tbdOuYJMJUcu+H4F/CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSqa2e7d06P5kaw1BdclGIRxN3UsXi7ybCv62TjSpfyX8S2mnBEf1+1OU9pFzTb5bbhQJVchPba+ziMJnAcqdoZluBfrEIqSQ61Ahrbjnc5bZbtTMrjkMWD+8PeQeHz0/bd7EMw83pf1L4mjGmbfp/Uo4BDCtP4C8Sv3uW8K3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MirafwV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86786C19425;
	Sat, 28 Feb 2026 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300384;
	bh=DnlNZrpKdXMCrmj9gg1iXz58tbdOuYJMJUcu+H4F/CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MirafwV2ESGkYmlFSTm7x9O1POtz1J2kEaGy/kL/DRWXm2tIKo8dGGEFC61PL/s8J
	 KoW5XLBSAqLrUkLrrNiwmbBcMZddajgFrSJfzZQabzH8Vg8o+w951wXBZ+QZ7C9NJb
	 3se/MPNOLY8mXQV+gFeymeGzMb+RxNkwlvywT8YSVLG0yFRosLIXjA3yVyB65ZVoAc
	 Bg/kglwg6qirlOiOsGPZ/1LjP/Wzb/DHX1tsVv+b1KOfkeIDQqyZo8uggQl987qXbR
	 RNDM8dUxiG7Zif+FIp/yNoSZdxR2ADkgF8tUzHTd0TxvoCICY3OM69MDWiCAD+qMLh
	 H8KT43PbdrITw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 420/844] mshv: clear eventfd counter on irqfd shutdown
Date: Sat, 28 Feb 2026 12:25:33 -0500
Message-ID: <20260228173244.1509663-421-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220499-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 518B51C8011
X-Rspamd-Action: no action

From: Carlos López <clopez@suse.de>

[ Upstream commit 2b4246153e2184e3a3b4edc8cc35337d7a2455a6 ]

While unhooking from the irqfd waitqueue, clear the internal eventfd
counter by using eventfd_ctx_remove_wait_queue() instead of
remove_wait_queue(), preventing potential spurious interrupts. This
removes the need to store a pointer into the workqueue, as the eventfd
already keeps track of it.

This mimicks what other similar subsystems do on their equivalent paths
with their irqfds (KVM, Xen, ACRN support, etc).

Signed-off-by: Carlos López <clopez@suse.de>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/mshv_eventfd.c | 5 ++---
 drivers/hv/mshv_eventfd.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 6d176ed8ae516..188923fce40b4 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -248,12 +248,13 @@ static void mshv_irqfd_shutdown(struct work_struct *work)
 {
 	struct mshv_irqfd *irqfd =
 			container_of(work, struct mshv_irqfd, irqfd_shutdown);
+	u64 cnt;
 
 	/*
 	 * Synchronize with the wait-queue and unhook ourselves to prevent
 	 * further events.
 	 */
-	remove_wait_queue(irqfd->irqfd_wqh, &irqfd->irqfd_wait);
+	eventfd_ctx_remove_wait_queue(irqfd->irqfd_eventfd_ctx, &irqfd->irqfd_wait, &cnt);
 
 	if (irqfd->irqfd_resampler) {
 		mshv_irqfd_resampler_shutdown(irqfd);
@@ -372,8 +373,6 @@ static void mshv_irqfd_queue_proc(struct file *file, wait_queue_head_t *wqh,
 	struct mshv_irqfd *irqfd =
 			container_of(polltbl, struct mshv_irqfd, irqfd_polltbl);
 
-	irqfd->irqfd_wqh = wqh;
-
 	/*
 	 * TODO: Ensure there isn't already an exclusive, priority waiter, e.g.
 	 * that the irqfd isn't already bound to another partition.  Only the
diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
index 332e7670a3442..464c6b81ab336 100644
--- a/drivers/hv/mshv_eventfd.h
+++ b/drivers/hv/mshv_eventfd.h
@@ -32,7 +32,6 @@ struct mshv_irqfd {
 	struct mshv_lapic_irq		     irqfd_lapic_irq;
 	struct hlist_node		     irqfd_hnode;
 	poll_table			     irqfd_polltbl;
-	wait_queue_head_t		    *irqfd_wqh;
 	wait_queue_entry_t		     irqfd_wait;
 	struct work_struct		     irqfd_shutdown;
 	struct mshv_irqfd_resampler	    *irqfd_resampler;
-- 
2.51.0


