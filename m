Return-Path: <stable+bounces-135108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A730DA968B6
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 14:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775CD3BA9B0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B444C1AB531;
	Tue, 22 Apr 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/RSBhj/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BB4A3C;
	Tue, 22 Apr 2025 12:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324271; cv=none; b=C+8FeTyDu49wJn501mpfzDUtr+EOsxlffZqqjozmv3UqMtlP0ZDUrhsC079PMT7Xuscox7rttk4TP2///9QyFG/8i7tb+4RrbpM4h0vHxlInxFTPLwEQQ2iGJfPH6gB7fwvF6uEL/DkHdnY5/SNW7Xt63LPURDQHK2/6WkFW/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324271; c=relaxed/simple;
	bh=BUfBS1olvnBAC5Sam459VRxNa4KZVnHDVMi1DErPxP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTC2VE/Reoyw5UDo469dLjZvg7c4fhd18cj48Wf/6Q7cfjPwfiKkIc2AmjjsFFrZsZKpsy8X74qhk9k01NLdjggzZBl5XLzpTipo7Xcn6/Dc9ElKWLDTVCoglfnwB444nLabtI6wrArovoQ1sXnQ/sks/sYoaBmh9/B9Dj2IU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J/RSBhj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85109C4CEE9;
	Tue, 22 Apr 2025 12:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745324270;
	bh=BUfBS1olvnBAC5Sam459VRxNa4KZVnHDVMi1DErPxP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/RSBhj/BUwxZsexAGiw70yijBy0GBgg+1XHXcbljmGFMO7g6kI4OSakpstczr2ID
	 GRVqm6LvoKP96QL7jIz8bpnLt7DmLKahe2+aE488zOxyrXghU3G4QJP4/1Tn+uqCgV
	 OabJukt2y3ONWQpTLfv1etzRVrN+HnOsT83DCDIU=
Date: Tue, 22 Apr 2025 14:17:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@intel.com>
Subject: Re: [PATCH] accel/ivpu: Add handling of
 VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Message-ID: <2025042227-crumb-rubble-7854@gregkh>
References: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408095711.635185-1-jacek.lawrynowicz@linux.intel.com>

On Tue, Apr 08, 2025 at 11:57:11AM +0200, Jacek Lawrynowicz wrote:
> From: Karol Wachowski <karol.wachowski@intel.com>
> 
> commit dad945c27a42dfadddff1049cf5ae417209a8996 upstream.
> 
> Trigger recovery of the NPU upon receiving HW context violation from
> the firmware. The context violation error is a fatal error that prevents
> any subsequent jobs from being executed. Without this fix it is
> necessary to reload the driver to restore the NPU operational state.
> 
> This is simplified version of upstream commit as the full implementation
> would require all engine reset/resume logic to be backported.

We REALLY do not like taking patches that are not upstream.  Why not
backport all of the needed patches instead, how many would that be?
Taking one-off patches like this just makes it harder/impossible to
maintain the code over time as further fixes in this same area will NOT
apply properly at all.

Think about what you want to be touching 5 years from now, a one-off
change that doesn't match the rest of the kernel tree, or something that
is the same?

thanks,

greg k-h

