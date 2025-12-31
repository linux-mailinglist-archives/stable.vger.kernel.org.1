Return-Path: <stable+bounces-204308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A640CEAFE4
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 02:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C11D4301B2DC
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DDB1F91E3;
	Wed, 31 Dec 2025 01:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovjUx9Y9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D686352;
	Wed, 31 Dec 2025 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767144326; cv=none; b=XRmhnW3JNqUuTvnI8KTt5VyYcSkzX916xcH2FmgxqURrCbwMuc5Ape0vu0nxapKh0ZYt8TsqId4VL4MZAfckol+Quzdkn55xkFMKl9wnTDLaHNEGxD9Yh8eYLyEk0YDUiuQ1hjpt9Q5zASoSvq0VYlgrNcX92awu30MSXe+uEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767144326; c=relaxed/simple;
	bh=O5xxeuSOtbrcGO6p0D++q4AK9X/cFtiDX/QhXReUnnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX2OOgT6i87w84XlZYSOFsAmWqADiQ5K+UeQgaqz29fdLJ5h4WJDmwZM+MZprMemfh0z9WqxarnsTCV0UmdjqA7uVdYFOmKBMaDcyovHsP0B1+o1lnsYXWNBIWJQKYosKnOu+pjZbIVhEDUkor1MMXXxtqw5COPWmWd7TtX/OZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovjUx9Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C93C116C6;
	Wed, 31 Dec 2025 01:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767144325;
	bh=O5xxeuSOtbrcGO6p0D++q4AK9X/cFtiDX/QhXReUnnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovjUx9Y9iiMW5glAhyrYp5ExTgMJT3Yl+5KuUqsL8mwD23ntkR9sDaM37MqmLcAPm
	 c3mZraznn7ipiZOCFmczpodFb95ZPd7ZZWL0VyEHDV0KSikwkN6vX3uaQT86wOBY/t
	 wlxPoo2Or2IkubTHkzVyEAlPOHsnbtv0PLiySMO9LZqZhBdhxoZxeKi1/i06b32Nrt
	 OCJAw2hXYu/16iPIHFqfV2crQo8Q6hF4mm45dpG6hOMaXvS3qohMjhXLb1Isnz3V2y
	 a9H6A5Q6/XQ3cOO/gz71nZKzXLylxfRBQ23CG1ILn7iKXvQbh/EH659XEnT4bdfyy9
	 0/RA2rf6/CbUA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	JaeJoon Jung <rgbi3307@gmail.com>
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
Date: Tue, 30 Dec 2025 17:25:20 -0800
Message-ID: <20251231012522.75876-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230034516.48129-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Dec 2025 19:45:14 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> > 
> > > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > 
> [...]
> > > I will send a new version of this fix soon.
> > 
> > So far, I got two fixup ideas.
> > 
> > The first one is keeping the current code as is, and additionally modifying
> > kdamond_call() to protect all call_control object accesses under
> > ctx->call_controls_lock protection.
> > 
> > The second one is reverting this patch, and doing the DAMON running status
> > check before adding the damon_call_control object, but releasing the
> > kdamond_lock after the object insertion is done.
> > 
> > I'm in favor of the second one at the moment, as it seems more simple.
> 
> I don't really like both approaches because those implicitly add locking rules.
> If the first approach is taken, damon_call() callers should aware they should
> not register callback functions that can hold call_controls_lock.  If the
> second approach is taken, we should avoid holding kdamond_lock while holding
> damon_call_control lock.  The second implicit rule seems easier to keep to me,
> but I want to avoid that if possible.
> 
> The third idea I just got is, keeping this patch as is, and moving the final
> kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
> removes the race condition between the final kdamond_call() and
> damon_call_handle_inactive_ctx(), without introducing new locking rules.

I just posted the v2 [1] with the third idea.

[1] https://lore.kernel.org/20251231012315.75835-1-sj@kernel.org


Thanks,
SJ

[...]

