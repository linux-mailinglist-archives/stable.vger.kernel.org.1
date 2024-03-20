Return-Path: <stable+bounces-28489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554D8814BB
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1DE1C213FC
	for <lists+stable@lfdr.de>; Wed, 20 Mar 2024 15:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC14E1CA;
	Wed, 20 Mar 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="g8jClpGh"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3D39AF4
	for <stable@vger.kernel.org>; Wed, 20 Mar 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949223; cv=none; b=f54EfkUnmHBBjPScKogfEQpQmT6I117JrChQXT3iFjtatfZnJPrisg2BXY1d8C90tAE95Vy5upjsvchJ4OQXmBi83zF5CHkEdCSTVBOfrWSQYhEljItTsIHQAG+MUnY1uAeT/aO1B81uLmnYZ1ojjUaws9gSwEr0Y0jgDUoNEis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949223; c=relaxed/simple;
	bh=YSkkPa+J6OiCreggrSTv5EuF0GAawwdpMcYiTWaFMMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqQCO3QSBGfV6Ln4QLMc/aFGIux9q22oXxNCzpV+oBtdcL6FoqsRQ4DZ2q8jNMcb2kxgEFoVDD7cz/CF4rfswHJzdfOu+IiYc2i5abG3DeFWKW+5gQGIe5xUjlAEdS+j3FYrgBvhmnYlSt/VDDIa15PgLvYfPbewDx+zDq/1Ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=g8jClpGh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d23114b19dso85035101fa.3
        for <stable@vger.kernel.org>; Wed, 20 Mar 2024 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1710949220; x=1711554020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkMYzc9ktSXD4/lGPR3gzLrhYRVUW8d9S/Mr9bDPnog=;
        b=g8jClpGhe/OBgBVeH7SiPwu8DKxRR0pSTPMziGS7IfVbWEyUTsAXgdHIjQyYgh7b9W
         5IQ0vazuYKKTbgFqoAf9DzHUcLZnOsg9kmumn5nuctoGbQNp5qGO+NLtsWngYEJsYXUl
         yLXCvIZN+UxmtTEJ/Xs6LSzzYpNtoNOoy0zEhl5CrGuDo1n2fhHIP1FAaJ1wG31LZWyM
         wZW0ra9Vgl2K+/SZWC19bqNDQQJWs3DBoXyA0938Wy1FJf2O+8JAxA7z7UjmFRyIbyfI
         H8exKT7M2alQUOggP6AGYhJFZMvET/0X4T271AmGcql+ondpHVzTBjFeiW3OFL3GUrrq
         YN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949220; x=1711554020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkMYzc9ktSXD4/lGPR3gzLrhYRVUW8d9S/Mr9bDPnog=;
        b=Tjm351FCmLdMXHHJevwHmGwnXBR4WEOiVAJ1BOVwoVRxJkaMC55lzc74z20B9p2NiQ
         ViC7JbkJq+4lq+WDlUGEeIVqHKm4DEhHCPzpASu/VWnF9V9Vt8OkgEgFe43QosQjQ0f1
         6NxJ5MxaAmibdmS8YJJo13tusviU7QVs1FoGTf1k6x5no64c+BbSuYVW/EwsLLZ1Vysh
         RF2cfguVnoZPQvtW9T9zSqtnPpSYZVKa4uzSqSVvlsySx3vO1UZcslhmP+1+WOGjgNgH
         0axQdog9AoIz9owZJ++XCxfEJDSjMyil4yExMLQg1kRVIqAkO3A/G7ruZT40V1r3rnBF
         70Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX2b4/jWekikAB9NSIxHldN/w1sTYMQ3aA8AyVJadvfD/BwiMZ3FymyeNHyUqH5yLlLA8VXXWPY5Nbue7XIZWTX4+759jAu
X-Gm-Message-State: AOJu0YzEg5d+XZWV+eLRK7/JnYVePEPxVXSz1Y5Lx0mG8btbJxkjva//
	mIrQQkNQT94WGYry7HEx/TN8tS5v+yZWcBVStPRSM5/O5K9x+wMpfUixM5o9XrY=
X-Google-Smtp-Source: AGHT+IF4xIDSrxcYjuUFrmCEBCyUD5ebFdIMCnD/C2zFineBSItC1RmylLLh6Wew7uMyxUtIRyXTZA==
X-Received: by 2002:a2e:9608:0:b0:2d5:122a:4b1f with SMTP id v8-20020a2e9608000000b002d5122a4b1fmr5171414ljh.43.1710949219645;
        Wed, 20 Mar 2024 08:40:19 -0700 (PDT)
Received: from [192.168.0.101] ([84.65.0.132])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0560000dcb00b0033b66c2d61esm14902596wrb.48.2024.03.20.08.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:40:19 -0700 (PDT)
Message-ID: <3fe26c42-cc34-42b2-a5cc-21a6a9468b4e@ursulin.net>
Date: Wed, 20 Mar 2024 15:40:18 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Disable automatic load CCS load balancing
Content-Language: en-GB
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris.p.wilson@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 John Harrison <John.C.Harrison@intel.com>, stable@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>
References: <20240313201955.95716-1-andi.shyti@linux.intel.com>
 <Zfr7hPs_VAUkTNTX@ashyti-mobl2.lan>
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <Zfr7hPs_VAUkTNTX@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 20/03/2024 15:06, Andi Shyti wrote:
> Ping! Any thoughts here?

I only casually observed the discussion after I saw Matt suggested 
further simplifications. As I understood it, you will bring back the 
uabi engine games when adding the dynamic behaviour and that is fine by me.

Regards,

Tvrtko

> On Wed, Mar 13, 2024 at 09:19:48PM +0100, Andi Shyti wrote:
>> Hi,
>>
>> this series does basically two things:
>>
>> 1. Disables automatic load balancing as adviced by the hardware
>>     workaround.
>>
>> 2. Assigns all the CCS slices to one single user engine. The user
>>     will then be able to query only one CCS engine
>>
>> >From v5 I have created a new file, gt/intel_gt_ccs_mode.c where
>> I added the intel_gt_apply_ccs_mode(). In the upcoming patches,
>> this file will contain the implementation for dynamic CCS mode
>> setting.
>>
>> Thanks Tvrtko, Matt, John and Joonas for your reviews!
>>
>> Andi
>>
>> Changelog
>> =========
>> v5 -> v6 (thanks Matt for the suggestions in v6)
>>   - Remove the refactoring and the for_each_available_engine()
>>     macro and instead do not create the intel_engine_cs structure
>>     at all.
>>   - In patch 1 just a trivial reordering of the bit definitions.
>>
>> v4 -> v5
>>   - Use the workaround framework to do all the CCS balancing
>>     settings in order to always apply the modes also when the
>>     engine resets. Put everything in its own specific function to
>>     be executed for the first CCS engine encountered. (Thanks
>>     Matt)
>>   - Calculate the CCS ID for the CCS mode as the first available
>>     CCS among all the engines (Thanks Matt)
>>   - create the intel_gt_ccs_mode.c function to host the CCS
>>     configuration. We will have it ready for the next series.
>>   - Fix a selftest that was failing because could not set CCS2.
>>   - Add the for_each_available_engine() macro to exclude CCS1+ and
>>     start using it in the hangcheck selftest.
>>
>> v3 -> v4
>>   - Reword correctly the comment in the workaround
>>   - Fix a buffer overflow (Thanks Joonas)
>>   - Handle properly the fused engines when setting the CCS mode.
>>
>> v2 -> v3
>>   - Simplified the algorithm for creating the list of the exported
>>     uabi engines. (Patch 1) (Thanks, Tvrtko)
>>   - Consider the fused engines when creating the uabi engine list
>>     (Patch 2) (Thanks, Matt)
>>   - Patch 4 now uses a the refactoring from patch 1, in a cleaner
>>     outcome.
>>
>> v1 -> v2
>>   - In Patch 1 use the correct workaround number (thanks Matt).
>>   - In Patch 2 do not add the extra CCS engines to the exposed
>>     UABI engine list and adapt the engine counting accordingly
>>     (thanks Tvrtko).
>>   - Reword the commit of Patch 2 (thanks John).
>>
>> Andi Shyti (3):
>>    drm/i915/gt: Disable HW load balancing for CCS
>>    drm/i915/gt: Do not generate the command streamer for all the CCS
>>    drm/i915/gt: Enable only one CCS for compute workload
>>
>>   drivers/gpu/drm/i915/Makefile               |  1 +
>>   drivers/gpu/drm/i915/gt/intel_engine_cs.c   | 20 ++++++++---
>>   drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c | 39 +++++++++++++++++++++
>>   drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h | 13 +++++++
>>   drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  6 ++++
>>   drivers/gpu/drm/i915/gt/intel_workarounds.c | 30 ++++++++++++++--
>>   6 files changed, 103 insertions(+), 6 deletions(-)
>>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
>>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h
>>
>> -- 
>> 2.43.0

