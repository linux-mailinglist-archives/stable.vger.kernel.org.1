Return-Path: <stable+bounces-80381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08D98DD2D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA3B1C230B3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685CF1D1738;
	Wed,  2 Oct 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wCsCq+Il"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A571EA80;
	Wed,  2 Oct 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880208; cv=none; b=A+XBX7vVAJxnV/iXgIY5YHrcURH1qYIDCC5DJlw6lDalt2kaxJsHldK9l4cFYaxrGUjL3swiHoo9o74ynbFsAmJV6TZuNEqtnT3Tr8D9hbN5pfgroK8ps33D84vMtRGdj8AiabUi3+DzWWb0c6z4WrsHmL9TQQXFZZc3ZTO0ORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880208; c=relaxed/simple;
	bh=5ZAkAonDBKXhXXIPYvSHGn0j0wN+I1hYNcfTVadkW8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAikEGGe/gIamhtsVI8AeIljJye2XO+zcxc7aK4ZnbZZFsrdJ1EEdaXSzQygWIeKNyTmIXqI464tXGf3CawQRTonk5LD0P+jhGE/XcR8fGVIQf/LCaJ0w7LQ/i0OS+hCbLawveZf82ROuo38lrEn3Hkb+0DBP945XlqQ+45/t3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wCsCq+Il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADA9C4CEC2;
	Wed,  2 Oct 2024 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880208;
	bh=5ZAkAonDBKXhXXIPYvSHGn0j0wN+I1hYNcfTVadkW8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wCsCq+IlppfsKJ4fuAoYKFtagRk++q5GrXAFMyVcl4k41u8hfokBj1WdzKngg+btV
	 rl9XIapqCbrB3IMiNX2DuHzmJyTriKjp2qQwAtnSiECYJo1i1mLRWFmQSc4FgELieu
	 Qsw8/ZcMSzl1gmK1lj4D02zqbs2qI7f4PfHWsTdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 381/538] netfilter: nf_tables: use rcu chain hook list iterator from netlink dump path
Date: Wed,  2 Oct 2024 15:00:20 +0200
Message-ID: <20241002125807.470279262@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 4ffcf5ca81c3b83180473eb0d3c010a1a7c6c4de ]

Lockless iteration over hook list is possible from netlink dump path,
use rcu variant to iterate over the hook list as is done with flowtable
hooks.

Fixes: b9703ed44ffb ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
Reported-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 935e953b8e1bf..da7fd3919ce48 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1778,7 +1778,7 @@ static int nft_dump_basechain_hook(struct sk_buff *skb, int family,
 		if (!hook_list)
 			hook_list = &basechain->hook_list;
 
-		list_for_each_entry(hook, hook_list, list) {
+		list_for_each_entry_rcu(hook, hook_list, list) {
 			if (!first)
 				first = hook;
 
-- 
2.43.0




