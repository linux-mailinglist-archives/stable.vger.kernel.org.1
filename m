Return-Path: <stable+bounces-210256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C53D39E03
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE642300F889
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66708226863;
	Mon, 19 Jan 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwo6cmBW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027257260A
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801734; cv=none; b=BF2xzzN0IFzFfIX1nQA9sgemKX7mqlTIZSSLTQ+4+VCMNKIApppSowVqOAYHP7BP7558JqEyhcg1Uj3f3UJ+jbFsK4I80+Tj2WB4s9DpHE2z+hOCHWqjmkdQbzMd6LhWLCHyDoA6rI/35kWJiuWReYijhgKZYJdiU+BVgNMwx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801734; c=relaxed/simple;
	bh=ysB7SxTOh5ZyKA5DysZWLp3MiKHbwJvwwstm/AQkBjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/Hsz+VvNpvFBvNPCq2mZehclRd3YBhgnVQbGIMVxR4/D19S9L7Yr/PxANezW/PCsnPStj/kTHFpUTicvH7J37X6fcios1BD3M2xup7XE7sXNfAS89zmcs7s5q6NxCxEge4cHNudy5THwdCGU4toN/XHyhEw+vWg8D90NccsMfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwo6cmBW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so1525204a12.3
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 21:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768801732; x=1769406532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+/S68usaW+kTcKvw3RLnxGJfu2TKIUUxfyXIfkHcDk=;
        b=dwo6cmBWPz7Cc+gE6lzHvllgGDRMhjyLxiIuJKgR9WuMS2+8pBgTKmIbNLts3fWHyQ
         wW0i/jvsXDYdh8PE8R2rGuo+hQo+fZCG7Pg+Ik6zyW9jkxbY6ASMQ5/RFg9ITINtPEAY
         BZff37hzQu10k/qZgnUKb/sJqzwzb5AvWyixh33Q8VrzsJMMt3YgTs0E86qbZeIdA2SG
         PbqTtSejCsYWNSdneEB2OVNyafn/7O+QFkWM0EoyMAA9V1z++qYUTWZqnOb7ouEKiyAX
         dEXABAMXiLsDZF2lUyPRrAvBAJlVQ9/n/uFy1UVogOcmRTMSnchy+3m13dHO8hv2q+gL
         tYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768801732; x=1769406532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+/S68usaW+kTcKvw3RLnxGJfu2TKIUUxfyXIfkHcDk=;
        b=HisAV+Oog8XaTVL8iSzsCaQ0MGZZ5oDDAFeFU4pbRtFjKAYsRsVjk2TIGIAlj0dFx+
         jF1gXtsNCPAjN1GWPvVUtC2S6EvbOqctnxcvuSUnJRsx1sT3k+Cr04Xeo1qQPSzSFK01
         ouyZucUNibOt6FkE/eo67uQFbZhxj5Kyc+4xj6M33vBagwyuy4Ybl7wrAt3msMP5tAON
         fnOCtg48P86Vq6PEGFi4+H1JPK7ALh8USjeC3wPVnxYFKPVRnwTeigGcUNGoj5I85K6A
         EqwwKtyB2MII33F+LalIYb4StWOLOIeWWqbU7zy62JTS/QcAi7L6mNKCfU49W+Tm9+QX
         4hoA==
X-Forwarded-Encrypted: i=1; AJvYcCV/vbrNK7JoRfhsE9ujJYy1KRzR3CfzedvTDbNBZ2Mna/uv444CIKbdVIQJrlufkyS9YPD653I=@vger.kernel.org
X-Gm-Message-State: AOJu0YydcwSqnbySCshBehZ3U3Mxmu8DZ0XXRSxVOhq+cRzuPZaTsspY
	vYuXsHczyXZqd26EiWQNfoojC8F8cRcYmzHJDw5dz1oimiQYfTkaxHdrExYSeAuWmcU=
X-Gm-Gg: AY/fxX5FqDoTWPxcBwyeGJgonMtMiY06rRS0pVWCzmIEDoWnFHQh67rkO78EqrW9+Yn
	Ld19qwUzZqJsIHRhe6in0GcIyY/UfhT2aKUR2hoSOFLl2eeY0igE4Z3a1m/sOOadv4XlMWelVV5
	hKEHJKSR0JlevLLIbeVE6WgauIFSutBySaoNxozu2i4LFoBfzsRF591LVGaDx90jfvbifZD1t+2
	1R+3Joy3amqOnC6BLeu2sWcbm9PpTQMy+op9epDB+uHfSV7Rw3ScVE+RUl43fIbCbKW8xBMOM1/
	lF+wr2gdfpBhvF7PfrC8+WId56Wx2wTvwi2qehLZcYnplxmNNcn2+09+mwwPDF9uDEosY79hVzw
	QE+jKX62Q3vdMGRCVJ2s7m0Ym0tpW9sA2wnjurqFufHWhmjo/SJ/JDtE+OfpKyDkvWEsWzyRLiS
	panW1ljKxvTTX0y7Ivewwm9w==
X-Received: by 2002:a05:6a21:9d48:b0:371:53a7:a48a with SMTP id adf61e73a8af0-38dfe572a0cmr10318092637.1.1768801732018;
        Sun, 18 Jan 2026 21:48:52 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf251a6csm7921857a12.13.2026.01.18.21.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 21:48:51 -0800 (PST)
Date: Mon, 19 Jan 2026 11:18:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Juan Martinez <juan.martinez@amd.com>
Cc: Ray.Huang@amd.com, gautham.shenoy@amd.com, Mario.Limonciello@amd.com, 
	rafael@kernel.org, Perry.Yuan@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Kaushik.ReddyS@amd.com
Subject: Re: [PATCH] cpufreq/amd-pstate: Add comment explaining nominal_perf
 usage for performance policy
Message-ID: <rdym4zzkiokzvmlj6qmxzomgyazggzfbj4euwlbp2nq7yhop6u@3qg4yo6zamkl>
References: <20260116214539.8139-1-juan.martinez@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116214539.8139-1-juan.martinez@amd.com>

On 16-01-26, 15:45, Juan Martinez wrote:
> Add comment explaining why nominal_perf is used for MinPerf when the
> CPU frequency policy is set to CPUFREQ_POLICY_PERFORMANCE, rather than
> using highest_perf or lowest_nonlinear_perf.
> 
> Signed-off-by: Juan Martinez <juan.martinez@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index c45bc98721d2..88b26f36937b5 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -636,6 +636,19 @@ static void amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
>  	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
>  
>  	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
> +		/*
> +		 * For performance policy, set MinPerf to nominal_perf rather than
> +		 * highest_perf or lowest_nonlinear_perf.
> +		 *
> +		 * Per commit 0c411b39e4f4c, using highest_perf was observed
> +		 * to cause frequency throttling on power-limited platforms, leading to
> +		 * performance regressions. Using lowest_nonlinear_perf would limit
> +		 * performance too much for HPC workloads requiring high frequency
> +		 * operation and minimal wakeup latency from idle states.
> +		 *
> +		 * nominal_perf therefore provides a balance by avoiding throttling
> +		 * while still maintaining enough performance for HPC workloads.
> +		 */
>  		perf.min_limit_perf = min(perf.nominal_perf, perf.max_limit_perf);
>  		WRITE_ONCE(cpudata->min_limit_freq, min(cpudata->nominal_freq, cpudata->max_limit_freq));
>  	} else {

Applied. Thanks.

-- 
viresh

