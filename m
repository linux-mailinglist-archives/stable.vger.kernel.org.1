Return-Path: <stable+bounces-255908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAgjIeWmGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824BB5F9022
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCE6B3014A1E
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5733CE8A;
	Thu, 28 May 2026 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZZHWN2H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B833372A;
	Thu, 28 May 2026 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000216; cv=none; b=o8gBt3CPmR+fShR7DfeczCfyJvxX7E0V4oJeDk4xK0qclkAsnIuYfLRh6MjPAX+GwD8uvnH4OD1dKmwG1QdvuUi1YWU2AgJgCH+o+sE+9cysl0/b1yAxaLPkVWsTAoczm+mAOO4hxHwC1I9vZeQipGPEBoLY2n893pz7SiPMx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000216; c=relaxed/simple;
	bh=PMT+Agqkhxop+zq/avYzvxnOyMd/pCm7Qcl34l3twi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLR/zY71ZPxGH542gn2QGCLtKpD1VOWXeGDmOww89JkzVuFLR7OXUQINZ2nyK2pExASvlB4Ju4KOhw2Ls6c/aDf7RDCvYcmPHwo46DRBwX+59BWKohb5LtFQbfzrM1luAR50+EK6z4ykA6wkDLWJSsoruqVApk3jlZHe7r1Xtzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZZHWN2H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43351F000E9;
	Thu, 28 May 2026 20:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000215;
	bh=rd7VFU90bWA7Fsk0JzHxbs29V09opO489ZAgZztRaHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FZZHWN2HcavYlb67LlDwV43MbH2msLEwpZ+GpgONcHnXZ300xD4DFhKKMREpDRfxE
	 +cM7JE/StP77SaKcKeDofKXMxp6Hgk7c3AfHyg2NwveYA3CMsC4t78h58xPr7ABYWJ
	 kcIyi+snIhT/5ZOIlFtdNyuZ4Qmx8WvXkKGk0RUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 342/377] net: airoha: Fix NPU RX DMA descriptor bits
Date: Thu, 28 May 2026 21:49:40 +0200
Message-ID: <20260528194648.323467067@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255908-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 824BB5F9022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit 0cb5a74faa3bdcfa3b18735d554e12c0f615e35d ]

In an internal review from Airoha, it was notice that the RX DMA descriptor
bits and mask are wrong. These values probably refer to an old NPU firmware
never published. The previous value works correctly but it was reported
that in some specific condition in mixed scenario with both Ethernet and
WiFi offload it's possible that RX DMA descriptor signal wrong value with
the problem to the RX ring or packets getting dropped.

To handle these specific scenario, apply the new suggested bits mask from
Airoha.

Correct functionality of both AN7581 NPU and MT7996 variant were verified
and confirmed working.

Fixes: a7fc8c641cab ("net: airoha: Fix npu rx DMA definitions")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260518134530.3683-1-ansuelsmth@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/soc/airoha/airoha_offload.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 0e82f1f4d36c4..d4f6e8124a493 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -70,9 +70,9 @@ static inline void airoha_ppe_dev_check_skb(struct airoha_ppe_dev *dev,
 #define NPU_RX1_DESC_NUM	512
 
 /* CTRL */
-#define NPU_RX_DMA_DESC_LAST_MASK	BIT(27)
-#define NPU_RX_DMA_DESC_LEN_MASK	GENMASK(26, 14)
-#define NPU_RX_DMA_DESC_CUR_LEN_MASK	GENMASK(13, 1)
+#define NPU_RX_DMA_DESC_LAST_MASK	BIT(29)
+#define NPU_RX_DMA_DESC_LEN_MASK	GENMASK(28, 15)
+#define NPU_RX_DMA_DESC_CUR_LEN_MASK	GENMASK(14, 1)
 #define NPU_RX_DMA_DESC_DONE_MASK	BIT(0)
 /* INFO */
 #define NPU_RX_DMA_PKT_COUNT_MASK	GENMASK(31, 29)
-- 
2.53.0




