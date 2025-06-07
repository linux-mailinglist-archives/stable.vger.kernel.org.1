Return-Path: <stable+bounces-151742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B78D3AD0B8C
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55776188E2D1
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 07:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F01F3D20;
	Sat,  7 Jun 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0jdPSNS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9091CF7AF
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749280239; cv=none; b=SvW87uhaAOpkvO1eBvCYInYMI3x0blUaouga7E5ZjI+f8x4lmhwWPpfJVYCnPU9MZ5cQ7F6gmaQjlqFDwrfgQ+xYlVbszS/P5TQhpCjOEE63C63jM/UGW/XZi+tIS2zvJfFUw+kFh7vabmplR/HhEOHklz3GWiVoYw0Jwhhn8l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749280239; c=relaxed/simple;
	bh=amQEes7dq+DSrjfO5C5QEje0E7MJgqiVHXPGj78tmNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEunf97jtH50/+X+OgXZjpQNN383b+IKkdxY+4yvt7qRRk6btcwVUf2zYDmqguzsQEhfHZ72rR7IV0OY+1qjpELT8sDjHm6vtpyxfR5gn2/nYMuZToxfaYmbMToSmcDPS8I70Yah/G+nkeLHZid04xF2+pyIsmYkbD57rW7K7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0jdPSNS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BABC4CEE4;
	Sat,  7 Jun 2025 07:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749280238;
	bh=amQEes7dq+DSrjfO5C5QEje0E7MJgqiVHXPGj78tmNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0jdPSNS3y2J5pxph+G9EqU2AtjcU05LJggALMcUOmos6IuD85BdZsGY32zQoeWfY1
	 JbgtwXMqYsvDCafF3IiKHtRVhsto9jzcYKqbiS6UBm21acSowpEDkGwUXkAkeifvnZ
	 j3zgUsQqZPWArOEYnE5EKtx1HHPRCPwysvpHWsKE=
Date: Sat, 7 Jun 2025 09:10:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: stable@vger.kernel.org
Subject: Re: Request for backporting accel/ivpu PTL patches to 6.12
Message-ID: <2025060727-whoopee-reentry-f29c@gregkh>
References: <fe7c8681-83de-4f3e-8dab-04185f0f9416@linux.intel.com>
 <2025060411-tableful-outage-4006@gregkh>
 <ddfa88ba-cf7c-44b0-93b0-f67383c787af@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddfa88ba-cf7c-44b0-93b0-f67383c787af@linux.intel.com>

On Fri, Jun 06, 2025 at 02:09:49PM +0200, Jacek Lawrynowicz wrote:
> Hi,
> 
> On 6/4/2025 3:21 PM, Greg KH wrote:
> > On Tue, Jun 03, 2025 at 12:42:09PM +0200, Jacek Lawrynowicz wrote:
> >> Hi,
> >>
> >> Please cherry-pick following 9 patches to 6.12:
> >> 525a3858aad73 accel/ivpu: Set 500 ns delay between power island TRICKLE and ENABLE
> >> 08eb99ce911d3 accel/ivpu: Do not fail on cmdq if failed to allocate preemption buffers
> >> 755fb86789165 accel/ivpu: Use whole user and shave ranges for preemption buffers
> >> 98110eb5924bd accel/ivpu: Increase MS info buffer size
> >> c140244f0cfb9 accel/ivpu: Add initial Panther Lake support
> >> 88bdd1644ca28 accel/ivpu: Update power island delays
> >> ce68f86c44513 accel/ivpu: Do not fail when more than 1 tile is fused
> >> 83b6fa5844b53 accel/ivpu: Increase DMA address range
> >> e91191efe75a9 accel/ivpu: Move secondary preemption buffer allocation to DMA range
> >>
> >> These add support for new Panther Lake HW.
> >> They should apply without conflicts.
> > 
> > That's way larger than the normal "add a new quirk or device id" patch
> > for new device support, right?  Why do you feel this is needed and
> > relevant for 6.12.y and meets the requirements that we have for stable
> > kernel patches?
> 
> Yeah, maybe I overshot a bit. Sorry about this.
> I wanted to provide the best possible PTL experience but most of these patches are not critical.
> 
> The absolute minimal set of patches to enable PTL is:
> c140244f0cfb9 accel/ivpu: Add initial Panther Lake support
> 88bdd1644ca28 accel/ivpu: Update power island delays
> 
> Please include just these two.

Both now queued up, thanks.

greg k-h

