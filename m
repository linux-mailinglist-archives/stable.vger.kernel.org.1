Return-Path: <stable+bounces-176647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1559BB3A878
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D653BDFBE
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009833EB1C;
	Thu, 28 Aug 2025 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSb+xr5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC933EB14
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402919; cv=none; b=D1fVbxEVqs+h2Yf1oHfuwsaoRfmbXqJWloBsp2r4e5h1eQjHbHXL16Bl7AoWVEIoP65HdvXbrN6UcE65s5yPyIqnOz9FHa9RKToNH+KnePLojDwBnPizeTYylgmbkUtAbKyXQk84CAC302V0tBxzKP0vWEIPAryV1Q9vIumr9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402919; c=relaxed/simple;
	bh=ROzfsbnVweuxMfF7UTolbMguXegPAwAsJiTfhuPecP0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnEdjdNTHrEuz38MaIKTBzveMgJ3IGyvjPPdh3KYVBLuZxCdHKD+qy7vMsN41fmPKG8ovRkE01UYuxMGMnSsrytJdrY9yXgv6vDiIaDtcO9NThqzprEpIiNTcREIcqugEOlxjuGHikri8E8t50GalJF0ekukxe+g7y+SeW6a8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSb+xr5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E253C4CEED
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402919;
	bh=ROzfsbnVweuxMfF7UTolbMguXegPAwAsJiTfhuPecP0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oSb+xr5RTfpJGVLcava/eRbEU86ylLjWnjZ2U8itCyvlI4SFUPG0zNGqlhsiQelTo
	 uJmENCDW2oft4PTU1jJCY1N3DP6PBMLodT7k1Up6RrDaqERThok2Vna9sxN/463CCB
	 wbKWxMXrhdL5Vw30rQhX/QbSIHv2XG34Zf4okKZVKw50PDaaHuDs5toySBac5RBydk
	 kp2/tICzhoJ6El+fK0EXvPF5DSuBX6IBk43el0d2Dtd9hfOyt+gdbbpMROdNHv/An1
	 PE8+N83knBg3JgY2Srzq7cg5ctMdBd/BVuUiKc2zAe88mTMuaPlwq8wUsmXMGIy4ww
	 nU+Qo4BKrZANQ==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y 0/2] FAILED: patch "[PATCH] NFS: Fix a race when updating an existing write" failed to apply to 5.10-stable tree
Date: Thu, 28 Aug 2025 10:41:56 -0700
Message-ID: <cover.1756402795.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025082225-attribute-embark-823b@gregkh>
References: <2025082225-attribute-embark-823b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The patch in question has a dependency on a previous patch by Christoph.
Both needed backporting to Linux 5.10.y

Christoph Hellwig (1):
  nfs: fold nfs_page_group_lock_subrequests into
    nfs_lock_and_join_requests

Trond Myklebust (1):
  NFS: Fix a race when updating an existing write

 fs/nfs/pagelist.c        |  86 ++----------------------
 fs/nfs/write.c           | 140 +++++++++++++++++++++++++--------------
 include/linux/nfs_page.h |   2 +-
 3 files changed, 97 insertions(+), 131 deletions(-)

-- 
2.51.0


