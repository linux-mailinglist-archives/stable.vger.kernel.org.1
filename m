Return-Path: <stable+bounces-228105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAzJHK1IwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:05:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 066482F3C9C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85B9430DC5D9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5C3AE18C;
	Mon, 23 Mar 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yjr8GgK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612D61A680D;
	Mon, 23 Mar 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274140; cv=none; b=l3k2HPg2u1UG6oEteQVHY0997vf1ZMvQXp7NpAKU8HMymIg9y4ifJiU7JqCEjsh7Lz0ndOVQiCEMYQ8wR6ev1xUfHZa1U/tFGFWqxF+4EUWs1xyYFyjNGuPQ+DKuecP2SUrJcaL6ebxb6W8ihLW3KxEgN0xyP2N9avpKOnHaxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274140; c=relaxed/simple;
	bh=tW5rJjv3sFUiw7fw4wcAZxBXNvyYiQzxmPpe3LWSE/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTTh3kGmJzKYUOBhClQ0Mk45tCQqbZYgHLkj1HjudpZQsTrQpfTms1agL1A1N0yR8XvF2xmlbvXam7sDpblDQs9Aj/P8vIdiOdwYBGx0mTtYJpTWE7o/+zn0D8R0dtxj8RPoMTt/PWbrncUKKr06Vmd3nVaTtjeU/OXKG28/O9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yjr8GgK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58BFC4CEF7;
	Mon, 23 Mar 2026 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274140;
	bh=tW5rJjv3sFUiw7fw4wcAZxBXNvyYiQzxmPpe3LWSE/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yjr8GgK+qnQJTxgJtKdlOrfxh6ruSrX5Dbmc84tLIFV2diwCh+oO6TgiDBAdpvnBR
	 CkBHWtp9ZXrBoeYsuNmpQ+arOVzcfOEbbdVCe+/xpCMKVSWNwb4sOuxNWq2DY6HtkH
	 CjkusmM6WQYA13UqlJvyQQvx+QGXcZajFDFc3DgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alessio Belle <alessio.belle@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH 6.19 080/220] drm/imagination: Fix deadlock in soft reset sequence
Date: Mon, 23 Mar 2026 14:44:17 +0100
Message-ID: <20260323134507.126627235@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228105-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,imgtec.com:email]
X-Rspamd-Queue-Id: 066482F3C9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alessio Belle <alessio.belle@imgtec.com>

commit a55c2a5c8d680156495b7b1e2a9f5a3e313ba524 upstream.

The soft reset sequence is currently executed from the threaded IRQ
handler, hence it cannot call disable_irq() which internally waits
for IRQ handlers, i.e. itself, to complete.

Use disable_irq_nosync() during a soft reset instead.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Cc: stable@vger.kernel.org
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Link: https://patch.msgid.link/20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/imagination/pvr_power.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -510,7 +510,16 @@ pvr_power_reset(struct pvr_device *pvr_d
 	}
 
 	/* Disable IRQs for the duration of the reset. */
-	disable_irq(pvr_dev->irq);
+	if (hard_reset) {
+		disable_irq(pvr_dev->irq);
+	} else {
+		/*
+		 * Soft reset is triggered as a response to a FW command to the Host and is
+		 * processed from the threaded IRQ handler. This code cannot (nor needs to)
+		 * wait for any IRQ processing to complete.
+		 */
+		disable_irq_nosync(pvr_dev->irq);
+	}
 
 	do {
 		if (hard_reset) {



