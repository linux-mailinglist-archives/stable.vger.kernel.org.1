Return-Path: <stable+bounces-152560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2EBAD74D8
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 16:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923F62C36DB
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00B26FD87;
	Thu, 12 Jun 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyhEhweN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5015278E;
	Thu, 12 Jun 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740294; cv=none; b=rCJfvHUrCQ9wFZzc1eGgJ2mbnu9hSAoaTYb8Pw6GBaBBWMoP3fhTOIYd61mrmNKzlr6FIaacuq0OXLmkQYJcqMWY5Po6QOgfrCIGe2bhQdokXSDvUBpKVsu/33jGGvCWHCefdzZ3olSfDwYIz81wrcaOGR+fWxb/h/FSDeNRdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740294; c=relaxed/simple;
	bh=MEQ00cN8fGMKpGx5TTT2lBG5uw4fLGW1FJZZt7d8B0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaiX3QaVumLmmOglpx3WyHjErhbxpPv1cD9djLrG/p47nKEmdomWhPv90FoURwdl0gFWAZavevOFqL8kIHp/pJJ+UtyV38M/edXleJBoqXtj8mSsJL0CpR+W23c36Onkmww8czXRjZ3mpbydydWK6QkdPl+5RLyjEvp3xUFC1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyhEhweN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5474DC4CEEA;
	Thu, 12 Jun 2025 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749740293;
	bh=MEQ00cN8fGMKpGx5TTT2lBG5uw4fLGW1FJZZt7d8B0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyhEhweNRZcVd2K4arWld8S0SFJue+WF4/91t2dHUDMg0/cbg2Tvu9EtE4Iu1hzNb
	 7jOB/+bthFWk32dO1y/vdiyWb8jsdhiDa0Ex9SMs3hpmjcn2jk/9OllCxRuXZnHdXF
	 yxkaJpCWCTh8DQVAXTlnr5El/O0Xg5/pCNbCUm4GJTIwvrL9kp8Ya9Ov0hfJgsUvOy
	 LL1bg3cEte3Pq/tJ4GVaS4w7m31nGTN+aldUzZcbCJR0xesh8gmDJIdIwGNA1BSAIL
	 7l6J7d3JBj9VD7KEZqtj6M6C4gp60RJhapMQrsgcUrHG0oTYOtdm90twWZX3SKWjG3
	 s2TGt9tLDstZw==
Date: Thu, 12 Jun 2025 15:58:08 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH] arm64/ptdump: Ensure memory hotplug is prevented during
 ptdump_check_wx()
Message-ID: <20250612145808.GA12912@willie-the-truck>
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
User-Agent: Mutt/1.10.1 (2018-07-13)

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

How do other architectures (e.g. x86) handle this? I don't see any usage
of {get,put}_online_mems() over there. Should this be moved into the core
code?

Will

