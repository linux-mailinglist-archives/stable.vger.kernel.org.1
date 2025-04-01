Return-Path: <stable+bounces-127304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05188A77758
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79FB16A46A
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D61EDA01;
	Tue,  1 Apr 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvJPz23u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF81EDA05
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498743; cv=none; b=pjQ3sKaXwiALTSe1w1EWK+Rh3MVdRAvbDOtTGy9irvRSaT9auWn2oQSu1kuNe1/7yckXH2kVF9Tw9whMoZK4HPcrQqJhDBq1fJc6DheO2qWD9gV5FALDZv3so9/l19BvRc+y2f1bPz5bifEckaE/pZMnGFtmHyXzp5DrWZKCoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498743; c=relaxed/simple;
	bh=MzwEEmtin+d9TVtkXd3peX2PkMiXvi9C+lB6Wza/2eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIGuclHnU8PBrwBlxtwRXsIRMw+RCHjYZVoj4MA+GijX0cjMbyD7N43TsmvTZZg3pyVPiYoEYDxQUBLfdPfrOB6S6m42EvkVWG7uB9aI7SFXq50pRD49AXbxJR7N7+G7goA/cvoW6kuAPCyAV5p+xrNeTuUbS6kXBQ+RgUFB8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvJPz23u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95616C4CEE4;
	Tue,  1 Apr 2025 09:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743498742;
	bh=MzwEEmtin+d9TVtkXd3peX2PkMiXvi9C+lB6Wza/2eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvJPz23ulAR/D5U+4XaUOiYRLjiSKQvnvyUl6VXNC1Bb9cBTGfb8//r9eHB6IFLKC
	 FkwRM5NVSynjRUqKUC1VkL9XZCUihvaKy3UIv2mhKke/pSbyWNzIK232fQc7juBP0v
	 e6Vzlx8wZIe5Z+dJaO6jWWJMWEfmtdeYiFnekLNE=
Date: Tue, 1 Apr 2025 10:10:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Munehisa Kamata <kamatam@amazon.com>
Cc: stable@vger.kernel.org, keescook@chromium.org, yangyj.ee@gmail.com
Subject: Re: Request to cherry-pick a few ARM mm fixes
Message-ID: <2025040145-pension-sufferer-589f@gregkh>
References: <20250328184609.751984-1-kamatam@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328184609.751984-1-kamatam@amazon.com>

On Fri, Mar 28, 2025 at 11:46:09AM -0700, Munehisa Kamata wrote:
> Hello stable maintainers,
> 
> The following mainline commits fix a certain stack unwinding issue on ARM,
> which had existed till v6.9. Could you please cherry-pick them for 5.4.y -
> 6.6.y?
> 
>  169f9102f919 ("ARM: 9350/1: fault: Implement copy_from_kernel_nofault_allowed()")
>  8f09b8b4fa58 ("ARM: 9351/1: fault: Add "cut here" line for prefetch aborts")
>  3ccea4784fdd ("ARM: Remove address checking for MMUless devices")
> 
> Confirmed these cleanly apply and build in all the branches.

Now queued up, thanks.

greg k-h

