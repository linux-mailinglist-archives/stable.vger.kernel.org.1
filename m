Return-Path: <stable+bounces-136609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8302A9B428
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E893BD901
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198428C5B9;
	Thu, 24 Apr 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rC2fYIsX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F528BA9A
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745512210; cv=none; b=nuL7SOUrYh81Dwv9OuDF7SENEGLeh9/6XApAJx3TrKeSsatXA15RpPaT6dv2MGtIN5QMJeyOvhxiXpNIuGBt13ff+XEslOkQqTXrcHrelR8UWG7Kp19WhFNWIEgKoFZ1MO1iMbm8RZ5Nz0Q/T+c84K3y+8p9fd+DuOnCAenBzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745512210; c=relaxed/simple;
	bh=1WAOjR7sl/MSpDZ3qT3vAy9GwH/ON/SJk1Bx7Fy/GLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooaBMebqXW/OcY/1xoUVXjOaEbjzyVch6K7M6lEkc9F5QABo/15vULI4oBwJU59SjFYKi7VFxqW9DlRzcRLNQtN96VLB1PZHfJp98cF+dn3T/irAWeNolaGBlmTgZDVaYNI3J/P9xSHDpImf500SZ8cggjTmQ5fYuiodhxgtqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rC2fYIsX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so205369366b.1
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745512206; x=1746117006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jH7CEZXVUMDd3gCXVEyO4RBZjepJpKTpn2k/QUd2tFI=;
        b=rC2fYIsXym0EvW0jtJpJhf83Ly8jYkEH8YKR4fBFgXvFxdgbmhoRQrBaw9xPo5FufS
         4Yt3CKjUfWDi0M0V3mugP3C2dqp6lGzCS7/qEq7c7pcfhS2uELhkvQrzFupjGEYpRQo6
         2zQscg/61PCfLADPxRT3gdm66KiRgKjJdd9D9HuD6DP8/yVNZwYImz67ODwwxGJeD95p
         S5uj8tALG7R6xW++MHCVN7y7uv9I+hcL8XGVNC3N8SQ16xXzRuXAYUCEp5XVfRWCxf3n
         KoXTyZvT638lp+Xw+L3ST6MdTIAyWdOKYDlxGNEMmRxBtHXDrTCN/QemwPQj7W2VkQrC
         Xa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745512206; x=1746117006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH7CEZXVUMDd3gCXVEyO4RBZjepJpKTpn2k/QUd2tFI=;
        b=WQ5nEYdwDUQTHzmSul2P7Cs/CNUKeuCPAUkMM8z+uFFJ0G600Cn5Q5euRauQjytGMe
         pp0fQx/eZfQbWd+SH2UiHQkq86Slo7rfG4CTGGzqISrNG/q6maCQAfSPl64+X2HWgC48
         L50X4nvqdG6bSR58ctiCV8UoWUPBfzi/+Oh6bEl78eEo05XQkLIZPtUO2rNz0jYfvHR4
         8eAnDiOSER44kcmilfdhrfV1txak2INxcZduoR+tFJSh0CpEKSrNl0aLAhuoBykBu7Vz
         m5zfNM7DZZMXbNuvoJA3FM5Ply2WG2zfKhr0LNUpgl0lhkyWOuQHwi9HZLdGdA1z//rD
         xaTA==
X-Gm-Message-State: AOJu0YzqzyZvwaBJj5fkn7dz+9+wtmRfIc4A9vsFvY+IPReYheNKl4LT
	rTz7ur/PNotUZ748L5XuMboEoE84JuFPKVNpUZh8BBk6uJY1RoDpjemuHBkOms0=
X-Gm-Gg: ASbGncvftWqk31wFV+Ae2xhPtc4Qp/N1gYxgpUv/aZN435hr7iTrcv+LDRIBWuCXmic
	ku2mUxWVRJtGfJ55p6VKvZ4JArnepOPuyHRFaGGYT5L4/TMEksWONCtUpCfweXSE9rTOYURh2qj
	t3iFXqv+WmjFgYfpsfX8PCC8dkTtlEBdPhJAWRdE4fV3j0oz+4+yRwagTdiStKn3RDUJ5LbWXlf
	TrmY2XVSHWzjEJIDmj2e46wVfiZ+z5fHO6s1LT9pnS+8llBL3RPFDLbDVeNvWByS/F7CgKtlO7E
	VXsHcYunP4lqp1A49UudiAcWF5+f+4vjQzWR2oUYUJHCcxi05A==
X-Google-Smtp-Source: AGHT+IFONF/lCYBw6vekNr7fjobWwHIWN+irjsqyTEIDQ01dOF1plQA90/ozblEmrDjY+pDgvtDc6Q==
X-Received: by 2002:a17:907:2dab:b0:acb:85f2:f032 with SMTP id a640c23a62f3a-ace6b39eb97mr24992766b.13.1745512205811;
        Thu, 24 Apr 2025 09:30:05 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59830efdsm130857066b.32.2025.04.24.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:30:05 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:30:01 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 6.14 130/241] cpufreq: Avoid using inconsistent
 policy->min and policy->max
Message-ID: <aApnCaypsl1VWIfo@linaro.org>
References: <20250423142620.525425242@linuxfoundation.org>
 <20250423142625.881627603@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423142625.881627603@linuxfoundation.org>

Hi Greg,

On Wed, Apr 23, 2025 at 04:43:14PM +0200, Greg Kroah-Hartman wrote:
> 6.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> commit 7491cdf46b5cbdf123fc84fbe0a07e9e3d7b7620 upstream.
> 
> Since cpufreq_driver_resolve_freq() can run in parallel with
> cpufreq_set_policy() and there is no synchronization between them,
> the former may access policy->min and policy->max while the latter
> is updating them and it may see intermediate values of them due
> to the way the update is carried out.  Also the compiler is free
> to apply any optimizations it wants both to the stores in
> cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq()
> which may result in additional inconsistencies.
> 
> To address this, use WRITE_ONCE() when updating policy->min and
> policy->max in cpufreq_set_policy() and use READ_ONCE() for reading
> them in cpufreq_driver_resolve_freq().  Moreover, rearrange the update
> in cpufreq_set_policy() to avoid storing intermediate values in
> policy->min and policy->max with the help of the observation that
> their new values are expected to be properly ordered upfront.
> 
> Also modify cpufreq_driver_resolve_freq() to take the possible reverse
> ordering of policy->min and policy->max, which may happen depending on
> the ordering of operations when this function and cpufreq_set_policy()
> run concurrently, into account by always honoring the max when it
> turns out to be less than the min (in case it comes from thermal
> throttling or similar).
> 
> Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
> Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Link: https://patch.msgid.link/5907080.DvuYhMxLoT@rjwysocki.net
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Please drop this patch from all stable queues for now. It is causing the
CPU frequency to be stuck at minimum after temperature throttling.
I reported this with more detail as reply to the original patch [1].

Thanks,
Stephan

[1]: https://lore.kernel.org/linux-pm/aAplED3IA_J0eZN0@linaro.org/

