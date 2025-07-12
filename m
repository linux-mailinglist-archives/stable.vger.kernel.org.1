Return-Path: <stable+bounces-161701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 936EBB02AC1
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2661C22B6A
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 12:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A04221FAA;
	Sat, 12 Jul 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C7fe2Zzf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CE81E
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752321909; cv=none; b=QxgLCX6xomwwrtGwgs+QHgWaB3DLecYnRgPZZ5wIx0m1tA/Qk49LvbFVOkg0oZthm1jpUA672Y3wlWG6vUM+udyeGaerLuVIvSbjJYUboRTzvKNxuqs1WuSCzH1KBLGJPIlMvBKQS8sJdegiqOsMNSOBhpEo594u+nDqxA84GWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752321909; c=relaxed/simple;
	bh=dnqV8BrWGTZHMDF9bv2qL2DQGHEVkhgWzc92Yv7DX/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPy6eUM4UwgkMGKshT1tiDOXcbemtF5vBOcBDt3dr1DMS+LkvJI6RInQjT2ufH8h1XiAabqMksUFdkDta6DpRKHxu3R4b3QteAtGmPCablhBthrX7vPqujgM5h91nVaBeNoB+xKQxvpiNDm4SKuMrRg3Ack1w9V0ZKs3bo5TTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C7fe2Zzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36686C4CEEF;
	Sat, 12 Jul 2025 12:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752321908;
	bh=dnqV8BrWGTZHMDF9bv2qL2DQGHEVkhgWzc92Yv7DX/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7fe2ZzfPCXKl495TZVf6FOflOLWEAWz8tWwJju7BpkFHKYsaHtv6BmrpUwj3dX+u
	 j8WKQlobkPfDTaWHIlUFa9t/YC4CmX7+Hf3iX0BJ3LTHl/YHxrvaCmfaRLrffL3rqO
	 DSI2rIS5tfhB9NGa3UdQG8HqcD6tZMDFqPxExCkA=
Date: Sat, 12 Jul 2025 14:05:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Gray <jsg@jsg.id.au>
Cc: stable@vger.kernel.org, flora.cui@amd.com, alexander.deucher@amd.com
Subject: Re: 6.12 drm/amdgpu ip discovery for legacy asics
Message-ID: <2025071258-name-number-b179@gregkh>
References: <aHCFws53G5vjFheh@largo.jsg.id.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHCFws53G5vjFheh@largo.jsg.id.au>

On Fri, Jul 11, 2025 at 01:32:18PM +1000, Jonathan Gray wrote:
> After 6.12.36, amdgpu on a picasso apu prints an error:
> "get invalid ip discovery binary signature".
> 
> Both with and without picasso_ip_discovery.bin from
> linux-firmware 20250708.
> 
> The error is avoided by backporting more ip discovery patches.
> 
> 25f602fbbcc8 drm/amdgpu/discovery: use specific ip_discovery.bin for legacy asics
> 2f6dd741cdcd drm/amdgpu/ip_discovery: add missing ip_discovery fw
> 
> second is a fix for the first
> 

Now queued up, thanks.

greg k-h

