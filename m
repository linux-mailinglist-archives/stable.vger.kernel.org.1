Return-Path: <stable+bounces-66460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5694EB22
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCC41C21713
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0217C230;
	Mon, 12 Aug 2024 10:29:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C30176FBD;
	Mon, 12 Aug 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458573; cv=none; b=V98sLGnyS7maXst+vipkUwlV4G1vHbHJ4jpYy7CplfLMhBlt7jbK+GtgujLKp7lGak0na1c3t2+Hme/9DZCKKzNcnaTKzz3tq1tUUP/G/40Emr1rcUWAp0gLA0j6TDf6/BFT6J8gBWNlm1m3FbVeRUlT3IiVFYEMX40vvQY81uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458573; c=relaxed/simple;
	bh=+xZWVzZPJ1qW0QowvdsdstF8XAceSAbZKQpSebfe++Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKHD9z/xRxCHf2b3sL33Ji8creN7IEiP+YyvE8bULG1VeHfm54C5PZb/yDTLXhd25rfsbsN78biBxbufIAZ9bBScr+P+EAw+YuHd6mGaokqu2pVpDgmr9IZ6EqjA+887HdP9PlZ2PKAtAfIYS/ZokQZDyi0mRLS6CGbMgMY2qjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,4.19.x 1/3] netfilter: nf_tables: set element extended ACK reporting support
Date: Mon, 12 Aug 2024 12:29:23 +0200
Message-Id: <20240812102925.394733-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240812102925.394733-1-pablo@netfilter.org>
References: <20240812102925.394733-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b53c116642502b0c85ecef78bff4f826a7dd4145 upstream.

Report the element that causes problems via netlink extended ACK for set
element commands.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f2611406af14..b64d3cd97ee7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4523,8 +4523,10 @@ static int nf_tables_getsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_get_set_elem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
+		}
 	}
 
 	return err;
@@ -4902,8 +4904,10 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_add_set_elem(&ctx, set, attr, nlh->nlmsg_flags);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			return err;
+		}
 	}
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
@@ -5103,9 +5107,10 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_del_setelem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
-
+		}
 		set->ndeact++;
 	}
 	return err;
-- 
2.30.2


