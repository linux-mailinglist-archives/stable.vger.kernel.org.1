Return-Path: <stable+bounces-188003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16869BF0182
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB063E5643
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA0F2EB87B;
	Mon, 20 Oct 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="abag3KVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BAB2E9ECE
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951323; cv=none; b=H6hqcIQxRNChzrIRFmvJw/HugipoEBYsnp5C//WGp7U+ySLObnMmMuMumtAZeEF0jAwroq13rmgdtNpfxemiukheKCDc+1p1FeB4rYozOjzvur+11swFeAcgpLvNtxQLXbL8smRDAajXeynZXnSLrFSq/q87bowtuOUPXcX4pXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951323; c=relaxed/simple;
	bh=nOCn/6Ihk+X2zaF5Y7/xvQO86uWR2f9akZzxRl3+rDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4CuTbcfDqTSSgnVUl3JLiyXoVofTOQh3pMCoIS7ScgRIUg10nnqQoviNYodBvmEiMYJjZt/t4e9Nnv4jxJk1WkMHJ9uKYMXiaS3TEUJHNElJM0pkEVhy66o2qEBVDsDNZ8i85FrvNazcBRZf804rjyCaVfLqMX7W0kEbT5CsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=abag3KVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF22C4CEFE;
	Mon, 20 Oct 2025 09:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760951323;
	bh=nOCn/6Ihk+X2zaF5Y7/xvQO86uWR2f9akZzxRl3+rDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abag3KVAB9Z0/ef9AAnfjajpsWasgVv8x2Blg3r06oImQy+899pHBc1/iB2XddKud
	 +MxxFltx1vL08lYZyaGMuCPz8kjJHlbaQBX+SUqqJakfOCGI0C5pdGhuS4DZQHTHEz
	 abHfHUgVzPHM5kMG9LtvGW10bUPnR+0NC8ge+fn0=
Date: Mon, 20 Oct 2025 11:08:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: stable <stable@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] drm/amd/display: fix dmub access race condition
Message-ID: <2025102005-praying-overlord-eb5d@gregkh>
References: <389171823.1798956.1760724071998.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389171823.1798956.1760724071998.JavaMail.zimbra@raptorengineeringinc.com>

On Fri, Oct 17, 2025 at 01:01:12PM -0500, Timothy Pearson wrote:
> +/**
> + * struct dm_vupdate_work - Work data for periodic action in idle
> + * @work: Kernel work data for the work event
> + * @adev: amdgpu_device back pointer
> + * @stream: DC stream associated with the crtc
> + * @adjust: DC CRTC timing adjust to be applied to the crtc
> + */
> +struct vupdate_offload_work {
> +       struct work_struct work;
> +       struct amdgpu_device *adev;
> +       struct dc_stream_state *stream;
> +       struct dc_crtc_timing_adjust *adjust;
> +};

What happened to the proper formatting of this structure?  You lost all
tabs :(

Please fix up and resend.

thanks,

greg k-h

