Return-Path: <stable+bounces-110700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B83CA1CB91
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD1916A20C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6D8226869;
	Sun, 26 Jan 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqmqbkbA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED48F22655D;
	Sun, 26 Jan 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903868; cv=none; b=mPstwhGNy24kctj8vd1awmfWe8BFhUNLANc/4tG/8c9UC/wY5NpJ55h3v5i79HXD33kZ1KvfbWi4zs4LE7gcDSZTomPr8fdOzHKqtpT522VMNQwN38Joa3BQ8E8+OrLKGv9U94OBeeWuzNUkHMp3/lWdhQ8YcUIbIjcVlY0OU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903868; c=relaxed/simple;
	bh=QkNNT6tGsIYdcGF/EhkT+x2oYwr+rhLs/HZSHF1E8uY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyTUcQacV6VsLUYS+/QS8hA3ukkwlZLaneF7k4FpU8yTYTKSNKyB9dNfe9BtfFSZy6MJkav7v56lM6uYg62k5scJZXEIj/aQMrDBYf/ZWz/FB8DvU7dFI3DwSfoH+D6E6TAs1J29/FypBEYPN7+8TXrE3RK63Nm+aIO5PuOfOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqmqbkbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA84C4CEE3;
	Sun, 26 Jan 2025 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903867;
	bh=QkNNT6tGsIYdcGF/EhkT+x2oYwr+rhLs/HZSHF1E8uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqmqbkbAycz+pxtuDt8bB0YZPsqYCD+Vw339Z4i2/7kfox6M4kvx0IyJMw2uWh71l
	 Xjl/I6j90IjHgwFZLzDTYfKc5H11mU/niZXiK2MuObxJvwfE685Y+zjy4u753HmsJa
	 DAStV9I8Bj9+5FWSP1Q2X2ZrnUuhYZDmnsNYC1bnu6SvksWPNvmrFaYiSkciYV/r+w
	 qX5VJ+Eg+u/evpWF8ABqgJbmP7dMHxEiElBch38kJDZR4qbOEQqU257INVJSZbXecF
	 F2fI9pbBhjE4o82wtFQuBu8ewq8Duob4YzaPcqUZ14F1lyAM/x2eF/egDffxYIOkjy
	 ZDrGUaiccKyjw==
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
Subject: [PATCH AUTOSEL 6.1 16/17] tipc: re-order conditions in tipc_crypto_key_rcv()
Date: Sun, 26 Jan 2025 10:03:52 -0500
Message-Id: <20250126150353.957794-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150353.957794-1-sashal@kernel.org>
References: <20250126150353.957794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 65f59739a041a..25c18f8783ce9 100644
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


