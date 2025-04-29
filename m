Return-Path: <stable+bounces-137153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2A5AA11ED
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1C87B0D3B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25295246326;
	Tue, 29 Apr 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bAz0Rkfi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5322AE7C;
	Tue, 29 Apr 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945219; cv=none; b=Mn7ufcHtmGpNOvFY87cXGxah+3pXPCILGr4X+5eWjAIfu8BGJ8ZkgMoaaneN1JvNmUt9Nf0JZ+qlYne5xk/s5eQxMompVnYx2MTsOtWefHnesCj+umEgGJ1TYygEo4qS1p5FCet3YDAPi3ZvKtNO4DcLHBYHcZe3EHzhX+3FJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945219; c=relaxed/simple;
	bh=sxURhYTAy/XoBsbCL4RYu5flF5fvkOEJDYCGndlxg6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwWWqSiGdJT+KPEsxm0Gi0cNWUdnPdrJUIFkDCNbvuzRjn6NI5EXoZGibhOwKteq5+PtuJwmDvqK7TWv1kY5GsE+yE2S0vswQlQv0ouLUeNo8gwFH4Lfn7bBY+D3lBSgoL5wdOBl6LwfKWOUJg7k+lbgJD9DwtYzxj/tewZTMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bAz0Rkfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F11DC4CEE3;
	Tue, 29 Apr 2025 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945219;
	bh=sxURhYTAy/XoBsbCL4RYu5flF5fvkOEJDYCGndlxg6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAz0RkfiZ4DWNtDG7M4Q4xGq95sG33KbnxNakEbh2Mb61+fzuuG3Lh84AbN9Pz3ZH
	 rsNdhHTtUc8pRNlhhrg044JBSJoXji/OYTzx2B0QJwTuTppQXm/I5rXmw4w9aHHC9q
	 6Ps/dnjkMxAapwxd4eI1UdFyBGrDmAaApPeImcFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Dooks <ben.dooks@sifive.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 040/179] bpf: Add endian modifiers to fix endian warnings
Date: Tue, 29 Apr 2025 18:39:41 +0200
Message-ID: <20250429161051.032306625@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161049.383278312@linuxfoundation.org>
References: <20250429161049.383278312@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Dooks <ben.dooks@sifive.com>

[ Upstream commit 96a233e600df351bcb06e3c20efe048855552926 ]

A couple of the syscalls which load values (bpf_skb_load_helper_16() and
bpf_skb_load_helper_32()) are using u16/u32 types which are triggering
warnings as they are then converted from big-endian to CPU-endian. Fix
these by making the types __be instead.

Fixes the following sparse warnings:

  net/core/filter.c:246:32: warning: cast to restricted __be16
  net/core/filter.c:246:32: warning: cast to restricted __be16
  net/core/filter.c:246:32: warning: cast to restricted __be16
  net/core/filter.c:246:32: warning: cast to restricted __be16
  net/core/filter.c:273:32: warning: cast to restricted __be32
  net/core/filter.c:273:32: warning: cast to restricted __be32
  net/core/filter.c:273:32: warning: cast to restricted __be32
  net/core/filter.c:273:32: warning: cast to restricted __be32
  net/core/filter.c:273:32: warning: cast to restricted __be32
  net/core/filter.c:273:32: warning: cast to restricted __be32

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20220714105101.297304-1-ben.dooks@sifive.com
Stable-dep-of: d4bac0288a2b ("bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6ba1121a9f344..4406009ee163b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -205,7 +205,7 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u16 tmp, *ptr;
+	__be16 tmp, *ptr;
 	const int len = sizeof(tmp);
 
 	if (offset >= 0) {
@@ -232,7 +232,7 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u32 tmp, *ptr;
+	__be32 tmp, *ptr;
 	const int len = sizeof(tmp);
 
 	if (likely(offset >= 0)) {
-- 
2.39.5




