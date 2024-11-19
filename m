Return-Path: <stable+bounces-93960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB69D25D6
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481E61F23AF7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0DB1CBE89;
	Tue, 19 Nov 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwW6RESO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935881CBEB5
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019447; cv=none; b=rEYja1RItwQ/2PUEh8muw9IIdSSlR9HNlUxcpRbBoRUSu/UXl2UZdhIwtKdfLa0+kdD6vYZ20NfMcCZci8Onn1Emu/1y5aW5FBHLf0CipMSwG6c/SzL3ElQwYORuwxe5GPWhqzTHhuhpb65ny8WhGOeDPJOdPGPbKQ8rQYEbayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019447; c=relaxed/simple;
	bh=P6Dn8gE044iZGKdawjtxuLQqKly+00Pu+v1po9bY+Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl+yL43/hmY3JOVTGBCcrHmS42lj2rm8VR+ilLP3WkGIYGzJ3SFEYsvBJcj5Z3GuzWz0R5tMn231oi4GLHcO5tlFccRfFV25aF1usXqHC24a7fjA3Ctx2GBf1qGYg+UKRSG7qXmkRsFNgZ2OXq+FtsBF8v/o+5RvGVXmIzSPJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwW6RESO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0181C4CECF;
	Tue, 19 Nov 2024 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019447;
	bh=P6Dn8gE044iZGKdawjtxuLQqKly+00Pu+v1po9bY+Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwW6RESO0Pa2wUNzBs3bKZ9P4C+QVcBK6Cte5lN2RiQcX8XaVaMLqLGkaLgsFZDBB
	 QQGrX6YaWaYcKw/AW9sSGmNBNu304Sx+Uow+0Wr7PExK5LC2bAMq7pMfSojjPlyiiV
	 kGCSqJAlevfgsHvYxLT9w3v4MNDnUoeAFR1LSDpnFqAdewxG8X529Z0rB0hY2xvtUN
	 RNse4NqMcIB3YzWEC4nD1hrxgcS+JGR5N/wNIw9q1zUJ91bHyX9mFcourd6wONmvH4
	 etPdXcPwUMDZ4CeQ6rDvDtBWTFr3fLSUHtZKb7fBhi2h0td3YXM15SIP7RSCy4n5lr
	 kgT2ADlRikMig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 6/6] mptcp: pm: use _rcu variant under rcu_read_lock
Date: Tue, 19 Nov 2024 07:30:45 -0500
Message-ID: <20241118182718.3011097-14-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118182718.3011097-14-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: db3eab8110bc0520416101b6a5b52f44a43fb4cf

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: b5e96b7d3dea)      |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 01:23:44.789483772 -0500
+++ /tmp/tmp.5L1iL6LFxQ	2024-11-19 01:23:44.782305743 -0500
@@ -15,15 +15,16 @@
 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-3-b835580cefa8@kernel.org
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_netlink.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)
 
 diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
-index db586a5b3866f..45a2b5f05d38b 100644
+index 76be4f4412df..2cf4393e48dc 100644
 --- a/net/mptcp/pm_netlink.c
 +++ b/net/mptcp/pm_netlink.c
-@@ -524,7 +524,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
+@@ -525,7 +525,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
  {
  	struct mptcp_pm_addr_entry *entry;
  
@@ -33,3 +34,6 @@
  		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
  			return entry;
  	}
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

