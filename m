Return-Path: <stable+bounces-225683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJp1MmBbuGk7cgEAu9opvQ
	(envelope-from <stable+bounces-225683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:34:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F9629FD4A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA1DA30297A3
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B23E717B;
	Mon, 16 Mar 2026 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOTDcPAN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91ED1A9FAF;
	Mon, 16 Mar 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689691; cv=none; b=NQdPvkH/sQ9Z1YjCNjJ7gMrsO7zWdpB1gYFv5QEc8q72zvKzUyUDt2LIBDUpCxEfS62g2ZjC8h8g/ry7fZYWGuvFdxdVFfXRkOWDzR6AoaztuzgXC4uiG/TGaIEisz4nUvK3zKmu6/5C9FP1lS8y1/36W06J962Njhs4JtSh8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689691; c=relaxed/simple;
	bh=ypMADP71DX2Iy1YOt9Ke+EpLL8A4YBFUr74ekNFQ57U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ensnkZpFgNdBzeKPqkLBdCgG3c5G9EqqjmMcWGvyQgCmLh8Xl4e15gwBKvGQzeC+rZJXs66v2R73AxHKvvaaddc14wbe+ApOxGsOBCht6g884FBCLyIHLkIlSX3uS+LHQpYdExwdstJ9zeUdrK1dXsHxSTVsGobuKiRvfVdjnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOTDcPAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55360C2BCB0;
	Mon, 16 Mar 2026 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773689691;
	bh=ypMADP71DX2Iy1YOt9Ke+EpLL8A4YBFUr74ekNFQ57U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOTDcPAN27JEc0aoYvLAzmR+L1LIxNUknSz4dQ1rJSa02UmlZG3h8g8cd9j4r51pC
	 YRrUzY3/OA0NehmrglV+le3T7pHax2YBcDVljkFi5zLAcFP7lyRw/UNr/CxbHotPdS
	 R2ScqitwzblTJF4bxXgZ1eJq3+oEOvNf+9/Mob/HJiUPkagnLKyMSz4DpRJRdJHUYq
	 RsSwrEhz6+OtOQXBrxGaAHK/5brpTdYOP93RIdxL9vg5MUD6vhp+K3JP/RTta0TZ1R
	 8V5r2SZ6dRkRH1XmkRnVsc+rCbLCp1YpLQPiHyChBXxgo38oqG/ebKa3bve8U+uf7t
	 2baotgtsoaBVw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon/stat: monitor all System RAM resources
Date: Mon, 16 Mar 2026 12:34:49 -0700
Message-ID: <20260316193449.6053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316102539.2af039f5ca7ce1164da34b47@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225683-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31F9629FD4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 10:25:39 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sun, 15 Mar 2026 09:27:15 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > DAMON_STAT usage document (Documentation/admin-guide/mm/damon/stat.rst)
> > says it monitors the system's entire physical memory.  But, it is
> > monitoring only the biggest System RAM resource of the system.  When
> > there are multiple System RAM resources, this results in monitoring only
> > an unexpectedly small fraction of the physical memory.  For example,
> > suppose the system has a 500 GiB System RAM, 10 MiB non-System RAM, and
> > 500 GiB System RAM resources in order on the physical address space.
> > DAMON_STAT will monitor only the first 500 GiB System RAM.  This
> > situation is particularly common on NUMA systems.
> > 
> > Select a physical address range that covers all System RAM areas of the
> > system, to fix this issue and make it work as documented.
> > 
> > Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
> > Cc: <stable@vger.kernel.org> # 6.17.x
> 
> This doesn't apply to current mainline?

Ah, you're right.  Sorry for this noise.

I will rebase it to mm-hotfixes-unstable and post it as v3, by tonight.  If you
prefer mainline or another tree other than mm-hotfixes-unsable as the baseline
of v3, please let me know.


Thanks,
SJ

