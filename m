Return-Path: <stable+bounces-15084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F04F8383CF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6832956B0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEAC651B5;
	Tue, 23 Jan 2024 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vr7/INZW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C4651BC;
	Tue, 23 Jan 2024 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975070; cv=none; b=UQenb/LGFun4sRP1HlQ9f4/Czzjy4KcOvjUsUstjCsc0Qsdlo9mRgMmT7ktHHcYoXkXG/SyemcRo/j31pwt8JIylBP3jV+VzitRCAnIzhFBbXIV0y0fH489sH9eXG24YUX0rRcVKLG4gmP/ZH8w68iS9rdoledL9AEpxAx2nC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975070; c=relaxed/simple;
	bh=hzrzwgVLyYrr/c/pJATpvRBAlh7lZ6G2denEQcwcMCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSD3JxVMUVS1xkXEGVk3tACbsPFcmNZkbTQW8U/IYgNz7XFhKc6i821teABEYpOcar797AtYbvdYz87pIobv+EF+r7uEUXr9kheToFEuDf1QZClAtRIxuiPT4g1UC+hcgYHHHjIV2VIhh/iho1amazDkcvr4uP67Q+sWoBERQjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vr7/INZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE39C433F1;
	Tue, 23 Jan 2024 01:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975070;
	bh=hzrzwgVLyYrr/c/pJATpvRBAlh7lZ6G2denEQcwcMCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vr7/INZWYYnq+Da6gwt+aeKOYUZL57g8YZuDncKShG7xCMekU6pvlxDE7AnytZB9x
	 aXPG45Ga0+O0MK5NL0TLlxHvjtpV2br2U2kU1bQoboUigFYCXb1mKAH3DsOPx7bOfH
	 WIwdC0/ATj15eh9v6u+Q95m8bMrRlZTOem8E/IVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 352/374] netfilter: nf_tables: do not allow mismatch field size and set key length
Date: Mon, 22 Jan 2024 16:00:08 -0800
Message-ID: <20240122235757.180937763@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 3ce67e3793f48c1b9635beb9bb71116ca1e51b58 ]

The set description provides the size of each field in the set whose sum
should not mismatch the set key length, bail out otherwise.

I did not manage to crash nft_set_pipapo with mismatch fields and set key
length so far, but this is UB which must be disallowed.

Fixes: f3a2181e16f1 ("netfilter: nf_tables: Support for sets with multiple ranged fields")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e1a06d5a386f..9f22f62a9b4d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4453,8 +4453,8 @@ static int nft_set_desc_concat_parse(const struct nlattr *attr,
 static int nft_set_desc_concat(struct nft_set_desc *desc,
 			       const struct nlattr *nla)
 {
+	u32 num_regs = 0, key_num_regs = 0;
 	struct nlattr *attr;
-	u32 num_regs = 0;
 	int rem, err, i;
 
 	nla_for_each_nested(attr, nla, rem) {
@@ -4469,6 +4469,10 @@ static int nft_set_desc_concat(struct nft_set_desc *desc,
 	for (i = 0; i < desc->field_count; i++)
 		num_regs += DIV_ROUND_UP(desc->field_len[i], sizeof(u32));
 
+	key_num_regs = DIV_ROUND_UP(desc->klen, sizeof(u32));
+	if (key_num_regs != num_regs)
+		return -EINVAL;
+
 	if (num_regs > NFT_REG32_COUNT)
 		return -E2BIG;
 
-- 
2.43.0




