Return-Path: <stable+bounces-110714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A73A1CBD2
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0BB3AF54B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7F22A803;
	Sun, 26 Jan 2025 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+TK6QG7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F9A22A7FA;
	Sun, 26 Jan 2025 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903898; cv=none; b=MGB9QqnE8OZeOUzbICpEsIdOL21o3v420qlZQxNbdfLiCi4A7RzbOV2ODuHh3OARwPCJpBVoHbtX5sNPOyXF7oWMCjffQ4Svghji9eAtvXpAzIR/qpSE7J2e7dPSJwFYL9zkE+mXH2921UkKm85xMjnmcsLTjJPb4dKo/OTFcZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903898; c=relaxed/simple;
	bh=pwkJmB+zJ8BDzbAFafwV103sxFnANgTlDdQKWcc9Y+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rMGPD2Fq7XAnziWzu2JnjLQoWyFxhdwdUfaeLjo7tDrBEkk1E9hQBi5joTQK2MMOzmw4R9d+F4o01CZOt2tjjC4AZXgvdLvdwzIGQwIRPcZaTfARDLLqj5Z7wXfGgrcfsE2EJpWap+FoEmIej8YzKQV+ftpU/MBtL7CBnjIs6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+TK6QG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0735C4CED3;
	Sun, 26 Jan 2025 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903898;
	bh=pwkJmB+zJ8BDzbAFafwV103sxFnANgTlDdQKWcc9Y+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+TK6QG758Kf8ERyfw3051kBMrw2G9ri+Vpc30CSIf9c/DP5biWgQAeUm68jxQQvH
	 srSApnA190tXOceTToo3EICazHG+cPJhe6/SlR7D0mzxKtwvnCaUXxJJ/o87FXfiXw
	 5P/Az2OrVpF4ra1nUHt42SWxYQ/sgAGbhCEkjE3c4EI6z7BjnksxfZesuDfXmxnqLR
	 JuHn/o8qfMQAhyCDltFyWxOTopw/ogrT0ZMoxtWrOsDCWRyT7N6Ydjqb4EfrzwHS+J
	 dlp3wNYjTdV0gaJfDNQlUYOTI8uHpvjoV00kmcLqth51IDPURHdAQXKw4zmnmFc7oe
	 KyD8GhSaXukow==
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
Subject: [PATCH AUTOSEL 5.15 13/14] tipc: re-order conditions in tipc_crypto_key_rcv()
Date: Sun, 26 Jan 2025 10:04:29 -0500
Message-Id: <20250126150430.958708-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150430.958708-1-sashal@kernel.org>
References: <20250126150430.958708-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index 86d1e782b8fca..b09c4a17b283e 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -2304,8 +2304,8 @@ static bool tipc_crypto_key_rcv(struct tipc_crypto *rx, struct tipc_msg *hdr)
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


