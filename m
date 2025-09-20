Return-Path: <stable+bounces-180720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B02B8BB6D
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 02:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D531C21822
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 00:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8AB154BE2;
	Sat, 20 Sep 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W34bmWuv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979291D6BB;
	Sat, 20 Sep 2025 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329761; cv=none; b=aKXfwvVwwl+T7NsyLgzYXrE1NufRum1Xh/46DP0hbsH6LPo+t8cnP3q/iWhUsVYFI5vovRoodOssD86K7oF0WwZq7W/nrjmvdcOqKUXreVkIDDTb5ecviKopNy4XrgHFCndaSAFYM+EXrLb4kMMaOy2UqA67mJod6NP68ncifqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329761; c=relaxed/simple;
	bh=kvKfAjitcbTLQsI2Awo6FX330gVEAw9BSbt3m48J6pk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nhFyrazATzXGecndYo84bBjgxzvK2VqYBMTngrgEnXzUU9ppz9Hp/RbyENklH/rLAtI2zf/phU+P5YEgCBzv40UApBOBlq4PVbV+gMGWZwH4J1Kn9ePZPyVzBWAD5i21yZt+cuLRrJ/4Ih5kGDZpFImDHSN/Q2NR7Zp6mX0KNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W34bmWuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A305C4CEF0;
	Sat, 20 Sep 2025 00:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329761;
	bh=kvKfAjitcbTLQsI2Awo6FX330gVEAw9BSbt3m48J6pk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=W34bmWuvwAVc6uarjDsw/Js6LfVE+N1Mt4RN+zbeZD+YQ/M2fAEakHBRMxQJ4zJ/J
	 jsIfenYFvIsdgYgf2IT5FmBoDtV1D1dYton5tD8KZDq/wrob3NbFVnnyH8i0HTGAbp
	 m2edo5DjBhqQNa7sS+jhwHCxDKwVbIgcQt4ha9ydNRgb0z51sFINTXQMjoF+1BRSbi
	 IbUwYt8UEARl7nLBiCs6s+PNXNTkd1vKgWIeJTButGk0lXJF/zvXEYD0vidAZfSO0F
	 voVTJqoTZlujBiMVvWf7/vsGJgBWEsuB0OlejlTgrVebFqv+TkZ5sSmyv9yoEtuKbJ
	 JWMduWALxCPeA==
Date: Fri, 19 Sep 2025 18:55:59 -0600 (MDT)
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
Message-ID: <485fba52-1f41-e940-bc38-2e2244d78c76@kernel.org>
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

Thanks, this one was sent upstream as part of the last fixes PR.
  

- Paul
  


