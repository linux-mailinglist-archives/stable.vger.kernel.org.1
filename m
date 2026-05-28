Return-Path: <stable+bounces-255502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLl9McWhGGqvlggAu9opvQ
	(envelope-from <stable+bounces-255502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:12:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1B15F8136
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07C933020201
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB433CE8A;
	Thu, 28 May 2026 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RoOM+DYU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F14833F5BE;
	Thu, 28 May 2026 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999091; cv=none; b=SXyBfADVXgT0htpHZINqHzLkdYCXha8mJT0tBiakt0lgzLV3TmIjvFvwYU/nf5dxj5YEHDUzzT4b1kyJ1+VFce5jciVvRL3NAELtBlOt0/HUHhnrD55A3m/DRx2XsqdA4APmYKlfIG07YNaf8yirbpKE2pzGGxtXAm86HbKDd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999091; c=relaxed/simple;
	bh=hv3BNZKaQyCoeZmwZW8kP7ZfetYoHKwQTdt6jroWFp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDSIoFaLkNyxB3gmvzKSV+f5kaG0NfZUh2M07Hv/T/2u3lLqvk17rVegSv4E3lZxIPvTvmBpEenw204Vbi6dqpT7YvAALRws39qfYEX3+er3fytAuJZJzUjOoSljJfTrg7ePhbP83JE7JLxHLepvg8JN4EsWQOUttd7QkRKEUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RoOM+DYU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3271F000E9;
	Thu, 28 May 2026 20:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999090;
	bh=p5sEzzuuhBUsmCLnkZQouJLCCeHGzCmoC8F74WG6VbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RoOM+DYUbfaWDdriEp5EHoHI78hHdoLSIwlWjxcNhG4z/viBGG49Z8mehLWq9Y/a1
	 EvaRsQ84o2yIpmtB2YExy8b1Ntfkn0Xds8l9EkhBBousb6lOAq6RWyOXsEcHVIo1zg
	 tc0HDr5tKBRo9wQUosbH5/niETyw2X4QqBKPy8Co=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 406/461] net: airoha: Fix NPU RX DMA descriptor bits
Date: Thu, 28 May 2026 21:48:55 +0200
Message-ID: <20260528194659.234027879@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255502-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: CF1B15F8136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index d01ef4a6b3d7c..7589fccfeef6d 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -71,9 +71,9 @@ static inline void airoha_ppe_dev_check_skb(struct airoha_ppe_dev *dev,
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




