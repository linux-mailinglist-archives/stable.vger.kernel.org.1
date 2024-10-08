Return-Path: <stable+bounces-81554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C5994420
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF4828FB11
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868013A88A;
	Tue,  8 Oct 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fDTf9Qcr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD338DF2
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379379; cv=none; b=mcm4iX+zkwHwZ7+ieWOJ7/esxQC9a+FobJnuGpzUwFSguENiL7vPi5hMLENqFu+7yq4BzMio6lgPoMiqkN5HRcN6/BP+iGi4/CerXeFgDpnoi5nHAcAJcNjpgY9wbRH6aAKIDa6UNpokRtlhoV9lMcOXHH7f/4T0zW0NNf5KQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379379; c=relaxed/simple;
	bh=GQmaoKOmh0KbA2vGuB7EWKSh13e51GqPKizukdss1h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXQoxVnBfZN3yRp9ppkeK7Um0U1DISC5oekaes0sLBVrjJAJwTDgYNlC1+nGRffE934BI1dYV5dOjTyU9d3CeS2FXAzKmCm3c5iIVe6KNSKlHy1AYLvR3SJsZYXmqsOIDhgd2bGZTKEDCuRyT79GRyrs0Yn077isdJLYRsFg5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fDTf9Qcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9A5C4CECF;
	Tue,  8 Oct 2024 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379379;
	bh=GQmaoKOmh0KbA2vGuB7EWKSh13e51GqPKizukdss1h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fDTf9QcrJ9RWbwh8Z1lGNGHhDi+VzCLWatbkzZD726LPLmFoFs+8w9CAZsVWRUL0C
	 zT9RdnCPuKP8lXH9qVK7tqmTGg9ZUMzdQBe+uXCFlVZ9SgbX9lYghhc3eSuR53K8Bi
	 Y7ukT2TkWpiTdDSdVsDyeDx8BGUPn2ZCUXvVCPwo=
Date: Tue, 8 Oct 2024 11:22:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Gray <jsg@jsg.id.au>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] Revert "drm/amd/display: Skip Recompute DSC Params
 if no Stream on Link"
Message-ID: <2024100842-tidiness-buzz-ad6a@gregkh>
References: <20241007035711.46624-1-jsg@jsg.id.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007035711.46624-1-jsg@jsg.id.au>

On Mon, Oct 07, 2024 at 02:57:11PM +1100, Jonathan Gray wrote:
> This reverts commit a53841b074cc196c3caaa37e1f15d6bc90943b97.
> 
> duplicated a change made in 6.6.46
> 718d83f66fb07b2cab89a1fc984613a00e3db18f
> 
> Cc: stable@vger.kernel.org # 6.6
> Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7fb11445a28f..d390e3d62e56 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1266,9 +1266,6 @@ static bool is_dsc_need_re_compute(
>  		}
>  	}
>  
> -	if (new_stream_on_link_num == 0)
> -		return false;
> -
>  	if (new_stream_on_link_num == 0)
>  		return false;
>  
> -- 
> 2.46.1
> 

The whole drm tree is messed up when it comes to stable patches.
Duplicates like this happen all the time due to their bizarre workflow
that causes this to happen at least once a release, and is still a major
pain to deal with.

I dread the -rc1 merge window each time for the drm patches and put them
off until I have gotten through everything else.  Can you please work
with those developers to make this go better to prevent this from
constantly happening?

thanks,

greg k-h

