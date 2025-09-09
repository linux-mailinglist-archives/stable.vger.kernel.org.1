Return-Path: <stable+bounces-179017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81752B4A05D
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 05:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D0C3AEAED
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 03:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24FF264636;
	Tue,  9 Sep 2025 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBxgxzOE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774AD255F27;
	Tue,  9 Sep 2025 03:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389905; cv=none; b=Cz/S9K2NbyEWBs976eTj8nF3hy+FSMOo9ynw3OVsD7wZzbD4eEAEKhWozeUKEIPZHuwAFLkqfRHH+F4fAGnCZjOX7t6tZjAxwH0rcTk0hQIFL3iBfL99+35RJRXVjrRTA4pLAd3+xvHWwESJzm5898h4XTVaMJ7FEbnhzBRUusQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389905; c=relaxed/simple;
	bh=hDFSqIoDGm+oeOAZ9q443ZWBkCIE3hQkRhHMZyq47fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3sIqudagcJbYvIO2Sco37fHqiZ5Nrdc1GgRrxpzTdOu2myJP2R5GPEfKoagffIggrWkpLZKqFKMWCBZz8IgOAufkKznu5YS496H4H2TDnIRaXZVjzRMc09uyS3aF/Mk+D1Unv47qTDeflxw07yvv8VJIoyzWgzeeeLayTZuc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBxgxzOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6069C4CEF4;
	Tue,  9 Sep 2025 03:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757389905;
	bh=hDFSqIoDGm+oeOAZ9q443ZWBkCIE3hQkRhHMZyq47fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBxgxzOEa8Ac6u4NfIJZg7uvYs9srT6Cy6snFEvxalwi+d2+6suPkVf9VfqXgfDcc
	 JlcT0Q2YpAFnYky/zbHUDTmhp4KPF5M/taeWvmOUGamiJuPnnxVp7A7ydYwx6Ze8Z3
	 BFTHiDwU/RdL3NfWk9uT3DMra1l/NgC50To6cwWVdqfyEO+jEwKlSEIsZvz7qvo7PR
	 +P+WMi8LelFiKdOv04IW/kXl50UZsCYPBmiTg+jaKTruDc4//pRE6p6OZ0aoTz1eky
	 K+xL55w8cQw6Pvkk95z9e69KgSjNLDJEWHMcRI1opEaT5utpHCwFqL/biZlW8AeBlz
	 HCctCpmAXk01Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17-rc1" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] samples/damon: fix boot time enable handling fixup merge mistakes
Date: Mon,  8 Sep 2025 20:51:41 -0700
Message-Id: <20250909035141.7545-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908193548.a153ef39d85cc54816950f71@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 8 Sep 2025 19:35:48 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon,  8 Sep 2025 19:22:35 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > First three patches of the patch series "mm/damon: fix misc bugs in
> > DAMON modules" [1] was trying to fix boot time DAMON sample modules
> > enabling issues by avoiding starting DAMON before the module
> > initialization phase.  However, probably by a mistake during a merge,
> > only half of the change is merged, and the part for avoiding the
> > starting of DAMON before the module initialized is missed.  So the
> > problem is not solved.  Fix those.
> > 
> > Note that the broken commits are merged into 6.17-rc1, but also
> > backported to relevant stable kernels.  So this series also need to be
> > merged into the stable kernels.  Hence Cc-ing stable@.
> 
> That's unfortunate, but the about doesn't actually tell us what this
> series does.  

Good point.  The issue is that the sample modules can crash if those are
enabled at boot time before DAMON is initialized, via kernel command line.

Would you prefer me sending another version of this patch series with an
elaborated cover letter?

> 
> > [1] https://lore.kernel.org/20250706193207.39810-1-sj@kernel.org
> 
> Presumably it's in there somewhere?

You're right.  Both the cover letter and the individual fix patches (first
three of the series) describes the issue and origin broken commit.

Please let me know if there is anything I can help for this patch series from
my side :)


Thanks,
SJ

