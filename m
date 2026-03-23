Return-Path: <stable+bounces-228128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL0cLNxGwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-228128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:57:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14A2F3807
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDF7F30172EC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840FF3AD538;
	Mon, 23 Mar 2026 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oV57VD5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385ED3ACF03;
	Mon, 23 Mar 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274209; cv=none; b=olad/sU6TUHEjQjEBn+cGKg5tGvxsx0q0ArKpp4joTEsUClS4rZ02ul4fEAQG+XP+oncRe+wvWNo86eGI4lpGnqqqCbMtOg/hFU06QDjHShZUdTxT+NwzwzEHQ4VfoW50umtb0hlHcLT5MqZA4Tdrpc/plWD9kEzbKMmVDx6/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274209; c=relaxed/simple;
	bh=s82wtiHEyL/HinNP2hZNza+G2lnU0+pf92R02lWot9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IimkiL8l2RoFm6RA1VPl7sDlb8Gq/AlJUQV78O36B49qnUkcgSRnooaFZGJJLRbAL5/Iw41OilG2oQIUXGyw4tGgyMsIzLF/1XmLdhVkjKqdVHyZZG0WmRLo2wLEfCOTnKxlVREfzfpj82CeE4l0lXu7lK2FFo5Qtc5nwyrHcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oV57VD5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260CBC4CEF7;
	Mon, 23 Mar 2026 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274208;
	bh=s82wtiHEyL/HinNP2hZNza+G2lnU0+pf92R02lWot9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oV57VD5ZOApBN4CcSkMyve4ph2Wd9+tU+qOvS+2lCL+cY748lrQ5aeAKO4Jml+XcV
	 t49pAZUHNlpzUBSR9VgWqBgF5iOkspMfmU2P2vjwMEX2OEjhPX4BAhalqPMxlGG6y6
	 LfLqomQ9Lf2gBpt4ZY70hJeBP8YJjPXY8sramukM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 144/220] net: mana: fix use-after-free in mana_hwc_destroy_channel() by reordering teardown
Date: Mon, 23 Mar 2026 14:45:21 +0100
Message-ID: <20260323134509.142739401@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228128-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4F14A2F3807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dipayaan Roy <dipayanroy@linux.microsoft.com>

[ Upstream commit fa103fc8f56954a60699a29215cb713448a39e87 ]

A potential race condition exists in mana_hwc_destroy_channel() where
hwc->caller_ctx is freed before the HWC's Completion Queue (CQ) and
Event Queue (EQ) are destroyed. This allows an in-flight CQ interrupt
handler to dereference freed memory, leading to a use-after-free or
NULL pointer dereference in mana_hwc_handle_resp().

mana_smc_teardown_hwc() signals the hardware to stop but does not
synchronize against IRQ handlers already executing on other CPUs. The
IRQ synchronization only happens in mana_hwc_destroy_cq() via
mana_gd_destroy_eq() -> mana_gd_deregister_irq(). Since this runs
after kfree(hwc->caller_ctx), a concurrent mana_hwc_rx_event_handler()
can dereference freed caller_ctx (and rxq->msg_buf) in
mana_hwc_handle_resp().

Fix this by reordering teardown to reverse-of-creation order: destroy
the TX/RX work queues and CQ/EQ before freeing hwc->caller_ctx. This
ensures all in-flight interrupt handlers complete before the memory they
access is freed.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/abHA3AjNtqa1nx9k@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index aa4e2731e2ba7..840c6b8957c90 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -814,9 +814,6 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 		gc->max_num_cqs = 0;
 	}
 
-	kfree(hwc->caller_ctx);
-	hwc->caller_ctx = NULL;
-
 	if (hwc->txq)
 		mana_hwc_destroy_wq(hwc, hwc->txq);
 
@@ -826,6 +823,9 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	if (hwc->cq)
 		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
 
+	kfree(hwc->caller_ctx);
+	hwc->caller_ctx = NULL;
+
 	mana_gd_free_res_map(&hwc->inflight_msg_res);
 
 	hwc->num_inflight_msg = 0;
-- 
2.51.0




