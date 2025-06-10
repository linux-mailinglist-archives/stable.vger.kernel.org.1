Return-Path: <stable+bounces-152318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EFAAD3F56
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 18:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01ED23A8F71
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FFE242D7F;
	Tue, 10 Jun 2025 16:42:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77046242D72;
	Tue, 10 Jun 2025 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573733; cv=none; b=P1wwEC37ZWSGuWgNthTFn/EjLFG5XTJNObr2SeAxiDV+7si2GGqSJgJ2fQFfQhK088AUvT3XscsQi0wa48afyjlA90hHb3lQ5JdBf7VUy9mXhZemKlTRREzzjT8ykbVMJ6hfQc67IueCvrP0H8B+ioUed3Vn54aeuAOxEtfBqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573733; c=relaxed/simple;
	bh=lMUQA/9ez5/bz1KZtr9dlzw5DP7MmCi34znWBMLT8B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opHPQe1Rsr8kaWD8Iozk+Aa9fZrJB2tZi5Sfsav2sWxR7/JbJVD/HHgF+qSeGRLpdgLmzhnNJnR3oyDbCmOzrQtQ8iJ7Vz8fAsrlvT3CXxNFpcHC8SNGWw2V0ALu/MrHylR50ZIu2QJylNeyIl0epHOhmX3JWW82r3Ypg9BEx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1315C4CEF0;
	Tue, 10 Jun 2025 16:42:11 +0000 (UTC)
Date: Tue, 10 Jun 2025 17:42:09 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org, Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH] arm64/ptdump: Ensure memory hotplug is prevented during
 ptdump_check_wx()
Message-ID: <aEhgYQiMv-0fYHoh@arm.com>
References: <20250609041214.285664-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609041214.285664-1-anshuman.khandual@arm.com>

On Mon, Jun 09, 2025 at 05:12:14AM +0100, Anshuman Khandual wrote:
> The arm64 page table dump code can race with concurrent modification of the
> kernel page tables. When a leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
> 
> When intermediate levels of table are freed, the dump code will continue to
> use memory which has been freed and potentially reallocated for another
> purpose. In such cases, the dump code may dereference bogus addresses,
> leading to a number of potential problems.
> 
> This problem was fixed for ptdump_show() earlier via commit 'bf2b59f60ee1
> ("arm64/mm: Hold memory hotplug lock while walking for kernel page table
> dump")' but a same was missed for ptdump_check_wx() which faced the race
> condition as well. Let's just take the memory hotplug lock while executing
> ptdump_check_wx().
> 
> Cc: stable@vger.kernel.org
> Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

