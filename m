Return-Path: <stable+bounces-176644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A696B3A865
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A86F7C0FAF
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B360921B9F1;
	Thu, 28 Aug 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRMFUoVf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C06322C91
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402875; cv=none; b=SsRAnIEvE8qyAkWB5X6xczXqoaBr8bjNK+YpDNi6y/3T1zt7dnoE8e8AILZn4wIn1+mR+8mKEerT5HsGyyqwBXYsRtu8tT3Q0bBD65LBAsAAa6YHBE8uSYejs+/KeCEB8EM0vMA8eMID+35xx3acIsFOVIv308nnDlVSxSQw4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402875; c=relaxed/simple;
	bh=b57kSuYKmrq3iXuDj6LrN3hT8bHvQF2B8cEYMqMr9eA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkR5rPpBrncEV8r46p/6w0SJY/l2jcqOdTR8UncEaAJG4pSglYZN+gYwuondX/ElAAVLSwghGrN28Ckbp7E5QQASBjfqwHzRC2ejsf8MbYF2kflE0Uc7Sqh2vyndc3sS/iIRGsIw7itGVEgTOYGMaxbFyEJkc1uRIicGHIz8ZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRMFUoVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6434C4CEEB
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402875;
	bh=b57kSuYKmrq3iXuDj6LrN3hT8bHvQF2B8cEYMqMr9eA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GRMFUoVf8KIrO5TDV2FynPWSVHWf6jMQIaGdmjkNahy633iyaJGBeJE9vyb8BlVm5
	 TUcs0pY75ZQVn6hQ6qxul3UDimQnEmlTgEkhY1BWvW4BchY/lfINlO2Pc7rx/49mlC
	 MWTux4ux7NjhwtCJw8C2oKnSeWgfw2lI0hkFbjwA3vELgofM6uBOm4NMsVzcqz10cr
	 H/vj82uO/IkySUXBFh9HPLPW4ITHeYwYqOwS4ppFgjzhO+uVKHo8zhul8zWBFA0ytz
	 gGL6DJbt0BrizH1buwW2wz8pmKC5bkTvneS6ZXYiSRjVWxVnsiaEvEfT4fUbqcze4n
	 n9HJphzsl8aDw==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/2] FAILED: patch "[PATCH] NFS: Fix a race when updating an existing write" failed to apply to 5.15-stable tree
Date: Thu, 28 Aug 2025 10:41:11 -0700
Message-ID: <cover.1756402339.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025082225-cling-drainer-d884@gregkh>
References: <2025082225-cling-drainer-d884@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The patch in question has a dependency on a previous patch by Christoph.
Both needed backporting to Linux 5.15.y

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


