Return-Path: <stable+bounces-93805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E379D14D6
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7811F22EBB
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFC1A08BC;
	Mon, 18 Nov 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtSmwFU0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB97196C7C
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945452; cv=none; b=spuMF1ecXbxEpP4Z7PA8Np4WP05+Rlyr7VWazX9tOzhy+Y6L+TkKIFDNjQLHy8Tc7WHnbEi05qHUuvZmtvZo2+d5fFyDMJnSmJmlp50uq65cEwOBIYbkTsA/3D3WWcs8ROyR0CPnoPM82T6VBS5LWKruuEhvYQxfjxBZOjnawPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945452; c=relaxed/simple;
	bh=a2fQ9aak+BD9rvsC1M+J5B+JryWc54v6TajfJkLqdYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I611OcF0agsn3qM9gjAF3KMM0ScOPzLjKsESdEbJmk2gO0jWnOyqFf3+KZagT9h9WvJ9gWP8/1X/QaEPiTX8B23GQrKC9xi0pAVxU1WHCLB/y+GymtYsO1yGtdkqf7aAn6onVaHkcOlOg2Ci1bDCsEidXDrSveySouRByRxeCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtSmwFU0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731945450; x=1763481450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a2fQ9aak+BD9rvsC1M+J5B+JryWc54v6TajfJkLqdYw=;
  b=PtSmwFU0gyQSOK8KhdRiDZ+OITMyBbg9e2CwoevetMh5VZ5/KeFcBg2y
   0TPzkWapNYXX4WqCP+WqaZs3fHuVmRXd9QJeAvDBYjQwQsVEb1fd36kQY
   t5GF86SbvmnWCUCWFdkyM15Pq8Okq9V4NDAp7u5G3+ZLKh9bSIfaphHLC
   IRTK0dqqLXENAu9a8G1gWUEEimebhfS7/Vt2zB/1Rg5jzUY9s7O5FFY7T
   W/5IptQDAkY29GW2/LpOTO3ywMoXVv3fzh0jPCcoAcznA+rd1LoQelqOF
   Z+/fX0qVaMKalqN6cj8sIJGUHTcJSRZJrhn8f/UBlV2pfcCEtE4wmBRJ5
   A==;
X-CSE-ConnectionGUID: ryHGmfN3STaPERYcyI0xMA==
X-CSE-MsgGUID: x9bG9P3GQFSyIEIecPxRpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31847321"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31847321"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 07:57:30 -0800
X-CSE-ConnectionGUID: 9+UrdNhETd2WejhBvPSrjw==
X-CSE-MsgGUID: XVKJAPKjRPG3DGH8jKIsMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89281327"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.108.237])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 07:57:29 -0800
Date: Mon, 18 Nov 2024 09:57:24 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
Cc: gregkh@linuxfoundation.org, matthew.brost@intel.com, 
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/xe: improve hibernation on igpu"
 failed to apply to 6.11-stable tree
Message-ID: <a4yt3jiedsawyudr6ekjtzplgdno5bwz6arkysr3prtzn2pnox@5qjjxhwyzwxw>
References: <2024111758-jumbo-neon-1b3c@gregkh>
 <90c3c1ad-2791-49d7-8afc-a12a55859ca2@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <90c3c1ad-2791-49d7-8afc-a12a55859ca2@intel.com>

On Mon, Nov 18, 2024 at 11:34:35AM +0000, Matthew Auld wrote:
>On 17/11/2024 20:36, gregkh@linuxfoundation.org wrote:
>>
>>The patch below does not apply to the 6.11-stable tree.
>>If someone wants it applied there, or to any other stable or longterm
>>tree, then please email the backport, including the original git commit
>>id to <stable@vger.kernel.org>.
>>
>>To reproduce the conflict and resubmit, you may use the following commands:
>>
>>git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
>>git checkout FETCH_HEAD
>>git cherry-pick -x 46f1f4b0f3c2a2dff9887de7c66ccc7ef482bd83
>># <resolve conflicts, build, test, etc.>
>>git commit -s
>>git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111758-jumbo-neon-1b3c@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..
>>
>>Possible dependencies:
>
>There is a dependency with:
>https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=dd886a63d6e2ce5c16e662c07547c067ad7d91f5
>
>I guess we need to get that patch into linux-6.11.y branch also? I 
>think we also need both patches for "drm/xe: handle flat ccs during 
>hibernation on igpu" to work, even if it applies without.

there are more dependencies... in 6.11 for example we can't simply "use
what we have for dgfx" like we did here, because those patches are not
there. I have a few extra patches to stable that includes it and will
submit soon.

thanks
Lucas De Marchi

