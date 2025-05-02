Return-Path: <stable+bounces-139510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F5AAA78F3
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 19:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A119B17E5CC
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48351256C61;
	Fri,  2 May 2025 17:57:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6E9266B6B;
	Fri,  2 May 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208667; cv=none; b=T0B8BWQz99b3gAOoEMPTWgFQNRa6Q56KU6+uCnzi3KRBWbbLGwO1t7JCfkAsAuSXRICso0zTr/V1qrApziawR5SDyXlU8eIws/hQf4xND3iZKDPDw03iDaD2A8kcIu+rSqAxzXtgaQxdz2tUhyeQ4UMEFgYHYUE7T9ikmPRERfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208667; c=relaxed/simple;
	bh=Yw0+zj4FQ/6+qnnRhIcK5j1bCjj3c2GpDqNk7I89aCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAQWvZ48XnaVwdfM25awNFAM0BfFVi+tBAv65NQfbzR2aDRKDw+Zy4HrpX8dqMB8sIqxTeNukkacH6Mcx58pRJjdirqjJ/WoFMShIf9TyaLxqZH0377BOpAGRdn9IUVUAEWDWP7fnHup8YheRh81apn/+viaVYuDx86yjhV/t/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA0BC4CEE4;
	Fri,  2 May 2025 17:57:42 +0000 (UTC)
Date: Fri, 2 May 2025 18:57:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, will@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, frederic@kernel.org, joey.gouly@arm.com,
	james.morse@arm.com, hardevsinh.palaniya@siliconsignals.io,
	shameerali.kolothum.thodi@huawei.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: annotate arm64_use_ng_mappings with
 ro_after_init to prevent wrong idmap generation
Message-ID: <aBUHlGvZuI2O0bbs@arm.com>
References: <20250502145755.3751405-1-yeoreum.yun@arm.com>
 <CAMj1kXEoYcS6YPU0mBdvijDRK6ZVB7mPYZsCVpz7sYotabrxtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEoYcS6YPU0mBdvijDRK6ZVB7mPYZsCVpz7sYotabrxtQ@mail.gmail.com>

On Fri, May 02, 2025 at 06:41:33PM +0200, Ard Biesheuvel wrote:
> Making arm64_use_ng_mappings __ro_after_init seems like a useful
> change by itself, so I am not objecting to that. But we don't solve it
> more fundamentally, please at least add a big fat comment why it is
> important that the variable remains there.

Maybe something like the section reference checker we use for __init -
verify that the early C code does not refer anything in the BSS section.

-- 
Catalin

