Return-Path: <stable+bounces-108556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB2DA0FD38
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 01:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BA43A6C9F
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7214690;
	Tue, 14 Jan 2025 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBXdL0Bk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5AC29B0
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813612; cv=none; b=NQBViuLfPPYGTq/37o/9TuCIdxGZTUP6Hfup0jmuGdNFsHXvGvm6kZLH3TIVpKeSUkJKGFNfhJWDpG/YLoXQPfRQSQuIL9bCvUMfWWR+cb9mdlRcOs2Juk9rlqkj6kK+TSJViv0bpK1kBL5765Fw7TJkJzmxH6bR4cIoxDZB4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813612; c=relaxed/simple;
	bh=S6Rjy2MqDZq8dx0yxcPpRJNSk0X/Zo5jIIRzruV3+oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlS3ToA5Txn7MuVUrVS3pnQOfiBH6ZO4SjltvaDZmu1PByTJpcbvTsoLRUjp+Ogg60ZGkufTsNDdoHaVwJX3iK8zztkXKkjEY84ymVQVkSyQl0yM3hZ0Il6tiSQzlSH/vue7Si52u8bbuTIm6LrDKYWyNwd0kKCt5G/PhiL+qhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBXdL0Bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A1EC4CED6;
	Tue, 14 Jan 2025 00:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736813612;
	bh=S6Rjy2MqDZq8dx0yxcPpRJNSk0X/Zo5jIIRzruV3+oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBXdL0Bk91RlKRQaOQeLwERkwXfPzufzpiUnkftqtdXfcNvFxAcrt0Mm4pqk7Azdy
	 hG7Pe7OKVewVRqdS5BUqM1davQeHIs33zG5WV39dyW883gv3YUBhpQiiX4Rz3yNgP3
	 uG1H+5ALrpqotYgZO1Kifh+tLczzcXgDx4JDhU6ZswrMbL+7yN4j4awGfByxjX3c7w
	 cuArM0Fg+0ZZ3BhQ9PyzlgKPab1oOpQGt1awWPIQteztPqJRFFzMj2wBixVKrOvfma
	 n2QwP8Rlvlhp9oJfjQyegDm4hFfWMKrKbIT3W4SzPEHyb1NdlHWEQhTvniYh7QLapw
	 X8M0MmUo8REyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] netdev: prevent accessing NAPI instances from another namespace
Date: Mon, 13 Jan 2025 19:13:30 -0500
Message-Id: <20250113181314-17e3b4eb3bab95ac@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113191714.4036263-1-kuba@kernel.org>
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

The upstream commit SHA1 provided is correct: d1cacd74776895f6435941f86a1130e58f6dd226


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d1cacd747768 ! 1:  0686eb4ff47a netdev: prevent accessing NAPI instances from another namespace
    @@ Metadata
      ## Commit message ##
         netdev: prevent accessing NAPI instances from another namespace
     
    +    [ Upstream commit d1cacd74776895f6435941f86a1130e58f6dd226 ]
    +
         The NAPI IDs were not fully exposed to user space prior to the netlink
         API, so they were never namespaced. The netlink API must ensure that
         at the very least NAPI instance belongs to the same netns as the owner
    @@ net/core/netdev-genl.c: int netdev_nl_napi_get_doit(struct sk_buff *skb, struct
      	if (napi) {
      		err = netdev_nl_napi_fill_one(rsp, napi, info);
      	} else {
    -@@ net/core/netdev-genl.c: int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
    - 	rtnl_lock();
    - 	rcu_read_lock();
    - 
    --	napi = napi_by_id(napi_id);
    -+	napi = netdev_napi_by_id(genl_info_net(info), napi_id);
    - 	if (napi) {
    - 		err = netdev_nl_napi_set_config(napi, info);
    - 	} else {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

