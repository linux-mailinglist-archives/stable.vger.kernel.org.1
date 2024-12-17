Return-Path: <stable+bounces-104430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187F9F4351
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D278418890A5
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35D155759;
	Tue, 17 Dec 2024 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K32sQapp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7618E20
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415882; cv=none; b=DKC2oy65vZIbILm0rkzD0S6ZgghGg5iA8rlfDxYKRhlW26+bIuZgjLGaKniYPKo/OZUbbAEmO9eC/TrL3ZQmqeNc1YJ66+wKBMJk1kLSCy1lTs2Lh6G1dXMCCy7lpSIkV8ltnsGiQZwa3I4BotAWfaJh7cO4mLf6GHVK7EtJ1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415882; c=relaxed/simple;
	bh=xXkBxzM3g5zbU10TqJpBXxsh80nLv79U+nm1WTFgl4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHJWOTtUzHTJJk6FU38NgKjWXJkWE/H6dozpimoqfQxf29lL79aK4gHn5zFXrYzlQuf1KPcPFsriS7SMexsgger3MK7S90NAg8eoNvve6Emg92tbXZDNMQ0qBo/K2Cdw02ubxX0PxzuSceQmHrEHh56ascUh1tnPYvy0vVDBpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K32sQapp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d161947so2291928f8f.3
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 22:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734415878; x=1735020678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJLYblhNWxDB0QFjoaq9hD7GmTkXcbnZK/GrTq1z9W4=;
        b=K32sQappZ1r6TgSf/H1R/eWzkzFJX5P9vsTcD7Pt08JdoudT4QUbbmWa0YV7hgZyQ7
         jS5xQB4Q9dO7C1AKwu5Z7XaIXt7FUfT9AQdwceLXbcMUa9jEH8aS9GHVYWF4fuwF+ekp
         CtplYfT2VJM+pVNM2QrfdFlh1Esek6MWvOgIHLJ89/NxKjYNo0aPALHtbcvfH2M6hQlr
         5vEn6GeoYIa3Sx5662GpFoqtCaB+u4/chMdVIy8f6hKVtAWQ7iciJ4mk00HIlzaeZ+gg
         JYUj4Z2LIkonROgDfH2HjPUhlkHWdC12y6R2lefDwVa5Bb0RrIFOtiUJnlHa+Hd0m+aA
         q2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734415878; x=1735020678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJLYblhNWxDB0QFjoaq9hD7GmTkXcbnZK/GrTq1z9W4=;
        b=muZYxcybbEZl155zf99AR0e7vev3KeQcUlJenHudhtbuo088R+y0dGo2d7rDcg5TAR
         vhx09a2nuMwmgenCgtVhsES8b3SJHSA8vp408VL4dhdnMX/NAXNC4celKa/ZOc4C6LVu
         hN/uTBPRdsoVr327UJ+gFxuIBULN25wfvpUCtxTEBQFQIwwgjmEa3BL6hK0osjXQsavG
         2vvsEXUEw+At9RfzAFQXfWMVsQX50PDJFAi1rDoiJ9wn0MEYjcIwM5WUYStq9zOSCym+
         3Fit1vyQqbznVbRJfaAcPM3pC2G6hfC6X3tev7y2Ilo6ukgJNrnXoMKPv4wpg4SB5mMu
         iXyg==
X-Gm-Message-State: AOJu0YwNh7fIwNFRv5LXNEqEOrVCuklIsRmfZw8BdPnJWMPSu8V/3K8j
	b/Eby8cbVFSsbClw0Yb51eNgxsgnc++RQRajzUENQQ/aAKYCa+AjTFLoJBYLHq0=
X-Gm-Gg: ASbGncuQoxt8pWP4pVP8HDelDk7SsdNG4TXlXnQ2woF+QeZPp7RMlS+T66+IUXuWtQq
	SJ8iHKUynVxGECTxdQRv4sFwIntEtDU05kT5gpk0ieiXrJFY80pA73zsY/XByVm9U6Lf5dcw62p
	1pdnJjmMVVSvQNuta4k0uYUtWz9tMF9IvnBt6ys2z0MI3IMT1e3EI9ZqD2p7IYsJ+1gIXfPdZmO
	H+u+5kZAJvRGukjXF7r8IJMK9h53VnDDYMn6O5BXa9Vw+7fnU6W
X-Google-Smtp-Source: AGHT+IEFhLBks+29An8gzjkcG91MuCq2pRyz9sQLoNdtcokHJDVy8PEb4L65GNq+IPZioTlAGrF9PQ==
X-Received: by 2002:a05:6000:144a:b0:385:f417:ee3d with SMTP id ffacd0b85a97d-38880adb3c3mr10854882f8f.35.1734415878161;
        Mon, 16 Dec 2024 22:11:18 -0800 (PST)
Received: from u94a ([2401:e180:8862:6db6:63ae:a60b:ac30:803a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc486sm52006075ad.67.2024.12.16.22.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:11:17 -0800 (PST)
Date: Tue, 17 Dec 2024 14:11:11 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Hao Luo <haoluo@google.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Hou Tao <houtao1@huawei.com>, Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: Re: [PATCH stable 6.6 0/8] Fix BPF selftests compilation error
Message-ID: <xnglf7xxm5q5bwcrilbzghsbzsmpjsyddjtmb4kosyvz5fphse@ub3udgjibsi6>
References: <20241126072137.823699-1-shung-hsi.yu@suse.com>
 <Z0dGtWhX9kdsm2IJ@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0dGtWhX9kdsm2IJ@sashalap>

On Wed, Nov 27, 2024 at 11:20:05AM -0500, Sasha Levin wrote:
> On Tue, Nov 26, 2024 at 03:21:22PM +0800, Shung-Hsi Yu wrote:
> > Currently the BPF selftests in fails to compile (with
> > tools/testing/selftests/bpf/vmtest.sh) due to use of test helpers that
> > were not backported, namely:
> 
> What was the offending backport? It might make more sense to just revert
> that.

- for __xlated() it is commit 68ec5395bc24, backport of mainline commit
  a41b3828ec05 ("selftests/bpf: Verify that sync_linked_regs preserves
  subreg_def")
- for netlink_helper-related error " netlink_helpers.h: No such file or
  directory", is should be commit e41db26543ef backport of mainline
  commit 5f1d18de7918 ("selftests/bpf: Extend tcx tests to cover late
  tcx_entry release")

For __xlated() I think we just need a refresh patch that removes its
use, the test cases should function without it albeit at a reduced
coverage.

OTOH for netlink_helper it's probably simpler to have it backported
(note: there was the precedence of b02372814ad6, but that's related to
netkit, which was not in 6.6, where as tcx is in 6.6).

I'll send a new series which the proposed changes.

Shung-Hsi

