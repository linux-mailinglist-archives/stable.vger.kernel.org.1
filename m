Return-Path: <stable+bounces-110634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61959A1CA93
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728677A04D8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71518206F31;
	Sun, 26 Jan 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLgrgT0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE4206F1D;
	Sun, 26 Jan 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903725; cv=none; b=EG/D8gCZLOTtbpsw2X2IH26SRrvIVOEtUixAIZF+fILpPToN3kA5mp5EmrfQBz2oGgYG9zSxAedU23EnChnGWkRx7qJtmz1n2iD722Cs1AcbIzcEHtEC6sIZeOIoNsO4QRezOqIGuY2dsbHYCcCng7sItd26kWWpWpfXvSKLCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903725; c=relaxed/simple;
	bh=zSeSfUeMzNK21Yc1cAHQWReLtKedWZhLkCGOUpektQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N7h/gVSpO+72t8XecS7Rfju94sI2cureQnL2gYsFTlsSDAdMxY9B7n56Gt5nxleqSpsbsQkzuFeogEojU3JQ6F3s6aQVqGvOPIYMIlo/spHYkjsPlbOQfHzlfrYxFhD/8ysg7mGY4ww5aNQGgzX/Ic5ZiNMFt/1D0FDs2tjTUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLgrgT0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C89C4CED3;
	Sun, 26 Jan 2025 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903725;
	bh=zSeSfUeMzNK21Yc1cAHQWReLtKedWZhLkCGOUpektQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLgrgT0AyFDRcs64pjUfWdMlxgHQanZir1SQls6CTdUkKECj0v8qC+JTmAxT1UG0A
	 mljoZ5A6VJx5kTaEREiMG8/tz42XMY1gh9Pu/7PoKujBCVwGK2nt+JOEf+4pi026NM
	 h0esYMARFIiXmXfAiInw524t3jFzVWzFZCx/1W3cHuR8dc6DVhFjswo/Z5GrK4TWCe
	 KzVQJh5P+62E/cmN79lJW1CVubn+fplnF4tTXBcxBc9oGbMjaFieCeE/SJFdEr7TiD
	 mFRpEqDUkLM1cwA16jnrX3mTG9UI2ILQE6l5faINKWInufainCz4AR+fWQi7aU2WIh
	 OfajGEdeisuVQ==
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
Subject: [PATCH AUTOSEL 6.13 33/35] tipc: re-order conditions in tipc_crypto_key_rcv()
Date: Sun, 26 Jan 2025 10:00:27 -0500
Message-Id: <20250126150029.953021-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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


