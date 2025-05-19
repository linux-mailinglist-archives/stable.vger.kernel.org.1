Return-Path: <stable+bounces-144760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB49ABB9FC
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D271887FD9
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDE326D4D8;
	Mon, 19 May 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iE+XGRYS"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EF226D4DC;
	Mon, 19 May 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647550; cv=none; b=X92Ni/3H+Ct4eC0hZSKEGV0Lnk0fLvRhk1rvus7LnRARjQYwxuTSY8OeLVREBW8oH0k/0ZG8U/GMcmlJksr8vQLrYVk0M6im6cqcJuCWWbdw4BxiltLoJzIcwbDn04a2GB8ySlwk0frRdr5wTC4WbivyZ4I28+deSMNk06ThR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647550; c=relaxed/simple;
	bh=Q3jbe7vgCBhIhpDUXSphYx3LHQa/1syNw4eKb+MmUT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIGQi+DY+xS9hQAdn75irSx8/UlVEwWRVed0M/rtA3lWJQD8zCMDRTY0FUpd84M1azfkUgpoWDi8zGm/auaiADFYEsTOz2NuLYFkaaXR6U+coXuvBeWYf+N1VJTGlyQXkOvKAEA6GRw5xFUBr6iGLLQ4j/9TxkFmEunCAS0sOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iE+XGRYS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4vyZVyTQ0wc3N+1J78WxeomElLxUA/OG79TuTgtbMwY=; b=iE+XGRYShtBlMrihxcE/mw2oVv
	BfxtMqQ0Juq+rq9mbPPhfFp2C6M8n71uAT5mpfxxHsEJ4anZtL/PSXusg23nXC273gwjJq5QnDpGZ
	8dB5iEMK7HTwVq61HDB0zRBATyeA2/veYaZkKs7kJj4UBWf27Ku5TusVLa67D0fqp6520u3UqqRU+
	IZypwoVwF8OYt8t09+r8NWN8L7D7VUxZH0htZvv6vn/sIMcVlkM8xY6hVhBvJPzPJ3Q/XAhgvzvho
	6JD+YQgBnezkDIoRtbmXz9vvLpgVQKMzyC/BH1+uKhMoJio3cDLdKUfongxkz/IyJcfMNKSOyJCpH
	+5JLqPVA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uGwxV-00000000c59-3wU1;
	Mon, 19 May 2025 09:38:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6093030035E; Mon, 19 May 2025 11:38:57 +0200 (CEST)
Date: Mon, 19 May 2025 11:38:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: limingming3 <limingming890315@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, limingming3@lixiang.com
Subject: Re: [PATCH] sched/eevdf: avoid pick_eevdf() returns NULL
Message-ID: <20250519093857.GC24938@noisy.programming.kicks-ass.net>
References: <20250519092540.3932826-1-limingming3@lixiang.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519092540.3932826-1-limingming3@lixiang.com>

On Mon, May 19, 2025 at 05:25:39PM +0800, limingming3 wrote:
> pick_eevdf() may return NULL, which would triggers NULL pointer
> dereference and crash when best and curr are both NULL.
> 
> There are two cases when curr would be NULL:
> 	1) curr is NULL when enter pick_eevdf
> 	2) we set it to NUll when curr is not on_rq or eligible.
> 
> And when we went to the best = curr flow, the se should never be NULL,
> So when best and curr are both NULL, we'd better set best = se to avoid
> return NULL.
> 
> Below crash is what I encounter very low probability on our server and
> I have not reproduce it, and I also found other people feedback some
> similar crash on lore. So believe the issue is really exit.

If you've found those emails, you'll also have found me telling them
this is the wrong fix.

This (returning NULL) can only happen when the internal state is
broken. Ignoring the NULL will then hide the actual problem.

Can you reproduce on the latest kernels?, 6.1 is so old I don't even
remember what's in there.

