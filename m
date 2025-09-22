Return-Path: <stable+bounces-181381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E5B9316F
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7400219C02A5
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEC1F91E3;
	Mon, 22 Sep 2025 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cglUL37I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73311C1ADB;
	Mon, 22 Sep 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570400; cv=none; b=JtcKN3v+jMqLOm7p5IX5/6fRl+Cu2yPi/g6MFnLuEbjkXGq0NB5WEHP0ecqy79qFFhuwYo8EnYkHOuR/focfsTuwPLD4rfSBWdVQ9yznPw6RR+EjkWpMdy769WPBFnk9sHj3JMelEVHAdJWJZ1GGOdOGUdYAsrKUBcPIr/1/x8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570400; c=relaxed/simple;
	bh=W2kEUUsoekU1tWT0cxlNuZafpBQYxzb8WxIY1LiGY6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Azg8svt1cimA34eWgJbOlAvIeTrRq1RYS7WA2PjSoXr/sKVhysBfBKya33UNULQx32mOr18tBbLb+1YAxqcS02CGp+Dv0JOz7BkZOE/Vhi40rpjp0s+F2pdH6sbvUn1XBj+dO3LBwDw2hij/aLPnH93PXiJ1cwKxwsqxBtHqXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cglUL37I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809B7C4CEF0;
	Mon, 22 Sep 2025 19:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570399;
	bh=W2kEUUsoekU1tWT0cxlNuZafpBQYxzb8WxIY1LiGY6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cglUL37Ix7m4MK6hZZbk7o9L650RimKVZfdipMYibuUCBmnAIFMOP7lUMfpzfTeNJ
	 xxMmkEZPZwqhw+UE7OUtMBZRsO21WtdQSlNIhJLewQGJUTCfwcgj42nJhT9sh2Efpn
	 uUOF2a4ZSXN63qrAPpBHIO5P2tjKAKuV9Ufv9Gls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 134/149] crypto: af_alg - Set merge to zero early in af_alg_sendmsg
Date: Mon, 22 Sep 2025 21:30:34 +0200
Message-ID: <20250922192416.248632865@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 9574b2330dbd2b5459b74d3b5e9619d39299fc6f ]

If an error causes af_alg_sendmsg to abort, ctx->merge may contain
a garbage value from the previous loop.  This may then trigger a
crash on the next entry into af_alg_sendmsg when it attempts to do
a merge that can't be done.

Fix this by setting ctx->merge to zero near the start of the loop.

Fixes: 8ff590903d5 ("crypto: algif_skcipher - User-space interface for skcipher operations")
Reported-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
Reported-by: Bing-Jhong Billy Jheng <billy@starlabs.sg>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/af_alg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index f02c5586a8ab3..ca6fdcc6c54ac 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1025,6 +1025,8 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			continue;
 		}
 
+		ctx->merge = 0;
+
 		if (!af_alg_writable(sk)) {
 			err = af_alg_wait_for_wmem(sk, msg->msg_flags);
 			if (err)
@@ -1064,7 +1066,6 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 			ctx->used += plen;
 			copied += plen;
 			size -= plen;
-			ctx->merge = 0;
 		} else {
 			do {
 				struct page *pg;
-- 
2.51.0




