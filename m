Return-Path: <stable+bounces-177904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F417B46677
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 00:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C715A86F1
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45BF1FFC48;
	Fri,  5 Sep 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSvIujsl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B87A13790B;
	Fri,  5 Sep 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110509; cv=none; b=Qp0r+gcfVpGJL3KZqbUGmHFjBu2hDxTXQczSLSVnec2iOlZ76dcK7KyUp+u1ELBuGY8SIwIZts8A+C2rKGpRPjdSlHhNOk6r1fk+XstRarmKGIWkip21hvtabIQnHX2RqFFt+pNsgB0TjXP0xM4cINOP1m/1sjHtC3/jIgG3VI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110509; c=relaxed/simple;
	bh=NTs7ekQEkNeZdhqJMnGSHZiWoHIQxzE/1U1C7GUFp3w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lSDI0iloAlg0i7uFb9xsBPEwOsbIdVDgGB36OvVZQ0BDUGmAOVcMY0QbptasfbyI/3uUVMFCjzGpsk2u1o0DwN7yqaqjTlqOWkWP1eZxQm56kG8vSPru5qhW6NZpN8BdGQcq2qjd67i5suceGT5KVVeNnJAUcXsficTrqebSwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSvIujsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F515C4CEF1;
	Fri,  5 Sep 2025 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757110509;
	bh=NTs7ekQEkNeZdhqJMnGSHZiWoHIQxzE/1U1C7GUFp3w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hSvIujslLpaZzfOg+xBZ/eTxP3WSmdyB/mUN4AUyM8t5Pq9coYjpMA5SbkSqijhsG
	 gpm0Kk9uQtxgNi04OsMFmFLBUHAySIXk8VIZOFoVrbctACitdmFkVmNmWH7wLU41MS
	 NdnDYwIBcOoslsOB0gpXRlhVhvO2q9nFC6TDqK3zZuDEK2bP7NTnrsBlxEc4Jt6kPD
	 1BHr3FaHRBDObyr9smz/2kHa4J1h4C8grEtzHXwUsxAsFSXDxQRFHrdwACFwz2gsoI
	 w0aHVQe7W13OCqh2cxqCJPQWoCgNcIBKOfn6YfLNQw/rgcg1YjFIXrLytgq3fQoFTf
	 89AML4ntI8D5A==
Date: Fri, 5 Sep 2025 16:15:06 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
cc: kernel test robot <lkp@intel.com>, Al Viro <viro@zeniv.linux.org.uk>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Cyril Bur <cyrilbur@tenstorrent.com>, 
    Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Fix sparse warning about different address
 spaces
In-Reply-To: <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
Message-ID: <4381e8fc-67eb-c7f8-d4ad-17a1fe0a5bfa@kernel.org>
References: <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com> <20250903-dev-alex-sparse_warnings_v1-v1-2-7e6350beb700@rivosinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Sep 2025, Alexandre Ghiti wrote:

> We did not propagate the __user attribute of the pointers in
> __get_kernel_nofault() and __put_kernel_nofault(), which results in
> sparse complaining:
> 
> >> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
>    mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
>    mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *
> 
> So fix this by correctly casting those pointers.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: f6bff7827a48 ("riscv: uaccess: use 'asm_goto_output' for get_user()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks, queued for v6.17-rc fixes.

- Paul

