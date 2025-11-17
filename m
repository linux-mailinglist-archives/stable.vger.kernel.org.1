Return-Path: <stable+bounces-194992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD00C652DF
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43C1E38486C
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773362D23A4;
	Mon, 17 Nov 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJQhwmxx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784F1C54A9
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396826; cv=none; b=fPyoXYIBcdpq+msqNeY6hA9VynVJlr544N3PVSJKshbRlO9HBlTAq24wrEJRWEvsxTaprkiYY1/ilvxTVM7kQ/MgofR6zz2RM4CzTPc0XKtvfk/1BuXUaZ3gl9qHCiAb4HZExkuhAux5s4O3g/XvsDSAQ0nI91ouFsg6qIBdIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396826; c=relaxed/simple;
	bh=yzYPZrpd44Gl4vB2cKVLqUa5FT5oZQOkbshwmkivACY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMwrVCfZ78jXMpAzXtwj8npGWuyX5v4AprIRnTASXGc3iB+HJEoKGehEZVlVkVvw8N6DxrzefR+JzQ6plqosZHbI5xqyHgRCmknFo0uWe1TXfst8WTV/AUiABcCh/Xx0t4DGKrNbF1ZkUcl2V6pwhWMyl2JYCmy8ZyFfZiq8MoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJQhwmxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC99C19422;
	Mon, 17 Nov 2025 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396824;
	bh=yzYPZrpd44Gl4vB2cKVLqUa5FT5oZQOkbshwmkivACY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJQhwmxxzWApRvtzN9sZORf7QXn+PPnnQKoSn2MPABopK3Hw5mOv13WMGaEpKNQYw
	 VCNsSlnKzzyxmN2YkR7xYAZALeAMQ6yQMl0DnNO49zHSj4ale9WIL/+vROkOjByF3G
	 G5rUMfXBChGFER0lKNYQjeprQ4IL9hrVeCvRBxCMWmk7d0qdEHyzcQy8ZvCQalwn1h
	 RCCE7ad+FgNZvBcWsaZkdEAC5b7g6zw1mPQIgADGkrRIjE0tVjJynPXfxQLPgSfShV
	 +QwGtSE2FN8nN5NKYSaCGvCkNOUBAMhS2qnDEeX70Ic1jpJpXVz+2Xkm28swVcRtv4
	 Z4t1OXGCqsNRA==
Date: Mon, 17 Nov 2025 11:27:02 -0500
From: Sasha Levin <sashal@kernel.org>
To: Max Krummenacher <max.oss.09@gmail.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
	Ian Rogers <irogers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: 6.1.159-rc1 regression on building perf
Message-ID: <aRtM1qdOprtHrw4n@laps>
References: <CAEHkU3Vr4RVG1Up1_cnoV70QRaYrRXW8ONCMOBB88F+Cu7WRuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEHkU3Vr4RVG1Up1_cnoV70QRaYrRXW8ONCMOBB88F+Cu7WRuw@mail.gmail.com>

On Mon, Nov 17, 2025 at 05:00:39PM +0100, Max Krummenacher wrote:
>Hi
>
>Our CI found a regression when cross-compiling perf from the 6.1.159-rc1
>sources in a yocto setup for a arm64 based machine.
>
>In file included from .../tools/include/linux/bitmap.h:6,
>                 from util/pmu.h:5,
>                 from builtin-list.c:14:
>.../tools/include/asm-generic/bitsperlong.h:14:2: error: #error
>Inconsistent word size. Check asm/bitsperlong.h
>   14 | #error Inconsistent word size. Check asm/bitsperlong.h
>      |  ^~~~~
>
>
>I could reproduce this as follows in a simpler setup:
>
>git clone -b linux-6.1.y
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>cd linux-stable-rc/
>export ARCH=arm64
>export CROSS_COMPILE=aarch64-none-linux-gnu-
>make defconfig
>make -j$(nproc)
>cd tools/perf
>make
>
>Reverting commit 4d99bf5f8f74 ("tools bitmap: Add missing
>asm-generic/bitsperlong.h include") fixed the build in my setup however
>I think that the issue the commit addresses would then reappear, so I
>don't know what would be a good way forward.

Thanks for the report! I could reproduce this issue localy.

Could you please try cherry-picking commit 8386f58f8deda on top and seeing if
it solves the issue and your CI passes?

-- 
Thanks,
Sasha

