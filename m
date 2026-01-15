Return-Path: <stable+bounces-209844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0CD277AA
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A055316A74E
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1623C1964;
	Thu, 15 Jan 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WC6Z/Fi7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B63C1965;
	Thu, 15 Jan 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499851; cv=none; b=jiZ9d8zqvNT/+5hRjMXUCbkQIrrbC+IcnR1XVy7/AliY1trScobuqv8VqpySLW2hO1nVCVD3n06AlZyXEe/UMHIFNXC8XMpMjTN0FXQRZO+Ro55c7BYvYiHzUkinIOpVrtQNyJMg86gliwYIJ9Rehjm+ws2UIagnB9t1wRiJVVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499851; c=relaxed/simple;
	bh=xAX7aCSxRg3dehXJvgrRW31r3NELrofiZVPsW8WS324=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgEaEKS3PdqEeAPJy+N9dqQ8HXMbzHWvmJaxnwVdXll0CtRZMiLB65VGrRgAiE4R6pIaxGHmvqOr0z511lIARm7qWFsCDYFtWcb+XjK3EgyO1TpLrSBCmTvRDLTEv/OWGnsBunaxOjoq5Xr5yxJ51TaH83rUGxICph75xsaPIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WC6Z/Fi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AB7C116D0;
	Thu, 15 Jan 2026 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768499851;
	bh=xAX7aCSxRg3dehXJvgrRW31r3NELrofiZVPsW8WS324=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WC6Z/Fi70WJr6pNQtq4IXSo3TvATSp+7bs8wbR/t9jNEOH4LhtSEDSCcJttpKUjDC
	 JtuMVn4k1HG3aAgOnnopXaWvNhqx4rg8Cq1Pj4chn8TVAHDeljB5A/IPwwrx2Pvec1
	 YscfzyQXDgt5gfI8X3Klu5pXFWLSPjWq0aN+AdJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Rogers <linux@joshua.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 370/451] SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
Date: Thu, 15 Jan 2026 17:49:31 +0100
Message-ID: <20260115164244.295886611@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sunrpc/auth_gss/svcauth_gss.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1177,7 +1177,8 @@ static int gss_read_proxy_verf(struct sv
 	}
 
 	length = min_t(unsigned int, inlen, argv->iov_len);
-	memcpy(page_address(in_token->pages[0]), argv->iov_base, length);
+	if (length)
+		memcpy(page_address(in_token->pages[0]), argv->iov_base, length);
 	inlen -= length;
 
 	to_offs = length;



