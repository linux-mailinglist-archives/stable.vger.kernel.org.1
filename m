Return-Path: <stable+bounces-108093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B658A07554
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0656188B144
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0A21767C;
	Thu,  9 Jan 2025 12:10:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86F216E24;
	Thu,  9 Jan 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424622; cv=none; b=fhdQc+K3NibGXx6etZHsOl7WBjSAEB4pCbl1xFS66L4UTrirFkKk5pDtw3bYbfI7Ibf8TTPJgAVT3mdwYsZti+rmeSyfgRSSU/HaKn7xOzTnkG3Iz+BhVFvHz2m0t4mioiY3USIEo/RbftvszdwIZJqE2J6WChaYEoCk6bMl3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424622; c=relaxed/simple;
	bh=ZFbomuY4Dm8Bgu++fDM4zU3sIGkQmsyEL71TrhLzgco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxkGUP+v2qMBy/Kx3lKBxIUVGVvHcEwLIdM5H8ZVPjwfVnsTrbt5RAX+cnV8nM3aAoa0/MmDcWVZD1bH7LELFhQG5NSv5Cd29qsITH1Ha/8afcQT2+YsH5YG1A/Ur1fDKuHz6po6oNK2qnrJBC59FQW8/BCSfgN5b+SjudQEPJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6E6C4CED2;
	Thu,  9 Jan 2025 12:10:19 +0000 (UTC)
Date: Thu, 9 Jan 2025 12:10:17 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, will@kernel.org,
	ardb@kernel.org, ryan.roberts@arm.com, mark.rutland@arm.com,
	joey.gouly@arm.com, dave.hansen@linux.intel.com,
	akpm@linux-foundation.org, chenfeiyang@loongson.cn,
	chenhuacai@kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] arm64: mm: Populate vmemmap/linear at the page level
 for hotplugged sections
Message-ID: <Z3-8qdluDbrDntRJ@arm.com>
References: <20250107074252.1062127-1-quic_zhenhuah@quicinc.com>
 <Z31--x4unDHRU5Zo@arm.com>
 <fbb134e0-cfeb-4c6e-98b4-d945f95383db@arm.com>
 <169f8006-ff33-48ca-a680-37fe1cf0efe8@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169f8006-ff33-48ca-a680-37fe1cf0efe8@quicinc.com>

On Thu, Jan 09, 2025 at 03:04:48PM +0800, Zhenhua Huang wrote:
> On 2025/1/8 18:11, Anshuman Khandual wrote:
> > Just wondering why not start with PUD level itself ? Although SUBSECTION_SHIFT
> > might never reach the PUD level but this will help keep the flags calculations
> > bit simple and ready for all future changes.
> > 
> 
> I suppose that it's because these are significantly larger than 2M, whereas
> Catalin assumed SUBSECTION_SIZE would not increase?
> His comment:
> "should cover any changes to SUBSECTION_SHIFT making it *smaller* than 2MB.
> "

Yeah, I was thinking of having fewer code lines. Otherwise the compiler
would likely optimise them anyway to a single assignment.

-- 
Catalin

