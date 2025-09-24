Return-Path: <stable+bounces-181589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0715B98F43
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 10:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B98B3A8F9B
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A028B7D7;
	Wed, 24 Sep 2025 08:44:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C828B3E7;
	Wed, 24 Sep 2025 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703459; cv=none; b=UmgogIiWVyDlq95vQxpm5/QKBlteuB+s72EbdbLseAlcfpPXAXu/WkdWQJpdSkqRe2Dk6k2HmM0+Mei3xsJQVQh54lJfplANBCW6WZY01++iMMcGaNVBQZqYFWiy8v/nJ1u5i1eyomUcEYQ0JBEJHGldOi6kJ5TpU7fEFKTXU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703459; c=relaxed/simple;
	bh=MIBEEF65sED8tkA0qmVYxIsBCuzy3nCLdU4Dm9FzBlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olG29ibRrlR/AON1547wdBPsoDY1yjSGk6PT1thzyjU3LmEncgAh4GS6n9wrx8SMtCpw9mOv9w96D5QHcfCK582eVMizTItxcj1+mGEER724qBibEOpZ8GJ3aJqP0LGhvbVftsRgF35RWq4oVG6lZ8hNNSPrwFhKxdDo8/Uz+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BEE7106F;
	Wed, 24 Sep 2025 01:44:09 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02FF13F66E;
	Wed, 24 Sep 2025 01:44:15 -0700 (PDT)
Date: Wed, 24 Sep 2025 09:44:13 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, rafael@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Message-ID: <20250924-nonchalant-adder-of-support-48db00@sudeepholla>
References: <20250923174308.1771906-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923174308.1771906-1-kaushlendra.kumar@intel.com>

On Tue, Sep 23, 2025 at 11:13:08PM +0530, Kaushlendra Kumar wrote:
> Fix incorrect use of PTR_ERR_OR_ZERO() in topology_parse_cpu_capacity()
> which causes the code to proceed with NULL clock pointers. The current
> logic uses !PTR_ERR_OR_ZERO(cpu_clk) which evaluates to true for both
> valid pointers and NULL, leading to potential NULL pointer dereference
> in clk_get_rate().
> 
> Per include/linux/err.h documentation, PTR_ERR_OR_ZERO(ptr) returns:
> "The error code within @ptr if it is an error pointer; 0 otherwise."
> 
> This means PTR_ERR_OR_ZERO() returns 0 for both valid pointers AND NULL
> pointers. Therefore !PTR_ERR_OR_ZERO(cpu_clk) evaluates to true (proceed)
> when cpu_clk is either valid or NULL, causing clk_get_rate(NULL) to be
> called when of_clk_get() returns NULL.
> 
> Replace with !IS_ERR_OR_NULL(cpu_clk) which only proceeds for valid
> pointers, preventing potential NULL pointer dereference in clk_get_rate().
>

For the 3rd and final time 😄,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Greg,

Can you please pick this up ? Not urgent for v6.17

-- 
Regards,
Sudeep

