Return-Path: <stable+bounces-40164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 154528A96D1
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 11:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973E1B20D55
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF715B15B;
	Thu, 18 Apr 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mLmvZNat"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6115B145
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434164; cv=none; b=UM/LCKbYpFwa5qsG9RHc2ottijGiBWkLLezxJfYie41druvQQgUCXNZt7rlZbdV5G9/xRQAM6EXeIFIcvK/9hC+/JjysAc8o7DmYDOAUr8zuhuLIFlmG5YzcE8DR4bXlEOydfVqbnrdiXXQP6fBKzODJUnRzEJJqWC6ef0wSLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434164; c=relaxed/simple;
	bh=E2pI9JDlFqb8OrFCQPny00tj9D6kwl7z7/Mw92mAV64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbKEmwEmfvRjEfe9r4b/zZOegoUBpHj+fyMFR45NNzeTMDNcqyDaetY8AvmUF+NViNGSO7ICBsKWokTu6GbndM9evMxm+vpx9EHc+k2AtTBH0f/m9fJsode/f4CdybtmcELW65bYWuugOZ1/3dLXlurm9fKtbl6v7WO+agoWQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mLmvZNat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFD5C113CC;
	Thu, 18 Apr 2024 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713434164;
	bh=E2pI9JDlFqb8OrFCQPny00tj9D6kwl7z7/Mw92mAV64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLmvZNatIc9R5kTE46DFzmFbrZMWQKU5UnD6/I1+psGlJK9jFQhd2PtKzHLpwfMxL
	 i2M40fMWm1AqlffDiuu/fvkSs2+ZB/2bPop5jXX6xoOVL9PrI0SuC/l2RhRWMCZsdY
	 tDoPCGPDIieeR+EFurTeXZH0cBCM6+S25trJ70Zs=
Date: Thu, 18 Apr 2024 11:56:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dcrady@os.amperecomputing.com
Cc: stable@vger.kernel.org
Subject: Re: v5.15+ backport request
Message-ID: <2024041848-favorite-skydiver-5010@gregkh>
References: <20240416034626.163580-1-dcrady@os.amperecomputing.com>
 <2024041608-unnatural-bullpen-b38e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024041608-unnatural-bullpen-b38e@gregkh>

On Tue, Apr 16, 2024 at 06:37:28AM +0200, Greg KH wrote:
> On Mon, Apr 15, 2024 at 08:46:26PM -0700, dcrady@os.amperecomputing.com wrote:
> > Please backport the following v6.7 commit:
> > 
> > commit be097997a273 ("KVM: arm64: Always invalidate TLB for stage-2 permission faults")
> > 
> > to stable kernels v5.15 and newer to fix:
> 
> Any specific reason you didn't cc: the maintainers and developers of
> that change with this request?

Dropping from my review queue and will wait for you to resubmit this.

thanks,

greg k-h

