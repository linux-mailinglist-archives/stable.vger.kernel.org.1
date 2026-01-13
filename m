Return-Path: <stable+bounces-208295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC0CD1B34E
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 21:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB0B3027DA4
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36D21ABAC;
	Tue, 13 Jan 2026 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYg/Seaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD850094C;
	Tue, 13 Jan 2026 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336238; cv=none; b=AJpoEzbKBG4ejK5VVykBonFJG/QLEFkmO03OY1RVvoilePR+tFtqE+aJn7+ogzyvrnLCA+NVlISudN4FL9pCJi4WR7SOcnyICzK6PFHSoSMAhJYt3zXSBR4bYqNtCuf2/jClvpBC1iz6VcQstiVI2B//mnrtk/H1V3YHFtrMXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336238; c=relaxed/simple;
	bh=Sihjm+ikTVFR+ea0zy0/V6dFHxtfUgZsis7BjlplsWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga14MZG0k/Lvcmt+rt6GgNCNl0PIXG6c+VlYWhbXix5avnfxrBLGa3dyHLizgXPahQnzd+/RRZxm+F/Xc0IMlApFsNIOzCJRjDpNm5ufzT6nfL/J9Uzug6Z31LX04sVgRLn83j5s44AAwBKDFGrXcVqXQwHrFVnETQv+EVHRtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYg/Seaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D847C116C6;
	Tue, 13 Jan 2026 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768336237;
	bh=Sihjm+ikTVFR+ea0zy0/V6dFHxtfUgZsis7BjlplsWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYg/SeaqyBfhQ4J0wPlwVtJGCvOPIukQs7iE4izehrK9GBk361/9SyRt1OmG8VdgI
	 2XqH28R+wk3Zu82r0bD+UnNRsq5Z7ouUsrd+Fsi3U6XBf88VV0Fb+yKZewe6VlVjoO
	 VJ8mejAL/D1GPIrwlVGX+ofIE6V5ASZa1gl08c5S24ZZ1TSN4Znmz0BOdJpTi5qoEe
	 vNOnbKxpj3I8awHIJiLNqCkFNJjP4uuZvbV33PhcWuNgGy7hk4oYf5QtYNnMbT0ANS
	 Zh03B6zY/9XDC4aKuuYHYYudL/eSFLbziLyaZaPCozI4yBofm8JssU8Vx6WtPsBwo9
	 /7zOV5aEhoXfw==
Date: Tue, 13 Jan 2026 17:30:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf Documentation: Correct branch stack sampling
 call-stack option
Message-ID: <aWaraqlO-swgAdY8@x1>
References: <20251216013949.1557008-1-dapeng1.mi@linux.intel.com>
 <e2a105fc-8b5c-4c7d-ba29-de8bb560cc85@linux.intel.com>
 <aV9LVqqrhfW6DfbQ@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV9LVqqrhfW6DfbQ@google.com>

On Wed, Jan 07, 2026 at 10:14:46PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Jan 07, 2026 at 08:58:53AM +0800, Mi, Dapeng wrote:
> > @Arnaldo, @Kim, @Ian
> > 
> > Kindly ping ... 
> 
> Sorry for the delay.

Ditto

> > > Cc: stable@vger.kernel.org
> > > Fixes: 955f6def5590 ("perf record: Add remaining branch filters: "no_cycles", "no_flags" & "hw_index"")
> > > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo

