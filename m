Return-Path: <stable+bounces-236442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFZiOQgZ3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D6C3EEE29
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFF0302E307
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F70330AACB;
	Mon, 13 Apr 2026 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGdmXyfD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BE30ACE6;
	Mon, 13 Apr 2026 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096916; cv=none; b=p7J5hZxNfS5k5om0UGiEq34I3MGlz6QntrKCx69bKZN1ym5xl/otb3VG2nwJ0q/sjLRD1B2WUm2Rhv7+z2c4l/hpnN+1TVYKr3iBwgq11bkgIWcZYno1sOxsn/o0yt1jL+cI39Ee+Gs93fRcducsfxzxIQ1vwZ1ws2QLiy/eJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096916; c=relaxed/simple;
	bh=/b7WRGqVwSeQR4fcmYAeN4djvQt9ZfQDB292qQZ1b10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MK0CeBY/XcguwP6H6u9IJfwHM3Mah9SiwJ02czmLCGo/+Y4hwhJQTV4negr+vOnzBheeSysYT2dF25AScnPNIGIFBRD8HUFsJnfhh0FOCItb54eS9OKya9hXYw0Nb/pQ4liMYNbjoJOv0wA9P53DGccfXSE64Aeizt22cqQ5wDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGdmXyfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC769C2BCAF;
	Mon, 13 Apr 2026 16:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096916;
	bh=/b7WRGqVwSeQR4fcmYAeN4djvQt9ZfQDB292qQZ1b10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGdmXyfD6GL9uee8PiTf58mC+tVw4DVGJuXtFH51K/S90gfdzanwvi89/XtMgtMxz
	 Rb9wyj0GnMNcnUSQczi8wqnDjG4TTT58WDhrGZKgss49fvCnw46BxzRHKF41KjyMcS
	 EFlHpNStxD7j+NUzzZc5Y0fQqdiLuHP55ZC59xFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 42/50] net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
Date: Mon, 13 Apr 2026 18:01:09 +0200
Message-ID: <20260413155726.082621997@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236442-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 58D6C3EEE29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

commit 3fd0da4fd8851a7e62d009b7db6c4a05b092bc19 upstream.

page_pool_create() can return an ERR_PTR on failure. The return value
is used unconditionally in the loop that follows, passing the error
pointer through xdp_rxq_info_reg_mem_model() into page_pool_use_xdp_mem(),
which dereferences it, causing a kernel oops.

Add an IS_ERR check after page_pool_create() to return early on failure.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260405055241.35767-2-devnexen@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -85,6 +85,8 @@ static int lan966x_fdma_rx_alloc_page_po
 		pp_params.dma_dir = DMA_BIDIRECTIONAL;
 
 	rx->page_pool = page_pool_create(&pp_params);
+	if (unlikely(IS_ERR(rx->page_pool)))
+		return PTR_ERR(rx->page_pool);
 
 	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
 		struct lan966x_port *port;



