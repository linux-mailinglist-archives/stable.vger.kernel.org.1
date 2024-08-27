Return-Path: <stable+bounces-71084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F0961192
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7618B1C232AD
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201811CC8AE;
	Tue, 27 Aug 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TWU0ptva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4A1CFBC;
	Tue, 27 Aug 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772047; cv=none; b=aE+gpUlQyRZOVyyAVlTFOUWMOiqvu3z4h6U3vnYkDvlBgqOxscKtO6n6sqH+7VZ9AIJP88IL0qK2qaFRb2rXMNpZWMsyKgnMlzz0Noklr6NRXxEEFj7ZV4ZidkmtMzCZ8MZuJWBWnpyZ0bxbUri3hEZ7O9HSlUn2uXC5tBz2PPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772047; c=relaxed/simple;
	bh=1bJJWE9omHDivhWajsBY2oooY+X6XV/rEREQFxCLMm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnTJ/+ktw8sedquiTfbCodntSHW/hC57lNreP2Ag+1iLPXEW+ZABADOUjsRhLzPs7gL2in8zEc58Dg2JuL44P+olh6JcXSKeDpnkrpmTVY9p8ycSswfm8qA7YZ7gavKSLIJHnsKFw9GJu+OcQJVBDMxUMFv0hr+6e2oN4flTaYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TWU0ptva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2F6C4E693;
	Tue, 27 Aug 2024 15:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772047;
	bh=1bJJWE9omHDivhWajsBY2oooY+X6XV/rEREQFxCLMm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWU0ptvaoXSUdQfKaDEqC+V3gL1cCjuaEyDw3Vt0a7tF0QSv47Ux0S1IHEpZD8zX8
	 3PWJzOQQEwRFdraw46avYXveOPd+0tAByez8cRnyu/lHSMIAQ7Uxe1HoNOSU7zY81j
	 XcBY4YfrS65rB7SR7GWgGfJCqRsZmsoBQXxwDGLg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 096/321] netfilter: flowtable: initialise extack before use
Date: Tue, 27 Aug 2024 16:36:44 +0200
Message-ID: <20240827143841.893712067@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

From: Donald Hunter <donald.hunter@gmail.com>

[ Upstream commit e9767137308daf906496613fd879808a07f006a2 ]

Fix missing initialisation of extack in flow offload.

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_flow_table_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 1c26f03fc6617..1904a4f295d4a 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -841,8 +841,8 @@ static int nf_flow_offload_tuple(struct nf_flowtable *flowtable,
 				 struct list_head *block_cb_list)
 {
 	struct flow_cls_offload cls_flow = {};
+	struct netlink_ext_ack extack = {};
 	struct flow_block_cb *block_cb;
-	struct netlink_ext_ack extack;
 	__be16 proto = ETH_P_ALL;
 	int err, i = 0;
 
-- 
2.43.0




