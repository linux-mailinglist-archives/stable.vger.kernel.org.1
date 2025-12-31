Return-Path: <stable+bounces-204360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A420CEC1CD
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12E4B3002977
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14CC22F75E;
	Wed, 31 Dec 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoZyYCNB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F664218AC4
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767192185; cv=none; b=ARtJYQ1kuM/G04v5TDh1HfvOX3wxaRV22GrTctIrjwVxio0YNMH1ZH4DyoYnaDFeNab9iHD11hewjEDuWHVbFwPAX5A/BPC37uggNFae1Z75S306ax+dwUSvLpZuXU8aAAiIMT+rfQ11LOuygR1p9pS8xBMKYz8P1aTJzRpMXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767192185; c=relaxed/simple;
	bh=Wf4YHd+dxhB2if65y4eFcIKp7ok1VMy+QPjGD0PNhjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHCOzxbseqhzRRHPmkSHSzqPgfLl0AhCYoaTU7mW5pNp94UkehEh3GxwvVY8KsP1f7Vrpmzsnr7npe/nLQ5vLWUtkxhXSmtiUs0EkKBeecgQitDmKKtDaID/U2Ibaww/inEg95AMv8ifJAKw28WoHzKpxJczGKgHFeeR+olWSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoZyYCNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5D4C113D0;
	Wed, 31 Dec 2025 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767192185;
	bh=Wf4YHd+dxhB2if65y4eFcIKp7ok1VMy+QPjGD0PNhjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NoZyYCNBKJKIYz/wSgtRSpMvWW1bSjijuscMY7FFzOLYjmteTQ8vnfdHNGxJGsdrb
	 f/Df/zhUFRYRDX8lpm+K7Vfk+MpJC//Jt0l4K4ny9trs2nsbntOAhFO4u1TpKpdpPd
	 ljlsS4kiDSu9RhvujrjSWf1DGhP74UR3cjomlhJYGPmVNagwrn268xD14F+z5aUOMG
	 Fa08J4t0ABJQetycpbyG/gfaGhB6rrMHYBZtE+B0w9IqUE+EvDzcJH/0W9FghLLuDb
	 nDlJgC3he3Yakr2uVVGbCquw9w7ErO6zmfayklIq/gY6dgX3CfH5bguZCJz/u58AS9
	 1HCe6E7hjpvHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
Date: Wed, 31 Dec 2025 09:43:03 -0500
Message-ID: <20251231144303.3088891-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122941-pupil-strongly-abe3@gregkh>
References: <2025122941-pupil-strongly-abe3@gregkh>
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
index 329eac782cc5..fe85762dbd96 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1177,7 +1177,8 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	}
 
 	length = min_t(unsigned int, inlen, argv->iov_len);
-	memcpy(page_address(in_token->pages[0]), argv->iov_base, length);
+	if (length)
+		memcpy(page_address(in_token->pages[0]), argv->iov_base, length);
 	inlen -= length;
 
 	to_offs = length;
-- 
2.51.0


