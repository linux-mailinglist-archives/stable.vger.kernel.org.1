Return-Path: <stable+bounces-182076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90777BAD2B1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410C11708DA
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C21DE4E1;
	Tue, 30 Sep 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NI29BUNS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044029405;
	Tue, 30 Sep 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242333; cv=none; b=usonVqprfcnOoBQCb4sswC2NX1jJMDpP4PXxHy+zLqL2DxZevhDGu0gkCEiihs5Cnc1OUmbb4fujzf7H+ahKxyI8dgfdc1BzwgMxJjmTpEb6zIDULhoSYtefQd6MlQElteSVA9K+98+EOeiYMyCOePXasMz0m04IAzLhDsnb+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242333; c=relaxed/simple;
	bh=HMMSK0gZE+ZPdzKo8NfDBgzWwBhENlb8Exrqm290TLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRGUHNcmG3UmcZ0WNMkRhOqXxGOcKrPuN8ok2DUkTP3h7ApoTj+9iii/ZBmRh1bNZDh3ILY2dtnz17N1qWy7WSywHfWgjHM7T1OzC1NlDkIzdq1/TXEkGWHr9HqK0jnmqmRlbXR8SmSguJTo7wyk43dc6hPWayDWA2CQcSkP2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NI29BUNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C533C4CEF0;
	Tue, 30 Sep 2025 14:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759242332;
	bh=HMMSK0gZE+ZPdzKo8NfDBgzWwBhENlb8Exrqm290TLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NI29BUNSmUmlWy0/PzEJPq2TmfVCQmImzFJn/FcYBSeWWKE5XbsJW0tLizQmoTw/p
	 /OlTKwzhrKyhEMrmQUtDMBnMDlrDM7g/4abQpV1W9vQsTcWCXCapcEz9uqyGGywsLg
	 2YwX5kxBXUyCDljHtMBWrNn0Gd8wgCi+IsvRjGKA=
Date: Tue, 30 Sep 2025 16:25:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: sashal@kernel.org, mario.limonciello@amd.com, lijo.lazar@amd.com,
	David.Laight@aculab.com, arnd@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH v2 03/13 6.1.y] minmax: simplify min()/max()/clamp()
 implementation
Message-ID: <2025093026-gutter-avert-7f16@gregkh>
References: <20250929183358.18982-1-farbere@amazon.com>
 <20250929183358.18982-4-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250929183358.18982-4-farbere@amazon.com>

On Mon, Sep 29, 2025 at 06:33:48PM +0000, Eliav Farber wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> [ Upstream commit dc1c8034e31b14a2e5e212104ec508aec44ce1b9 ]
> 
> Now that we no longer have any C constant expression contexts (ie array
> size declarations or static initializers) that use min() or max(), we
> can simpify the implementation by not having to worry about the result
> staying as a C constant expression.
> 
> So now we can unconditionally just use temporary variables of the right
> type, and get rid of the excessive expansion that used to come from the
> use of
> 
>    __builtin_choose_expr(__is_constexpr(...), ..
> 
> to pick the specialized code for constant expressions.
> 
> Another expansion simplification is to pass the temporary variables (in
> addition to the original expression) to our __types_ok() macro.  That
> may superficially look like it complicates the macro, but when we only
> want the type of the expression, expanding the temporary variable names
> is much simpler and smaller than expanding the potentially complicated
> original expression.
> 
> As a result, on my machine, doing a
> 
>   $ time make drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.i
> 
> goes from
> 
> 	real	0m16.621s
> 	user	0m15.360s
> 	sys	0m1.221s
> 
> to
> 
> 	real	0m2.532s
> 	user	0m2.091s
> 	sys	0m0.452s
> 
> because the token expansion goes down dramatically.
> 
> In particular, the longest line expansion (which was line 71 of that
> 'ia_css_ynr.host.c' file) shrinks from 23,338kB (yes, 23MB for one
> single line) to "just" 1,444kB (now "only" 1.4MB).
> 
> And yes, that line is still the line from hell, because it's doing
> multiple levels of "min()/max()" expansion thanks to some of them being
> hidden inside the uDIGIT_FITTING() macro.
> 
> Lorenzo has a nice cleanup patch that makes that driver use inline
> functions instead of macros for sDIGIT_FITTING() and uDIGIT_FITTING(),
> which will fix that line once and for all, but the 16-fold reduction in
> this case does show why we need to simplify these helpers.
> 
> Cc: David Laight <David.Laight@aculab.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  include/linux/minmax.h | 43 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)

This change breaks the build in drivers/md/ :

In file included from ./include/linux/container_of.h:5,
                 from ./include/linux/list.h:5,
                 from ./include/linux/wait.h:7,
                 from ./include/linux/mempool.h:8,
                 from ./include/linux/bio.h:8,
                 from drivers/md/dm-bio-record.h:10,
                 from drivers/md/dm-integrity.c:9:
drivers/md/dm-integrity.c: In function ‘integrity_metadata’:
drivers/md/dm-integrity.c:131:105: error: ISO C90 forbids variable length array ‘checksums_onstack’ [-Werror=vla]
  131 | #define MAX_TAG_SIZE                    (JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR - offsetof(struct journal_entry, last_bytes[MAX_SECTORS_PER_BLOCK]))
      |                                                                                                         ^~~~~~~~~~~~~
./include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
./include/linux/minmax.h:56:9: note: in expansion of macro ‘static_assert’
   56 |         static_assert(__types_ok(x, y, ux, uy),         \
      |         ^~~~~~~~~~~~~
./include/linux/minmax.h:41:31: note: in expansion of macro ‘__is_noneg_int’
   41 |          __is_noneg_int(x) || __is_noneg_int(y))
      |                               ^~~~~~~~~~~~~~
./include/linux/minmax.h:56:23: note: in expansion of macro ‘__types_ok’
   56 |         static_assert(__types_ok(x, y, ux, uy),         \
      |                       ^~~~~~~~~~
./include/linux/minmax.h:61:9: note: in expansion of macro ‘__careful_cmp_once’
   61 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
      |         ^~~~~~~~~~~~~~~~~~
./include/linux/minmax.h:92:25: note: in expansion of macro ‘__careful_cmp’
   92 | #define max(x, y)       __careful_cmp(max, x, y)
      |                         ^~~~~~~~~~~~~
drivers/md/dm-integrity.c:1797:40: note: in expansion of macro ‘max’
 1797 |                 char checksums_onstack[max((size_t)HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
      |                                        ^~~
drivers/md/dm-integrity.c:131:89: note: in expansion of macro ‘offsetof’
  131 | #define MAX_TAG_SIZE                    (JOURNAL_SECTOR_DATA - JOURNAL_MAC_PER_SECTOR - offsetof(struct journal_entry, last_bytes[MAX_SECTORS_PER_BLOCK]))
      |                                                                                         ^~~~~~~~
drivers/md/dm-integrity.c:1797:73: note: in expansion of macro ‘MAX_TAG_SIZE’
 1797 |                 char checksums_onstack[max((size_t)HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
      |                                                                         ^~~~~~~~~~~~


So I'll stop here on this series.

After the next release, can you rebase the series and resend the remaining ones after they are fixed up to build properly?

thanks,

greg k-h

