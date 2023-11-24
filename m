Return-Path: <stable+bounces-2528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4352C7F84A2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDFB9B2827A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F4B39FFD;
	Fri, 24 Nov 2023 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cMCt/0Tv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9438DD5;
	Fri, 24 Nov 2023 19:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65255C433C8;
	Fri, 24 Nov 2023 19:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700854106;
	bh=PoQwOY+p+i7AIvJrKP6iMVyUvCZG6dcvTfMZABmm0UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMCt/0TvsLHenRamdPoR7x0zYkZkZSsotRq9Wod4YuFSRSUiZFVsNFynk+12C4fQk
	 jFgnvBuzXojmXJ1QTvhQPTxBdxjNTSgkFxj5AU1Axuwx60hQbdN0o7W1HBAPilrszC
	 N+8simzGHOdDyHBBRm9LrqmLlGjWJ0ZmSaugZo6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 159/159] netfilter: nf_tables: bogus EBUSY when deleting flowtable after flush (for 5.4)
Date: Fri, 24 Nov 2023 17:56:16 +0000
Message-ID: <20231124171948.409928439@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

3f0465a9ef02 ("netfilter: nf_tables: dynamically allocate hooks per
net_device in flowtables") reworks flowtable support to allow for
dynamic allocation of hooks, which implicitly fixes the following
bogus EBUSY in transaction:

  delete flowtable
  add flowtable # same flowtable with same devices, it hits EBUSY

This patch does not exist in any tree, but it fixes this issue for
-stable Linux kernel 5.4

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6132,6 +6132,9 @@ static int nf_tables_newflowtable(struct
 			continue;
 
 		list_for_each_entry(ft, &table->flowtables, list) {
+			if (!nft_is_active_next(net, ft))
+				continue;
+
 			for (k = 0; k < ft->ops_len; k++) {
 				if (!ft->ops[k].dev)
 					continue;



