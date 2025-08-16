Return-Path: <stable+bounces-169841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DBCB28A30
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 05:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71BFB611A7
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95EC14E2E2;
	Sat, 16 Aug 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kej1y8fO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04A8632B;
	Sat, 16 Aug 2025 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314110; cv=none; b=OTwmHPsc78gTCk3FwZ/6agME5hHg6uLb+gBaBakCtJ1E3MbnyfDXs0H+y+Y4cd0xTJ6hVzWxT0fU64kwMHL9yksG/wfsVM6IcBpJKF1xBguut941QMST5r7iGVe1NiFI4unMPq2ZkY/ogJBbNP1MvBo2EsNQsUofgig/w4K1e90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314110; c=relaxed/simple;
	bh=e2AHVx4sR9gwNtpXS3kHx32KMASNg9bGdbVRA2ab8Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T70+SIJqs8QjwI6ZlpFkZMBWPP0aFYSTd9DgRv47Spa1Z8kccfJ8m14E1NgIz8/hSQbTiab5pDnUnBz2x7z2a7sX1EFWTRnE6+1oAO+6mVK6phhZt74CLPpQbIF77GA3BmUnztLHWlBMxQuM4em6RESXRTjzwFANpztUZb8Rmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kej1y8fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D03C4CEF6;
	Sat, 16 Aug 2025 03:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755314110;
	bh=e2AHVx4sR9gwNtpXS3kHx32KMASNg9bGdbVRA2ab8Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kej1y8fOu96ZpKIC/cG77meVol5uhDXTTABscyMRrTa6CnKsbfjTIraCWEuQo/oMj
	 PfdiDUR/lYrnm0sMnZDk2jXiL3G/qxm4CB6AukPFy36/u8pFvCm8fPLorELQFa2CTM
	 sf75biOZ/Q9ip9b9CryyxxqQMdj3bVwrslgA0XisnM1+7QTAXo8aW724pW88CAc1rk
	 eC4IOE4//GY9NjjuL5hKyoOjlS8N+mhxdtb+PrSjgxiNUSXCA/4vBdMTwWtGYwp0gM
	 tISMaYgKQ3emBiXRLdsVx+94qqHNHpILjjoZinoGPBEyPV+C5NtAZGsxgQBL1Pl0qJ
	 C09sHO+bCpzDw==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org,
	Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: David Lebrun <dlebrun@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net-next 1/3] ipv6: sr: Fix MAC comparison to be constant-time
Date: Fri, 15 Aug 2025 20:11:34 -0700
Message-ID: <20250816031136.482400-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816031136.482400-1-ebiggers@kernel.org>
References: <20250816031136.482400-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent timing attacks, MACs need to be compared in constant time.
Use the appropriate helper function for this.

Fixes: bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/ipv6/seg6_hmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index f78ecb6ad8383..5dae892bbc73b 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -33,10 +33,11 @@
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
 #include <net/xfrm.h>
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <net/seg6.h>
 #include <net/genetlink.h>
 #include <net/seg6_hmac.h>
 #include <linux/random.h>
 
@@ -278,11 +279,11 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 		return false;
 
 	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
 		return false;
 
-	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
+	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
 		return false;
 
 	return true;
 }
 EXPORT_SYMBOL(seg6_hmac_validate_skb);
-- 
2.50.1


