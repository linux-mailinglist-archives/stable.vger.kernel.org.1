Return-Path: <stable+bounces-229201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Fp7MhpbwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFCB2F6378
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33C5F301A9F8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178543BC68C;
	Mon, 23 Mar 2026 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dcm+WN3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1C3BC681;
	Mon, 23 Mar 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278379; cv=none; b=RE1htuZoY0nYcMivphjQZg+g2ar1wV3jworOHPpSYKR4lEhXFGJiOENOezsBCuTTR7KgzrVWTZocz/Svcpkv0E8Ku/yL8mQs3UorJX3TNhwVfWdyPtf2RtFOVBU1nKxvkup5tiiQ9023FdSWL10tTOi/BcU2/NQfhkuDcR4WrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278379; c=relaxed/simple;
	bh=i5WmP7r4N37HTO5bHh70rTpTnNTKvbbzHkt76x1Smqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haR3VqZTj912wv6Qd79WplHLJsLvv5IWEtv6cQ2/OIr37YBfsGbZ8JZiiNPmqA6NoOLKS0Ph+c8H0k4aX8eWp+oCEO02kc2I7ryqh2cbAIg4iVzcPpb3hpEy1kzVZNUElykQeFjx9dK2R3F3lmZkVPOEnFT2f+QrP4+ViSQJn7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dcm+WN3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD45C4CEF7;
	Mon, 23 Mar 2026 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278379;
	bh=i5WmP7r4N37HTO5bHh70rTpTnNTKvbbzHkt76x1Smqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dcm+WN3TcTuttkwB9z+sKhExExfLzpmmiwLhgH6Hj2xVuABZx8Vy0NLHY5hP99OxT
	 Noo0rR4MZ19wjWndh7cvz7rQ2rw+K4Ik+BbNBgfsPrOJA6W2jgJm5KqjCl2b+wPLNK
	 tiMDs79nffcGbFmV7+JIJSyUl/h9nOPlKitV8wdo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Hunter <adrian.hunter@intel.com>,
	Penghe Geng <pgeng@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 290/567] mmc: core: Avoid bitfield RMW for claim/retune flags
Date: Mon, 23 Mar 2026 14:43:30 +0100
Message-ID: <20260323134540.998257180@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229201-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CEFCB2F6378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Penghe Geng <pgeng@nvidia.com>

commit 901084c51a0a8fb42a3f37d2e9c62083c495f824 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mmc/host.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -446,14 +446,12 @@ struct mmc_host {
 
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
@@ -461,6 +459,9 @@ struct mmc_host {
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
 
+	bool			can_retune;	/* re-tuning can be used */
+	bool			retune_now;	/* do re-tuning at next req */
+	bool			retune_paused;	/* re-tuning is temporarily disabled */
 	int			need_retune;	/* re-tuning is needed */
 	int			hold_retune;	/* hold off re-tuning */
 	unsigned int		retune_period;	/* re-tuning period in secs */



