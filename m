Return-Path: <stable+bounces-71663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D3196681E
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 19:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36661F23CA8
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E469A1BB69D;
	Fri, 30 Aug 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b="ZCb3ubIv"
X-Original-To: stable@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B391BB68E;
	Fri, 30 Aug 2024 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039401; cv=none; b=IGhoQafFGF88TbFQIXkDR/Hmh14pkSc1vdfYAMly7kJkn2KB7SfjYTr3KgbbzPv5sH7U4l+BH1dzAA0ur7D4hGihu8SNbYwIHKyRKvtmwVIlCBiP9M7Yfc2oA/B8GEaxbNTUF06752Vxb1bPwRUTNKe1wKpRWM6UmCxqsyIVNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039401; c=relaxed/simple;
	bh=m9mvL05QGrtb0397eCWHejqwwS3BayVFJ7q21AMt5tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGOMNg9V9cwC6zz3TqM131l87QpJWGh6TbPJFK2GnUkQv5FJ1qrgX2nNd7bTu10SFqBAs6otdoRu2yZTPA4P3d+74M3WWdgR1gjLLuVPerHTn6DovWlPrOkrBBS33vobF6AZ/ul+UL3nyN9f/07aKlNftTTMSgXQah/wmpBLsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com; spf=pass smtp.mailfrom=kuruczgy.com; dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b=ZCb3ubIv; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuruczgy.com
Message-ID: <b70a4d1d-f98f-4169-942c-cb9006a42b40@kuruczgy.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuruczgy.com;
	s=default; t=1725039397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Z8u6d0217V5Y/FNALKuOgpP9nl8oH/BQ1NaMD7vo7Q=;
	b=ZCb3ubIvTlPDtoBTf/DvHqLb7WEGL8/gB9SLOThcW8kMMmmCkvtnmQgKfyFZQdurXp8L3f
	3wjZnevzcNpeQ84NCNtcMk7RcM+VBPqVyiEc2mXruLxmL0/hoYU33eNylk++XXx5XSS0eB
	K3P98H5FM2yMTgepxqpRe5lOXtmfiKM=
Date: Fri, 30 Aug 2024 19:36:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,1/2] drm/msm/dpu1: don't choke on disabling the writeback
 connector
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org,
 Leonard Lausen <leonard@lausen.nl>
References: <20240802-dpu-fix-wb-v2-1-7eac9eb8e895@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>
In-Reply-To: <20240802-dpu-fix-wb-v2-1-7eac9eb8e895@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Dear Dmitry,

For context, I have a Lenovo Yoga Slim 7x laptop, and was having issues 
with the display staying black after sleep. As a workaround, I could 
switch to a different VT and back.

> [ 1185.831970] [dpu error]connector not connected 3

I can confirm that I was seeing this exact error message as well.

>   	if (!conn_state || !conn_state->connector) {
>   		DPU_ERROR("invalid connector state\n");
>   		return -EINVAL;
> -	} else if (conn_state->connector->status != connector_status_connected) {
> -		DPU_ERROR("connector not connected %d\n", conn_state->connector->status);
> -		return -EINVAL;
>   	}
>   
>   	crtc = conn_state->crtc;

After applying this patch, the screen now resumes successfully, and the 
errors are gone.

(For future reference, I am using this kernel: 
https://github.com/jhovold/linux/commits/wip/x1e80100-6.11-rc5/, commit 
cc2cb95cc77fec43edd407c993122085fa8c2dd7.)

Tested-by: György Kurucz <me@kuruczgy.com>

Best regards,
György

