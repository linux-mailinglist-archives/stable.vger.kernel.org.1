Return-Path: <stable+bounces-88329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C49B2575
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCDC1F21C24
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84F18E047;
	Mon, 28 Oct 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0nfWKAmg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3D152E1C;
	Mon, 28 Oct 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096952; cv=none; b=k5nH57sUkgCfg6Z64tRYDLQxyoHzCJqXGEOupnrRzvpxXtMd5kpQZ6Cca9ceKxz762lA97Sq8bBHygY5G3/jRngCJu2OsbibpP7snR3jEuOoQHhm4L9GD5abDEkB2sWzIVO2fHC0ufDyuCG+T8PHpoQ7Sk+RTy6U3ppL4TEnBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096952; c=relaxed/simple;
	bh=sLNdEQ+FtFjH5ZpzcghUra0ocye529uvoKqHYEkdsu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2MQU58N3xaKZjKGXFxu6TM4VsA43SQjlycHO5oRPgOxDI6+0PeBXc4+MDXdz+gvcbn7XwzII4rUbwQ9hvTCQx3GYKy6RbCNAzizDB+rkxACVCs+z1uuah3DvdprXlV+uwnyUITy8g/j5d67YIO9GVZelhBmFV0e+Aj8JxQNkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0nfWKAmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA0EC4CEC3;
	Mon, 28 Oct 2024 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730096952;
	bh=sLNdEQ+FtFjH5ZpzcghUra0ocye529uvoKqHYEkdsu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0nfWKAmgojgBwcL6LihdqOP+ISrO14SFC7iJE8qSJQWr8a71cipC6wGJPTtGw/oPZ
	 W6hqWeI8d+xPJ/VgOiZHO1ZGHYx/kbaMkyaIdhgUdUFuksvnXNOXoxoWFn3JlYtl2S
	 r9Ugy81pEQEOk1mB7O3oheTlTEuAVg+EBPD4yKL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ignat Korchagin <ignat@cloudflare.com>,
	Ilya Katsnelson <me@0upti.me>,
	=?UTF-8?q?Krzysztof=20Ol=C4=99dzki?= <ole@ans.pl>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 58/80] netfilter: xtables: fix typo causing some targets not to load on IPv6
Date: Mon, 28 Oct 2024 07:25:38 +0100
Message-ID: <20241028062254.227317174@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
References: <20241028062252.611837461@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 306ed1728e8438caed30332e1ab46b28c25fe3d8 ]

- There is no NFPROTO_IPV6 family for mark and NFLOG.
- TRACE is also missing module autoload with NFPROTO_IPV6.

This results in ip6tables failing to restore a ruleset. This issue has been
reported by several users providing incomplete patches.

Very similar to Ilya Katsnelson's patch including a missing chunk in the
TRACE extension.

Fixes: 0bfcb7b71e73 ("netfilter: xtables: avoid NFPROTO_UNSPEC where needed")
Reported-by: Ignat Korchagin <ignat@cloudflare.com>
Reported-by: Ilya Katsnelson <me@0upti.me>
Reported-by: Krzysztof Olędzki <ole@ans.pl>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_NFLOG.c | 2 +-
 net/netfilter/xt_TRACE.c | 1 +
 net/netfilter/xt_mark.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_NFLOG.c b/net/netfilter/xt_NFLOG.c
index d80abd6ccaf8f..6dcf4bc7e30b2 100644
--- a/net/netfilter/xt_NFLOG.c
+++ b/net/netfilter/xt_NFLOG.c
@@ -79,7 +79,7 @@ static struct xt_target nflog_tg_reg[] __read_mostly = {
 	{
 		.name       = "NFLOG",
 		.revision   = 0,
-		.family     = NFPROTO_IPV4,
+		.family     = NFPROTO_IPV6,
 		.checkentry = nflog_tg_check,
 		.destroy    = nflog_tg_destroy,
 		.target     = nflog_tg,
diff --git a/net/netfilter/xt_TRACE.c b/net/netfilter/xt_TRACE.c
index f3fa4f11348cd..a642ff09fc8e8 100644
--- a/net/netfilter/xt_TRACE.c
+++ b/net/netfilter/xt_TRACE.c
@@ -49,6 +49,7 @@ static struct xt_target trace_tg_reg[] __read_mostly = {
 		.target		= trace_tg,
 		.checkentry	= trace_tg_check,
 		.destroy	= trace_tg_destroy,
+		.me		= THIS_MODULE,
 	},
 #endif
 };
diff --git a/net/netfilter/xt_mark.c b/net/netfilter/xt_mark.c
index f76fe04fc9a4e..65b965ca40ea7 100644
--- a/net/netfilter/xt_mark.c
+++ b/net/netfilter/xt_mark.c
@@ -62,7 +62,7 @@ static struct xt_target mark_tg_reg[] __read_mostly = {
 	{
 		.name           = "MARK",
 		.revision       = 2,
-		.family         = NFPROTO_IPV4,
+		.family         = NFPROTO_IPV6,
 		.target         = mark_tg,
 		.targetsize     = sizeof(struct xt_mark_tginfo2),
 		.me             = THIS_MODULE,
-- 
2.43.0




