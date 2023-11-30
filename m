Return-Path: <stable+bounces-3212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C27FEFF9
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F070E1C20DF9
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91DD46429;
	Thu, 30 Nov 2023 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwBSYZQ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CD39845
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA47FC433C8;
	Thu, 30 Nov 2023 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701350523;
	bh=449lL6+6tYXfMKNAmGDZExfCjKQ2K6PNx6km5QQUGt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwBSYZQ3SlbFfKDAIZHehhnSNL04q6Drs2lKhnxfaipsW9//BDZuE9olz8GMfLyBS
	 r3EXv47dWPGQqOLWAHBO3SHLtkpTpTRMms+dUIsZ0TXqn6QUJPwULMXCBb42ukD3wM
	 ZBg85X3t29Mn3gCLtX4uFzHd2Yvxtez10sIouHFE=
Date: Thu, 30 Nov 2023 13:22:00 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/i40iw: Prevent zero-length STAG registration
Message-ID: <2023113037-cycle-climatic-8876@gregkh>
References: <20231129224253.1447-1-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129224253.1447-1-shiraz.saleem@intel.com>

On Wed, Nov 29, 2023 at 04:42:53PM -0600, Shiraz Saleem wrote:
> [ Upstream commit  bb6d73d9add68ad270888db327514384dfa44958 ]
> 
> Currently i40iw allows zero-length STAGs to be programmed in HW during
> the kernel mode fast register flow. Zero-length MR or STAG registration
> disable HW memory length checks.
> 
> Improve gaps in bounds checking in irdma by preventing zero-length STAG or
> MR registrations except if the IB_PD_UNSAFE_GLOBAL_RKEY is set.
> 
> This addresses the disclosure CVE-2023-25775.
> 
> i40iw is replaced by irdma upstream starting 5.14, resulting in adjustments
> to upstream commit to support the older APIs.
> 
> The kernel versions to apply this patch are 5.10.x 5.4.x 4.19.x 4.14.x.

We also need a working version for 5.15.y so that you do not have a
regression when you update kernel trees.

thanks,

greg k-h

