Return-Path: <stable+bounces-224397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOucHG0CsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:37:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58C24B20E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4CFD305F76F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84513EFD36;
	Tue, 10 Mar 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKxCLKKy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE863876D0;
	Tue, 10 Mar 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142129; cv=none; b=fY/HkxPm03E/9xeADce8vSVNx7/Zn16tSjEQQ5LKYBDcw5+8hsZHQ0YjJ4LEQFLaLcc50ScBEzNSlqX7tti7YrwFOL+N3Q8s5I1I8HV/bAJoL4EtjVqJGt21CcOJseERw9jrQAZre4KoEGcby9HJGvODOf79YSvZn3WWndGUU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142129; c=relaxed/simple;
	bh=ldRMoNwU2050G0bm32xpNW5Lk/dgfURF2va618OVUQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ly/Yo3+eEkUYNdfI6X+aETtN4a1u/AEWTAMc3jr8RktbiR8pBUWY00rmdljMTEgQzHKyvkjGJh58xpYgqfADe1Obf/NktAdBPb+dg2W6s59Sxx5riSAOmzoJP+X8CiUYS4Jh5lQCssuv5Gu412SFSRIOGYUPVIvG5tVmgS91S7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKxCLKKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDB4C2BCAF;
	Tue, 10 Mar 2026 11:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142129;
	bh=ldRMoNwU2050G0bm32xpNW5Lk/dgfURF2va618OVUQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKxCLKKyVRmNLZ6IN5RAqnRp+BK5drXLMEBozseKJ81B/ze2U5vbCFWTXa06NAY53
	 HBvRp0UWRN8ZU8XSsSCcPenwjDv93bBIhhxK2xivjuXzuUodp4ElRpjXXk4yLbzGWB
	 k7227h0ybI2L786um8vRfv0UzbdfurD33UyO3lXlzo6MwTRpHfcYzuJZt+kU8cYBN7
	 ujrHoRLGMu8HpzrmRp7BvgqfhTd0NKm8mOPgbqG3tmb9C8O6wrvgHYsUqtcgk4MUo8
	 RgJYxgbpNB5cQARHd2mUJ1/H76/FUhSvkE/OzaoRFseADz70gT4TKtlyHMGFipMpHh
	 7bGgxYjrsB22w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Li Li <boolli@google.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 218/314] idpf: increment completion queue next_to_clean in sw marker wait routine
Date: Tue, 10 Mar 2026 07:17:57 -0400
Message-ID: <e48e379306ac10224148398abe589a67622226b9.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A58C24B20E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224397-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

From: Li Li <boolli@google.com>

[ Upstream commit 712896ac4bce38a965a1c175f6e7804ed0381334 ]

Currently, in idpf_wait_for_sw_marker_completion(), when an
IDPF_TXD_COMPLT_SW_MARKER packet is found, the routine breaks out of
the for loop and does not increment the next_to_clean counter. This
causes the subsequent NAPI polls to run into the same
IDPF_TXD_COMPLT_SW_MARKER packet again and print out the following:

    [   23.261341] idpf 0000:05:00.0 eth1: Unknown TX completion type: 5

Instead, we should increment next_to_clean regardless when an
IDPF_TXD_COMPLT_SW_MARKER packet is found.

Tested: with the patch applied, we do not see the errors above from NAPI
polls anymore.

Fixes: 9d39447051a0 ("idpf: remove SW marker handling from NAPI")
Signed-off-by: Li Li <boolli@google.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index a48088eb9b822..83cc9504e7e1a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2326,7 +2326,7 @@ void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq)
 
 	do {
 		struct idpf_splitq_4b_tx_compl_desc *tx_desc;
-		struct idpf_tx_queue *target;
+		struct idpf_tx_queue *target = NULL;
 		u32 ctype_gen, id;
 
 		tx_desc = flow ? &complq->comp[ntc].common :
@@ -2346,14 +2346,14 @@ void idpf_wait_for_sw_marker_completion(const struct idpf_tx_queue *txq)
 		target = complq->txq_grp->txqs[id];
 
 		idpf_queue_clear(SW_MARKER, target);
-		if (target == txq)
-			break;
 
 next:
 		if (unlikely(++ntc == complq->desc_count)) {
 			ntc = 0;
 			gen_flag = !gen_flag;
 		}
+		if (target == txq)
+			break;
 	} while (time_before(jiffies, timeout));
 
 	idpf_queue_assign(GEN_CHK, complq, gen_flag);
-- 
2.51.0


