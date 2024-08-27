Return-Path: <stable+bounces-70350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536AC960B0D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB112845EF
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB771BFE0E;
	Tue, 27 Aug 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+50Z/zB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135E1BC083
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762972; cv=none; b=TqybvpswTWuCJQxAzDUt1Xjq9UT2eYUycieZfuCrwmPQr+l8jJ3c4RvRlFhfB2o3G+kOX6uD+Zsrd0znp35WY2HYFRoHQo6zeVs45kPEogEAJ3+3hZsaNjSH/LpZGVoUiNLXeGgK5KKmadJ8xXJrq+DIwIMqC/pmUthVrtnrj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762972; c=relaxed/simple;
	bh=QwqqWlN/fy0JJOVAZrPQtzzfN/QFTbAbOvG5Tsn4UlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbnmlpX/B2AZSygFsv71c9f33746RbCW2uQmBNTa5p90FKW37kTfo4cBwFeGycz690OspvbJEXt4ZEtCIj6AY1aSpUlIUzn6UXqjcXHqF7eabNe0TK3TCgZwLaPdXgknKN12j1aO/xHKVneGFtzZv6iBIEdNbGXa+itKgfkqytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+50Z/zB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473F1C6106D;
	Tue, 27 Aug 2024 12:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724762971;
	bh=QwqqWlN/fy0JJOVAZrPQtzzfN/QFTbAbOvG5Tsn4UlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1+50Z/zBTk9gK0eoK7PCMY47hiXrA7BEnbrAjy+Bjv24pjxHm7JJ20RbWn8aW27nS
	 j2H2LDcToogY7JrNGeLC2j7MhXQdjo/zTJUFJgr9AN233b8E2SEP86zMo8+Ez1TpD1
	 LK7XCi/ZlfSYqP0j4GRiHzDseRLUCEObNCmVxQPc=
Date: Tue, 27 Aug 2024 14:49:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 6.6 0/2] VCN power saving improvements
Message-ID: <2024082722-oncoming-onslaught-cd8f@gregkh>
References: <20240826155532.2031159-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826155532.2031159-1-superm1@kernel.org>

On Mon, Aug 26, 2024 at 10:55:30AM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> This is a backport of patches from 6.11-rc1 that improve power savings
> for VCN when hardware accelerated video playback is active.
> 
> Boyuan Zhang (2):
>   drm/amdgpu/vcn: identify unified queue in sw init
>   drm/amdgpu/vcn: not pause dpg for unified queue
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 53 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>  2 files changed, 27 insertions(+), 27 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

Now queued up, thanks.

greg k-h

