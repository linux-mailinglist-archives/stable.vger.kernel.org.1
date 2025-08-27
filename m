Return-Path: <stable+bounces-176503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3781DB38441
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C133B366919
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CF1C8630;
	Wed, 27 Aug 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9x2s/LA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6163570D0
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303204; cv=none; b=DnFttvG2aEIupRVgFWeIUbHNAQzqTczOJZ827ngvtKRt5N/nS1ENCl9pWnwDU3pRBtun/H5aiPFUkSAn4RegjeYpu5wRfLJOzTbtutfmjcDakkXbLbRuQ65rT7gJ6IACpY/oyq+PMzgNwOzkBzqJuGDu4pIxcUJ5BCTri5uxTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303204; c=relaxed/simple;
	bh=f6pcj8zjcfnsjzaqwqXyO/i4c4CTBOYaJBQNdcICYR8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdPPFjvlRLenTyfIPESuPDK1Klmm4Z+I2QxzSlFSUaHHD3YRjN2HOi93RtSndp/RAWyID0+h0g8veWpWr7J6TVW8QnkXeGV8fOvARtxU96wf3xrI+SKhHGa3vJDAcVxVAjms38vZ3FVwVQ/CAHlyalNRK7jBQupzQ/shppPCLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9x2s/LA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6DFC4CEEB
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303203;
	bh=f6pcj8zjcfnsjzaqwqXyO/i4c4CTBOYaJBQNdcICYR8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B9x2s/LALLEMjDSEoLYsPulbkMjEl1UX0Obm92IJ7xXDrrgVqFEAzEI7OoVHeyC2h
	 nOR7PbHCveT/QvixOopu0iqCnuP5EXpvrtwaIR361WML10io9oWS999fOyAwNAydoV
	 zVUNZO4pOhqDQebRQtmn8sUOMNk02Ed07o1rH6Y9OzWWUIS40DnrJmSbpbYNqZQ7oo
	 7U38jucq99AgsIdReBNbVxLgDh/Gdb/jqIJVsN0jHdg5Px7f30eBDOeIA+2co6CTzD
	 ZFpt3r3XDHWjq+Cz13uQfn4hPT5y6KotpuROkZ2elc4mdL9j5bpzKg4yq7NiZTSK2K
	 OYH0m/zQihO2Q==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 0/2] FAILED: patch "[PATCH] NFS: Fix a race when updating an existing write" failed to apply to 6.6-stable tree
Date: Wed, 27 Aug 2025 06:59:59 -0700
Message-ID: <cover.1756303039.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025082224-submersed-commend-be4c@gregkh>
References: <2025082224-submersed-commend-be4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The patch in question has a dependency on a previous patch by Christoph.
Both needed backporting to Linux 6.6.y

Christoph Hellwig (1):
  nfs: fold nfs_page_group_lock_subrequests into
    nfs_lock_and_join_requests

Trond Myklebust (1):
  NFS: Fix a race when updating an existing write

 fs/nfs/pagelist.c        |  86 ++---------------------
 fs/nfs/write.c           | 146 +++++++++++++++++++++++++--------------
 include/linux/nfs_page.h |   2 +-
 3 files changed, 100 insertions(+), 134 deletions(-)

-- 
2.51.0


