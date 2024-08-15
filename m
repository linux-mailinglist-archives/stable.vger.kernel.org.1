Return-Path: <stable+bounces-69215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606295362B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D511C25225
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21261A00D2;
	Thu, 15 Aug 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUK6lHwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2383214;
	Thu, 15 Aug 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733395; cv=none; b=HU1Qd5q7iaPYjuWe9Upa+C7KMzk3iqY8DW8cpAsvrcZWR1F06/QsUGyk5VURqrh4ZQa3UDpD/3deO2Xi/ue/E5jdfddoaQkyIwhB6RtZ4OtJFrmvD/DIw/AsygsHvOEUqiqRVFYwkhB5KKZBupXKKNJ98nW1Gp//IgfEkng/RaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733395; c=relaxed/simple;
	bh=qLfNEBaIlyfX5Ak8kQTI9NcKIG84tMS17w2AU1H/rOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnfbFiOBiC1bVk33dqikKn3pzub6n68Jv2uiCy5tvhIYOaZs/XF8lZK3cwiFWSW6NCXBeTbYYGlPws1va4DLT8vezCT7nozxf3hj3a2Qottb5Kghh0p1ou9eDBmF1MmzYpa/550D6tkxTONAlKj5rectPkyRBduhsSzlORuE3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUK6lHwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A28C32786;
	Thu, 15 Aug 2024 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723733395;
	bh=qLfNEBaIlyfX5Ak8kQTI9NcKIG84tMS17w2AU1H/rOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUK6lHwvGMG2tKAeU+Q+Wn2IT26gPk5g1u5ihnJxJtOKzWZawGB83AoMsyhz5eymu
	 nPPtFBSbv+FDTwyhjjtFo0l/GMgLpgsAOh6ImcYyEC2a0iC2aoBbBCtU9PYojS6xSg
	 CKozE+FhwtT+CXF+dAevme8UR81D8nqCZ2+LdU8xCH4vRgPHVnf30E3GSbGjpsRqam
	 JwVNcmNP69oESvtR6Mu+XWYfujRtGJf2zRQubjv4l8LnxwnVS7RkVlcC/jp1x09MzP
	 dcFcawkrO44JM6WeTsA0QPuWx+NhEFLYzb5mu+P+uaVLVlklbHg5RsdK+EfaAq2dex
	 SlLQ7qT42a3iA==
Date: Thu, 15 Aug 2024 11:49:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	kernel-team@cloudflare.com, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Yunzhao Li <yunzhao@cloudflare.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf hist: Update hist symbol when updating maps
Message-ID: <Zr4VkBA7eJ8dPqkd@x1>
References: <20240815142212.3834625-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815142212.3834625-1-matt@readmodwrite.com>

On Thu, Aug 15, 2024 at 03:22:12PM +0100, Matt Fleming wrote:
> AddressSanitizer found a use-after-free bug in the symbol code which
> manifested as perf top segfaulting.
> 
>   ==1238389==ERROR: AddressSanitizer: heap-use-after-free on address 0x60b00c48844b at pc 0x5650d8035961 bp 0x7f751aaecc90 sp 0x7f751aaecc80
>   READ of size 1 at 0x60b00c48844b thread T193
>       #0 0x5650d8035960 in _sort__sym_cmp util/sort.c:310
>       #1 0x5650d8043744 in hist_entry__cmp util/hist.c:1286
>       #2 0x5650d8043951 in hists__findnew_entry util/hist.c:614
>       #3 0x5650d804568f in __hists__add_entry util/hist.c:754
>       #4 0x5650d8045bf9 in hists__add_entry util/hist.c:772
>       #5 0x5650d8045df1 in iter_add_single_normal_entry util/hist.c:997
>       #6 0x5650d8043326 in hist_entry_iter__add util/hist.c:1242
>       #7 0x5650d7ceeefe in perf_event__process_sample /home/matt/src/linux/tools/perf/builtin-top.c:845
>       #8 0x5650d7ceeefe in deliver_event /home/matt/src/linux/tools/perf/builtin-top.c:1208
>       #9 0x5650d7fdb51b in do_flush util/ordered-events.c:245
>       #10 0x5650d7fdb51b in __ordered_events__flush util/ordered-events.c:324
>       #11 0x5650d7ced743 in process_thread /home/matt/src/linux/tools/perf/builtin-top.c:1120
>       #12 0x7f757ef1f133 in start_thread nptl/pthread_create.c:442
>       #13 0x7f757ef9f7db in clone3 ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> When updating hist maps it's also necessary to update the hist symbol
> reference because the old one gets freed in map__put().
> 
> While this bug was probably introduced with 5c24b67aae72 ("perf tools:
> Replace map->referenced & maps->removed_maps with map->refcnt"), the
> symbol objects were leaked until c087e9480cf3 ("perf machine: Fix
> refcount usage when processing PERF_RECORD_KSYMBOL") was merged so the
> bug was masked.

Great analysis, thanks a lot, applied.

- Arnaldo
 
> Fixes: c087e9480cf3 ("perf machine: Fix refcount usage when processing PERF_RECORD_KSYMBOL")
> Signed-off-by: Matt Fleming (Cloudflare) <matt@readmodwrite.com>
> Reported-by: Yunzhao Li <yunzhao@cloudflare.com>
> Cc: stable@vger.kernel.org # v5.13+
> ---
>  tools/perf/util/hist.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0f554febf9a1..0f9ce2ee2c31 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -639,6 +639,11 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
>  			 * the history counter to increment.
>  			 */
>  			if (he->ms.map != entry->ms.map) {
> +				if (he->ms.sym) {
> +					u64 addr = he->ms.sym->start;
> +					he->ms.sym = map__find_symbol(entry->ms.map, addr);
> +				}
> +
>  				map__put(he->ms.map);
>  				he->ms.map = map__get(entry->ms.map);
>  			}
> -- 
> 2.34.1
> 

