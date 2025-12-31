Return-Path: <stable+bounces-204356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09581CEC167
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 848E4300B91B
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FD24A07C;
	Wed, 31 Dec 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDawS9ln"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234651BD035
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191562; cv=none; b=Yz3cpz7xcGNGhHoM0CkB08C+Lbvb/NRIPA1VKoOycH60fZSR7DP/HeuP4/qw6gLsMHr6QCXnzpM8STtRIpwJGEUL/pYwbnSEs8SEYzAICpH2oHjsb1uC7vHraYPgQz6Bd1N5sit14IY52NjAjZKJyj8u2cNhaJB2Lu1zA5JVjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191562; c=relaxed/simple;
	bh=47k4pI7DudWhjglbwtuXzCTgq4ggW3Mph2I/9SLyezk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROQE+FOmo8Bc4tkPPwinifpUcIKYadjY6JyTm4zry+tN3oqxfkGYfu3WoVJal3Pu1QluBsE+anfwSEU64Fm8ieYS04C5nLumzEHvVBB2aOIQM89q4P4io0PaV6Wr1u5T3katmqtjSoUeCkkGLWuZF1z48ljgaJ9QbK5NTcnyj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDawS9ln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA54C113D0;
	Wed, 31 Dec 2025 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191562;
	bh=47k4pI7DudWhjglbwtuXzCTgq4ggW3Mph2I/9SLyezk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDawS9lnz5ypb3kvo62jKhgX1mSJqosmoa/Ruo5+KXrFRvvMDph9sovWnacwpQees
	 GJAdZaAoL4RuD4uHS/2QM/xOu1K+sdPrzenH7fKuImITSjoT76wkbcEyBv2p6TSOfp
	 MrtyYFZyi1yvEBhDHNt2lSgh+Q94wmtxF61MGrs2ppO71/gzrhge8M+KrFbO3gXlkr
	 EZT4Vba5Tg3scMcpcAo6ZWItMZNsHzqF1IbZURanN/75Y3HysDHKPGHnlBbiJazhS8
	 r9cb56bj30Zed8iXsJz4ziQISd7crqkh4M4NARnu5EPSnBOQPt51sBQfuQ9Yy31zNQ
	 EF8lB+sPEZHmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
Date: Wed, 31 Dec 2025 09:32:39 -0500
Message-ID: <20251231143239.3043585-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122940-ember-smilingly-3df0@gregkh>
References: <2025122940-ember-smilingly-3df0@gregkh>
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
index d0575747ff0e..df0b8b1cdfc4 100644
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


