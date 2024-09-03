Return-Path: <stable+bounces-72829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F8969C99
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 13:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA77A2861BC
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F62C1C62CE;
	Tue,  3 Sep 2024 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaB6vy5O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B351A42BB;
	Tue,  3 Sep 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364713; cv=none; b=OgS927bkPz1QfMqg/ClotJ8pQcqwTATZy+lsB0gkkY3UATqE5ije/7XnkNGI5yLDPx7OkJcBbuNDUyVYI7pQ/p2gtFwIkO+TOsG4SN4JQHQi/0rDezWiA4o2CbFZmpG4d75ZBIQbaPgYg3Fm0QRUFiH/rEAt8phdyg075Eda7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364713; c=relaxed/simple;
	bh=ho3a+goSixIxtHo5Q0MzAJ11MSE158QsIAhRaUpd8MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euKkVzq+QNIZxMPHhQA7xht7IV/zryAMSGp9/eF2QH9u73I5ye72Oyof8wUNGjlTkLEl7nSYh0AP6PIr7kiZpTczHHsPcg2fsCcLOSrljUuNjwQkm0xuI2iWt3Iiqo7/bSOYaoyYQBvC78cvOCG6riRH02zpRk5D92qcTycdSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaB6vy5O; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725364712; x=1756900712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ho3a+goSixIxtHo5Q0MzAJ11MSE158QsIAhRaUpd8MU=;
  b=CaB6vy5Ozk022MaK2LwzqFhEDq/XBO3FCfsRl/mFl+0p/YywIJxObOy6
   tW5+/ujTOVVwJ46y6eonKxVYxqY6tJE/HE4zL6zE+ULMgiIobYXfF+UBN
   O32NVR0fUo4ej8S8GwfGbRQc8NnkTN15EmMdl7Ar3kw99UH28ii6zOVMV
   AMA2bvXgdBB/1Eo3KoOk+WtXBnJztL87gPQ2l29fSM7p54WlwBloqAmVu
   7+QwbF1oV+VH5RIVbomMXuNbOrCUex6hy/vQgmsBldo1/LlWWuipuaIGR
   rqKhFPIwTfFoDpPerE+eEuJjajFDDuGxGdB23ZpHhjm9kIrDIqAu5WuRZ
   A==;
X-CSE-ConnectionGUID: Z7gJC5aZShCf+8m49yLp0A==
X-CSE-MsgGUID: TsPQF/+QS9iCNTn6ArWdZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24095440"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="24095440"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 04:58:31 -0700
X-CSE-ConnectionGUID: 9cTWDaHWSQ2uafim1C8LNw==
X-CSE-MsgGUID: v4eO71WuSTeX+OaeFClYAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="65616954"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa008.jf.intel.com with SMTP; 03 Sep 2024 04:58:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Sep 2024 14:58:27 +0300
Date: Tue, 3 Sep 2024 14:58:27 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>, Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix cable registration
Message-ID: <Ztb544ShtH/r1guX@kuha.fi.intel.com>
References: <20240830130217.2155774-1-heikki.krogerus@linux.intel.com>
 <2024090331-confiding-preflight-a260@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090331-confiding-preflight-a260@gregkh>

On Tue, Sep 03, 2024 at 10:06:59AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 30, 2024 at 04:02:17PM +0300, Heikki Krogerus wrote:
> > The Cable PD Revision field in GET_CABLE_PROPERTY was
> > introduced in UCSI v2.1, so adding check for that.
> > 
> > The cable properties are also not used anywhere after the
> > cable is registered, so removing the cable_prop member
> > from struct ucsi_connector while at it.
> > 
> > Fixes: 38ca416597b0 ("usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 30 +++++++++++++++---------------
> >  drivers/usb/typec/ucsi/ucsi.h |  1 -
> >  2 files changed, 15 insertions(+), 16 deletions(-)
> 
> This doesn't apply to my usb-linus branch at all:
> 
> 	checking file drivers/usb/typec/ucsi/ucsi.c
> 	Hunk #1 succeeded at 965 (offset 54 lines).
> 	Hunk #2 FAILED at 941.
> 	Hunk #3 succeeded at 1203 (offset 52 lines).
> 	1 out of 3 hunks FAILED
> 	checking file drivers/usb/typec/ucsi/ucsi.h
> 	Hunk #1 succeeded at 465 (offset 30 lines).
> 
> Can you rebase and resend?

Will do. Thanks.

-- 
heikki

