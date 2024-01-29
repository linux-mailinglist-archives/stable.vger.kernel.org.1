Return-Path: <stable+bounces-17165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BA6841016
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1207028465F
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85474041;
	Mon, 29 Jan 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AfQg7AAB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AF15A490;
	Mon, 29 Jan 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548558; cv=none; b=eeM5k04bOQqOfZgfZOC/AeF4/Pr2HN3Cq9lNUBEAVLlBq/gF2/dLdcNZOaY8CR0loK6penzS0HEEeK0vTCaSNywIa2CvkLkHVlqYtqtpjSv/vavgYyy3axfPOEZb057IWapMSMfcogVBy6Po+wRXfCIGVDJ9qrHaNDpWujMHLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548558; c=relaxed/simple;
	bh=OfV+ks8yxJXtUKh9CMr572wQWKaa8qYSXkWRqSOOVOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uc6DbQvqK+T8cpQyDUFeAwrgMeAij5dzuWs5fYEhLbc5aKeiAiPq6ct2IJBy+JcnAAZvJj3CFWuGrFz81AmnOZxAzq5wC0AyqS18LpYfLGGj0FIZRnP3BKXwyPzZnVgtnwWM3S67VZVFi79cnsCjxgsG4ym8cnP9L5xd8XLA2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AfQg7AAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C1C433F1;
	Mon, 29 Jan 2024 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548558;
	bh=OfV+ks8yxJXtUKh9CMr572wQWKaa8qYSXkWRqSOOVOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AfQg7AABmaHNm+phkia7IkdszNw+Pi0DojYRtr6tH4txvEY2YgN3aPq1GO2c2ag97
	 UxDYSSB71tY4fH778QanZMwdLbIVcykGscRfINUgfEIjbJTdeBtYKAbJpD4uulx7UR
	 qiqFmiQ4Y97hEoOmmpAJ/U5odg6mz7w2awRbp3+M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 205/331] netfilter: nft_limit: reject configurations that cause integer overflow
Date: Mon, 29 Jan 2024 09:04:29 -0800
Message-ID: <20240129170020.877207170@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit c9d9eb9c53d37cdebbad56b91e40baf42d5a97aa ]

Reject bogus configs where internal token counter wraps around.
This only occurs with very very large requests, such as 17gbyte/s.

Its better to reject this rather than having incorrect ratelimit.

Fixes: d2168e849ebf ("netfilter: nft_limit: add per-byte limiting")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_limit.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
index 79039afde34e..cefa25e0dbb0 100644
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -58,17 +58,19 @@ static inline bool nft_limit_eval(struct nft_limit_priv *priv, u64 cost)
 static int nft_limit_init(struct nft_limit_priv *priv,
 			  const struct nlattr * const tb[], bool pkts)
 {
+	u64 unit, tokens, rate_with_burst;
 	bool invert = false;
-	u64 unit, tokens;
 
 	if (tb[NFTA_LIMIT_RATE] == NULL ||
 	    tb[NFTA_LIMIT_UNIT] == NULL)
 		return -EINVAL;
 
 	priv->rate = be64_to_cpu(nla_get_be64(tb[NFTA_LIMIT_RATE]));
+	if (priv->rate == 0)
+		return -EINVAL;
+
 	unit = be64_to_cpu(nla_get_be64(tb[NFTA_LIMIT_UNIT]));
-	priv->nsecs = unit * NSEC_PER_SEC;
-	if (priv->rate == 0 || priv->nsecs < unit)
+	if (check_mul_overflow(unit, NSEC_PER_SEC, &priv->nsecs))
 		return -EOVERFLOW;
 
 	if (tb[NFTA_LIMIT_BURST])
@@ -77,18 +79,25 @@ static int nft_limit_init(struct nft_limit_priv *priv,
 	if (pkts && priv->burst == 0)
 		priv->burst = NFT_LIMIT_PKT_BURST_DEFAULT;
 
-	if (priv->rate + priv->burst < priv->rate)
+	if (check_add_overflow(priv->rate, priv->burst, &rate_with_burst))
 		return -EOVERFLOW;
 
 	if (pkts) {
-		tokens = div64_u64(priv->nsecs, priv->rate) * priv->burst;
+		u64 tmp = div64_u64(priv->nsecs, priv->rate);
+
+		if (check_mul_overflow(tmp, priv->burst, &tokens))
+			return -EOVERFLOW;
 	} else {
+		u64 tmp;
+
 		/* The token bucket size limits the number of tokens can be
 		 * accumulated. tokens_max specifies the bucket size.
 		 * tokens_max = unit * (rate + burst) / rate.
 		 */
-		tokens = div64_u64(priv->nsecs * (priv->rate + priv->burst),
-				 priv->rate);
+		if (check_mul_overflow(priv->nsecs, rate_with_burst, &tmp))
+			return -EOVERFLOW;
+
+		tokens = div64_u64(tmp, priv->rate);
 	}
 
 	if (tb[NFTA_LIMIT_FLAGS]) {
-- 
2.43.0




