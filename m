Return-Path: <stable+bounces-183598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A493EBC449C
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 12:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C313AA713
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A30A2F5311;
	Wed,  8 Oct 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H1rftDEc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238D2F39CD;
	Wed,  8 Oct 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759918830; cv=none; b=aCuhJ/s82oQmzQlvRmMdY3+YxcXid0SyxT619HgNFbXZnuGRpXzoGsXEZH+lFf+VzfFy3DAeT5LH5S/e92qgIfvI0p14HT/pHAoB7wk00tK6ro3ZDDYu7ATDUZvJNvGjax/JyGjJK0q+s+ha27pjdJbVYSzvC/5xSj7JRpgYrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759918830; c=relaxed/simple;
	bh=3kn/Um2ENzowfrEYzak/NVYIYTDSIVj6NG/MWnQy38U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCM7VOeOlAq2TkTHNoOHJq78ZmkQpV5ULaDp/Ye8v/TDKD16Leg2nxfgbbTn+J1fyfSPKklQQ1CzVJokbjECMI1XAT1IsAFw/nhj1rD31rmbZvcmiaZmwtcxRWjV4VeMyEr2hQjxax9RpUGt+ngF/njwTubbpiQJBQNhJr4o1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H1rftDEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C3FC4CEFF;
	Wed,  8 Oct 2025 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759918829;
	bh=3kn/Um2ENzowfrEYzak/NVYIYTDSIVj6NG/MWnQy38U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1rftDEcgUF8m7aygkU8vIwno0Y/fpUPdoR01ezAOOpsWY3E3N25NhlRwWtddKFzb
	 RBPMQqY9tm3eminboS1AIpQ4wUfR8spgb+zOd6UJNUtEdq0Sbq1ejcenowXYph1F6Y
	 uw/A3q1F3sC2DRvmSMf/lOZrXInr0MULTz78pqSQ=
Date: Wed, 8 Oct 2025 12:20:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: stable@vger.kernel.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>, Charlie Jenkins <charlie@rivosinc.com>,
	Yangyu Chen <cyy@cyyself.name>, Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>,
	Yao Zi <ziyao@disroot.org>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH 6.6.y 0/2] riscv: mm: Backport of mmap hint address fixes
Message-ID: <2025100812-raven-goes-4fd8@gregkh>
References: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008-riscv-mmap-addr-space-6-6-v1-0-9f47574a520f@iscas.ac.cn>

On Wed, Oct 08, 2025 at 03:50:15PM +0800, Vivian Wang wrote:
> Backport of the two riscv mmap patches from master. In effect, these two
> patches removes arch_get_mmap_{base,end} for riscv.

Why is this needed?  What bug does this fix?

thanks,

greg k-h

