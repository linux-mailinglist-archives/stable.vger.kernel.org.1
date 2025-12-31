Return-Path: <stable+bounces-204357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2090CEC19D
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7B5300C5FF
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4858526CE04;
	Wed, 31 Dec 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5RGfpqI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075EC269B01
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191936; cv=none; b=UKJg0ew2Nwf6Q24vDocYNaMGfAnsUQ/TjxEcVeeHK9p/6grCIss0zKqv5q/gte2LO/nuJJRW/U3MDCw6Cak48qnUkWoiLNDTFkCrEAZT1YUiGOLnTICionPB5qJzUzHp1rQ9CUygdxGtrriEtZw6jorG3kVYkBvRR5uCPKyHdGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191936; c=relaxed/simple;
	bh=23k6+8YAT6Y5Cne7G5njheu2+7DneCxFrrwGQj5meC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFccF7gdwOq2BRIq5F+0wFDHHA+sBDDreVk/2I1TnT1SHn1fFFSaa2/EZ+R42f31EE4IoxAEbwI7jR5aaa6yFCyAekRUUCMVNo68c70SxI99/FaOZnzJe4x1Ic1ktkjmPiuhzUi6RWe05Dq5v0Fm5rbgP0R5Jcn/e7iCYR5pmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5RGfpqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D30C113D0;
	Wed, 31 Dec 2025 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191935;
	bh=23k6+8YAT6Y5Cne7G5njheu2+7DneCxFrrwGQj5meC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5RGfpqI0org2iC1t/5DJrhTw57wwDcmHExkFWn726BFcgRM7xVx0FN2ynR/VKP66
	 wKYBMA2ob/CgRbOhcHzR7o9+KxGqiJn0hmIemrIBChMPCk7SGkYUVp4j2F5HZ3cdaS
	 Q580GoSpRu4r5nL/G1AIp8PBmRUrE9ks5OZPvZ9lzMANUtmVuZ6BRjoV117M+OClWH
	 xLndTWQEuP3+lFiOYpvhV/VDB3mqmsQ3Qla01Z4d9pgbpBGjZH1VON1ocjlJL2ZmbJ
	 ypAaotbaM2XnMEpDv0102nBjea4AJJuJKDfXcgfRwrxrGqPV1Mo4hQu11q7A1BgyXp
	 /pFskagg6jIpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
Date: Wed, 31 Dec 2025 09:38:53 -0500
Message-ID: <20251231143853.3046790-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122940-illusion-nervy-c582@gregkh>
References: <2025122940-illusion-nervy-c582@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Rogers <linux@joshua.hu>

[ Upstream commit d4b69a6186b215d2dc1ebcab965ed88e8d41768d ]

A zero length gss_token results in pages == 0 and in_token->pages[0]
is NULL. The code unconditionally evaluates
page_address(in_token->pages[0]) for the initial memcpy, which can
dereference NULL even when the copy length is 0. Guard the first
memcpy so it only runs when length > 0.

Fixes: 5866efa8cbfb ("SUNRPC: Fix svcauth_gss_proxy_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ adapted xdr buffer pointer API to older argv iov_base/iov_len API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 93a7b7061d9a..1b8285e83df6 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1179,7 +1179,8 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	}
 
 	length = min_t(unsigned int, inlen, argv->iov_len);
-	memcpy(page_address(in_token->pages[0]), argv->iov_base, length);
+	if (length)
+		memcpy(page_address(in_token->pages[0]), argv->iov_base, length);
 	inlen -= length;
 
 	to_offs = length;
-- 
2.51.0


