Return-Path: <stable+bounces-88077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210719AE90E
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C32282FC4
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990BF1E0E0A;
	Thu, 24 Oct 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tos/w7Cx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4514F12F;
	Thu, 24 Oct 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780783; cv=none; b=mFIgI8V9SREPDGrxqdjNPumrvX5X9JtGYu32BcndvZisRER8b+Xo336DMoyLwtjxQoalctpk4CqlzrGPh2lWJL0/rEcum0Q/iRpEgyYeXuQyNivP4CTauLAw+S95swgE48fQb469p+i0SdQM0FBPZHCEbxT9uEvnvD5BILdU6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780783; c=relaxed/simple;
	bh=j7R7q/n1DGRJwGT/TXFXwmZAbDEB6EUvmAjBQm7Nx6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o314P5gpYlapGikD583SvKm1AvaYjVJ+QceRz7HPv9FFlCHsFiJJbqqu97rSlnRVoc6jA0hmVj5XErbCE0JnO4DoIrS86LZHPzQdUwNB+58/uxA9JNTc8A8PbPIhRbEU3P0I4wf2tNpD1zrmQJzWGDZTYujQv7ayDv2gvD5twXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tos/w7Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91EEC4CEC7;
	Thu, 24 Oct 2024 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780782;
	bh=j7R7q/n1DGRJwGT/TXFXwmZAbDEB6EUvmAjBQm7Nx6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tos/w7CxlYFcGag7h2b3k8RKWpM4Hz+vbcPW6zd94dK2EM7zuI7TZQJf9Nh7uwrtV
	 oMknMJ5wJXS64s73pcdxC2H3kUczbjgudI2JR9bw5o7IlNkqmgJ+EU9restFtTBQwH
	 RAiw2022PlE0qH1Mduq5TvPJuldOxzuCJfx5L0PrQam/03YvYyBl7HxKwG1oII1I0F
	 64bHtdsLbymYCNTn+q4Zs/ZmYe4qeSDrF/PVKdrHL1JvtFjIYhvLKWhU7OANh0rpj9
	 hR9RqISWgDgGASa2TFVFrgyiKFfwI9ltvuAX5DUG6taf1DBiV0BjRuuLVQ2fbk+od8
	 Xf9f19zJaS0lw==
Date: Thu, 24 Oct 2024 15:39:39 +0100
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, Tarun K Singh <tarun.k.singh@intel.com>
Subject: Re: [PATCH iwl-net 2/2] idpf: fix idpf_vc_core_init error path
Message-ID: <20241024143939.GQ1202098@kernel.org>
References: <20241022173527.87972-1-pavan.kumar.linga@intel.com>
 <20241022173527.87972-3-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022173527.87972-3-pavan.kumar.linga@intel.com>

On Tue, Oct 22, 2024 at 10:35:27AM -0700, Pavan Kumar Linga wrote:
> In an event where the platform running the device control plane
> is rebooted, reset is detected on the driver. It releases
> all the resources and waits for the reset to complete. Once the
> reset is done, it tries to build the resources back. At this
> time if the device control plane is not yet started, then
> the driver timeouts on the virtchnl message and retries to
> establish the mailbox again.
> 
> In the retry flow, mailbox is deinitialized but the mailbox
> workqueue is still alive and polling for the mailbox message.
> This results in accessing the released control queue leading to
> null-ptr-deref. Fix it by unrolling the work queue cancellation
> and mailbox deinitialization in the order which they got
> initialized.
> 
> Also remove the redundant scheduling of the mailbox task in
> idpf_vc_core_init.

I think it might be better to move this last change into a separate patch
targeted at iwl rather than iwl-net. It isn't a fix, right?

> 
> Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Cc: stable@vger.kernel.org # 6.9+
> Reviewed-by: Tarun K Singh <tarun.k.singh@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

...

