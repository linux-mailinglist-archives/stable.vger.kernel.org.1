Return-Path: <stable+bounces-96060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF8B9E0665
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6922E16B8A7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A83207A17;
	Mon,  2 Dec 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flSN9BDo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A1207A16
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150441; cv=none; b=ppzpXbY9/prXOSq/ToF+T7VOFz/9H55z0HlxAh1pp9j421wiV0ZsoACFyj3KGkNItcIPPi1vcdBhMT8VrcuC9tENGeS4wqLJrw4pLtGsWfopgnBhzQLO+h30WiNdEwBS6l71L9JNa+/oDQBt2SML5OxDg07Llf8FS4VUfkuMffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150441; c=relaxed/simple;
	bh=8pPcH85nhfF5jA4iZbA0nosF7IrI8r9yBuIFJ2Cm3Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DH/qx6dO89hNfTi3mJUJvvtiY0/9z/lK9oJIBqj2cLjxxCtFGa1P8t5IZoIYoAapBWV5lmrFFgq8FrVR2VRD1Lbbo16yU1Xi+0M0FOQpNx+ELEL15TwvCE9BX2IrmxypJxUr040XeEx6RwoD9Q1BRRPCTI7mKuS4CBd6dr3qtI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flSN9BDo; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733150440; x=1764686440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8pPcH85nhfF5jA4iZbA0nosF7IrI8r9yBuIFJ2Cm3Gk=;
  b=flSN9BDodiKunDUs56b5rkahU536EJQoLDzmBq1yeuWmOvvw7a6KGvf5
   5VPUfqqPf9VFDosgveJEZrTjFLyAOKhxpBVRw1J2Mg8d/KdF3H+fJYHh1
   DBj3NT04+sMkJV+OL9zEmwlR0UzRd69xnClJaQINfRQ3UiEYx1LnEvmBY
   i2WiF+qxLUBRFvueFShZusoj6AOQqd0aDGYqDVtNsbPLqnbSFPCXyJFED
   tvW3+I3WvZ8h21CjrwEc14ISQX8EAq3d2fTg3lz1hs1BC1QRl0Z4t1chI
   ik3hfCEBSPkTzkIBzU5M0eY+iiO4AqPoZP4T/IplcTMU2EzIgw/7XKlks
   Q==;
X-CSE-ConnectionGUID: 8UZjMmHVSYiy6J8EiEBdwg==
X-CSE-MsgGUID: a7hcHijZTt62/mFeWLYaZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32678675"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="32678675"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 06:40:39 -0800
X-CSE-ConnectionGUID: UF80WvgXQfa5Ckbi6I49Rg==
X-CSE-MsgGUID: rJCntOOURRmcTEk7FUSfmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93960641"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.111.145])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 06:40:39 -0800
Date: Mon, 2 Dec 2024 08:40:34 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: Re: [PATCH 6.11 27/31] drm/xe/display: Do not suspend resume dp mst
 during runtime
Message-ID: <i5j7pmrgftg7tiqnmffpwzpgshix3km5syndcnqylenylylrki@wuh7zdqc5kse>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
 <20241122210719.213373-28-lucas.demarchi@intel.com>
 <2024120222-mammal-quizzical-087f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2024120222-mammal-quizzical-087f@gregkh>

On Mon, Dec 02, 2024 at 10:50:14AM +0100, Greg KH wrote:
>On Fri, Nov 22, 2024 at 01:07:15PM -0800, Lucas De Marchi wrote:
>> From: Suraj Kandpal <suraj.kandpal@intel.com>
>>
>> commit 47382485baa781b68622d94faa3473c9a235f23e upstream.
>
>But this is not in 6.12, so why apply it only to 6.11?

oops, it should be in 6.12.

Rodrigo/Suraj why doesn't this patch have the proper Fixes trailer?

>
>We can't take patches for only one stable branch, so please fix this
>series up for 6.12.y as well, and then we can consider it for 6.11.y.

all these patches should already be in 6.12... I will take a look again
to make sure we aren't missing patches there.

>
>Also note that 6.11.y will only be alive for maybe one more week...

ok, then maybe the distros still using 6.11 will need to pick these
downstream or move on.

Lucas De Marchi

>
>thanks,
>
>greg k-h

