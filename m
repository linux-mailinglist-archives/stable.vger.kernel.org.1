Return-Path: <stable+bounces-96103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471009E0712
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3EE287590
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998A205ACD;
	Mon,  2 Dec 2024 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmzu190U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD01D63FC
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153326; cv=none; b=ShiGhMUtBDDpaJsINXxDoi9SOZhQ1oIV5SmZHuI4aHAF2+Vb5AnbVli7Y+lbVi4in9MLI7bLZKXSi0/nbd4HNOjD6jgwn66cVeV50beuGUR1q3k3t9lsviGTWc6frfJ4tqj6WNmeG38sbh7/CxfFBmm9CwBVscFHZpQfMhDUY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153326; c=relaxed/simple;
	bh=3xrPoLL2vuICL63hP8Ap3gAEA3OhEKu9P+TNMDZZN6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnsMqsk7Eu31C5pboKrCx30+6hcX7Ei7CGzc3t9E+o/6/uFu/QS9cVe41FQujGb04EsJRGvpjnnX7APXTHIUjpUe70uw2BJdP56LbyUPacmmq2f5anPzUwLUwFVjwjZL3cyKPGpLXzr1vqyWdNbG7aMfkBOrZBZupmFMkn8jj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmzu190U; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733153325; x=1764689325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3xrPoLL2vuICL63hP8Ap3gAEA3OhEKu9P+TNMDZZN6I=;
  b=cmzu190UVw0Yj5O42grSUqDO1gp5DWYeR6bsfZ2/cZJX8M4t9MvwRnW7
   zO483e1KCzGNRTw7DgLz7XfHjnuyMxI8/r3h37B1sFQyP2rYfnXuIifoi
   HiTog8ZF08kbaPjfcToBI+TTZwc8F2e8HJGZW4lD92On1/MUN4QEogUHf
   qfDMU5VCTA4gGGthVJt/2myy0R+hIlQdtAp6U09PSKOsHIAOmzLMbKhEj
   /RDCzrvVTVWNPAF+s7dr6IBxCgKoOcP4f2TMqQSoDSktX6gDgQsIZC/lX
   FJEDF0WfDhhDW5avFCCWbKwU89eiCd5tWV2v71254Llu5sjaD8Vms/WJQ
   w==;
X-CSE-ConnectionGUID: 2GC6c9DDTfeAQA0wawxuqw==
X-CSE-MsgGUID: bwapPsjdRc2kKpAAvkgMOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="43936174"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="43936174"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 07:28:44 -0800
X-CSE-ConnectionGUID: PIxlHJGCSGSTNrMAH4JOnQ==
X-CSE-MsgGUID: fL21de+qRCK5nIlc3jXWwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="130612702"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.111.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 07:28:44 -0800
Date: Mon, 2 Dec 2024 09:28:38 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.11 27/31] drm/xe/display: Do not suspend resume dp mst
 during runtime
Message-ID: <oqxdvwceub3zctbrfx722ctxfewys6gd3banczpcn7gy4xpkqq@zlzbufudm7bi>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
 <20241122210719.213373-28-lucas.demarchi@intel.com>
 <2024120222-mammal-quizzical-087f@gregkh>
 <i5j7pmrgftg7tiqnmffpwzpgshix3km5syndcnqylenylylrki@wuh7zdqc5kse>
 <2024120254-xbox-record-1bb9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2024120254-xbox-record-1bb9@gregkh>

On Mon, Dec 02, 2024 at 03:47:14PM +0100, Greg KH wrote:
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
>>
>> >
>> > We can't take patches for only one stable branch, so please fix this
>> > series up for 6.12.y as well, and then we can consider it for 6.11.y.
>>
>> all these patches should already be in 6.12... I will take a look again
>> to make sure we aren't missing patches there.
>>
>> >
>> > Also note that 6.11.y will only be alive for maybe one more week...
>>
>> ok, then maybe the distros still using 6.11 will need to pick these
>> downstream or move on.
>
>I think most will have moved on by now, do you know any that are
>sticking with 6.11.y?

 From https://ubuntu.com/kernel/lifecycle it seems 6.11 EOL will be
Jul/2025.  They already have most of these patches, but not all. My
intention was to migrate the fixes they've got to benefit all the 6.11
users... if other distros migrate to 6.12, then I believe this is not
needed.

Lucas De Marchi

>
>thanks,
>
>greg k-h

