Return-Path: <stable+bounces-39707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529788A544D
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FBD1C20DA5
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427917C085;
	Mon, 15 Apr 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwbVMlu6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5F763EC
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191574; cv=none; b=kDULClf9X+c/x/wIZEO+eLGJvjZEqtERxKqsjkN6Y3MwGq35Cg8lpNig0wG5UoLHTX47SAc8jqRetQcUQhK7bH78nnBzU18/OypV8UnOBBWZUH+EzNAoLo8dkCpBXZFQbpWT0+zm+lfsMH/8DeDXIjA1G0kFao1eDKGqPoIKiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191574; c=relaxed/simple;
	bh=kHJY2Uq2jF7R4G4MyJRdk9/tqdpX1bx3qo6G8B8h2A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIaXWuuIcyr8Cd/N4IN6RQbHQQzc82eW0n34y8bE8wSF1adQbecIXn4bH3PN/+waq1OQiKLspB3iQuKRQjv/K9naoFtTrq5eg5eFoBDF7POJTvXJJPY2UxrMPbjxWyJdSUP0o/Tzk0blsnAJZl06FAUw5a5+WZXO366KD014Iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwbVMlu6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713191573; x=1744727573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kHJY2Uq2jF7R4G4MyJRdk9/tqdpX1bx3qo6G8B8h2A8=;
  b=lwbVMlu6CHEa22PS3ZyLWT2bD8IMJB/Pej3QILcYiY9A3uUyhpI18lnV
   QoeVEmv5KXXk15iAjRx2vJ47HmvWigg71+okkueKg5oA24FZDQ+nfdHOp
   HxYyslkbYECfBkxq0AB+h+XdH4/2VMPxTPDvDl3Hd7+ATwBEwok9I7mza
   OvnIAExxmiGjpiHS+d04vStPJAD1aP+72wpDfDMxCaITf0KyPaYpcz7Mv
   NmgNkKqjBJW5gCejdD1/OEBrVxVRJPTbJWlyP6Axjf/N+k2VXqcrKOUAG
   llj86igmUkdU3Q6sh/esEkCGBXDPby5RVhp5hVECP31OhX89wqITgCwxl
   w==;
X-CSE-ConnectionGUID: vH5SjeruR7iMMMJnmkOFLA==
X-CSE-MsgGUID: Og6OjMamS2mIB59wyLB67g==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="26041392"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26041392"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 07:32:53 -0700
X-CSE-ConnectionGUID: 3VBzBj/4QOqcUsRE3vuTOA==
X-CSE-MsgGUID: bALrC1s1QNS9qgTw1M1cvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22030914"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.20.116])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 07:32:50 -0700
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Nirmoy Das <nirmoy.das@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject:
 Re: [PATCH 6.1.y] drm/i915/vma: Fix UAF on destroy against retire race
Date: Mon, 15 Apr 2024 16:32:48 +0200
Message-ID: <6034005.lOV4Wx5bFT@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <2024041507-helpless-stimulus-df3e@gregkh>
References:
 <2024033053-lyrically-excluding-f09f@gregkh>
 <2024041521-diploma-duckling-af2e@gregkh>
 <2024041507-helpless-stimulus-df3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 15 April 2024 14:23:22 CEST Greg KH wrote:
> On Mon, Apr 15, 2024 at 12:50:32PM +0200, Greg KH wrote:
> > On Fri, Apr 12, 2024 at 08:55:45AM +0200, Janusz Krzysztofik wrote:
> > > Object debugging tools were sporadically reporting illegal attempts to
> > > free a still active i915 VMA object when parking a GT believed to be idle.
> > 
> > <snip>
> > 
> > both backports now queued up, thanks.
> 
> And both backports break the build.  Did you test these?

I'm sorry, apparently I didn't test them.  Let me fix that and resubmit.

Janusz

> 
> Now dropped.
> 
> greg k-h
> 





