Return-Path: <stable+bounces-110726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1160DA1CBDB
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69581163582
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06022E3E6;
	Sun, 26 Jan 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXHgnTsz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C022DFBB;
	Sun, 26 Jan 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903925; cv=none; b=gYh2AO24PEzyo8PPABPSGFA4WZEX3agQQie5ww0o5ce8aAzrxjmGp8PMNc2OAn9EEcaw6EIUYrzxqXXU1o0FeRoHKvSC0PA05tyA29/cl9b95LHUPP74gECADixo7D9FFRER0PWvtH9k1p+InkvzFkgtGEaWquuS38FUPRWdxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903925; c=relaxed/simple;
	bh=GTV5pKFMp5uLTlYKxT1082FZdmLlioXLSHG6SNAlOPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbwPRv8LwK0P0l0u1e3bAKDiATteRR2wKx/y2inpez4I2f/w24SH5jHc5cSFOw7OTI+e95hb5ub/OBRmYwF5w6HUOkGKbIqhWuvBzgXleK/YXeiL5lXhARePNxgVvkbK1CP7YZ9nseFRZpT/T+y9XdaVkXZvCTwcpbEqmNQM8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXHgnTsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2702C4CEE2;
	Sun, 26 Jan 2025 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903925;
	bh=GTV5pKFMp5uLTlYKxT1082FZdmLlioXLSHG6SNAlOPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXHgnTszMJI0vEtcw52D8jIJ0Vi8Ws5gwwYq0BMtA60KuE74MTtQm5BPZmmxoFEfz
	 xygrokqromKMxrKkjB7I639H7RQA6pjoJACr1K1wf1CIlni4VF4K/eUw85bFcd16xU
	 op2xh3Re3RSGrr0kXoC9j2zN9qb3B7b5cgc0qGa1AQcHYMjygfMIFbpOe4j3DdBOIT
	 nYHCcs06HTAY3d5Ev/nx3CN0LnrITr00x4/FHJHgFRBhZK678JjtlotaY2JX1AQliC
	 z2QebGnpuT3GAyFFXO5I/ItCB8FjzaDHvU9kte66pBsm9P4J2wQ/LccsXdNrhRrfEL
	 DHSbCcs9ueavQ==
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
Subject: [PATCH AUTOSEL 5.10 11/12] tipc: re-order conditions in tipc_crypto_key_rcv()
Date: Sun, 26 Jan 2025 10:04:59 -0500
Message-Id: <20250126150500.959521-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150500.959521-1-sashal@kernel.org>
References: <20250126150500.959521-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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
index b5aa0a835bced..bf384bd126963 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -2297,8 +2297,8 @@ static bool tipc_crypto_key_rcv(struct tipc_crypto *rx, struct tipc_msg *hdr)
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


