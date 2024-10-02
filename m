Return-Path: <stable+bounces-79811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0741698DA60
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398DD1C23796
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771F1D094A;
	Wed,  2 Oct 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbFk0fWt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44041CFEBE;
	Wed,  2 Oct 2024 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878534; cv=none; b=e6LvE3aPUNuL4Y2FKR9HbDY7bN9QeVU4WLt4fJXttXrVAcqtfWQJmXEi1QCoYzyTQReRN9AC7ZemkjTcjrO7dmBIuetbVGtiRj7dTtW+Num91waNX26t06UMmJoP0oHbpzAUZoGARRZ6PWasdgpwlNkwleXvfBN5hAqiGqg+FQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878534; c=relaxed/simple;
	bh=rpDVY66yrkvprtIg3C6t62kqSyRhFG+pYvSgpQOWQmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6hEFbRw8QtywTVxpdXLv4Wgw8YRLu4qW5lUA4YwhO1RE70rlXS7phS2fWny9b3cNseg6FdIzgfsv5gS8s5v0Ta+SwOhb/SYIJx2F8zxfN5Wa+iiUi5aTGg81a4WxfXvViE0IqbYgoyKH1wBQqJ+07LW20LfGIaCss+9uHcNKqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbFk0fWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2329C4CEC2;
	Wed,  2 Oct 2024 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878534;
	bh=rpDVY66yrkvprtIg3C6t62kqSyRhFG+pYvSgpQOWQmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wbFk0fWtJKItslRDpHbH13Aie7e7dCTFDx8hFzs8ogOkY3vW/Bp88stN5GSuoEnJ/
	 o/SU3VjIAzN4RGwOtZKHK9AiTNbgOifnWJTr5ekArigqU7uzYpl5sy5+FbSZCZlrYC
	 pkyqZJjHeuIxqGZQylXwvfvuobpFy/EFuBHbEyMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 447/634] netfilter: nf_tables: use rcu chain hook list iterator from netlink dump path
Date: Wed,  2 Oct 2024 14:59:07 +0200
Message-ID: <20241002125828.744261647@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
index 3c19928b359c3..71df3e5cc46d9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1795,7 +1795,7 @@ static int nft_dump_basechain_hook(struct sk_buff *skb, int family,
 		if (!hook_list)
 			hook_list = &basechain->hook_list;
 
-		list_for_each_entry(hook, hook_list, list) {
+		list_for_each_entry_rcu(hook, hook_list, list) {
 			if (!first)
 				first = hook;
 
-- 
2.43.0




