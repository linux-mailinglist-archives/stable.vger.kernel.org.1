Return-Path: <stable+bounces-179023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABE7B4A0B5
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 06:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806014E6A5E
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D073C2DE715;
	Tue,  9 Sep 2025 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncqk3Z4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83796482F2;
	Tue,  9 Sep 2025 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757392213; cv=none; b=fPP1Ea5nvPKO1ydar189gMOmyqTjRtU3EGH85moGVZfBefqjOTFpBlUjpPBg3b0ADTaGJrm3HEeQzOmblEeAYa1VpYmSPvx9au+N++l5I6/FkGTXw3mmaZWxJvOsClIKeMXqyhfUWIFW4NyolJHbUNf7Yb3ziJhBLxCh2r3+/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757392213; c=relaxed/simple;
	bh=XaDrtfjywtQdCC1M0mnTwMYse4SqpKCgiK0eeh290h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eoMCQ9MQTkHnVHW7lMWByRVuUHRqNPlsaUeNfOrAvzgs8KGa1jcLgRhORTU4Is+xoeBYN4mfKdMIBtY8JmHIedoo/O3ay5e9rj9fOgrZRDeCwShS7c2JDZzPgx8NMr2dJPknYFqeJuO+Vl3vaeLo8osWgHdl80GTAAsMK9FSZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncqk3Z4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C88C4CEF4;
	Tue,  9 Sep 2025 04:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757392212;
	bh=XaDrtfjywtQdCC1M0mnTwMYse4SqpKCgiK0eeh290h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncqk3Z4AmlmqjSVH+RnWKfjmcxOmt0Il6EeReuZ2UkrQhoNG95On7Le+Rvyp7HqyU
	 nnPcmGgsRpnP/b/eej6hbxJ0dq7f0CVBWAgdX+fPc88fYU1MvcIVU84kjLyvYld84I
	 FZSk1hn4OiSX+gk4AwzjgpMyugqhyTcWEW5wy5uGY08iYZ9xLFNxsX3VgO0qaxGXWX
	 wMk354AtbW8VjkYR7Zgy2Xw3r2GuYOysRAFs9TXUxLHZtRMye1/QssczFR7YiRD+/A
	 1hoNBcDWHQTiwzJ+SY9BjtpuhXKago+0rV8pjqjMfY4OcgaEyRUgsDesiegTWLBmAZ
	 XRVkozjIbD21g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17-rc1" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] samples/damon: fix boot time enable handling fixup merge mistakes
Date: Mon,  8 Sep 2025 21:30:08 -0700
Message-Id: <20250909043008.8651-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908211845.bfc7299d783c361b10ae810b@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 8 Sep 2025 21:18:45 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon,  8 Sep 2025 20:51:41 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > > > Note that the broken commits are merged into 6.17-rc1, but also
> > > > backported to relevant stable kernels.  So this series also need to be
> > > > merged into the stable kernels.  Hence Cc-ing stable@.
> > > 
> > > That's unfortunate, but the about doesn't actually tell us what this
> > > series does.  
> > 
> > Good point.  The issue is that the sample modules can crash if those are
> > enabled at boot time before DAMON is initialized, via kernel command line.
> > 
> > Would you prefer me sending another version of this patch series with an
> > elaborated cover letter?
> 
> Please just send out the appropriate words and I'll paste it in.

Thank you for the guidance, Andrew.  How about below?

"""
First three patches of the patch series "mm/damon: fix misc bugs in DAMON
modules" [1] was trying to fix boot time DAMON sample modules enabling issues.
The issues are the modules can crash if those are enabled before DAMON is
enabled, like using boot time parameter options. The three patches were fixing
the issues by avoiding starting DAMON before the module initialization phase.

However, probably by a mistake during a merge, only half of the change is
merged, and the part for avoiding the starting of DAMON before the module
initialized is missed.  So the problem is not solved and thus the modules can
still crash if enabled before DAMON is initialized.  Fix those by applying the
unmerged parts again.

Note that the broken commits are merged into 6.17-rc1, but also backported to
relevant stable kernels.  So this series also needs to be merged into the
stable kernels.  Hence Cc-ing stable@.
"""


Thanks,
SJ

