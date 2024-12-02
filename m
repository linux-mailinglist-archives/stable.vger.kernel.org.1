Return-Path: <stable+bounces-96140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C39E0BE9
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 20:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD40B2840E
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C43617BB25;
	Mon,  2 Dec 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="il23wkkF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC061632EF
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158878; cv=none; b=Ax2GfRhSK5G9FjKKVwEpbAErk3SQqc8wE1BBakMfIMZ2tEu36Nh0H6/E+zrd/A0ZPorUUQAynOcTzRM+xnAFNxvBvBZRmnA5BANMq/Z4rPGz4yR07DL8nUxVbciBJ0GYD+ERwRfA+uXhXXc9ubvkPyw4WEC0SWFE4tvNWbBGQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158878; c=relaxed/simple;
	bh=1yGNg9+15EN0odtLCmjZgPC1UteAuN9EK+H7YAL9Yx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEcNORfqntD6QuCWsS+tZC+O8u/sw3FEEK2yg3fMRX/F8SoxHO914SkRGBknLVOsI6qzwUHEAgd6Au/E3+N5QgTBlbk90F5ERPDfWvfjU0LZHUwSIRE2N6T/f/r1DsguSPrS4bauDJPc2Ba74P+IV5D0T49UjiOwGjzSHM7CsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=il23wkkF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733158877; x=1764694877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1yGNg9+15EN0odtLCmjZgPC1UteAuN9EK+H7YAL9Yx4=;
  b=il23wkkFHYbGUDFbxcV5noQiicPhwxBIgUcbAgAvAB4UxLLP3nHULcFS
   +CRVd/tSjVeNpR/dziXaDq8NU3AgbW6uhoZ7gv9Fq7DRg6RUZLmjwqB+p
   wY5B2GYX4IPVbADelyjND8ktnmXXnOj3VmCSs8g13A2QrXR4cTXojyolu
   gftsE3wwF47F8CBTAP0e3C+ry39vQ0nUZ/BQZsllQQuiBDWvaiT05BlVq
   XPxCXbX+vDVMfnHWU9D+/vo3rJuBKaNoXkz/njTJ2/ThAVWuf7a8y6COj
   jwcTxwPGbY+MVd3XT9WDXii4w1xRnuDiuljdPLS0fglmxNFJGHV9adDFN
   A==;
X-CSE-ConnectionGUID: MWF6qEPPSm+H2edn5puzqg==
X-CSE-MsgGUID: 8DkKxMAASh6vkgcnc/tDrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33474165"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33474165"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:01:17 -0800
X-CSE-ConnectionGUID: BxMcDTE8RgyObBat4qtGHA==
X-CSE-MsgGUID: /hjrQUrJRei2jzR87gkZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93257525"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.111.145])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:01:16 -0800
Date: Mon, 2 Dec 2024 11:01:09 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.11 27/31] drm/xe/display: Do not suspend resume dp mst
 during runtime
Message-ID: <a7gqi7domuxo34wtfyyjhkd4gun6i33wrbnnz3pvzl4ckkpesv@ib4k3kcemrp5>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
 <20241122210719.213373-28-lucas.demarchi@intel.com>
 <2024120222-mammal-quizzical-087f@gregkh>
 <i5j7pmrgftg7tiqnmffpwzpgshix3km5syndcnqylenylylrki@wuh7zdqc5kse>
 <Z03h2spZMoHD1mHG@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z03h2spZMoHD1mHG@intel.com>

On Mon, Dec 02, 2024 at 11:35:38AM -0500, Rodrigo Vivi wrote:
>On Mon, Dec 02, 2024 at 08:40:34AM -0600, Lucas De Marchi wrote:
>> On Mon, Dec 02, 2024 at 10:50:14AM +0100, Greg KH wrote:
>> > On Fri, Nov 22, 2024 at 01:07:15PM -0800, Lucas De Marchi wrote:
>> > > From: Suraj Kandpal <suraj.kandpal@intel.com>
>> > >
>> > > commit 47382485baa781b68622d94faa3473c9a235f23e upstream.
>> >
>> > But this is not in 6.12, so why apply it only to 6.11?
>>
>> oops, it should be in 6.12.
>>
>> Rodrigo/Suraj why doesn't this patch have the proper Fixes trailer?
>
>hmm, missed fixes tag indeed, sorry...
>
>But it is already in v6.13-rc1, so it should be enough to get to 6.12
>and 6.11, no?!

yes, but we will need to submit it as it will (likely) not be picked
automatically.

Lucas De Marchi

