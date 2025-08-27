Return-Path: <stable+bounces-176506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF7B38452
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B326C368777
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 14:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D6F3126A2;
	Wed, 27 Aug 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbthAQ0I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13321171D
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303338; cv=none; b=CPN0NS94FqJS2ZG14snq1otM0J25QWY5OdkyhOWNzRWcJKgfejRhiKdpe8pOHYgtzJGOw9kfEOW0q/tH8ZHY+8cCS8ipgfr61IBW+eGV2mdmf3cql1bSmdt5MiNjsw6sMXZHxl7NJoNH+mooJAO+WtZ2NUroRwYORWcg0xSeQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303338; c=relaxed/simple;
	bh=xSXVxyMZCKkTFqZUg7H7Yb1i7BIpEE1TUsV3Zyzoekw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBRN9mtHUBoKurYZL9ochb+duW1h31FbOQmgWa6250qTx372gaJiSI1Fh2UwP4LIvHycHS/BMbATseZHgcBVQkNbv8ePsGd2pQ4wpAQnouzdpUCXesmX93JDnDoig7pKd5zuEhCIIe+tHNe+7pBel4lwYBvNN0iWFBBD+B0Tstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbthAQ0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AB0C4CEEB
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303338;
	bh=xSXVxyMZCKkTFqZUg7H7Yb1i7BIpEE1TUsV3Zyzoekw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jbthAQ0I+7/B8P7GQJNV7YA8djcXm3ZkhcukKWJRw5dWuTNvb+r6RC61CsX1nD8c6
	 EVQDC/oMi+h/8CKMV1FhcudZ0E3B+uDxgUyyu/19huSZucYa2DGfC3S7wqWnK/QYjt
	 gRU/Aj3U+WPPIxcHkov0c9IXuv1m0bKdG4Y+NUCBm3daXDFChWVdwDA+jZuNDcPddv
	 HyJSgHXrOEZtXsL5H3g2Lj5Vl7kIHQ6S0P+OVhUwTe2nWhLShcD94D7fXTwonSbTgk
	 sSqS/zWTdhNij3PNqU/mWb7Qt/b6GLQ9qGFcAnXag7zGyWpUl4WFNntlJ2oIUiNlx5
	 JflTGjlIMRbiw==
From: Trond Myklebust <trondmy@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/2] FAILED: patch "[PATCH] NFS: Fix a race when updating an existing write" failed to apply to 6.1-stable tree
Date: Wed, 27 Aug 2025 07:02:14 -0700
Message-ID: <cover.1756303256.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025082224-payment-unworthy-d165@gregkh>
References: <2025082224-payment-unworthy-d165@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The patch in question has a dependency on a previous patch by Christoph.
Both needed backporting to Linux 6.1.y

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


