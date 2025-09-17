Return-Path: <stable+bounces-179838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1E6B7DC64
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA14D3AE61B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2F1E1E1E;
	Wed, 17 Sep 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yzJBOb3c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC6189F5C;
	Wed, 17 Sep 2025 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112461; cv=none; b=Bc8/nW0wipwP/9R3/KNCpmjuIU0UhNOyfp2udRP/76ROC+75mDsMfzM7WhhUPq6nU9fljYMQYWh33scB3FwUPUmiV2pV0PcMAzDwyQIxnxXiTSi+Sg2ITom75Dq6AqrT772JKIBiLJyJzMsg6f7G1+uH/bo92DJFdgheUJM7Zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112461; c=relaxed/simple;
	bh=qkAtnr0sXMw+0SYUV0AuKKz3iXuu15biXIdQ4ivHAto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSh/utS/1HdR6uIhkIXfkcajEnK0wrBixtRS4q+Dp57EpcjCkLTbEnQARifd3KUtYH5C99LDo0hpCmkABUE6lmVr0YYdWleRtkTFekGrVUyC7KPzEHKY35WqUPGylXoCyfWFqErSvyS+q7zCp2xM1ufTay6D1uTg7pjj+Q87WhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yzJBOb3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4D2C4CEF0;
	Wed, 17 Sep 2025 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112460;
	bh=qkAtnr0sXMw+0SYUV0AuKKz3iXuu15biXIdQ4ivHAto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yzJBOb3clMLW1DnjyuAltcSKa6aIShyw6FLuTIc6s9c28mAWLzkJyUL5EajkgW6VG
	 3OL6Q4WleVFV+kNpoylsQ992Ck/DkT4B0EoGdrRiMVFW/hchFHV3cUGWK9jYk96ORf
	 vROwAcNoVKiMhg3kEYpCmMD+QYczkwQT9+6zoq7E=
Date: Wed, 17 Sep 2025 14:34:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: stable@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Charlie Jenkins <charlie@rivosinc.com>,
	Yangyu Chen <cyy@cyyself.name>, Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: Re: riscv: Backport request for mmap address space fixes to 6.6
Message-ID: <2025091739-roundish-dropper-c4f6@gregkh>
References: <b68478db-5a8c-4b5f-a4d1-f4202ca1f062@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b68478db-5a8c-4b5f-a4d1-f4202ca1f062@iscas.ac.cn>

On Wed, Sep 17, 2025 at 08:03:08PM +0800, Vivian Wang wrote:
> Hi,
> 
> I would like to request backport of these two commits to 6.6.y:
> 
> b5b4287accd702f562a49a60b10dbfaf7d40270f ("riscv: mm: Use hint address in mmap if available")
> 2116988d5372aec51f8c4fb85bf8e305ecda47a0 ("riscv: mm: Do not restrict mmap address based on hint")
> 
> Together, they amount to disabling arch_get_mmap_end and
> arch_get_mmap_base for riscv.
> 
> I would like to note that the first patch conflicts with commit
> 724103429a2d ("riscv: mm: Fixup compat arch_get_mmap_end") in the stable
> linux-6.6.y branch. STACK_TOP_MAX should end up as TASK_SIZE, *not*
> TASK_SIZE_64.

Please submit a backported set of patches that you have properly fixed
up and tested to ensure that we get the backport correct, and we will be
glad to take them.

thanks,

greg k-h

