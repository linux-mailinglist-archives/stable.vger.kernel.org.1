Return-Path: <stable+bounces-141953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D552AAD1A1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7771C00AC6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD121D3F0;
	Tue,  6 May 2025 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uwxv3ati"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F543D994;
	Tue,  6 May 2025 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574992; cv=none; b=uCKFk2fZE9P7fFiMb97+aFvTI9PeU8RqS9zw53kdsbRSslaxPmSE9NePHfFPIgts5a5ihSm+d1P/Rtut6EQoB5Vjc4MuyVSUK2TulVCTGpjdbTHA0SYzEO2BFAhWArhZADJCfyuqXlGCsrBRHkRzLry8CKYheafbhBCuGi6/+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574992; c=relaxed/simple;
	bh=oCAAxRSKxCl3OliVJxB6uq7ZBUIz9pnLzCnTMe+Q+qo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FMMk2Jj7Gb77bAIa5gIcagGs+EACxXP0ed4HVitKqlo90mlbjKhOBEHqe0MyYiZxiMLKGb1WaT7O3sh7IpLh9a/X+qhJum8AXPhjs7NIzL3uoif7t4P90dl0GSAxNsEllTtWavEeY04Y82H5d477ngK4KQwpDVVVAlVb7+Cmcg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uwxv3ati; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53841C4CEE4;
	Tue,  6 May 2025 23:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746574991;
	bh=oCAAxRSKxCl3OliVJxB6uq7ZBUIz9pnLzCnTMe+Q+qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uwxv3ati+NxPCpR2eIIU10Fu15XbUGEXJVM+M3OoDFd1opl2fdbQPXjKAoNCZC3io
	 JNZy0INRkKIADC6/lwSpxz833Tzx6xyLkuER/F6mPRpSH4RGLNvMNJNOYCXmobgJI6
	 +bP8gR/uPfr0WqfRZ/OHEFRvGzI2VNo5VZciH2g4=
Date: Tue, 6 May 2025 16:43:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ignacio.MorenoGonzalez@kuka.com
Cc: Ignacio Moreno Gonzalez via B4 Relay
 <devnull+Ignacio.MorenoGonzalez.kuka.com@kernel.org>,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 yang@os.amperecomputing.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if
 THP is enabled
Message-Id: <20250506164310.ff91ff53bb8295921d19cd19@linux-foundation.org>
In-Reply-To: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-1-f11f0c794872@kuka.com>
References: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
	<20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-1-f11f0c794872@kuka.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 May 2025 15:44:32 +0200 Ignacio Moreno Gonzalez via B4 Relay <devnull+Ignacio.MorenoGonzalez.kuka.com@kernel.org> wrote:

> commit c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") maps
> the mmap option MAP_STACK to VM_NOHUGEPAGE. This is also done if
> CONFIG_TRANSPARENT_HUGETABLES is not defined. But in that case, the
> VM_NOHUGEPAGE does not make sense.
> 
> Fixes: c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")
> Cc: stable@vger.kernel.org

Mixing -stable and non-stable patches in a single series is
troublesome, because the timing and targeting of these patches are
quite different.  I usually have to split them apart, munge around the
changelogging and generally do things which I'd prefer you had done in
the original!

So please consider presenting these as two standalone patches.

