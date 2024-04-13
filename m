Return-Path: <stable+bounces-39349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DDF8A39FE
	for <lists+stable@lfdr.de>; Sat, 13 Apr 2024 03:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D7FB214C9
	for <lists+stable@lfdr.de>; Sat, 13 Apr 2024 01:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9860B4A33;
	Sat, 13 Apr 2024 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b/DAJ9iO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1358F4C66
	for <stable@vger.kernel.org>; Sat, 13 Apr 2024 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969844; cv=none; b=XrwGPLdRnAzPpPZC38R8BZq/XY4TAIkmHzjXKF4mkUJs77mfAWI9yD1NPJQBkcOeGL2LlWtkujN9eecJ56NdlncbqEujbp+/Cxv+Sv6w5g9Cc6+8UTq5HnBo3ottUFWh7hSBTdEDFEkkJbUgIuveC89P0WmPSpqB3qtfHhyJrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969844; c=relaxed/simple;
	bh=bmzo1ooKzqufK+juDvo25PZMBaSl3V6Gz4q4MzinNGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx42cNFFaYYUFA9FWWpAv+RRuFGMy68CGtHtmPzAqiH6gn5li0TCjblrMPTf8Rs/pEkS63njcCZUoa9hJPZ7CVQntkKfehsuF5pOQfD9lk2TA/S6uyyFDFCapgm8yRUu8D4QOTWtLM3nOXQcCMnLPf1XOw0Xn7FtrsMC0hhFKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b/DAJ9iO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-344047ac7e4so1457122f8f.0
        for <stable@vger.kernel.org>; Fri, 12 Apr 2024 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712969840; x=1713574640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wc6szgZjNNFyh/LwTAWMUZNCmALq+FNR/Ebns3AOlpc=;
        b=b/DAJ9iOSoS2kY4rEO8CA6EkYIjguKRyM8bp7s2L3qy4wA2vmVHRGWQRXEb/pKOT0R
         zr90UeovvZ85AW//d4dVYXSEh9v2aabWhThaEt7wOmeDkr3JkJRKtx4NuT7OmEu5N3MG
         +1A6+lDVRVwsvdBiHHcLsTkJfSSH9gIFMHyuHGF7zG+85rXu/z6dae9m2WLVmKnkBwtY
         5OEn0Zp1KMsrAfAABOvmSv2AyP5M/F+pWOoG70VsTRXt6onjgfHwyxZc/PPBmPoi73LX
         +zSOUpZA2AMtdssZrmTooes6WTw+ycKw/5suBo8QqVzW54yP29LN1zucxmy61b5lzb0X
         osgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712969840; x=1713574640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wc6szgZjNNFyh/LwTAWMUZNCmALq+FNR/Ebns3AOlpc=;
        b=A/ImwSeLDi3jQ4ZO0UzDXQERjc44AFz4cxXqqU9Lc+eBJBmkugz1avkrCNT0b8JlHF
         xpPRfeK3B80xku9UhJLYV4/KhfqI73MsSOLQ4eR1GqG5av0r2WWcQHG8MwqyH6gsKHX5
         t0HspfqEL5sBXs/C/OqsEIOABXSLLCoH1ULFpxzqafx5qIGt1GsIALsj2T4wpKXIvQGs
         hKNwREDu3VWoHibxeegvFU7YR+KP7QrahctIbq/min90wt83UQuc2AY+J0a+o8OI3gYH
         XJTBbtQmupg3azsBOiJY7aUcEPpD89k2Dm9mdxYhG26ew9kbuFZ/5w7G7jb5h13H25rr
         OxcA==
X-Forwarded-Encrypted: i=1; AJvYcCXlTNQMhi3S9rhrwz2zyzm6zjCtlZ9Nee6WlVvQLuS+y278AItou7oVLOzVVuX4tmQqgxdwaSToWw9J4UNU/UbePsZwgTE6
X-Gm-Message-State: AOJu0Yy/iQSjVdMkPvQ2UjMpyL5vdwLkfv8gBXj74rIIfJwr+BPaLf1I
	+DtcVW2m8E6wSq8aUHDlJyhSkCxSZDOsCyzjZXwEMLjAcS4WmgQmadaCZat+YvDCvUO0jETIio6
	G
X-Google-Smtp-Source: AGHT+IG5KyNZ5UA78drYL10vGyqyFOO3ZKeVjROMtVCq0nW7TCGzkkBZy2nnAMrb7RUrG6yqAasTfA==
X-Received: by 2002:adf:fc49:0:b0:345:6cec:4e02 with SMTP id e9-20020adffc49000000b003456cec4e02mr5032792wrs.12.1712969840341;
        Fri, 12 Apr 2024 17:57:20 -0700 (PDT)
Received: from ?IPV6:2001:559:57b:111::ffff:d600? ([2001:559:57b:111::ffff:d600])
        by smtp.gmail.com with ESMTPSA id z5-20020ae9c105000000b0078ed33d55f2sm837987qki.121.2024.04.12.17.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 17:57:19 -0700 (PDT)
Message-ID: <c55d8329-6d59-4821-89f2-6b50fa9dc6a7@suse.com>
Date: Fri, 12 Apr 2024 20:57:18 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mst: Fix NULL pointer dereference in
 drm_dp_add_payload_part2 (again)
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
References: <20240413002252.30780-1-jeffm@suse.com>
Content-Language: en-US
From: Jeff Mahoney <jeffm@suse.com>
In-Reply-To: <20240413002252.30780-1-jeffm@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

As a follow up, I read through the original thread before sending this 
and my understanding is that this message probably shouldn't be getting 
printed in the first place.  I've turned on KMS, ATOMIC, STATE, and DP 
debugging to see what shakes out.  I have a KVM on my desk that I use to 
switch between systems fairly frequently.  I'm speculating that the 
connecting and disconnecting is related, so I'm hopeful I can trigger it 
quickly.

-Jeff

On 4/12/24 20:22, Jeff Mahoney wrote:
> Commit 54d217406afe (drm: use mgr->dev in drm_dbg_kms in
> drm_dp_add_payload_part2) appears to have been accidentially reverted as
> part of commit 5aa1dfcdf0a42 (drm/mst: Refactor the flow for payload
> allocation/removement).
> 
> I've been seeing NULL pointer dereferences in drm_dp_add_payload_part2
> due to state->dev being NULL in the debug message printed if the payload
> allocation has failed.
> 
> This commit restores mgr->dev to avoid the Oops.
> 
> Fixes: 5aa1dfcdf0a42 ("drm/mst: Refactor the flow for payload allocation/removement")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>   drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 03d528209426..3dc966f25c0c 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3437,7 +3437,7 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_topology_mgr *mgr,
>   
>   	/* Skip failed payloads */
>   	if (payload->payload_allocation_status != DRM_DP_MST_PAYLOAD_ALLOCATION_DFP) {
> -		drm_dbg_kms(state->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
> +		drm_dbg_kms(mgr->dev, "Part 1 of payload creation for %s failed, skipping part 2\n",
>   			    payload->port->connector->name);
>   		return -EIO;
>   	}

-- 
Jeff Mahoney
VP Engineering, Linux Systems

