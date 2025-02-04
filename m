Return-Path: <stable+bounces-112142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392CEA27074
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 12:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B250C1889798
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2720CCC7;
	Tue,  4 Feb 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kR2kb+IK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78020C494
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668964; cv=none; b=UhZmRIoC5V6cSciM7NdW+uaNqjHK6Ts04P7Jf3KPjK5VBHlsSaSIU7Kvtap0QHrmGFsocApd6Q9T6Q11khehYXDR6E58aCBtJzAkrAYTo3ryqGD1oOaPrfyAS74GpxaZr0EojPP/73Q4v6i0pH6mSzp/9X5pTN6+lw8RmBhto44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668964; c=relaxed/simple;
	bh=uImmeXFabwtZG4Lc8/3lFPCcaS16K656WgRzsxnQEt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMEh0PurMOT+eWQTt9YRa2yD6m3b57TKn5FuoYUUaX0MxKGLpns3OW3zfLS1QKSZFd3tFt4qTRJTpPfwcPHo+v9npv8x95L85t0Kw/jfnqx8YiGgozWO6oR/ovidmhmuDcDofmcRXeeqrjldPGPf5ydRCJvA3/m3bDYq9WofMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kR2kb+IK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E01C4CEDF;
	Tue,  4 Feb 2025 11:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738668963;
	bh=uImmeXFabwtZG4Lc8/3lFPCcaS16K656WgRzsxnQEt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kR2kb+IKgejdWLbOEetwjoUKNEnf9IibxwPCFrmE2WYrQVrTFxKfQ/FuSS3ynfZWh
	 HiMJyhZxnzdo6PsAqW5VArrnWDoCatF4xL8RNpvZ6P4/7BezIm/ZvLWwx17a1WMUxM
	 AxidpnwjGZLHST89PN571kiVWvJPVBm8MINIebtU=
Date: Tue, 4 Feb 2025 12:36:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Request to apply 961b4b5e86bf to LTS kernels
Message-ID: <2025020455-antarctic-unmoral-0e2f@gregkh>
References: <80e35d0e-1786-4dd2-af77-6b33de80d8f5@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80e35d0e-1786-4dd2-af77-6b33de80d8f5@oracle.com>

On Thu, Jan 30, 2025 at 09:55:25AM -0500, Chuck Lever wrote:
> Hi -
> 
> May I request that you apply
> 
>   961b4b5e86bf ("NFSD: Reset cb_seq_status after NFS4ERR_DELAY")
> 
> to all LTS kernels that don't have it?
> 
> I've checked that it applies cleanly to at least v6.1 and run
> it through NFSD CI. It should not be a problem to apply it
> elsewhere.

Now queued up, thanks.

greg k-h

