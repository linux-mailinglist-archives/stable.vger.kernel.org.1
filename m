Return-Path: <stable+bounces-181588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2417B98F19
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 10:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638CE3BD410
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBC289E36;
	Wed, 24 Sep 2025 08:41:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679828136E;
	Wed, 24 Sep 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703277; cv=none; b=YPwkXalxFYKiTQdvCbOIUvQZRBCtGlEKlCbHC62zoGYRNZTTdQ9USl7tDWCQgNcXHXEF5SHSIebCIRfH8KSmBgn6DaJYFWlyRUS2B2Vk6DX9GjvX9hf25VQFfI0gjUXQrKOq3Ro6nF02OcKgq+7344l3iQnUXEfgyQ7GH8L02H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703277; c=relaxed/simple;
	bh=QXn/qO4gV/dnfhpgMGyifJt/VNsT7VauOPD3mJA4Xok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCr03z+hFNXG+XvpFs32pTR+EIHwSSROxKki5dYK1bmIoDhnd2nZVnctS9PFjf28Z8I6GpKv5SPfkYz9xHcCYPvzJ4fB7OfG8YbuDRjUXRmRcNiW9hLEcyUKYdz2MP/7OLT+a4dp3CqALoMiKMZ2Pr0+j9rJ2MTO/Am+cQsqOuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40F6C106F;
	Wed, 24 Sep 2025 01:41:01 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14D683F66E;
	Wed, 24 Sep 2025 01:41:07 -0700 (PDT)
Date: Wed, 24 Sep 2025 09:41:05 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"dakr@kernel.org" <dakr@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Message-ID: <20250924-fancy-bull-of-opposition-0be83a@sudeepholla>
References: <20250923094514.4068326-1-kaushlendra.kumar@intel.com>
 <20250923-lurking-gaur-of-flowers-bb68f6@sudeepholla>
 <LV3PR11MB8768C62AFE6332ECDE9366EFF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3PR11MB8768C62AFE6332ECDE9366EFF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>

On Tue, Sep 23, 2025 at 06:03:08PM +0000, Kumar, Kaushlendra wrote:
> On Tue, Sep 23, 2025 at 3:30 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Tue, Sep 23, 2025 at 03:15:14PM +0530, Kaushlendra Kumar wrote:
> > > Fix incorrect use of PTR_ERR_OR_ZERO() in 
> > > topology_parse_cpu_capacity() which causes the code to proceed with 
> > > NULL clock pointers. The current logic uses !PTR_ERR_OR_ZERO(cpu_clk) 
> > > which evaluates to true for both valid pointers and NULL, leading to 
> > > potential NULL pointer dereference in clk_get_rate().
> > > 
> > > Per include/linux/err.h documentation, PTR_ERR_OR_ZERO(ptr) returns:
> > > "The error code within @ptr if it is an error pointer; 0 otherwise."
> > > 
> > > This means PTR_ERR_OR_ZERO() returns 0 for both valid pointers AND 
> > > NULL pointers. Therefore !PTR_ERR_OR_ZERO(cpu_clk) evaluates to true 
> > > (proceed) when cpu_clk is either valid or NULL, causing 
> > > clk_get_rate(NULL) to be called when of_clk_get() returns NULL.
> > > 
> > > Replace with !IS_ERR_OR_NULL(cpu_clk) which only proceeds for valid 
> > > pointers, preventing potential NULL pointer dereference in clk_get_rate().
> > > 
> > > Fixes: b8fe128dad8f ("arch_topology: Adjust initial CPU capacities 
> > > with current freq")
> > > Cc: stable@vger.kernel.org
> > > 
> > 
> > I wonder if you missed my response on v1[1] before you sent v2/v3 so quickly.
> > The reviewed by tag still stands, just for sake of tools:
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > --
> > Regards,
> > Sudeep
> > 
> > [1] https://lore.kernel.org/all/20250923-spectral-rich-shellfish-3ab26c@sudeepholla/
> 
> Hi Sudeep,
> 
> Thank you for the clarification and for providing the Reviewed-by tag!
> 

You are welcome.

> You're absolutely right - I apologize for missing your v1 response before 
> sending v2/v3. I was focused on addressing the feedback from other reviewers 
> (particularly Markus Elfring's suggestions about commit message improvements 
> and documentation compliance) and didn't properly check for your response first.
> 

Please take a look at these
https://lkml.org/lkml/2020/6/28/157
https://lkml.org/lkml/2024/6/25/1026
https://lkml.org/lkml/2024/1/30/1116
https://lkml.org/lkml/2025/9/2/812

> I really appreciate you maintaining the Reviewed-by tag through the versions, 
> and I'll make sure to check all responses more carefully before sending 
> subsequent versions in the future.
> 

Thanks.

> If possible you can ignore the later version of patch.
> 

Hmm, I see you have managed to send v4 before seeing my response on v1 and v3
and hence didn't add my review tag 🙁.

-- 
Regards,
Sudeep

