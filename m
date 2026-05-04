Return-Path: <stable+bounces-243350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFKGCiep+GmdxgIAu9opvQ
	(envelope-from <stable+bounces-243350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F7B4BEBF8
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11C703011377
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5033DEFF3;
	Mon,  4 May 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0DX1JQ8r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA723DE44F;
	Mon,  4 May 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903660; cv=none; b=L8gIHAq2qsftDgTByvB+ieRM38CEMxfKKD/cmcdWwQAp8/DNSJunSCHdt+uWz1DMsXF5Ddpq0pIvTfU2yN7stbZKOf057sWNJg5+0j1ZyFm76bwXR/wY0Nwx9dyO2BofIECfvlcAJjfELJLMXw5pxu7SQfRPpOWHpanC12oLQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903660; c=relaxed/simple;
	bh=1d1olDnkcPYe+lEJ86I/W53UtRpx+d3C7JE0EXFdxM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dd5ZObnUlaOif1x7Km0L3MUdtYzW/mTncb/2S9h4LETe5KFHBiE6Hgx5S4CQvMEcQnLUQg9F9hL4oFJ8mtPU4Zcq97ob2E04MJljTdsMfR4tMQEbz3iNVLV5E3Htl9CCABciSteYxc1OBM3LzRDNsXeXUEi+LOx27CDj61gNHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0DX1JQ8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B18C2BCB8;
	Mon,  4 May 2026 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903660;
	bh=1d1olDnkcPYe+lEJ86I/W53UtRpx+d3C7JE0EXFdxM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0DX1JQ8rmcpophpgyZ0pEM3X3QZx0l06RIP0aIaUza37GULht3seg2+CAi97JHnu2
	 HJJbEeFYrVCOz/aVW7OJkTDQbcXC0f7bqIjZIRcQrSVZ4bEv76lqjPEkJp8Lw9QOTA
	 3fVaq1nJqFcX6+/Hc8uN6az8+GnM2JCurbr2g7eY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH 6.18 013/275] misc: ibmasm: fix OOB MMIO read in ibmasm_handle_mouse_interrupt()
Date: Mon,  4 May 2026 15:49:13 +0200
Message-ID: <20260504135143.432225986@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: E9F7B4BEBF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[northwestern.edu:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,northwestern.edu];
	TAGGED_FROM(0.00)[bounces-243350-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TO_DN_SOME(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_SPAM(0.00)[0.912];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,northwestern.edu:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyllis Xu <livelycarpet87@gmail.com>

commit 4b6e6ead556734bdc14024c5f837132b1e7a4b84 upstream.

ibmasm_handle_mouse_interrupt() performs an out-of-bounds MMIO read
when the queue reader or writer index from hardware exceeds
REMOTE_QUEUE_SIZE (60).

A compromised service processor can trigger this by writing an
out-of-range value to the reader or writer MMIO register before
asserting an interrupt. Since writer is re-read from hardware on
every loop iteration, it can also be set to an out-of-range value
after the loop has already started.

The root cause is that get_queue_reader() and get_queue_writer() return
raw readl() values that are passed directly into get_queue_entry(),
which computes:

  queue_begin + reader * sizeof(struct remote_input)

with no bounds check. This unchecked MMIO address is then passed to
memcpy_fromio(), reading 8 bytes from unintended device registers.
For sufficiently large values the address falls outside the PCI BAR
mapping entirely, triggering a machine check exception.

Fix by checking both indices against REMOTE_QUEUE_SIZE at the top of
the loop body, before any call to get_queue_entry(). On an out-of-range
value, reset the reader register to 0 via set_queue_reader() before
breaking, so that normal queue operation can resume if the corrupted
hardware state is transient.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 278d72ae8803 ("[PATCH] ibmasm driver: redesign handling of remote control events")
Cc: stable@vger.kernel.org
Cc: ychen@northwestern.edu
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
Link: https://patch.msgid.link/20260308062108.258940-1-LivelyCarpet87@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ibmasm/remote.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/misc/ibmasm/remote.c
+++ b/drivers/misc/ibmasm/remote.c
@@ -177,6 +177,11 @@ void ibmasm_handle_mouse_interrupt(struc
 	writer = get_queue_writer(sp);
 
 	while (reader != writer) {
+		if (reader >= REMOTE_QUEUE_SIZE || writer >= REMOTE_QUEUE_SIZE) {
+			set_queue_reader(sp, 0);
+			break;
+		}
+
 		memcpy_fromio(&input, get_queue_entry(sp, reader),
 				sizeof(struct remote_input));
 



