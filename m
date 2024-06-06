Return-Path: <stable+bounces-49638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0158FEE3B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D200D1F21B98
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463661A01C9;
	Thu,  6 Jun 2024 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DFZp3cWs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049091A01A4;
	Thu,  6 Jun 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683635; cv=none; b=JwH2Jve1erjO8xAwhasKSN+dgZM6iCJs5tuEemSd4FIF32MbBhyFBzkfrf108kug9HjWgPkEdTX6CXTd1jexb/KtJyXDgx7OyYSt6IfOyjNxze9+N5zlylftpMPw8VoU0vsHzG8b2OIoKou7ufxSC1S70oDuRls6A3cwQ3lfJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683635; c=relaxed/simple;
	bh=9aQozEtMabQVQYYGhreuomi3JiYIAX5mRCxwdXEEJFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukV3EppA1Gp95Mhzf628YRNAjdefBeTwxih7QB7TRvCMxT+e1X61oAoZ2/tLY09od9F5tPcty7pmaZdmf6+po8q7bKVmzZE+l0+UNMuszajLO235RGSPjy4nh2RMqQEQ+xkfPU4Kf0upVNBp46KSUeP0QnLLbwn4ip0f9G7GlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DFZp3cWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0E7C2BD10;
	Thu,  6 Jun 2024 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683634;
	bh=9aQozEtMabQVQYYGhreuomi3JiYIAX5mRCxwdXEEJFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFZp3cWsY6pUwG/gDqRR/1xIzZ92WKH/b/vUPU3w4PvKmW6OnLhBHT8j2JkHo8Ytb
	 sT2tn6hO5xDpGcD3Vx7sshPnHK2jDEH1aYgyqU5zE0tmrMPYTgSG9CMrD1UfNpHchn
	 DKN6hHFn2Y7jZwPlvdc3NVF7m4AzkIlfNLDkFosA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 455/473] netfilter: nft_payload: move struct nft_payload_set definition where it belongs
Date: Thu,  6 Jun 2024 16:06:24 +0200
Message-ID: <20240606131714.738362336@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit ac1f8c049319847b1b4c6b387fdb2e3f7fb84ffc ]

Not required to expose this header in nf_tables_core.h, move it to where
it is used, ie. nft_payload.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 33c563ebf8d3 ("netfilter: nft_payload: skbuff vlan metadata mangle support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables_core.h | 10 ----------
 net/netfilter/nft_payload.c            | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 1223af68cd9a4..990c3767a3509 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -66,16 +66,6 @@ struct nft_payload {
 	u8			dreg;
 };
 
-struct nft_payload_set {
-	enum nft_payload_bases	base:8;
-	u8			offset;
-	u8			len;
-	u8			sreg;
-	u8			csum_type;
-	u8			csum_offset;
-	u8			csum_flags;
-};
-
 extern const struct nft_expr_ops nft_payload_fast_ops;
 
 extern const struct nft_expr_ops nft_bitwise_fast_ops;
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 70d8d87848fc0..e36627a654244 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -656,6 +656,16 @@ static int nft_payload_csum_inet(struct sk_buff *skb, const u32 *src,
 	return 0;
 }
 
+struct nft_payload_set {
+	enum nft_payload_bases	base:8;
+	u8			offset;
+	u8			len;
+	u8			sreg;
+	u8			csum_type;
+	u8			csum_offset;
+	u8			csum_flags;
+};
+
 static void nft_payload_set_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
-- 
2.43.0




