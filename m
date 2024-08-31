Return-Path: <stable+bounces-71697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA9967306
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 20:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1E71C2196D
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB57166F28;
	Sat, 31 Aug 2024 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b="JxihGx2l"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751413AD09
	for <stable@vger.kernel.org>; Sat, 31 Aug 2024 18:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725130001; cv=none; b=HQIQtO0fhzYhNMUWO7+YxyO9HhaGzoWvUAs9K9trQthGNmy33RkbdnBPSRYBncmsXo714aNZVAWBZgOLVPzQr8LOpVosSSfyn75Y3q2iPSKUxhSTBxCY4MZQHXg6wqAL8fZGL6OY09humTUrKuaGxIxbESZVQ3ltToi/jm90n/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725130001; c=relaxed/simple;
	bh=lrN6wIlqmLNwZhyJ8TZxzLNC+bpQ63ShLMD3eI6WJw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdaxl5iwJjvJJLU33jH0ArARRQibwynFkn41S1r7kXtvU7PrXsq/wzGOlgzsXObqvyxqAYG4e1m5wCCU5kitDmcwRmC13umtgh+vcu9zPfdtBmZa8LqsQA+P/Oob5MPlgLXiPMp9A3hRk4pT96QOrNjMZudOJM6tkdBV5kijMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com; spf=pass smtp.mailfrom=kuruczgy.com; dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b=JxihGx2l; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuruczgy.com
Message-ID: <56bf547a-08a5-4a08-87a9-c65f94416ef3@kuruczgy.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuruczgy.com;
	s=default; t=1725129996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaG84+/bdNFcK2s0BzGgnXzJQNkNWYStcn1LGw6NrpU=;
	b=JxihGx2lGXxk+1WGBTTuLdHOlldL9esbNFKgrjCnLAABchnfXS1f4YyejhWdaZOvPtciMw
	wN2a2kbxQgedVuJA7mGyVB9uFjzls6GGqwb0CoG0rcQicGxeJYp7R81Djg6V+l4xFEAb5d
	KmV3hpY477EDPzZFKcsB7qgQhSRVy94=
Date: Sat, 31 Aug 2024 20:46:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v2,1/2] drm/msm/dpu1: don't choke on disabling the writeback
 connector
To: Leonard Lausen <leonard@lausen.nl>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jeykumar Sankaran <jsanka@codeaurora.org>, stable@vger.kernel.org
References: <20240802-dpu-fix-wb-v2-1-7eac9eb8e895@linaro.org>
 <b70a4d1d-f98f-4169-942c-cb9006a42b40@kuruczgy.com>
 <0b2286bf-42fc-45dc-a4e0-89f85e97b189@lausen.nl>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>
In-Reply-To: <0b2286bf-42fc-45dc-a4e0-89f85e97b189@lausen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Dear Leonard,

> Do you observe this issue on every suspend-resume cycle?

I just did 10 suspend/resume cycles in a row to double check, and 
without this patch the screen never comes back (always have to switch VT 
back-and-forth to bring it back). The

[dpu error]connector not connected 3
[drm:drm_mode_config_helper_resume] *ERROR* Failed to resume (-22)

pair of error messages also consistently appears after all resumes.

Though I think e.g. Rob Clark reported that suspend/resume already works 
properly for him without this patch, so this experience is not universal 
on the Yoga Slim 7x.

> On sc7180 lazor, I do observe that this patch deterministically breaks restoring the CRTC state and functionality after resume. Can you please validate if you observe the same on Lenovo Yoga Slim 7x? Specifically, try set Night Light in your desktop environment to "Always On" and observe whether the screen remains in "Night Light" mode after resume. For lazor, "Night Light" is breaks after applying this patch and even manually toggling it off and on after resume does not restore "Night Light" / CRTC functionality.

Unfortunately I cannot test this, as color temperature adjustments seems 
to be completely non-functional for me in the first place. For color 
temperature adjustment, I use gammastep on my machines, which uses 
wlr_gamma_control_unstable_v1 under the hood. It outputs the following 
warnings:

Warning: Zero outputs support gamma adjustment.
Warning: 1/1 output(s) do not support gamma adjustment.

I haven't dug deeper into the cause yet, based on these it seems that 
wlroots isn't detecting the display as being gamma-adjustable in the 
first place.

Best regards,
György

