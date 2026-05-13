Return-Path: <stable+bounces-246757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNR0HkQXBGpLDgIAu9opvQ
	(envelope-from <stable+bounces-246757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:16:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A252E00D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3E613031F5A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70693382DE;
	Wed, 13 May 2026 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mAumR7Sr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256323D1A86
	for <stable@vger.kernel.org>; Wed, 13 May 2026 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652988; cv=none; b=WBSjKIHKoItOZqlXi0ftaZ+Ji0yCp0ywDcNu86RtakCSNDRE/XhH6qiaWT17shsYinTiMEy0zDhvdgMipgqothK1xErBXvnMGt+qgg+PILu81oUkNFUMhpAVSC2KfnuveWSlMKUiG/7z6xLtZXuSTWDvgjJB/I/Yq9k0H9xrVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652988; c=relaxed/simple;
	bh=nMH9bltGHRhs/AbTtr4aKYbvb984xhXoh9kz+aCGdq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIM0bd25Cf3yJNsMMRz8B4BnM/w23UO39J3Rsa/QyULtUBAehKSXhS/wG5j4ub1RXoY8jN7fh7VsWhZpD3sWV6PLmzgT0DEM/g3BxapzrilewnnZQ382TYXJuGSUzokA2vQ+lRLsj8Rryxius7E6MDELI2xOjNmy//4UpXX5Ges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mAumR7Sr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-366375c43c2so3738123a91.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 23:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778652986; x=1779257786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3/NmllfS+SrHzBU2sfiASJiEbjQXEMBJ1jiZMSTpf8=;
        b=mAumR7Sr8eux0/mOniFATpvnCHQ8ketH88GUTpEQNHLcgo7wp+/Q93NnMjRTDvabd8
         hS36UCKddn9kw60Nvon8hirmAfLLq9Qp+Jn7oKH2aovMiuStt2ePARiSpP4BqAuK1EsK
         vKsTyvboCVsi2A2M8YccZzUfzB0UQHtIVKDC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778652986; x=1779257786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3/NmllfS+SrHzBU2sfiASJiEbjQXEMBJ1jiZMSTpf8=;
        b=mNgtddpCxst8p15hoyKYiHImVOwy/uxkm9dzwVBF6zToxs/jorp2+EMCNDM6BwWOob
         WLIvjozKo+sLljwmcwoIFyTuD+luYvSkTnRPxQ14MGfYVV4HpiwiyvT3h+ZC5jSN02M0
         Gcb+5rqgJihChfFDmO/1nZTTldh7p6pQ0b+HyGbOSsQAXK65xIjSZvEDA29KfH/YAV1c
         HOk5y1DHRm1RlcjqxfHX76ddtLLKU0EANU+CfMl5SpqIOx7CKistpUU/17dxJQQtrU6l
         FTMtZCaiyodeDla1OAfMs22FcnRLRcp7nX6WJqbt7ISX0SD0KpvMoo1+fKsBiHOx8x1R
         vRvQ==
X-Forwarded-Encrypted: i=1; AFNElJ93SRWvcqRMZCC7sw6QY9c73esNpXiS/+9lcstQ0tQQpkR00SppsS9j8JQY7Rqy5tzWdAQM92o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUaLAahvgz4shrPcsnXDgGbPtAvHsV3sWV7UjD5fCasgp/qAVc
	SGBe2Ui4ccVpUSO5iY9P6E4N3eYJ6eXWZokvHBSmbY2oekrJRCemoS0z7x/OnPEbyw==
X-Gm-Gg: Acq92OEFLzvkyI4ndmeR7AhNrRA/WoUr1seKTmNNZrIXWcZnnOxcjDGpqQLPunJLWBO
	IrIWf6St30MhYaQYw4E+Y09dxNQk/cuZiHjptmnbKho4ZdStcTbOVGgsolnnIPv3DdK0ynoSdhS
	ip/7+/cptdgEsXTVI2ANYe7KcMhOqlRKUH2fFMBzPRwE6vwBDQ12uDaKwJb136YNC5eFio4L+VC
	uc/btGMdWBP+SQ75gGMcZ7qIlovZPmzoCHXtuSfV7HesyfUs9R+2fZea/Jxs1Tz4HTcx2kCyhco
	8jJxhs1YH4G0wR8F8yRatnNHL7+2DHFu7hZuGMV7PKjI9dmJ18JY1BhXv03/xBf+RL5c676oy9Q
	SEelOPYVYfi8nAXXupVCkjk44h3WWw40fZnYOFit+T9i2+ReWrTCMRei/q/EKQJVzyKQcu1FOBR
	BH/VleDPSeW/33Y1QGZQqrt6rPyfMTAio/sYYCP+MiNy9d/dy+6pehGlKL22/+9ns=
X-Received: by 2002:a17:90b:3c0e:b0:35f:bfdd:f5a1 with SMTP id 98e67ed59e1d1-368f3e680femr2025227a91.13.1778652986403;
        Tue, 12 May 2026 23:16:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:e541:a7ed:e8ee:843c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b04b2138sm1740198a91.9.2026.05.12.23.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:16:25 -0700 (PDT)
Date: Wed, 13 May 2026 15:16:22 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org, 
	senozhatsky@chromium.org, minchan@kernel.org, hannes@cmpxchg.org, gourry@gourry.net, 
	dan.j.williams@intel.com, chengming.zhou@linux.dev, contact.kartikn@gmail.com
Subject: Re: +
 zsmalloc-zero-initialize-zspage-memory-to-prevent-kmsan-uninit-reads.patch
 added to mm-hotfixes-unstable branch
Message-ID: <agQWo3GZfuGMkgn5@google.com>
References: <20260512214850.3AE80C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512214850.3AE80C2BCB0@smtp.kernel.org>
X-Rspamd-Queue-Id: 759A252E00D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chromium.org,kernel.org,cmpxchg.org,gourry.net,intel.com,linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	TAGGED_FROM(0.00)[bounces-246757-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Action: no action

On (26/05/12 14:48), Andrew Morton wrote:
> The patch titled
>      Subject: zsmalloc: zero-initialize zspage memory to prevent KMSAN uninit reads
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
>      zsmalloc-zero-initialize-zspage-memory-to-prevent-kmsan-uninit-reads.patch
> 
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/zsmalloc-zero-initialize-zspage-memory-to-prevent-kmsan-uninit-reads.patch
> 
> This patch will later appear in the mm-hotfixes-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> 
> The -mm tree is included into linux-next via various
> branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there most days
> 
> ------------------------------------------------------
> From: Kartik Nair <contact.kartikn@gmail.com>
> Subject: zsmalloc: zero-initialize zspage memory to prevent KMSAN uninit reads
> Date: Tue, 12 May 2026 03:06:58 +0530
> 
> Pages allocated via alloc_zpdesc() use alloc_pages_node() without
> __GFP_ZERO, leaving physical memory uninitialized.  When a compressed
> object spans two physical pages in a zspage, zs_obj_read_sg_begin() sets
> up a scatterlist pointing directly at the raw second page.  If the second
> page was freshly allocated and never written beyond the object boundary,
> KMSAN detects reads of uninitialized memory downstream in the decompressor
> (e.g.  sw842_decompress reading the CRC trailer).
> 
> Fix this by passing __GFP_ZERO to alloc_zpdesc() in alloc_zspage() so
> all pages backing a zspage are zero-initialized at allocation time.

This is very unlikely to fix anything, we should not have out-of-bounds
reads in the first place.

