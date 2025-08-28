Return-Path: <stable+bounces-176642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27E0B3A834
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4504A5E5BF1
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE9632C301;
	Thu, 28 Aug 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE0QBE0m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84E321446
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402520; cv=none; b=VJD3kuBt6+Lz5wlehZuEKEy95tojEppEkEjAVuD0F+haBfNYZMdVIs5b/OCIbDqPEqOVbrbcKrDKUD9EUf0VefZVxld70x/MlzMZjrMUd10El4qKXezW8BpMRgImccM0h/ZwfdDV4oou/L3YAW86PMlrr3WTdnhr3sfFuhZbVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402520; c=relaxed/simple;
	bh=b57kSuYKmrq3iXuDj6LrN3hT8bHvQF2B8cEYMqMr9eA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDRNl3MKwx4DE8PB9GvyFykPepQn30Fub1vqZZHR2bf+3SLJ6ZymCdYrP7P2VShAHORrr+AEsxTIfNngUpNrmSbbuTbyG4i8Uhe7ycxgfX2MbJfcmV2ecqsI4eNgDUCCq8zWMGUSc6rcrmMu9xxTd8nA/Fty1II3w/VLFVB0H6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE0QBE0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E824C4CEEB;
	Thu, 28 Aug 2025 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402519;
	bh=b57kSuYKmrq3iXuDj6LrN3hT8bHvQF2B8cEYMqMr9eA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YE0QBE0mXHx259WqShE9Jrwjbl3VMwLjPU6fd+cg377OGvIqU/B+ObEkQAeONK8H/
	 jeEUd/btY43RF6pJqbUo6uHAKG8qh9/EKTbWq6G7Wyyw7oGGRsGfqrmJZwphUPx6e8
	 O//b4iNFckqEWzFjgeO0IY3J/p/qmKKqflTzjL1Cfhy46SdErjXD6oasUGNyTRUHFk
	 vCvXU4UwsA8LR6gUwX1f0j/2UOlcRKIQW0CM8kVwJITywfuHvtOMyna3UcmvCHjjuM
	 c6v2CvzEpBjMfW6jjTaCrHvwsVLnMV4FTT0BWU1PlzEe54miZD7BfsFvaWueWd6Ubw
	 DlflMfgYjYGBg==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/2] FAILED: patch "[PATCH] NFS: Fix a race when updating an existing write" failed to apply to 5.15-stable tree
Date: Thu, 28 Aug 2025 10:35:15 -0700
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


