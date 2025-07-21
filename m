Return-Path: <stable+bounces-163618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECABB0C8C9
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED53D164CED
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0102E03F6;
	Mon, 21 Jul 2025 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aet7JhT/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B719F121;
	Mon, 21 Jul 2025 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115442; cv=none; b=cDJFmSJ+0mVw2CqlXEUo7MU2igUPnrQLKoHRgatY4tTcYURh1Uz+Tk2oOKaNU5NTALsw+r/bhzunNbwFGlcK70QflDHhTNCqxxHYQd2HX1vqBM4HgWMGMuJYdy+5sIXfXrISWgSkuudVlS+SrnIPM7ihlba7Tr4OZgxC1ZudndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115442; c=relaxed/simple;
	bh=F1htipO/AhtlOclsgkW5hJfJbVBa6guymt5cUS8NAXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYuFSPiQ9CqNTEtCY/xRUNhYQqntGwIrYKu25VajV5Ul1fS3KVNkUDcCfoZ+wkPTeO+SjWH824AdpMzZqX3+LT+nTxdwywgeRnM7+Za3yIQ8hz3jK6Mdg17dG9QDNK+dRw1plXmeRkfoYBd/1OO6sG+09MiyOEZV85P4Wajh7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aet7JhT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF7EC4CEED;
	Mon, 21 Jul 2025 16:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115441;
	bh=F1htipO/AhtlOclsgkW5hJfJbVBa6guymt5cUS8NAXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aet7JhT/3Cg+XD7nELXupEFsMsvRiPNuvnx+JJTECPvjMrYt9Ru2s1iZRx3Hh4I4h
	 odjxWCZ/Si7eLBYIi2tqfJ5ngyQNpMfp9QFki9LyCbTdyYfDv30ZSUyO5QElZFAEAs
	 7+in80aS55d9YsYrRIxf/C/BmAJyDwzh/uhyn4bnOe7DzZxQ0OarAmOPWfhUwkkNuW
	 CbGISHcMbTPl4Xm8W1mLRGicvZbyD8rH9YTgebKA4IHJEE3XM2rIFC5I5nytloru2u
	 5+pXjJUI4JFyg1/1N52anhJgTpu10hHVOGXKnkAx/HGFnP0wPncdD2tZPrYXJ+dGvr
	 lHIHF90J/Z8UQ==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: ignore migration request to invalid nodes
Date: Mon, 21 Jul 2025 09:30:37 -0700
Message-Id: <20250721163037.9920-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721152828.423605-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 08:28:26 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Sun, 20 Jul 2025 11:58:22 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > damon_migrate_pages() try migration even if the target node is invalid.
> > If users mistakenly make such invalid requests via
> > DAMOS_MIGRATE_{HOT,COLD} action, below kernel BUG can happen.
[...]
> > Add a target node validity check in damon_migrate_pages().  The validity
> > check is stolen from that of do_pages_move(), which is being used for
> > move_pages() system call.
> > 
> > Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion") # 6.11.x
> > Cc: stable@vger.kernel.org
> > Cc: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> 
> LGTM, thank you SJ!
> 
> On a side note... This seems like it would be a common check. However, doing a
> (quick) search seems to return no function that checks whether a node is valid.
> Perhaps it would make sense to look deeper and see how many other functions
> make this check, and export this as a function? I can try spinning something
> if it makes sense to you : -)

My humble impression was that this check is short enough to be ok to be
open-coded, but please don't be blocked on my opinion :)

> 
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thank you!

> 
> Sent using hkml (https://github.com/sjp38/hackermail)

Thanks,
SJ

