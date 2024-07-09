Return-Path: <stable+bounces-58741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AFE92B968
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4F1F26229
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 12:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A399158A32;
	Tue,  9 Jul 2024 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GdZNc7Lh"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A9158A11
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528046; cv=none; b=evSvP8FyV4JPU7IR9T5AB+kREuhqpxVBpy8koEBipWtUDLWXYWtgjtLVrvKsewkBsgZlITbdGb8HV5oqkb5VnUFhEddBR3qM7VOGYfYID5spWf5yAfgKHR7Gwxejmo82EY+L1zYLCj0cRZqWCUw4rbhUph7ja9dK6LXC9ziOm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528046; c=relaxed/simple;
	bh=tx6Q+H8v+nZJ8xSZhekIrhdfMQ/EMW1bDL63Q7jetTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UILlSYCF2uU4dACeX7YwHNgV25qc1i8dPU4qx4LVuPP9U6rg5Nki1a1jn7uXL643fihlvjOLfuSgMerBss3de/LLyrrns+KjMI2L8cjK6f0fJN1cYSQjnOsjNho6GjM7+vZcccm+p7umqs6fdrFfjKBh3W0ksgS823dhWm+1N4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=GdZNc7Lh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720528041;
	bh=yG8VM+AC2gBC/m6ETfftbKwWUlampOF7XBFC+g1UhG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GdZNc7Lh+a4yCaeVMc5h8IA53+HPYYrHTJEOWxKXmwjYm82Zo/Kb/7Mtv7K8RN127
	 Q/KYLIPcvEr/8HwvSYN4/5VFuUzfsr14FNRAX34BGa/FUMgmCvunxkDIrEqu8d+Ciy
	 2I5koaK8wFuAIixCCFrQOgZA7+wdq3PmXzqovQpn7Q744mjgWi79PI1vi16GU+fAec
	 cRRSIZLcIl6Ongs/7VKhAH4NYLFYWc7VGSBeENnyu9/c1fh9b21ed0a7SanPaXpdi6
	 07w7zCmi2C/9YBZtkLMMyb+/1qvUX1vXLUawqY/s6LAD83rLL/5a84BZRZ+qfOCudq
	 9OLqF6cHOJqYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJKxj6M4bz4wc3;
	Tue,  9 Jul 2024 22:27:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 patches@lists.linux.dev, Benjamin Gray <bgray@linux.ibm.com>, Sasha Levin
 <sashal@kernel.org>
Subject: Re: [PATCH 6.9 057/197] powerpc/dexcr: Track the DEXCR per-process
In-Reply-To: <20240709110711.171129088@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
 <20240709110711.171129088@linuxfoundation.org>
Date: Tue, 09 Jul 2024 22:27:20 +1000
Message-ID: <87v81e6993.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 6.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Benjamin Gray <bgray@linux.ibm.com>
>
> [ Upstream commit 75171f06c4507c3b6b5a69d793879fb20d108bb1 ]
>
> Add capability to make the DEXCR act as a per-process SPR.
>
> We do not yet have an interface for changing the values per task. We
> also expect the kernel to use a single DEXCR value across all tasks
> while in privileged state, so there is no need to synchronize after
> changing it (the userspace aspects will synchronize upon returning to
> userspace).
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://msgid.link/20240417112325.728010-3-bgray@linux.ibm.com
> Stable-dep-of: bbd99922d0f4 ("powerpc/dexcr: Reset DEXCR value across exec")

This is listed as a dep, but I don't see that commit (bbd99922d0f4)
queued up?

This series included user-visible changes including new prctls, it
shouldn't be backported piecemeal.

I think this series shouldn't be backported unless someone explicitly
wants it.

cheers

