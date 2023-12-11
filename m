Return-Path: <stable+bounces-6314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F9D80D9FF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7F1F213E7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9C51C50;
	Mon, 11 Dec 2023 18:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZF8JO7GH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604CE548;
	Mon, 11 Dec 2023 18:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC8AC433C8;
	Mon, 11 Dec 2023 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321094;
	bh=80ACtpH8qdmcEcfjx+lRT7wo4WvukFQNn7zRN1WmO50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZF8JO7GHMTLVPOQUcU4MS7Gl0sOYp0kv+/3bSXfzzrjCAeSgRHK5kIqbHS5bAblwc
	 J563+jA4szXOzHBYZMRS84Bhvo5RZjtSgqOjxgBACY5QmhO6rZUd67A80v3D9bsAoV
	 PnU64Gq+fYy1q/7XpasPAdEuoE/ICNub57u+TwLc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xingyuan Mo <hdthky0@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.15 108/141] netfilter: nft_set_pipapo: skip inactive elements during set walk
Date: Mon, 11 Dec 2023 19:22:47 +0100
Message-ID: <20231211182031.229249515@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 317eb9685095678f2c9f5a8189de698c5354316a upstream.

Otherwise set elements can be deactivated twice which will cause a crash.

Reported-by: Xingyuan Mo <hdthky0@gmail.com>
Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_set_pipapo.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2042,6 +2042,9 @@ static void nft_pipapo_walk(const struct
 
 		e = f->mt[r].e;
 
+		if (!nft_set_elem_active(&e->ext, iter->genmask))
+			goto cont;
+
 		elem.priv = e;
 
 		iter->err = iter->fn(ctx, set, iter, &elem);



