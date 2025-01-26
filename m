Return-Path: <stable+bounces-110683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E53BA1CB4D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C31889E15
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4E52206B1;
	Sun, 26 Jan 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2DvefhA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D8221D99;
	Sun, 26 Jan 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903831; cv=none; b=GQqtQFyNbgqfvEre4bOrbf201PXnAYAxsMwlw2r4QbxxPyTRZlZ5gzDhWZCyxK2qRs0pK8Dmm7gWwjXzz56Ctoz+gVELv3CB7yTbjjqHzQMDn33DR+ecirWpalMOdr1VdTOYxXPg7EZTN9eH8Q5qY1jtng4OubQPOzljIAqSB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903831; c=relaxed/simple;
	bh=zSeSfUeMzNK21Yc1cAHQWReLtKedWZhLkCGOUpektQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m5ZCw04Kzyi190zdyCYi1Gwb2RlnWByPapkyc5FMbYoxOhDpl2uoW3W6MIRGvN3/pNnkEcZFz01jojx+7zfNQS69WI3KOHCYbB8ajs2FKkL1J1/nQUH6xJvqTGsUcDqA15OKcz52ONv8O5LVZegIK9sGI59O2AwXAm2QF2j8AeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2DvefhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BADDC4CEE3;
	Sun, 26 Jan 2025 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903831;
	bh=zSeSfUeMzNK21Yc1cAHQWReLtKedWZhLkCGOUpektQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2DvefhAARMcnapZuTdRCo6g53e4+uk+j237pq0pSspuvoa0+fq1wv18tGEWUjrrn
	 d/9QG57/m6nWWdFn5W/qfOVio3jzd+8PP67G878dQiLDgLn/VMRjZXtXIX6VQE/hzK
	 //OHRZ75GXR/anNjq69ueiqJI7Z93cP9ZhVjIY+xzV9l3XuuZVcgTV0j1LKCSSGCcc
	 KCjO+vP6nPI2J3j9jQz3ExEK6wZuqsbtTSTDRW9Dx/Tflas1TeCdObuk1uFn26FNg3
	 2T8Cf7SkBV+MgQM611bwgs9N9qEbkur/meLHMdeACS1I+SY4U+C3ic/LDVrYdmZ6ER
	 FtsGu0cAxuu0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	jmaloy@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 18/19] tipc: re-order conditions in tipc_crypto_key_rcv()
Date: Sun, 26 Jan 2025 10:03:13 -0500
Message-Id: <20250126150315.956795-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150315.956795-1-sashal@kernel.org>
References: <20250126150315.956795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 5fe71fda89745fc3cd95f70d06e9162b595c3702 ]

On a 32bit system the "keylen + sizeof(struct tipc_aead_key)" math could
have an integer wrapping issue.  It doesn't matter because the "keylen"
is checked on the next line, but just to make life easier for static
analysis tools, let's re-order these conditions and avoid the integer
overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 43c3f1c971b8f..c524421ec6525 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -2293,8 +2293,8 @@ static bool tipc_crypto_key_rcv(struct tipc_crypto *rx, struct tipc_msg *hdr)
 	keylen = ntohl(*((__be32 *)(data + TIPC_AEAD_ALG_NAME)));
 
 	/* Verify the supplied size values */
-	if (unlikely(size != keylen + sizeof(struct tipc_aead_key) ||
-		     keylen > TIPC_AEAD_KEY_SIZE_MAX)) {
+	if (unlikely(keylen > TIPC_AEAD_KEY_SIZE_MAX ||
+		     size != keylen + sizeof(struct tipc_aead_key))) {
 		pr_debug("%s: invalid MSG_CRYPTO key size\n", rx->name);
 		goto exit;
 	}
-- 
2.39.5


