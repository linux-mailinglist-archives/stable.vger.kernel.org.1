Return-Path: <stable+bounces-78028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CED79884BB
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4EF1C21EE2
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E7118C016;
	Fri, 27 Sep 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dRlsQ/N/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3818BB91;
	Fri, 27 Sep 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440223; cv=none; b=OMZeQHv0o+z7tWPVw8rNN4mFpVEsHnH9KRgQMBdwqQpi38LPyWlrAZ31k7OpGUFOnqFnnwAJCrBQg+SNEVY6n3U7Ei28RFSoU5SN0jdiB++yHtmS64S3DNpXYnn6WXFk9172+s9qVKvTW+3A+rhweJiiioBJVi0x6Ogy+Z4UVNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440223; c=relaxed/simple;
	bh=g5npTw7hYVlH9UWOp+9stNb5/hfsHNi7hO+X/Yz9aLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZOlRCPnu5QuG1aj2OgC7LZ4OHRsWgczcZA1efGwohU9Grf9lRQJLpJE5sjSuGuK29MYhtRK/uiJlnsB1y7tsnOUouXWV0wzLRWLgsvRkC1waZqUt6Q/NDmL4y7UhkDJHqHNVESwZ/jA6DoqH3rmk2xm/XW9wEz+7qohHpWoP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dRlsQ/N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4788C4CEC4;
	Fri, 27 Sep 2024 12:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440223;
	bh=g5npTw7hYVlH9UWOp+9stNb5/hfsHNi7hO+X/Yz9aLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRlsQ/N/cx/g2nwMg1KO8zNcgH59GeesaUMdcZqLMMMO8nqvfuhu2gOC3lWk5PZSK
	 YHWTTke7VtFoCjq4QnFb6x/TrjlEChjUMdVXb6rea900fkIhrfCEzqeIZUq5sLZnSZ
	 65yjKQbAZ31wmJ8ly88vMAFdzdKu6ltprbt0P+f8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.11 07/12] netfilter: nft_socket: Fix a NULL vs IS_ERR() bug in nft_socket_cgroup_subtree_level()
Date: Fri, 27 Sep 2024 14:24:10 +0200
Message-ID: <20240927121715.557785873@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
References: <20240927121715.213013166@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 7052622fccb1efb850c6b55de477f65d03525a30 upstream.

The cgroup_get_from_path() function never returns NULL, it returns error
pointers.  Update the error handling to match.

Fixes: 7f3287db6543 ("netfilter: nft_socket: make cgroupsv2 matching work with namespaces")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Florian Westphal <fw@strlen.de>
Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
Link: https://patch.msgid.link/bbc0c4e0-05cc-4f44-8797-2f4b3920a820@stanley.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_socket.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -61,8 +61,8 @@ static noinline int nft_socket_cgroup_su
 	struct cgroup *cgrp = cgroup_get_from_path("/");
 	int level;
 
-	if (!cgrp)
-		return -ENOENT;
+	if (IS_ERR(cgrp))
+		return PTR_ERR(cgrp);
 
 	level = cgrp->level;
 



