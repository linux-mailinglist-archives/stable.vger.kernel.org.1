Return-Path: <stable+bounces-208877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 731FCD26484
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 768C431BDA02
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6401A08AF;
	Thu, 15 Jan 2026 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+1OgBPf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBB2820C6;
	Thu, 15 Jan 2026 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497097; cv=none; b=ffmN7+xXhUc6YCSCTN7FCvhQI9hMJYhhinB6Na1I0+llv5Cezh9/sUEKaJxPqCMCvspt4itwWXgtQQDlCEasy8YYP3rmL5IZ9yfRXOQPgefbbKvPYynuwGaOUSAcQDQzWFvoj6VHBeikwtL1qFCklMFfpB58sPHIXcctFx9jTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497097; c=relaxed/simple;
	bh=+FH8JhjRbuNMgS3ZD/kat2/3KnPJutPDawyAX/eN+CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/mmi89+XfvN/eeDjsMLR/rB42ZRGzCtAW6faPLJoOzMzkUi25yOP/LxGncvtWr6V0Zi8Moz45GT23exfL0tEyPm+LDlyi83U233WzCOS4stbLeP3lQmOlNdnowOoJoNBC3me5x2aME1LF2e5m37fEOXwBIxSLQZL5Zart4oiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+1OgBPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F299C116D0;
	Thu, 15 Jan 2026 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497097;
	bh=+FH8JhjRbuNMgS3ZD/kat2/3KnPJutPDawyAX/eN+CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1+1OgBPf/8SuOUFZ+KZ29ZResbzJ9dkTHkc668dEAMo+TjHO9XEe3ITbcBXrXVUgt
	 XOH5dsthmGkwR0GNS2aAzZkISKhneNN1Q1Dy3WIdSC/nw+tJvakv0JJwbQiJYkOVZe
	 +4eB8bmLEmWzX1nnv5l8Uh22akCCe+sDzpQFI82s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 35/72] netfilter: nf_conncount: update last_gc only when GC has been performed
Date: Thu, 15 Jan 2026 17:48:45 +0100
Message-ID: <20260115164144.767316764@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164143.482647486@linuxfoundation.org>
References: <20260115164143.482647486@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Fernando Fernandez Mancera <fmancera@suse.de>

[ Upstream commit 7811ba452402d58628e68faedf38745b3d485e3c ]

Currently last_gc is being updated everytime a new connection is
tracked, that means that it is updated even if a GC wasn't performed.
With a sufficiently high packet rate, it is possible to always bypass
the GC, causing the list to grow infinitely.

Update the last_gc value only when a GC has been actually performed.

Fixes: d265929930e2 ("netfilter: nf_conncount: reduce unnecessary GC")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conncount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index c00b8e522c5a7..a2c5a7ba0c6fc 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -229,6 +229,7 @@ static int __nf_conncount_add(struct net *net,
 
 		nf_ct_put(found_ct);
 	}
+	list->last_gc = (u32)jiffies;
 
 add_new_node:
 	if (WARN_ON_ONCE(list->count > INT_MAX)) {
@@ -248,7 +249,6 @@ static int __nf_conncount_add(struct net *net,
 	conn->jiffies32 = (u32)jiffies;
 	list_add_tail(&conn->node, &list->head);
 	list->count++;
-	list->last_gc = (u32)jiffies;
 
 out_put:
 	if (refcounted)
-- 
2.51.0




