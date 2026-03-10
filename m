Return-Path: <stable+bounces-224062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BWoIn3+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33924A6E1
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81CD331FBAB3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306D387571;
	Tue, 10 Mar 2026 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXLKWULT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BC23859DF;
	Tue, 10 Mar 2026 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141196; cv=none; b=U4y8YpZTNfRtGewwL4Bgo4W8VUbp7LWSOLf1FE7K9TwYhTu3hIsHMioxe5IsnqPGdglFnxNWM2RSG++E3sSpFTGTwPWIpn6R1r3c726roEcBKCaUM+eUjXnLYm65fWpWekYzNrGQTnjaxuQT/au3aUnet4Vsk5btrS/G7FTM5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141196; c=relaxed/simple;
	bh=QccW6cyqKoTAs/xHLg87J6mZAwKWfrQURGqDAox24ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm3DrTSijPKr19gOTeL542LsC9MrgkpiJJS2vd4EP0Z4UK2pTdMG0+raIH8R3yT/km6J8bgC9iusGU4KKk9M6LnRGU8S8wlkjf5umZLTaSis19SUrcCzbiVTsUhMpr5Xvk0Rrju1MkE5aCilIV5fnEh9Dj61199gR5mRRZjYg8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXLKWULT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58609C2BC86;
	Tue, 10 Mar 2026 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141196;
	bh=QccW6cyqKoTAs/xHLg87J6mZAwKWfrQURGqDAox24ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXLKWULTMoUJ2+l5Kf6I2KEA78ir7/HrEzazw+oXWdSo78dWokpjKd6m0tITl6W1e
	 en/NIjJpFUfaCQMmv1q/WqqtfuY3pjTw5fJY/oz7P/BZ8Xe9W3DQYKEQRzhHnIbw0/
	 DEtP1Ybe2SgtqCPlLI2G4gP9RCfbzQ3Ip6OEMsZtlPJetjQpVQ1/gn87z0H8msUdvg
	 FxXE21LAMzd3+zs1rjuWzj0uPnq2rICCOpbB5jLhtnI/dz18k9CSZ6jQyq1eOovI9B
	 0UrfscxqLDi3KZH+N35Ilgk60p02HnP1pHAuQXLSESBliPMy+0LiEeD9l97duuerr7
	 Tw/S4QnaBUJWw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 197/311] i40e: Fix preempt count leak in napi poll tracepoint
Date: Tue, 10 Mar 2026 07:04:04 -0400
Message-ID: <0a369fdef8cf09371f72d1981cb0bee70fc00703.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F33924A6E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224062-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,osuosl.org:email,dama.to:email,intel.com:email]
X-Rspamd-Action: no action

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit 4b3d54a85bd37ebf2d9836f0d0de775c0ff21af9 ]

Using get_cpu() in the tracepoint assignment causes an obvious preempt
count leak because nothing invokes put_cpu() to undo it:

  softirq: huh, entered softirq 3 NET_RX with preempt_count 00000100, exited with 00000101?

This clearly has seen a lot of testing in the last 3+ years...

Use smp_processor_id() instead.

Fixes: 6d4d584a7ea8 ("i40e: Add i40e_napi_poll tracepoint")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index 759f3d1c4c8f0..dde0ccd789ed1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -88,7 +88,7 @@ TRACE_EVENT(i40e_napi_poll,
 		__entry->rx_clean_complete = rx_clean_complete;
 		__entry->tx_clean_complete = tx_clean_complete;
 		__entry->irq_num = q->irq_num;
-		__entry->curr_cpu = get_cpu();
+		__entry->curr_cpu = smp_processor_id();
 		__assign_str(qname);
 		__assign_str(dev_name);
 		__assign_bitmask(irq_affinity, cpumask_bits(&q->affinity_mask),
-- 
2.51.0


