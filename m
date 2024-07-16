Return-Path: <stable+bounces-60278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F61932F6A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0363E281276
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F719FA99;
	Tue, 16 Jul 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZFuk6Fd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751654BD4;
	Tue, 16 Jul 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152335; cv=none; b=T1UQ7IL7crSldL06jQNGMofaGcU17SXUnW5j+LikznkyiZhJ/JCI9RhlWgd2IMr4WG499DezcYMfbbV3kfYc7+6IJw1qTnFszmVDDf4Zd468uuycA8eh2PMJ2mzz5FVoejwwJcflddzgIzJGvNmjSuHO2YL3dzZHaofTLX9qXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152335; c=relaxed/simple;
	bh=3INfJTBuIGPGIxdF53Rc/9nUYk4n6kQ4mowWADu56tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gh9xTmL/K5g2ZkoTMAkZEB2XPY8jGxlnvo4n4PYV5de9NhluKVXUF9Oas7/fc5rK0r9DyA+WvrSAB3sRDu++e1705a3g2v7MUyKkhjaPT1+oXpWPR/USsx+7fnr2tGOabnsMWZCZ8VA3eTrhdYuh/PYklfJo1JftZkiun1Yx9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZFuk6Fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615F9C116B1;
	Tue, 16 Jul 2024 17:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152334;
	bh=3INfJTBuIGPGIxdF53Rc/9nUYk4n6kQ4mowWADu56tE=;
	h=From:To:Cc:Subject:Date:From;
	b=WZFuk6FdDQEkzsYkBlCgHKnPQIDagWQ30YEHBH9MGPXMIThAsPRpBYakiokDLaL/X
	 rMmGRVFhlHwxwyWqc30cgxF1im+jcBG0ffTxe+LhZ6hSypzt9fJHPfiknvWV5MGkSh
	 iBX5251Xad6ujunkUiT7E7sEs1YSixB1Rn3qHVVOxi2PmhJCH/tkoBYmXAhMtfr6oM
	 EQ6oGvtG1NjLnWKT8OaLzZl2dAAJBJuDqwMqhKn7upOvLZCrwLjYj9d4qRnU4Oi6eI
	 5vyq+iK9hUGJnIXrtVcFiyjxqjIt/+hh9qDEwfwaqxDWuEF+wx6KUgI4j4D/fqfefv
	 ji60aKb1P/itA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y 0/7] Backport patches for DAMON merge regions fix
Date: Tue, 16 Jul 2024 10:51:58 -0700
Message-Id: <20240716175205.51280-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 310d6c15e910 ("mm/damon/core: merge regions aggressively when
max_nr_regions") causes a build warning [1] on 6.1.y.  That was due to
unnecessarily strict type check from max().

Fix the warning by backporting a minmax.h upstream commit that made the
type check less strict for unnecessary case, and upstream commits that
it depends on.

Note that all patches except the third one ("minmax: fix header
inclusions") are clean cherry-picks of upstream commit.  For the third
one, a minor conflict fix was needed.

[1] https://lore.kernel.org/2024071519-janitor-robe-779f@gregkh

Andy Shevchenko (1):
  minmax: fix header inclusions

David Laight (3):
  minmax: allow min()/max()/clamp() if the arguments have the same
    signedness.
  minmax: allow comparisons of 'int' against 'unsigned char/short'
  minmax: relax check to allow comparison between unsigned arguments and
    signed constants

Jason A. Donenfeld (2):
  minmax: sanity check constant bounds when clamping
  minmax: clamp more efficiently by avoiding extra comparison

SeongJae Park (1):
  mm/damon/core: merge regions aggressively when max_nr_regions is unmet

 include/linux/minmax.h | 89 ++++++++++++++++++++++++++++++------------
 mm/damon/core.c        | 21 +++++++++-
 2 files changed, 83 insertions(+), 27 deletions(-)


base-commit: 291e563ecab1ea89c70172ecf0d6bff7b725d3cb
-- 
2.39.2


