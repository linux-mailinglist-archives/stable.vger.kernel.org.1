Return-Path: <stable+bounces-225857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKjQC05AuWkowQEAu9opvQ
	(envelope-from <stable+bounces-225857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4072A940F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45B52302B45C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868B3AE70B;
	Tue, 17 Mar 2026 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdVtgwZE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FB3AE19A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748194; cv=none; b=fFfm4n8Dq0E4pY52W7BK0rVB7/DETx1O5hs5XUs9ykCcsciO+dDxzFAFuq0YBhDzwECXzEenDCy/FW/LS1D1VJaD4u+8ddpELAGkSUuE15HLSPMmnb3zr9Vvf4b8CZT5nDWx6EcokiPaWjqEC7pr9iTmLLmS4cOaIpzgUtNvX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748194; c=relaxed/simple;
	bh=eNV6TAX2CutyZq2rmhnK5T2FDvt09H1M4KfDdMHMSM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcwwMpoHrHFqzjI31IEyfIDfK4h7nYzXk+YL5s9qN6QVzouMdWsHmODI49KoUGQcoPskaK6xqrwgZAqg1Ii2bHczbGQ/0QrmJRxip2+/Z13agHz/oV0uJ8QXWdHLM1Vl2OYkRH90cYBnrtoBOQ0iyaiy4WMTZJYujibidOWFo14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdVtgwZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BCFC2BCAF;
	Tue, 17 Mar 2026 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748194;
	bh=eNV6TAX2CutyZq2rmhnK5T2FDvt09H1M4KfDdMHMSM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdVtgwZEOdyc9swoVjfMWdAtJo5Pwkd062MmpMTeDfTeqLo6JaNNYrr320G5Jns4r
	 flA9kwNT7i4rhlu5SLCI8pzl/G0Pl6di1v/80m+Cy3zIN25O/9aOJzoEoP2WipKquK
	 fIzNx0xvnqVQRVY85ookN2zFshDuQb80arBx0/t9tAhEnN8OtR5Qxxuy4A5mKPh6C+
	 zVBT1VprDcqPIkOSCoWfHQn7hW1cdHFU4+nZA+RoUOmn8eo2HfH0mMCrVaB4nw1p9z
	 /PNUhETGJ/PXb3ayuSkcWy3bxt0KcukdUv7lGdM5h+Ualz5LOpxKavGdDhwz24z+/y
	 qDSjIilYg0n7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Penghe Geng <pgeng@nvidia.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] mmc: core: Avoid bitfield RMW for claim/retune flags
Date: Tue, 17 Mar 2026 07:49:49 -0400
Message-ID: <20260317114949.126875-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317114949.126875-1-sashal@kernel.org>
References: <2026031713-defeat-mobster-d0a8@gregkh>
 <20260317114949.126875-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225857-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2F4072A940F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Penghe Geng <pgeng@nvidia.com>

[ Upstream commit 901084c51a0a8fb42a3f37d2e9c62083c495f824 ]

Move claimed and retune control flags out of the bitfield word to
avoid unrelated RMW side effects in asynchronous contexts.

The host->claimed bit shared a word with retune flags. Writes to claimed
in __mmc_claim_host() or retune_now in mmc_mq_queue_rq() can overwrite
other bits when concurrent updates happen in other contexts, triggering
spurious WARN_ON(!host->claimed). Convert claimed, can_retune,
retune_now and retune_paused to bool to remove shared-word coupling.

Fixes: 6c0cedd1ef952 ("mmc: core: Introduce host claiming by context")
Fixes: 1e8e55b67030c ("mmc: block: Add CQE support")
Cc: stable@vger.kernel.org
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Penghe Geng <pgeng@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mmc/host.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 400556db06cb0..daed43b39b611 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -400,14 +400,12 @@ struct mmc_host {
 
 	struct mmc_ios		ios;		/* current io bus settings */
 
+	bool			claimed;	/* host exclusively claimed */
+
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
-	unsigned int		claimed:1;	/* host exclusively claimed */
 	unsigned int		doing_init_tune:1; /* initial tuning in progress */
-	unsigned int		can_retune:1;	/* re-tuning can be used */
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
-	unsigned int		retune_now:1;	/* do re-tuning at next req */
-	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
 	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
@@ -415,6 +413,9 @@ struct mmc_host {
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
 
+	bool			can_retune;	/* re-tuning can be used */
+	bool			retune_now;	/* do re-tuning at next req */
+	bool			retune_paused;	/* re-tuning is temporarily disabled */
 	int			need_retune;	/* re-tuning is needed */
 	int			hold_retune;	/* hold off re-tuning */
 	unsigned int		retune_period;	/* re-tuning period in secs */
-- 
2.51.0


