Return-Path: <stable+bounces-78335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E56298B684
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083CA1F250DA
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2211BD005;
	Tue,  1 Oct 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vcgkJZBL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5529A1
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769992; cv=none; b=AqIisu4Ko9s60sJneBenpOFWRLmeVXj157mRyYXsNugwShEBw74Riv/j+gVh8WedLlw3hvAht8xEPxzpba5zP4BehlZrHKA2W1qN5ab4FCmiawn883jnhjQ5JX/nrcQa7CQJ2LmUMTZCnjGSqRI5XCATpnUgVSLjW0utECVwpjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769992; c=relaxed/simple;
	bh=QA4X3VFLvAi3+SvsieLATQWEJOCWS4gatE4bPKf4oUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWbH6Bf7fOJeBVbSNUpO8gkr1uMP7vw8DeOSSJVgJht3gIYjEA/hToTMDSmwB0/D4mIXU7AgWDVjuOHkRYPjjzZo0AA6V1vLSiWghLXGH0c6CrEAYYShazUc2ocg2yAV/+PcOtIfps6HSHR0OGSnPheixtSHMNBRgRa7Lvf9XaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vcgkJZBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2887C4CEC6;
	Tue,  1 Oct 2024 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727769991;
	bh=QA4X3VFLvAi3+SvsieLATQWEJOCWS4gatE4bPKf4oUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vcgkJZBLGjfIyekX/h3lH2Zd6Sj/L/cmC+2cQIQ/BBUBk+ZF0MvKlWHhb7HocyP2k
	 JA3rn2dWdG9bvI01ADxHcbz5w+QJexWT8S0MR51FWQmWt9MWoTa5qqC1+zSMg93lp2
	 5iGaxA3lqVKR35iSqqCX3do/XWJBFIksmWTrHZNw=
Date: Tue, 1 Oct 2024 10:06:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: stable@vger.kernel.org, x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	Pawan Kumar Gupta <pawan.kumar.gupta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH 5.10.y 0/3] x86: Complete backports for x86_match_cpu()
Message-ID: <2024100115-pessimism-mayday-cbd9@gregkh>
References: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>

On Sat, Sep 28, 2024 at 09:24:28AM -0700, Ricardo Neri wrote:
> Hi,
> 
> Upstream commit 93022482b294 ("x86/cpu: Fix x86_match_cpu() to match just
> X86_VENDOR_INTEL") introduced a flags member to struct x86_cpu_id. Bit 0
> of x86_cpu.id.flags must be set to 1 for x86_match_cpu() to work correctly.
> This upstream commit has been backported to 5.10.y.
> 
> Callers that use the X86_MATCH_*() family of macros to compose the argument
> of x86_match_cpu() function correctly. Callers that use their own custom
> mechanisms may not work if they fail to set x86_cpu_id.flags correctly.
> 
> There are three remaining callers in 5.10.y that use their own mechanisms:
> a) setup_pcid(), b) rapl_msr_probe(), and c) goodix_add_acpi_gpio_
> mappings(). a) caused a regression that Thomas Lindroth reported in [1]. b)
> works by luck but it still populates its x86_cpu_id[] array incorrectly. I
> am not aware of any reports on c), but inspecting the code reveals that it
> will fail to identify INTEL_FAM6_ATOM_SILVERMONT for the reason described
> above.
> 
> I backported three patches that fix these bugs in mainline. Hopefully the
> authors and/or maintainers can ack the backports?
> 
> I tested patches 2/3 and 3/3 on Tiger Lake, Alder Lake, and Meteor Lake
> systems as the two involved callers behave differently on these systems.
> I wrote the testing details in each patch separately. I could not test
> patch 1/3 because I do not have access to Bay Trail hardware.

This and the 5.15 series now queued up, thanks.

greg k-h

