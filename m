Return-Path: <stable+bounces-7991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE081A3DD
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595EEB26E2C
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FF41766;
	Wed, 20 Dec 2023 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0DqZzqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B334041862
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 16:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FFBC433C7;
	Wed, 20 Dec 2023 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088434;
	bh=LmQNejV7piIHVGJ/pSi2Ed4vdZijU8+vokyGKF9qYqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0DqZzqVZPnT/uS0BPMBWJEktW3Dr6PvBlc7kkcJn/dEOGL0XKGPKDBmTFvLFGvxY
	 EjDfV/yhGcNtrducIdSDrghkeLAfK8CxXuZEjWkKgW07S7lZCuY9qlgvIaXjOAm/PT
	 hbyXviAPwZcxWfDxvSONnQbbNhhCr653C9ZjSEck=
Date: Wed, 20 Dec 2023 17:07:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Stable <stable@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Haibo Li <haibo.li@mediatek.com>, Kees Cook <keescook@chromium.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH for-5.15.y+] kasan: disable kasan_non_canonical_hook()
 for HW tags
Message-ID: <2023122000-climatic-zesty-4d75@gregkh>
References: <20231219084807.963746-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219084807.963746-1-amit.pundir@linaro.org>

On Tue, Dec 19, 2023 at 02:18:07PM +0530, Amit Pundir wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> [ Upstream commit 17c17567fe510857b18fe01b7a88027600e76ac6 ]
> 
> On arm64, building with CONFIG_KASAN_HW_TAGS now causes a compile-time
> error:
> 
> mm/kasan/report.c: In function 'kasan_non_canonical_hook':
> mm/kasan/report.c:637:20: error: 'KASAN_SHADOW_OFFSET' undeclared (first use in this function)
>   637 |         if (addr < KASAN_SHADOW_OFFSET)
>       |                    ^~~~~~~~~~~~~~~~~~~
> mm/kasan/report.c:637:20: note: each undeclared identifier is reported only once for each function it appears in
> mm/kasan/report.c:640:77: error: expected expression before ';' token
>   640 |         orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;
> 
> This was caused by removing the dependency on CONFIG_KASAN_INLINE that
> used to prevent this from happening. Use the more specific dependency
> on KASAN_SW_TAGS || KASAN_GENERIC to only ignore the function for hwasan
> mode.
> 
> Link: https://lkml.kernel.org/r/20231016200925.984439-1-arnd@kernel.org
> Fixes: 12ec6a919b0f ("kasan: print the original fault addr when access invalid shadow")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Haibo Li <haibo.li@mediatek.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> Needed on v6.1.y as well.

Now queued up, thanks.

greg k-h

