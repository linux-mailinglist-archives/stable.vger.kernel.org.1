Return-Path: <stable+bounces-76085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C3978285
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1505BB20A1C
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE777B67D;
	Fri, 13 Sep 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDcOS59r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB82B672
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726237677; cv=none; b=Oeld3LYQ3em6JG077QdLrjuYdsOMIfUDwnixPe9yNw7wywJ5IKFDnrGZMJGfxFX13ajX6s+SS6849uHcmLZKNOMQzNIyqqXJ9WX2GpTqgDJr3Tyj2SDKzIdSRkfEeoKimHH+z+mOAaC1SvMrsqzCp7BBCDFFZx0AyqhFUzos/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726237677; c=relaxed/simple;
	bh=L+2VZeRnJHTSQ+zYM8PG/4GMUJQ1lc2mOrFWE8E0nL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKehHmkhuIy8+lzHzbGt/pW140vxx+O8X01YHASImDqE1U0o/Yj8NKbGKM2gVzx8+oJ0TVCp8z5zFMcmmFHWgQVIHcz7nGKn3earwVt4gb15QILGdO4s77N83oszh59YTgnrEbtqOKjg2ckXXMylO1G9q3DKx78zv8lVQv+nWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDcOS59r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08DDC4CEC0;
	Fri, 13 Sep 2024 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726237677;
	bh=L+2VZeRnJHTSQ+zYM8PG/4GMUJQ1lc2mOrFWE8E0nL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDcOS59riCSGbhyzdpVafo16n1nn17FSl0cEZb1aSQO9OIFcNI/vdVGVb14EoXoWU
	 qSsgYmf72wcRYZOHb6jDHiG72aWMKTlm2W9kcRpqNz0ZHdraTW822gboIxebIvavGz
	 3PJD5YvMo84KoFwsDAxhLEYHaU2F5+YYXtOcWl5M=
Date: Fri, 13 Sep 2024 16:27:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: He Lugang <helugang@uniontech.com>
Cc: stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH 6.6.y RESEND 2/2] LoongArch: Use accessors to page table
 entries instead of direct dereference
Message-ID: <2024091339-untangled-tracing-d859@gregkh>
References: <2024091028-stinking-mourner-56f5@gregkh>
 <20240910131119.18625-1-helugang@uniontech.com>
 <1197B2966A66F7F9+20240910131119.18625-2-helugang@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1197B2966A66F7F9+20240910131119.18625-2-helugang@uniontech.com>

On Tue, Sep 10, 2024 at 09:11:19PM +0800, He Lugang wrote:
> From: Huacai Chen <chenhuacai@loongson.cn>
> 
> commit 4574815abf43e2bf05643e1b3f7a2e5d6df894f0 upstream
> 
> As very well explained in commit 20a004e7b017cce282 ("arm64: mm: Use
> READ_ONCE/WRITE_ONCE when accessing page tables"), an architecture whose
> page table walker can modify the PTE in parallel must use READ_ONCE()/
> WRITE_ONCE() macro to avoid any compiler transformation.
> 
> So apply that to LoongArch which is such an architecture, in order to
> avoid potential problems.
> 
> Similar to commit edf955647269422e ("riscv: Use accessors to page table
> entries instead of direct dereference").
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

You did not sign off on this, so I'm dropping it :(


