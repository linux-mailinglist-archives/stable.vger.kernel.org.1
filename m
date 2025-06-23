Return-Path: <stable+bounces-156159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A6AE4D72
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A33B6E42
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B878F51;
	Mon, 23 Jun 2025 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLF/zl5a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB878F4F
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706260; cv=none; b=ozICHdIH34sP8M0m10BhwlIOQftK15SIl+8k55oDQujIV2Gd6ltfuvnbSrBVDKEXISxaaERptowt+326qm8NJQzGG9OMCTQbO1PPia6tXKA/g73+5Qgons/RTLUPMpgKgZPqzvP0z/A2y3XXmCQ6e+H/RCagZRrO8piUtppjFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706260; c=relaxed/simple;
	bh=SeW+GN7PiZcat0ha9E/tpF6zuEIh1Z3p7sao25ryCPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfB8r+cSZwe0fBAVxMcRgg8V6t0jpykzzo9V+Mi9han5ZVnI3wWe8RVdlvcFlvcRaJfJOrnNaN2+okXwSxmojQZhqug8SZoqrWNPzKN8+V0BoY2EpU5Sz5TctwA3TXD1LdkzMr/RWxS8LcNjvDYqLv09OdCbYmBQaJOdRSPLr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLF/zl5a; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750706259; x=1782242259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SeW+GN7PiZcat0ha9E/tpF6zuEIh1Z3p7sao25ryCPY=;
  b=QLF/zl5aGqy3vBpYTd3H54fk1rpRqwivgahDA0IT5oYMQ1gfJX1n5NAW
   11bTdgto3iXEE2gH6zfNkFvpukUlKEh3VVmI1qJgltfrgn5SFgO/vKHcf
   jtw66Iim30i28RbFYUB+I8/f3uhQ96sOcqbFld4azyttFft5J7LC9Amto
   ISRfwrom/czz84NstEfScJ+yYZnj/K/rRXnf6KBwU5RDtQoUE3XnW5DL5
   0BAMZMUyeNHB5l2iILfYcsfnk0ALUM2r5l5ofoly4TRP1kUvTQsGuDHag
   VT0TYuwdGOokeHgfUTy3iOx0j5U6ng0clDw1aZdFEA6hfugrkw+9zoA6U
   g==;
X-CSE-ConnectionGUID: bKWXsHAeT36naxXuQyzteA==
X-CSE-MsgGUID: sMxcO7CnT1iAC9krRmzuiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56705826"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="56705826"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 12:17:39 -0700
X-CSE-ConnectionGUID: J35IK+VnRGaFsFvNpgtn8w==
X-CSE-MsgGUID: iHGYFyWfQDaU8ThS8BirMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; 
   d="scan'208";a="151455424"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 12:17:38 -0700
Date: Mon, 23 Jun 2025 12:17:33 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10 v2 10/16] x86/its: Fix undefined reference to
 cpu_wants_rethunk_at()
Message-ID: <d2bh7rhdcaf3yfnw5s4vpb6up4jkoc3anhp56y3tq7h7rx3atm@2xmtxaal3mod>
References: <20250617-its-5-10-v2-10-3e925a1512a1@linux.intel.com>
 <20250618181407-e453f543cb25ed9b@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618181407-e453f543cb25ed9b@stable.kernel.org>

On Thu, Jun 19, 2025 at 05:03:12AM -0400, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ℹ️ This is part 10/16 of a series
> ⚠️ Could not find matching upstream commit

True, the patch fixes a problem that is only present in 5.15. The upstream
commit does not exist, and hence this patch is backported from 5.15.

> No upstream commit was identified. Using temporary commit for testing.
> 
> NOTE: These results are for this patch alone. Full series testing will be
> performed when all parts are received.
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.15.y       |  Success    |  Success   |

