Return-Path: <stable+bounces-23866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53970868BE4
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C661C2202E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8116B136654;
	Tue, 27 Feb 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m7WHZpb3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4174913664F
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025028; cv=none; b=hIYlRBt0TXGumM8b/DsYc0zY4L8fhboxnuD3aB8FE3OaDYTmh+2CfGSlJik4dvYFU73XK9+YjnFVFhHO4LON4ILivzEZr196slXfApiGO8ZDzlUWBNXyrfBtka76c0ZmtTNIykSYyJXeX42UeltC+Njd59VXJbg9ElPz0J4f6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025028; c=relaxed/simple;
	bh=hC/gubxCw+Qg9ZRBkFswyYcpY8zcUjNchpx21rRhRyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3giNgKPYTf8NOb55HWF/25OBkdldnw++s+2eiuH73cB7yw6+yQ8PCYoXi/1IW0TEVOXZoEBo/9iS+JoqYUS4xiYt40VTsxYmJu9iPgOxrZlAnvXbcKv2CU3pHXDAwIYm/A4QTO5sjWShzPFBX0xi5lEjh2B7PgwGz/cj9NNgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m7WHZpb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93995C433C7;
	Tue, 27 Feb 2024 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709025027;
	bh=hC/gubxCw+Qg9ZRBkFswyYcpY8zcUjNchpx21rRhRyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m7WHZpb3SUYi7FCpNksRWlI3DEc9AQLIUNYwbQJocVw+PCNZI4PvMD2sHMoACjEn6
	 /GL7EERy36CIVeizDbQ/HsrWDUW4UNVrvO65tuAU306U+9K/mw8+7q4BtSd2u1cjIu
	 gdTmofeDMqEMigjY/2Pn1sDExlWioBQ0xvtW7JFc=
Date: Tue, 27 Feb 2024 10:10:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 6.6.y 0/6] Delay VERW - 6.6.y backport
Message-ID: <2024022743-employee-untimed-af9c@gregkh>
References: <20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com>
 <2024022740-smugness-cone-e80c@gregkh>
 <20240227090500.hfuo546w4cuio762@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227090500.hfuo546w4cuio762@desk>

On Tue, Feb 27, 2024 at 01:05:00AM -0800, Pawan Gupta wrote:
> On Tue, Feb 27, 2024 at 09:54:00AM +0100, Greg KH wrote:
> > On Mon, Feb 26, 2024 at 09:34:14PM -0800, Pawan Gupta wrote:
> > > This is the backport of recently upstreamed series that moves VERW
> > > execution to a later point in exit-to-user path. This is needed because
> > > in some cases it may be possible for data accessed after VERW executions
> > > may end into MDS affected CPU buffers. Moving VERW closer to ring
> > > transition reduces the attack surface.
> > > 
> > > Patch 1/6 includes a minor fix that is queued for upstream:
> > > https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/
> > 
> > Obviously I can't take this, you know that :(
> > 
> > Please include the actual commit in the series, when it hits Linus's
> > tree.
> 
> Backports to 6.6 and 6.7 will work without the commit waiting to be
> upstreamed.

Ok, that too is not obvious as you included it here :(

Please be more careful.  Take a day and do some testing and then resend
when ready.

thanks,

greg k-h

