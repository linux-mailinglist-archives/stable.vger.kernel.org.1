Return-Path: <stable+bounces-204183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC0CE8A7E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 04:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B76DE3011A6A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB08192B90;
	Tue, 30 Dec 2025 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pkyu2x1y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59785EAE7;
	Tue, 30 Dec 2025 03:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767066325; cv=none; b=Y3bK0lGaHs2dtOx5rW2m6DkpwotPv2zMX/cXX2wOdD+S4LCChQwnOJ6Xj4HH4Ah2/NaIl0KJRh7DISI4gzgVB7IvcuxX60S+f2qcdm578cz78LdX53Fw6kQM1XQmfCVfS4zq+KEfmHXOrJzC/Vq14dxUYoKt0tEknQZaq7q7bfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767066325; c=relaxed/simple;
	bh=7hTn6XLuotVM0ay7KF0gp/Y77dKrAK/9QRLqPA4o/Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPGh+p4/Im9zk/tSGPwV5okHoa5hanBGUUcon31gAi97ckK3JPPTwg7z96yOOWninBS2vNQWDaobKePF7JRPPLuyaqUiZH1RVGvuIppw4WeXiHwLIXWab19ipk8hIXkF+4Xc0ngJ2eJEIhFrXUfHiXzyo6xEScd3WQXbGPEZsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pkyu2x1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F02DC4CEFB;
	Tue, 30 Dec 2025 03:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767066325;
	bh=7hTn6XLuotVM0ay7KF0gp/Y77dKrAK/9QRLqPA4o/Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pkyu2x1yY9ChEhz+A4uqDHEzEsGSRK9WjQecxK+ot1Vv8kvrDikE1/PzUq8kPtOMj
	 MAE5AA4UPEtxFHCevYUprh32lc/34a6Ss1S6ZU2daY/gIHSVq7SgtAoe5kA6QoCb2M
	 SJfGy51DO4zPdPl5twfcpPcI06Q9OsUeOnZER5yvv6d/lvmo4s/eGjZ4ce8p16fluq
	 a2R4tiBycE3ekeAJoum69QIx67GLz82TuSH6TuzveCQQ5JsqNyWPhnHDBDw6+QGtKl
	 EW4VOzBGHZnzm1OARpZ8yZsVcpciM8ofoBI7g5zLPSOSspMRMZDfe+sppChQrBk9eJ
	 v5pVAM9vCXOdw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 14 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	JaeJoon Jung <rgbi3307@gmail.com>
Subject: Re: [PATCH] mm/damon/core: remove call_control in inactive contexts
Date: Mon, 29 Dec 2025 19:45:14 -0800
Message-ID: <20251230034516.48129-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230024129.47591-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Dec 2025 18:41:28 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 29 Dec 2025 17:45:30 -0800 SeongJae Park <sj@kernel.org> wrote:
> 
> > On Sun, 28 Dec 2025 10:31:01 -0800 SeongJae Park <sj@kernel.org> wrote:
> > 
[...]
> > I will send a new version of this fix soon.
> 
> So far, I got two fixup ideas.
> 
> The first one is keeping the current code as is, and additionally modifying
> kdamond_call() to protect all call_control object accesses under
> ctx->call_controls_lock protection.
> 
> The second one is reverting this patch, and doing the DAMON running status
> check before adding the damon_call_control object, but releasing the
> kdamond_lock after the object insertion is done.
> 
> I'm in favor of the second one at the moment, as it seems more simple.

I don't really like both approaches because those implicitly add locking rules.
If the first approach is taken, damon_call() callers should aware they should
not register callback functions that can hold call_controls_lock.  If the
second approach is taken, we should avoid holding kdamond_lock while holding
damon_call_control lock.  The second implicit rule seems easier to keep to me,
but I want to avoid that if possible.

The third idea I just got is, keeping this patch as is, and moving the final
kdamond_call() invocation to be made _before_ the ctx->kdamond reset.  That
removes the race condition between the final kdamond_call() and
damon_call_handle_inactive_ctx(), without introducing new locking rules.


Thanks,
SJ

[...]

