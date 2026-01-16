Return-Path: <stable+bounces-209979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9085CD2A0C0
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 03:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BB1A30115CA
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1A338594;
	Fri, 16 Jan 2026 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPTDAJ13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA3264A9D;
	Fri, 16 Jan 2026 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768529923; cv=none; b=XG3a4DwbeBrikzqXNpjzEEI5h+HFSt25owu0i2aGCOTUEtDbc34DikMXPz8L7smqOkNOsimr7CjydjoCKcr/A3DhXxkT+r8917ruxxK2ffdYcQKyQDuT848xbywNO8hNpHDaTm6+KoD04uJqRm6NXQFhLxV60dk6cfLbMT+ZIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768529923; c=relaxed/simple;
	bh=xGlwY78YgnNbg3yS+LVBBKRA+TOB2qhqnJXMmBJVQWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/d4LLxvLLOiE18CblZ8sI+ToaaVYMfoU5+HLvBrb78v8FIL8u+1NgCpjmm3rxQ/MfXzThQjITUfOcsw2TgXpWmRvaTAZtMiBlX/MB2uuBFhGigiXPCFNxTnVjsM/6CzYoiF/nOWk9TnEfSth7mzAgBbhvbIyml+DV2LrmvIk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPTDAJ13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61F3C116D0;
	Fri, 16 Jan 2026 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768529923;
	bh=xGlwY78YgnNbg3yS+LVBBKRA+TOB2qhqnJXMmBJVQWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPTDAJ13Mve+x1u8jgmEeoGS4WDvjrP7KrYW3HxmWZTXqVCi2dJc/rOgv7H8ds82O
	 1R8PeGdcoXBmm2psxQlZpWlh2m49WiwjtZLwMTsNT0EHfgvAI0AwHdC6g42Kd5Yewx
	 SoHzScXpKaMLMaZfklq2B7rFUv5qXKYYnKSa/wKDVQbDVtfZs5Ao//PgCMJDSFY8N9
	 jCHeKQdjx8pRw15XfLbtf7Qu10HI4vKTbL9pYNjGwtHfF+ermolFnR2P//PwHyq3AL
	 vTBVyrwR4v1cbFm1S782F5numkyOC1890a1zxTgvh1lSOI2BL41urUp5qaFuU9MaAx
	 jVUzMSdqDs2Lw==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	akpm@linux-foundation.org,
	kent.overstreet@linux.dev,
	corbet@lwn.net,
	ranxiaokai627@163.com,
	ran.xiaokai@zte.com.cn,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Docs/mm/allocation-profiling: describe sysctrl limitations in debug mode
Date: Thu, 15 Jan 2026 18:18:34 -0800
Message-ID: <20260116021835.71770-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAJuCfpEQZMVCz0WUQ9SOP6TBKxaT3ajpHi24Aqdd73RCsmi8rg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 15 Jan 2026 09:05:25 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Wed, Jan 14, 2026 at 9:57 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Jan 14, 2026 at 09:45:57PM -0800, Suren Baghdasaryan wrote:
> > > +  warnings produces by allocations made while profiling is disabled and freed
> >
> > "produced"
> 
> Thanks! I'll wait for a day and if there are no other objections, I
> will post a fixed version.

Assuming Matthiew's good finding will be fixed,

Acked-by: SeongJae Park <sj@kernel.org>

Fwiw, the typo is also on the .../sysctl/vm.rst part.  And from the finding, I
was wondering if it is better to put the description only one of two documents
rather than having the duplication, and further if the 'Usage:' part of
allocation-profiling.rst is better to be moved to
'Documentation/admin-guide/mm/'.  But I ended up thinking those are too trivial
and small things.


Thanks,
SJ

