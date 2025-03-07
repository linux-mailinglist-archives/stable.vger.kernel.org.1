Return-Path: <stable+bounces-121372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26DA5674A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBD5176825
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D295E2185B4;
	Fri,  7 Mar 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLJMg2kf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852B2185AB;
	Fri,  7 Mar 2025 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348659; cv=none; b=rJfozTRqAFRw46ALHJoj7dCwAeRHotNYg8/Uu2kUSObcPXjYKJ2lOshvoXOc+ECOdik5jJdjqQx4G38Rjkj5JYJiy7k/HG0gABd5uZa/0mkelYU1pZqTjgG516yv+WPBexWhqEGDazMdCG+dAj6XakdHZdo6cWBhALrz2w9dM/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348659; c=relaxed/simple;
	bh=7XOGo7ABoiCaCyAt4GU6abEYIUDtQR2GppbrPjBKcKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EboXPeuIvnCbtyvoVDSPFnDgnnhUagdDDzT+e3c8/+K8AHQ0tpbOrfLIQnEzGCmSXKbpL0qcfivzoHhb4eqC8qd8nZaYOLRPsGyuBNR1VIl9dJ0aWUVfnDb1S6v1i3U4Os+D67k3YIDUa8RkHBPeWVD7Dkvden0lPOjT3/Fmd3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LLJMg2kf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741348657; x=1772884657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7XOGo7ABoiCaCyAt4GU6abEYIUDtQR2GppbrPjBKcKQ=;
  b=LLJMg2kfjz0yQIyhwSMifuhBXbFtToTEf36dJLy3uJwEsvDu53y0rf7s
   LLYbIcwMyYzSv27MeYyFXaxaB7jIx9qwkWz0+tETU0VetwqtxpJnwvJ4A
   UJ+i/jidMbs0a3qzRUMogP6ZRwUJow8qui5E5AMhHWa+XkC6A8EGpimhr
   Tplh11eI6Z7DLcEH7g0bUnRwnqQMXK82lEpVA92wSXdHHibwy1TS5F48l
   5X1/KM5OEMgD6Biis5mGcmlgI4jMjKUQOmpdBimVlDj7Zqi+MpBCYTNAZ
   6hBn2JyAeX2MyPCtAGmbO8b745F7o9JVNQNY2Gbi5BEUWEr+jU/8Bzal5
   A==;
X-CSE-ConnectionGUID: /ygKTgoFST66RHPbfS7ZFg==
X-CSE-MsgGUID: tkg32GVSTuyqlxaCJ3nIUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42427741"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42427741"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:57:37 -0800
X-CSE-ConnectionGUID: IgulX+oQSQKT17Rd9yFw3g==
X-CSE-MsgGUID: aSWLRNJPQEyXZ0ZT05JM8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119306187"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 07 Mar 2025 03:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B813B224; Fri, 07 Mar 2025 13:57:33 +0200 (EET)
Date: Fri, 7 Mar 2025 13:57:33 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Subject: Re: [PATCH] x86/boot: Sanitize boot params before parsing command
 line
Message-ID: <qtxxvlrhgvok5k4spffhqw7ztvfn7djo55wg6bjvqwofkgroqa@y2ncocp3th42>
References: <20250306155915.342465-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306155915.342465-2-ardb+git@google.com>

On Thu, Mar 06, 2025 at 04:59:16PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The 5-level paging code parses the command line to look for the 'no5lvl'
> string, and does so very early, before sanitize_boot_params() has been
> called and has been given the opportunity to wipe bogus data from the
> fields in boot_params that are not covered by struct setup_header, and
> are therefore supposed to be initialized to zero by the bootloader.
> 
> This triggers an early boot crash when using syslinux-efi to boot a
> recent kernel built with CONFIG_X86_5LEVEL=y and CONFIG_EFI_STUB=n, as
> the 0xff padding that now fills the unused PE/COFF header is copied into
> boot_params by the bootloader, and interpreted as the top half of the
> command line pointer.
> 
> Fix this by sanitizing the boot_params before use. Note that there is no
> harm in calling this more than once; subsequent invocations are able to
> spot that the boot_params have already been cleaned up.
> 
> Cc: <stable@vger.kernel.org> # v6.1+
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
> Closes: https://lore.kernel.org/all/202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

