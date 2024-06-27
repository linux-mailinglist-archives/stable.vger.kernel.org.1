Return-Path: <stable+bounces-55965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5191A8A8
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C14F286CE9
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D119581D;
	Thu, 27 Jun 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNgSCYAB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566F195811;
	Thu, 27 Jun 2024 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497286; cv=none; b=oQtnUkLHjyxNxse5B9jJ8rdxq+UMt9fhQ+Z7l0n5edUNAoCqoebLqUOyQNCiApEx/zG8ulxPmoHZGozxHoiiRBTqdZvmUl5qL4t+UbUkYCuMlDiC+UyYZEZ8o85ESrbxeKrL8WidDj/sTqHGr5wOatohVmfL3KcahGvEsQykPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497286; c=relaxed/simple;
	bh=tOGAjh8fOWBrBKO+gKQpEbeiFrPZiME/ff0aGa99Pak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e2Ald6FtiZENThbtun/hh53DPtlL4qrl6sAcbcIhxa2LrlWYWMgsfmX3uGbBrQQAZq3Tv51GSXAFjW7MsvHqaODntVNERZf7SdAWczhI3PGMEJApm0cuOK2q1dUX5IoYX39DnF1lJkw+G3INV1y4heEiADqDLALpfCLK+QPKmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNgSCYAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D03EC32789;
	Thu, 27 Jun 2024 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719497285;
	bh=tOGAjh8fOWBrBKO+gKQpEbeiFrPZiME/ff0aGa99Pak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qNgSCYABdrETrv9VmirOi7dRe8S+APD37F6qvNKMG4LZHuenFa8LU9/Uz0JP/ZBKO
	 ly+MFzQU03LLPIlruQl0lYg51SP3fiTXazGOOb/GBTBkdLcJd9H8izNnu1D7iJ5Tf8
	 bzrnN5crAmIysc/rVrQh4jahpcxEjVgfEOIR3JNCF/PfAyFykWvI867moj61d3C4ml
	 voxf4C5OhVv8NDobiFbi/XgJviWCq5VwQkZDDJOey2LO57CsH0Y1L+XSEnLh+iCHqF
	 M2BomlNgrn6UvJnCoDSJwnXoOR9LnWN/Mviyht5QeyQeX+o4WkFVBzH8BtCMkd/NxN
	 ydAZLH33AfkAA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Celeste Liu <coelacanthushex@gmail.com>,
 linux-riscv@lists.infradead.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, "Dmitry
 V . Levin" <ldv@strace.io>
Cc: linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Felix Yan
 <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, Celeste Liu
 <CoelacanthusHex@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] riscv: entry: always initialize regs->a0 to -ENOSYS
In-Reply-To: <20240627103205.27914-2-CoelacanthusHex@gmail.com>
References: <20240627103205.27914-2-CoelacanthusHex@gmail.com>
Date: Thu, 27 Jun 2024 16:08:02 +0200
Message-ID: <87o77mpjgd.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Celeste Liu <coelacanthushex@gmail.com> writes:

> Otherwise when the tracer changes syscall number to -1, the kernel fails
> to initialize a0 with -ENOSYS and subsequently fails to return the error
> code of the failed syscall to userspace. For example, it will break
> strace syscall tampering.
>
> Fixes: 52449c17bdd1 ("riscv: entry: set a0 =3D -ENOSYS only when syscall =
!=3D -1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>

Reported-by: "Dmitry V. Levin" <ldv@strace.io>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

