Return-Path: <stable+bounces-42808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7E98B7CC2
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8791C23015
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA1179641;
	Tue, 30 Apr 2024 16:23:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6445BE8;
	Tue, 30 Apr 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494218; cv=none; b=VjHsrEXk0iqBneDzJRN4zKbwKsZIYJ3YmsCEiBykaRWqrs70Foqqx/f1pwzfvZuvlIWiLag0pY98DS6g3fNLOQ2Qa74YyY6DLsjIImmxJ3Y2hRfDkWW9W4xN8GcAlzcomG+eFdMWnrIJZIP8x7Ah9g/eReF3i4kSwapkUeDV0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494218; c=relaxed/simple;
	bh=acfgyR5CHip0LwmW/Ejeaatjc/EImji2C2b125IG8Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFAKVb1gmmYtyPJ4AWRfij3CmHNERohuq5csPrTZvchZDQZEquhysGH79ZBQR/QFVLYQBFgjXBk4xcBZaelUg3s/tQP/lAMMSE1Qq1K+Wl2jcZGZ2F197ExZ40VdNFVmBXe9gf34U2nEZ0TIk7L0laHL9g/G8X/HHrQ6Q9qUXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ED0C2BBFC;
	Tue, 30 Apr 2024 16:23:35 +0000 (UTC)
Date: Tue, 30 Apr 2024 17:23:33 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/mm: pmd_mkinvalid() must handle swap pmds
Message-ID: <ZjEbBasQ8H-wa84I@arm.com>
References: <20240430133138.732088-1-ryan.roberts@arm.com>
 <20240430135534.GA14069@willie-the-truck>
 <41a83b7a-17e0-469d-bec4-10ebfff4ef57@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a83b7a-17e0-469d-bec4-10ebfff4ef57@arm.com>

On Tue, Apr 30, 2024 at 03:04:32PM +0100, Ryan Roberts wrote:
> On 30/04/2024 14:55, Will Deacon wrote:
> > But it might be worth splitting the tests from the fix to make backporting
> > easier.
> 
> Yes good point. I'll leave this hanging for today to see if any more comments
> come in, and will re-post tomorrow as 2 patches. I assume we need to go fast to
> catch 6.9.

Yes, I'll pick it up for 6.9. I can drop the tests from the patch (and
their mention in the log) and you can post your tests separately to go
via Andrew's tree.

-- 
Catalin

