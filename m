Return-Path: <stable+bounces-212612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM3aGos6emlN4wEAu9opvQ
	(envelope-from <stable+bounces-212612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:34:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8DA5D4C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18A833043861
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7643033C4;
	Wed, 28 Jan 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMVmxjno"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EA81AA8;
	Wed, 28 Jan 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616103; cv=none; b=ayJQlz6Vhp6bB5JCwdd/vwp/FMrqWS7ecZmtwDVXJu3syY1tM9RkRxZ++9O5hfwfxQ1rcfPjZV316T8XWDiS/YaLRjXZ20qq9mxlE0cHfWp9B77Em8Q0JjkLG0N1cIYgrhX5hbaQ9Ws8AoqLa0Z7r56VWix270V4pbetfLXdmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616103; c=relaxed/simple;
	bh=Wdry6PtqB5khVJJU/9jGoCdZoRVcvr4X4WRfJjPwA1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTRTs9TlIeJoy0pefIqOeVnGUvEbDyQAZEo0+QuB7yUYZc7tgVO2U5FcFRqaeqQA1LcxoiLrU0LtAj9Vm96iX2bxaCi0tE4lPEjWPNP8hDmR/acdr2fQycmUiCfxgKVfZO82sgxXBR/GW1VOgpunhsJ/g0JZpzF79sKAJq1Fgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMVmxjno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39491C4CEF1;
	Wed, 28 Jan 2026 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616103;
	bh=Wdry6PtqB5khVJJU/9jGoCdZoRVcvr4X4WRfJjPwA1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMVmxjno+vgqUvJY/gJmww6X0r0G2yK3iqTjNzxsLl5XWmIUEa6viOtgBORCbQ8K8
	 EHA6ZEtvS6XmD02xDNq4zZjPk2NMrRuWzI0bczHYoWcqfmVlaKE6uSrLUC7uaCyj05
	 IxMYNJCRxFyPdqdQ4VzaKyw1A4bite3oWzyUKCwQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH 6.18 175/227] wifi: ath12k: fix dma_free_coherent() pointer
Date: Wed, 28 Jan 2026 16:23:40 +0100
Message-ID: <20260128145350.747048431@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-212612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 8BF8DA5D4C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

commit bb97131fbf9b708dd9616ac2bdc793ad102b5c48 upstream.

dma_alloc_coherent() allocates a DMA mapped buffer and stores the
addresses in XXX_unaligned fields.  Those should be reused when freeing
the buffer rather than the aligned addresses.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Link: https://patch.msgid.link/20260106084905.18622-2-fourier.thomas@gmail.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath12k/ce.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -984,8 +984,8 @@ void ath12k_ce_free_pipes(struct ath12k_
 			dma_free_coherent(ab->dev,
 					  pipe->src_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->src_ring->base_addr_owner_space,
-					  pipe->src_ring->base_addr_ce_space);
+					  pipe->src_ring->base_addr_owner_space_unaligned,
+					  pipe->src_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->src_ring);
 			pipe->src_ring = NULL;
 		}
@@ -995,8 +995,8 @@ void ath12k_ce_free_pipes(struct ath12k_
 			dma_free_coherent(ab->dev,
 					  pipe->dest_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->dest_ring->base_addr_owner_space,
-					  pipe->dest_ring->base_addr_ce_space);
+					  pipe->dest_ring->base_addr_owner_space_unaligned,
+					  pipe->dest_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->dest_ring);
 			pipe->dest_ring = NULL;
 		}
@@ -1007,8 +1007,8 @@ void ath12k_ce_free_pipes(struct ath12k_
 			dma_free_coherent(ab->dev,
 					  pipe->status_ring->nentries * desc_sz +
 					  CE_DESC_RING_ALIGN,
-					  pipe->status_ring->base_addr_owner_space,
-					  pipe->status_ring->base_addr_ce_space);
+					  pipe->status_ring->base_addr_owner_space_unaligned,
+					  pipe->status_ring->base_addr_ce_space_unaligned);
 			kfree(pipe->status_ring);
 			pipe->status_ring = NULL;
 		}



